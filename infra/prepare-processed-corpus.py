"""Preserve processed history and prepare an inactive administrative archive, never a certified release."""
import argparse
import collections
import csv
import hashlib
import json
from pathlib import Path
import re
import unicodedata


def repair(value):
    if re.search(r'[ÃÂ][\u0080-\u00bf]', value):
        try:
            return value.encode('latin1').decode('utf-8')
        except UnicodeError:
            raise ValueError('Codificación ambigua: requiere revisión manual') from None
    if '\ufffd' in value:
        raise ValueError('Carácter perdido: requiere revisión manual')
    return value.strip()


ACCENTS = dict(zip(
    'Academica Academico Alimentacion Aranceles Catolica Catolico Concepcion Economica Economico Educacion Ensenanza Formacion Gomez Integracion Lider Mantencion Matricula Merito Nuble Pedagogias Politecnico Postulacion Propedeutico Region Tecnica Tecnico Valparaiso Vina'.split(),
    'Académica Académico Alimentación Aranceles Católica Católico Concepción Económica Económico Educación Enseñanza Formación Gómez Integración Líder Mantención Matrícula Mérito Ñuble Pedagogías Politécnico Postulación Propedéutico Región Técnica Técnico Valparaíso Viña'.split()))


def spelling(value):
    value = repair(value)
    return re.sub(r'\b\w+\b', lambda m: ACCENTS.get(m[0], m[0]), value)


def key(value):
    return ''.join(c for c in unicodedata.normalize('NFKD', value.casefold())
                   if not unicodedata.combining(c)).strip()


def write_csv(path, fields, rows):
    with path.open('w', encoding='utf-8', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)


def prepare(corpus, output, evidence=None):
    groups = collections.defaultdict(list)
    files, originals = [], []
    for path in sorted(corpus.glob('*.csv')):
        raw = path.read_bytes()
        digest = hashlib.sha256(raw).hexdigest()
        files.append({'archivo': path.as_posix(), 'sha256': digest})
        with path.open(encoding='utf-8-sig', newline='') as stream:
            reader = csv.DictReader(stream)
            headers = reader.fieldnames or []
            if len(headers) != len(set(headers)):
                raise ValueError(f'Encabezados duplicados: {path.name}')
            for index, row in enumerate(reader, 1):
                warnings = []
                if None in row:
                    warnings.append('COLUMNAS_EXTRA')
                    row['_columnas_extra'] = row.pop(None)
                if any(v is None for v in row.values()):
                    warnings.append('COLUMNAS_AUSENTES')
                name, institution = spelling(row['nombre']), spelling(row['institucion'])
                if not name or not institution or len(name) > 255 or len(institution) > 255:
                    raise ValueError(f'Identidad no válida: {path.name}#{index}')
                identity = key(institution) + '\0' + key(name)
                candidate = hashlib.sha256(identity.encode('utf-8')).hexdigest()
                item = {'candidato': candidate, 'archivo': path.as_posix(), 'registro': index,
                        'archivo_sha256': digest, 'hallazgos_parser': warnings, 'original': row}
                originals.append(item)
                groups[candidate].append((name, institution, item))
    output.mkdir(parents=True, exist_ok=True)
    confirmed = {}
    allowed = {'monto', 'url', 'nem_minimo', 'fecha_inicio', 'fecha_cierre', 'cobertura_tipo',
               'cobertura_importe', 'cobertura_moneda', 'cobertura_periodicidad', 'cobertura_porcentaje'}
    for entry in evidence or []:
        identity = key(spelling(entry['institucion'])) + '\0' + key(spelling(entry['nombre']))
        candidate = hashlib.sha256(identity.encode('utf-8')).hexdigest()
        if candidate not in groups or candidate in confirmed or not entry.get('fuentes') or not entry.get('revisado'):
            raise ValueError('Evidencia sin candidato, duplicada o sin fuente/fecha')
        if not set(entry['campos']).issubset(allowed) or not all(isinstance(v, str) for v in entry['campos'].values()):
            raise ValueError('La evidencia no puede activar ni reemplazar identidades o datos administrativos')
        confirmed[candidate] = entry
    with (output / 'originales.jsonl').open('w', encoding='utf-8', newline='\n') as stream:
        for row in originals:
            stream.write(json.dumps(row, ensure_ascii=False, sort_keys=True) + '\n')
    archive, index = [], []
    for candidate, variants in sorted(groups.items()):
        name, institution, _ = variants[0]
        reference = ' | '.join(f"{r['archivo']}#{r['registro']}" for _, _, r in variants)
        # No historical value becomes a verified eligibility field merely by appearing in a CSV.
        archive.append(dict(nombre=name, institucion=institution, tipo_beca='Beca por verificar',
            monto='', fecha_inicio='', fecha_cierre='', rsh_maximo='', nem_minimo='', regiones='',
            descripcion='Registro histórico no confirmado. Pendiente de revisión oficial.',
            descripcion_larga=f'Registro administrativo inactivo. No certifica la existencia ni vigencia del beneficio. '
                f'Trazabilidad: candidato {candidate}. Originales y referencias en originales.jsonl. '
                'DOCUMENTOS REQUERIDOS: desconocidos hasta confirmación oficial.',
            url='', documentos_requeridos='', cobertura_tipo='DESCONOCIDA', cobertura_importe='',
            cobertura_moneda='', cobertura_periodicidad='', cobertura_porcentaje='', estado_activa='false', solo_crear='true'))
        entry = confirmed.get(candidate)
        if entry:
            archive[-1].update(entry['campos'])
            archive[-1]['descripcion_larga'] += ' Revisión parcial: ' + entry['limite']
        index.append(dict(candidato=candidate, nombre=name, institucion=institution,
            filas=len(variants), estado='REVISION_PARCIAL' if entry else 'PENDIENTE_CONFIRMACION', referencias=reference,
            urls_historicas=' | '.join(sorted({r['original'].get('url') or '' for _, _, r in variants})),
            fuentes_revisadas=' | '.join(entry['fuentes']) if entry else '',
            identidades_historicas=json.dumps(sorted({(r['original']['nombre'], r['original']['institucion'])
                for _, _, r in variants}), ensure_ascii=False)))
    write_csv(output / 'archivo_administrativo.csv', list(archive[0]) if archive else [], archive)
    write_csv(output / 'indice.csv', list(index[0]) if index else [], index)
    summary = dict(files=len(files), original_rows=len(originals), candidates=len(groups),
                   duplicate_candidates=sum(len(v) > 1 for v in groups.values()),
                   certified=0, active=0, files_sha256=files)
    summary['parser_warnings'] = sum(bool(r['hallazgos_parser']) for r in originals)
    summary['partially_confirmed_candidates'] = len(confirmed)
    (output / 'consolidacion.json').write_text(json.dumps(summary, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({k: v for k, v in summary.items() if k != 'files_sha256'}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--corpus', type=Path, default=Path('ScrapperBecasFind/data_lake_becas/03_procesados'))
    parser.add_argument('--output', type=Path, default=Path('documentacion/auditoria_corpus/procesados'))
    parser.add_argument('--evidence', type=Path, default=Path('documentacion/auditoria_corpus/procesados/campos_confirmados.json'))
    args = parser.parse_args()
    if not args.corpus.is_dir() or not list(args.corpus.glob('*.csv')):
        parser.error('No se encontraron CSV procesados; no se generó un archivo vacío.')
    evidence = json.loads(args.evidence.read_text(encoding='utf-8')) if args.evidence.exists() else []
    prepare(args.corpus, args.output, evidence)
