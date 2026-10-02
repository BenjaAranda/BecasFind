"""Compare historical references without treating equal names as confirmed duplicates."""
import csv
import json
from collections import defaultdict
from pathlib import Path


def report(folder):
    originals = [json.loads(line) for line in (folder/'originales.jsonl').read_text(encoding='utf-8').splitlines()]
    repairs = [json.loads(line) for line in (folder/'reparaciones/reparados.jsonl').read_text(encoding='utf-8').splitlines()]
    replaced = {(row['archivo'], row['registro_logico_anterior']) for row in repairs}
    groups = defaultdict(list)
    for row in originals:
        if (row['archivo'], row['registro']) not in replaced:
            groups[row['candidato']].append(dict(archivo=row['archivo'], referencia=f"registro original {row['registro']}", campos=row['original']))
    for row in repairs:
        groups[row['candidato']].append(dict(archivo=row['archivo'], referencia=f"línea física {row['linea_fisica']} reconstruida", campos=row['reconstruido']))
    with (folder/'indice.csv').open(encoding='utf-8', newline='') as stream:
        identities = {row['candidato']: row for row in csv.DictReader(stream)}
    identities.update({row['candidato']: row for row in repairs})
    reconciled = {}
    path = folder/'variantes/conciliaciones.json'
    for entry in json.loads(path.read_text(encoding='utf-8')) if path.exists() else []:
        candidate = entry['candidato']
        if candidate not in groups or len(groups[candidate])<2 or candidate in reconciled:
            raise ValueError('Conciliación desconocida, duplicada o sin referencias repetidas')
        if not entry.get('fuentes') or not entry.get('decision_identidad') or not (folder/'variantes'/entry['informe']).is_file():
            raise ValueError('Conciliación sin fuentes, identidad o informe')
        reconciled[candidate] = entry
    output = folder/'variantes'
    output.mkdir(exist_ok=True)
    summary, details = [], []
    for candidate, entries in sorted(groups.items()):
        if len(entries) < 2:
            continue
        fields = sorted(set().union(*(entry['campos'].keys() for entry in entries)))
        different = [field for field in fields if len({entry['campos'].get(field, '') for entry in entries}) > 1]
        if candidate in reconciled and set(reconciled[candidate]['campos']) != set(different):
            raise ValueError('Conciliación sin decisión para cada campo distinto')
        summary.append(dict(candidato=candidate, nombre=identities[candidate]['nombre'], institucion=identities[candidate]['institucion'],
                            referencias=len(entries), campos_distintos='; '.join(different), estado='CONCILIADO' if candidate in reconciled else 'PENDIENTE_CONCILIACION'))
        details.append(dict(candidato=candidate, referencias=entries, campos_distintos=different, conciliacion=reconciled.get(candidate)))
    with (output/'grupos.csv').open('w', encoding='utf-8', newline='') as stream:
        fields = ['candidato', 'nombre', 'institucion', 'referencias', 'campos_distintos', 'estado']
        writer = csv.DictWriter(stream, fieldnames=fields, lineterminator='\n')
        writer.writeheader()
        writer.writerows(summary)
    (output/'referencias.json').write_text(json.dumps(details, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    totals = dict(grupos=len(summary), referencias=sum(row['referencias'] for row in summary),
                  referencias_adicionales=sum(row['referencias']-1 for row in summary),
                  grupos_con_campos_distintos=sum(bool(row['campos_distintos']) for row in summary),
                  grupos_conciliados=len(reconciled), grupos_pendientes=len(summary)-len(reconciled))
    (output/'resumen.json').write_text(json.dumps(totals, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    return totals


if __name__ == '__main__':
    print(json.dumps(report(Path('documentacion/auditoria_corpus/procesados')), ensure_ascii=False))
