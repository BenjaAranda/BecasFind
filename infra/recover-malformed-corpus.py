"""Apply reviewed, fingerprinted CSV structure repairs without certifying historical fields."""
import argparse
import csv
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import re

spec = importlib.util.spec_from_file_location('corpus_prepare', Path(__file__).with_name('prepare-processed-corpus.py'))
prepare = importlib.util.module_from_spec(spec)
spec.loader.exec_module(prepare)

FIELDS = 'nombre institucion tipo_beca monto fecha_inicio fecha_cierre rsh_maximo nem_minimo regiones descripcion descripcion_larga url documentos_requeridos'.split()


def transform(line, action):
    kind = action['kind']
    if kind == 'close_description_before_url':
        boundary = ' ' + action['url'] + ','
        if line.count(boundary) != 1:
            raise ValueError('El límite de URL revisado no es único')
        prefix, documents = line.split(boundary)
        line = prefix.rstrip() + '\",' + action['url'] + ',' + documents
    values = next(csv.reader([line], strict=True))
    if kind == 'remove_empty_region_column':
        if len(values) != 14 or values[8] != '' or not re.fullmatch(r'[IVXRM]+(?:,[IVXRM]+)*', values[9]):
            raise ValueError('La columna vacía no coincide con la reparación revisada')
        del values[8]
    elif kind == 'join_description_fragments':
        if len(values) <= 13:
            raise ValueError('No hay fragmentos adicionales que reunir')
        values = values[:10] + [','.join(values[10:-2])] + values[-2:]
    elif kind != 'close_description_before_url':
        raise ValueError('Reparación no reconocida')
    if len(values) != 13 or not values[11].startswith(('https://', 'http://')) or not values[12].startswith('[OBLIGATORIO]'):
        raise ValueError('La estructura final no coincide con URL y documentos históricos revisados')
    return dict(zip(FIELDS, values))


def recover(corpus, manifest, baseline, output):
    if output.resolve().is_relative_to(corpus.resolve()):
        raise ValueError('La salida no puede escribirse dentro de los originales')
    old_candidates = {r['candidato'] for r in baseline}
    recovered, resolved = [], set()
    filenames = set()
    # Validate every input before writing any output.
    for file in manifest['files']:
        if Path(file['filename']).name != file['filename'] or file['filename'] in filenames:
            raise ValueError('La reparación debe referirse a un archivo directo del corpus')
        filenames.add(file['filename'])
        path = corpus / file['filename']
        raw = path.read_bytes()
        canonical_hash = hashlib.sha256(raw.replace(b'\r\n', b'\n')).hexdigest()
        if canonical_hash != file['sha256_lf']:
            raise ValueError('El original cambió después de revisar la reparación')
        lines = raw.decode('utf-8-sig').splitlines()
        if next(csv.reader([lines[0]])) != FIELDS:
            raise ValueError('Encabezado distinto del contrato revisado')
        before_reader = csv.reader(io.StringIO(raw.decode('utf-8-sig'), newline=''))
        next(before_reader)
        origin_records, previous_end = {}, 1
        for number, _ in enumerate(before_reader, 1):
            for physical in range(previous_end + 1, before_reader.line_num + 1):
                origin_records[physical] = number
            previous_end = before_reader.line_num
        repaired_lines, seen = lines.copy(), set()
        for action in file['actions']:
            physical = action['line']
            if physical in seen or physical < 2 or physical > len(lines):
                raise ValueError('Línea duplicada o fuera de rango')
            seen.add(physical)
            row = transform(lines[physical - 1], action)
            name, institution = prepare.spelling(row['nombre']), prepare.spelling(row['institucion'])
            identity = prepare.key(institution) + '\0' + prepare.key(name)
            candidate = hashlib.sha256(identity.encode('utf-8')).hexdigest()
            recovered.append(dict(archivo=path.as_posix(), archivo_sha256=hashlib.sha256(raw).hexdigest(),
                linea_fisica=physical, registro_logico_anterior=origin_records[physical],
                linea_original=lines[physical - 1], reparacion=action, reconstruido=row, candidato=candidate,
                nombre=name, institucion=institution, candidato_nuevo=candidate not in old_candidates))
            resolved.add((path.as_posix(), origin_records[physical]))
            stream = io.StringIO(newline='')
            csv.writer(stream, lineterminator='\n').writerow([row[f] for f in FIELDS])
            repaired_lines[physical - 1] = stream.getvalue().rstrip('\n')
        for row in csv.reader(io.StringIO('\n'.join(repaired_lines), newline=''), strict=True):
            if len(row) != 13:
                raise ValueError('Quedan columnas mal formadas fuera del manifiesto')
    output.mkdir(parents=True, exist_ok=True)
    prepare.write_csv(output / 'estructura_reparada.csv', FIELDS, [r['reconstruido'] for r in recovered])
    (output / 'reparados.jsonl').write_text(''.join(json.dumps(r, ensure_ascii=False) + '\n' for r in recovered), encoding='utf-8')
    archive_fields = 'nombre institucion tipo_beca monto fecha_inicio fecha_cierre rsh_maximo nem_minimo regiones descripcion descripcion_larga url documentos_requeridos cobertura_tipo cobertura_importe cobertura_moneda cobertura_periodicidad cobertura_porcentaje estado_activa solo_crear'.split()
    candidates = {}
    for row in recovered:
        if row['candidato_nuevo']:
            entry = dict.fromkeys(archive_fields, '')
            entry.update(nombre=row['nombre'], institucion=row['institucion'], tipo_beca='Beca por verificar',
                descripcion='Identidad recuperada del histórico. Sin confirmación oficial completa.',
                descripcion_larga=f"Registro administrativo inactivo. candidato {row['candidato']}. "
                    f"Origen: {row['archivo']} línea física {row['linea_fisica']}. "
                    'Reparación y texto original en reparados.jsonl. DOCUMENTOS REQUERIDOS: desconocidos hasta confirmación oficial.',
                cobertura_tipo='DESCONOCIDA', estado_activa='false', solo_crear='true')
            candidates[row['candidato']] = entry
    prepare.write_csv(output / 'recuperados_administrativos.csv', archive_fields, candidates.values())
    summary = dict(archivos=len(manifest['files']), registros_logicos_reparados=len(resolved),
                   lineas_reconstruidas=len(recovered), candidatos_nuevos=len(candidates),
                   campos_historicos_certificados=0, activados=0)
    (output / 'resumen.json').write_text(json.dumps(summary, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    return summary


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--corpus', type=Path, default=Path('ScrapperBecasFind/data_lake_becas/03_procesados'))
    parser.add_argument('--manifest', type=Path, default=Path('documentacion/auditoria_corpus/procesados/reparaciones_estructura.json'))
    parser.add_argument('--baseline', type=Path, default=Path('documentacion/auditoria_corpus/procesados/indice.csv'))
    parser.add_argument('--output', type=Path, default=Path('documentacion/auditoria_corpus/procesados/reparaciones'))
    args = parser.parse_args()
    with args.baseline.open(encoding='utf-8', newline='') as stream:
        baseline = list(csv.DictReader(stream))
    print(json.dumps(recover(args.corpus, json.loads(args.manifest.read_text(encoding='utf-8')), baseline, args.output)))
