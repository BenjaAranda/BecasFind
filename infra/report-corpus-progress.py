"""Report reconstructed records and editorial progress without counting duplicates twice."""
import csv
import json
from collections import defaultdict
from pathlib import Path
from urllib.parse import parse_qs, urlparse
from corpus_discard import read_discards


def specific_source(url):
    parsed = urlparse(url)
    if parsed.scheme != 'https' or not parsed.hostname or parsed.username or parsed.password:
        return False
    if parsed.path not in ('', '/'):
        return True
    query = parse_qs(parsed.query, keep_blank_values=True)
    keys = [key for key in ('page_id', 'p') if key in query]
    if len(keys) != 1:
        return False
    page_ids = query[keys[0]]
    return len(page_ids) == 1 and page_ids[0].isascii() and page_ids[0].isdigit() and int(page_ids[0]) > 0


def read_csv(path):
    with path.open(encoding='utf-8', newline='') as stream:
        return list(csv.DictReader(stream))


def write_csv(path, fields, rows):
    with path.open('w', encoding='utf-8', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=fields, lineterminator='\n')
        writer.writeheader()
        writer.writerows(rows)


def essential_confirmations(folder, reviewed, completed):
    path = folder/'confirmaciones_esenciales.json'
    entries = {}
    for entry in json.loads(path.read_text(encoding='utf-8')) if path.exists() else []:
        key = entry['candidato']
        checks = entry.get('verificaciones', {})
        if key not in reviewed or key in entries or key in completed:
            raise ValueError('Confirmación esencial desconocida, duplicada o ya completa')
        if set(checks) != {'identidad', 'fuente_oficial', 'cobertura', 'requisitos_principales'} or any(value is not True for value in checks.values()):
            raise ValueError('Confirmación esencial con verificaciones incompletas')
        if any(not entry.get(field) for field in ['alcance', 'beneficio', 'requisitos_principales', 'limites', 'fuentes', 'informe']):
            raise ValueError('Confirmación esencial sin alcance, datos o límites')
        if not (folder/entry['informe']).is_file():
            raise ValueError('Informe esencial ausente')
        if any(not specific_source(url) for url in entry['fuentes']):
            raise ValueError('Fuente esencial sin enlace específico válido')
        entries[key] = entry
    return entries


def report(folder):
    originals = [json.loads(line) for line in (folder/'originales.jsonl').read_text(encoding='utf-8').splitlines()]
    repairs = [json.loads(line) for line in (folder/'reparaciones/reparados.jsonl').read_text(encoding='utf-8').splitlines()]
    replaced = {(r['archivo'], r['registro_logico_anterior']) for r in repairs}
    rows = [dict(archivo=r['archivo'], referencia=f"registro original {r['registro']}", candidato=r['candidato'])
            for r in originals if (r['archivo'], r['registro']) not in replaced]
    rows += [dict(archivo=r['archivo'], referencia=f"línea física {r['linea_fisica']} reconstruida", candidato=r['candidato']) for r in repairs]
    identities = {r['candidato']:dict(nombre=r['nombre'], institucion=r['institucion']) for r in read_csv(folder/'indice.csv')}
    identities.update({r['candidato']:dict(nombre=r['nombre'], institucion=r['institucion']) for r in repairs})
    reviewed = read_csv(folder/'revisiones_parciales.csv')
    reviews = defaultdict(set)
    for entry in reviewed:
        if entry['candidato'] not in identities:
            raise ValueError('Revisión sin identidad en el inventario')
        if not (folder/entry['informe']).resolve().is_file():
            raise ValueError('Informe de revisión ausente')
        reviews[entry['candidato']].add(entry['informe'])
    completed = {}
    path = folder/'confirmaciones_completas.json'
    for entry in json.loads(path.read_text(encoding='utf-8')) if path.exists() else []:
        candidate = entry['candidato']
        checks = entry.get('verificaciones', {})
        if candidate not in reviews or candidate in completed:
            raise ValueError('Confirmación desconocida, duplicada o sin revisión previa')
        if set(checks) != {'identidad', 'convocatoria', 'cobertura', 'requisitos', 'documentos', 'discrepancias'} or any(value is not True for value in checks.values()):
            raise ValueError('Confirmación con verificaciones incompletas')
        if not entry.get('alcance') or not entry.get('fuentes') or not (folder/entry['informe']).is_file():
            raise ValueError('Confirmación sin alcance o evidencia')
        completed[candidate] = entry
    essential = essential_confirmations(folder, reviews, completed)
    discarded = read_discards(folder, identities, completed.keys() | essential.keys())
    closed = completed.keys() | essential.keys() | discarded.keys()
    files, institutions = defaultdict(list), defaultdict(set)
    for row in rows:
        identity = identities[row['candidato']]
        row.update(identity)
        candidate = row['candidato']
        reports = set(reviews.get(candidate, set()))
        if candidate in completed:
            reports.add(completed[candidate]['informe'])
        if candidate in essential:
            reports.add(essential[candidate]['informe'])
        if candidate in discarded:
            reports.add(discarded[candidate]['informe'])
        row.update(estado='DESCARTADA_EDITORIAL' if candidate in discarded else 'CONFIRMADA_COMPLETA' if candidate in completed else 'CONFIRMADA_ESENCIAL' if candidate in essential else 'REVISION_PARCIAL' if candidate in reviews else 'SIN_REVISION_INDIVIDUAL',
                   pendiente_confirmacion='false' if candidate in closed else 'true', informes='; '.join(sorted(reports)))
        files[row['archivo']].append(row)
        institutions[row['institucion']].add(row['candidato'])
    if set(identities) != {r['candidato'] for r in rows}:
        raise ValueError('Inventario y referencias no coinciden')
    output = folder/'avance'
    output.mkdir(exist_ok=True)
    fields = ['archivo', 'referencia', 'candidato', 'nombre', 'institucion', 'estado', 'pendiente_confirmacion', 'informes']
    write_csv(output/'por_registro.csv', fields, sorted(rows, key=lambda r:(r['archivo'],r['referencia'])))
    summary = []
    for filename, entries in sorted(files.items()):
        candidates = {r['candidato'] for r in entries}
        partial = len((candidates & reviews.keys())-closed)
        summary.append(dict(archivo=Path(filename).name, registros=len(entries), becas_unicas=len(candidates),
                            revision_parcial=partial, sin_revision_individual=len(candidates-reviews.keys()),
                            confirmadas_completas=len(candidates & completed.keys()), confirmadas_esenciales=len(candidates & essential.keys()), descartadas=len(candidates & discarded.keys()), pendientes_confirmacion=len(candidates-closed)))
    totals = dict(archivos=len(files), registros=len(rows), becas_unicas=len(identities),
                  revision_parcial=len(reviews.keys()-closed), sin_revision_individual=len(identities)-len(reviews),
                  confirmadas_completas=len(completed), confirmadas_esenciales=len(essential), descartadas=len(discarded), pendientes_confirmacion=len(identities)-len(closed))
    write_csv(output/'por_archivo.csv', list(summary[0]), summary)
    by_institution = [dict(institucion=name, becas_unicas=len(candidates), revision_parcial=len((candidates & reviews.keys())-closed),
                          sin_revision_individual=len(candidates-reviews.keys()), confirmadas_completas=len(candidates & completed.keys()), confirmadas_esenciales=len(candidates & essential.keys()), descartadas=len(candidates & discarded.keys()), pendientes_confirmacion=len(candidates-closed))
                      for name,candidates in sorted(institutions.items())]
    write_csv(output/'por_institucion.csv', list(by_institution[0]), by_institution)
    (output/'resumen.json').write_text(json.dumps(totals, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    table = '\n'.join(f"| {r['archivo']} | {r['registros']} | {r['becas_unicas']} | {r['revision_parcial']} | {r['confirmadas_esenciales']} | {r['descartadas']} | {r['sin_revision_individual']} | {r['pendientes_confirmacion']} |" for r in summary)
    text = f'''# Avance editorial por archivo

Inventario reconstruido al 2 de octubre de 2026: {totals['registros']} registros en {totals['archivos']} archivos; {totals['becas_unicas']} identidades únicas. {totals['revision_parcial']} tienen revisión parcial documentada y {totals['sin_revision_individual']} no tienen revisión individual. {totals['confirmadas_completas']} tienen confirmación completa y {totals['confirmadas_esenciales']} confirmación esencial: faltan {totals['pendientes_confirmacion']} por cerrar con el criterio vigente. Una confirmación no autoriza publicar como vigente sin cierre confirmado.

La incorporación administrativa está terminada. Hay {totals['descartadas']} candidatas descartadas editorialmente: se excluyen de la selección para publicar y de los pendientes; no son confirmaciones ni prueban inexistencia. Originales y registros administrativos inactivos se conservan. `descartes.json` documenta cada motivo y evidencia. El criterio esencial confirma identidad, fuente específica, beneficio y requisitos principales. Una confirmación no autoriza activar sin cierre confirmado.

Los conteos por archivo comparten becas repetidas: no sumar su columna de únicas para obtener el total global. `por_registro.csv` identifica cada una de las 647 referencias y su estado; `por_institucion.csv` agrupa las identidades. `revisiones_parciales.csv` conserva la relación candidata/informe; se cuenta revisión parcial una sola vez por candidato, incluso si aparece en varios archivos.

| Archivo | Registros | Becas únicas | Revisión parcial | Confirmadas esenciales | Descartadas | Sin revisión individual | Pendientes de cierre |
|---|---:|---:|---:|---:|---:|---:|---:|
{table}

Reproducir: `python infra/report-corpus-progress.py`. No consulta fuentes, modifica originales ni certifica automáticamente. Los informes enlazados contienen el alcance y límites de cada revisión.
'''
    (output/'README.md').write_text(text, encoding='utf-8')
    return totals


if __name__ == '__main__':
    print(json.dumps(report(Path('documentacion/auditoria_corpus/procesados')), ensure_ascii=False))
