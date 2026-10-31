"""Prepare an inactive import from closed editorial evidence; never activate records."""
import csv
import argparse
import hashlib
import io
import json
from collections import Counter
from datetime import date
from pathlib import Path
from urllib.parse import urlsplit


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'documentacion/auditoria_corpus/procesados'
OUTPUT = SOURCE / 'despliegue_p12'
FIELDS = ['nombre', 'institucion', 'tipo_beca', 'monto', 'fecha_inicio',
          'fecha_cierre', 'rsh_maximo', 'nem_minimo', 'regiones', 'descripcion',
          'descripcion_larga', 'url', 'documentos_requeridos', 'cobertura_tipo',
          'cobertura_importe', 'cobertura_moneda', 'cobertura_periodicidad',
          'cobertura_porcentaje', 'estado_activa', 'solo_crear']
COMPLETE_FILES = {
    '371af7982aa3b8152cd1d362a873b11e7744674163eef5d869aba7c715a031fe':
        'confirmacion_buch_admision_2027.csv',
    '2f9a8aa98fc2fdd2704fbbdefc3801b7549a2e23d9a08829919b6f1957fb26a5':
        'confirmacion_dalcahue_superior_2026.csv',
}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def confirmed_date(value):
    if value in (None, ''):
        return ''
    return date.fromisoformat(value).isoformat()


def specific_url(sources):
    for value in sources:
        parsed = urlsplit(value)
        if (parsed.scheme in ('http', 'https') and parsed.hostname
                and not parsed.username and parsed.path.strip('/')
                and len(value) <= 500):
            return value
    return ''


def prepare(output=OUTPUT):
    cases_path = SOURCE / 'cierre/casos.json'
    cases = json.loads(cases_path.read_text(encoding='utf-8'))
    counts = Counter(case['estado'] for case in cases)
    summary = json.loads((SOURCE / 'avance/resumen.json').read_text(encoding='utf-8'))
    expected = {'CONFIRMADA_ESENCIAL': summary['confirmadas_esenciales'],
                'CONFIRMADA_COMPLETA': summary['confirmadas_completas']}
    if any(counts[state] != count for state, count in expected.items()):
        raise ValueError('El cierre y el resumen editorial no coinciden')

    rows, ledger, identities, hashes = [], [], set(), set()
    inputs = {cases_path.relative_to(ROOT).as_posix(): digest(cases_path)}
    for case in sorted(cases, key=lambda item: item['candidato']):
        if case['estado'] not in expected:
            continue
        candidate = case['candidato']
        identity = (case['nombre'].strip(), case['institucion'].strip())
        if candidate in hashes or identity in identities:
            raise ValueError('Identidad duplicada: no fusionar candidatas al importar')
        hashes.add(candidate)
        identities.add(identity)
        row = dict.fromkeys(FIELDS, '')
        if case['estado'] == 'CONFIRMADA_COMPLETA':
            path = SOURCE / COMPLETE_FILES[candidate]
            with path.open(encoding='utf-8-sig', newline='') as stream:
                full_rows = list(csv.DictReader(stream))
            if len(full_rows) != 1 or (full_rows[0]['nombre'], full_rows[0]['institucion']) != identity:
                raise ValueError('El archivo completo no corresponde a la candidata')
            row.update({field: full_rows[0].get(field, '') for field in FIELDS})
            sources = [row['url']]
            inputs[path.relative_to(ROOT).as_posix()] = digest(path)
        else:
            evidence = case['confirmacion_esencial']
            for field in ('beneficio', 'requisitos_principales', 'alcance', 'fuentes'):
                if not evidence.get(field):
                    raise ValueError(f'Falta evidencia estructurada: {candidate}/{field}')
            sources = evidence['fuentes']
            benefit = evidence['beneficio']
            row['monto'] = benefit if len(benefit) <= 255 else ''
            documents = evidence.get('documentos') or 'No especificado en el expediente esencial.'
            row['descripcion_larga'] = '\n'.join([
                'ALCANCE VERIFICADO: ' + evidence['alcance'],
                'BENEFICIO: ' + benefit,
                'REQUISITOS PRINCIPALES: ' + evidence['requisitos_principales'],
                'LÍMITES: ' + (evidence.get('limites') or 'No especificado.'),
                'DOCUMENTOS REQUERIDOS: ' + documents,
            ])
            row['fecha_inicio'] = confirmed_date(evidence.get('fecha_inicio'))
            row['fecha_cierre'] = confirmed_date(evidence.get('fecha_cierre'))
            row['cobertura_tipo'] = 'DESCONOCIDA'

        row.update(nombre=identity[0], institucion=identity[1],
                   tipo_beca='No especificado', estado_activa='false', solo_crear='true',
                   url=specific_url(sources),
                   descripcion='Ficha confirmada para el alcance indicado en el detalle. Vigencia actual pendiente de comprobación.')
        row['descripcion_larga'] += (
            '\nTRAZABILIDAD EDITORIAL: ' + candidate + '; ' + case['estado']
            + '. Confirmación editorial separada de la vigencia publicable.'
        )
        for field in ('fecha_inicio', 'fecha_cierre'):
            row[field] = confirmed_date(row[field])
        for field, maximum in [('nombre', 255), ('institucion', 255), ('monto', 255), ('url', 500)]:
            if len(row[field]) > maximum:
                raise ValueError(f'Campo demasiado largo: {candidate}/{field}')
        rows.append(row)
        ledger.append(dict(fila_csv=len(rows) + 1, candidato=candidate, nombre=identity[0],
                           institucion=identity[1], estado=case['estado'], fuentes=sources,
                           informes=[item['informe'] for item in case['revisiones']],
                           referencias=case['referencias'], vigencia='NO_COMPROBADA_PARA_PUBLICACION',
                           estado_activa=False))

    if len(rows) != sum(expected.values()) or len(rows) != len(hashes):
        raise ValueError('Selección incompleta')
    stream = io.StringIO(newline='')
    writer = csv.DictWriter(stream, fieldnames=FIELDS, lineterminator='\n')
    writer.writeheader()
    writer.writerows(rows)
    content = stream.getvalue().encode('utf-8')
    path = output / 'confirmadas_inactivas.csv'
    if path.exists() and path.read_bytes() != content:
        raise ValueError('Conservar el paquete previo: usa --output con una carpeta nueva para la revisión')
    output.mkdir(parents=True, exist_ok=True)
    path.write_bytes(content)
    manifest = dict(entradas=expected, filas=len(rows), activas=0,
                    descartadas_excluidas=counts['DESCARTADA_EDITORIAL'],
                    csv_sha256=digest(path), fuentes_sha256=inputs, registros=ledger)
    (output / 'trazabilidad.json').write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({key: value for key, value in manifest.items() if key != 'registros'}, ensure_ascii=True))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=OUTPUT)
    prepare(parser.parse_args().output)
