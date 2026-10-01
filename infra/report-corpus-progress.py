"""Report reconstructed records and editorial progress without counting duplicates twice."""
import csv
import json
from collections import defaultdict
from pathlib import Path


def read_csv(path):
    with path.open(encoding='utf-8', newline='') as stream:
        return list(csv.DictReader(stream))


def write_csv(path, fields, rows):
    with path.open('w', encoding='utf-8', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=fields, lineterminator='\n')
        writer.writeheader()
        writer.writerows(rows)


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
    files, institutions = defaultdict(list), defaultdict(set)
    for row in rows:
        identity = identities[row['candidato']]
        row.update(identity)
        row.update(estado='REVISION_PARCIAL' if row['candidato'] in reviews else 'SIN_REVISION_INDIVIDUAL',
                   pendiente_confirmacion='true', informes='; '.join(sorted(reviews.get(row['candidato'], set()))))
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
        partial = len(candidates & reviews.keys())
        summary.append(dict(archivo=Path(filename).name, registros=len(entries), becas_unicas=len(candidates),
                            revision_parcial=partial, sin_revision_individual=len(candidates)-partial,
                            confirmadas_completas=0, pendientes_confirmacion=len(candidates)))
    totals = dict(archivos=len(files), registros=len(rows), becas_unicas=len(identities),
                  revision_parcial=len(reviews), sin_revision_individual=len(identities)-len(reviews),
                  confirmadas_completas=0, pendientes_confirmacion=len(identities))
    write_csv(output/'por_archivo.csv', list(summary[0]), summary)
    by_institution = [dict(institucion=name, becas_unicas=len(candidates), revision_parcial=len(candidates & reviews.keys()),
                          sin_revision_individual=len(candidates-reviews.keys()), pendientes_confirmacion=len(candidates))
                      for name,candidates in sorted(institutions.items())]
    write_csv(output/'por_institucion.csv', list(by_institution[0]), by_institution)
    (output/'resumen.json').write_text(json.dumps(totals, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    table = '\n'.join(f"| {r['archivo']} | {r['registros']} | {r['becas_unicas']} | {r['revision_parcial']} | {r['sin_revision_individual']} | {r['pendientes_confirmacion']} |" for r in summary)
    text = f'''# Avance editorial por archivo

Inventario reconstruido al 1 de octubre de 2026: {totals['registros']} registros en {totals['archivos']} archivos; {totals['becas_unicas']} identidades únicas. {totals['revision_parcial']} tienen revisión parcial documentada y {totals['sin_revision_individual']} no tienen revisión individual. Ninguna tiene confirmación editorial completa: faltan {totals['pendientes_confirmacion']} por cerrar, incluidas las revisadas parcialmente.

La incorporación administrativa está terminada. «Pendiente» aquí significa confirmar identidad, convocatoria, requisitos, documentos y cobertura antes de publicar; no significa que falte importar. Una referencia revisada puede detectar contradicciones o ausencia de confirmación. Las 573 becas de la base local incluyen registros previos ajenos al inventario; no usar ese total para contar pendientes del corpus.

Los conteos por archivo comparten becas repetidas: no sumar su columna de únicas para obtener el total global. `por_registro.csv` identifica cada una de las 647 referencias y su estado; `por_institucion.csv` agrupa las identidades. `revisiones_parciales.csv` conserva la relación candidata/informe; se cuenta revisión parcial una sola vez por candidato, incluso si aparece en varios archivos.

| Archivo | Registros | Becas únicas | Revisión parcial | Sin revisión individual | Pendientes de cierre |
|---|---:|---:|---:|---:|---:|
{table}

Reproducir: `python infra/report-corpus-progress.py`. No consulta fuentes, modifica originales ni certifica automáticamente. Los informes enlazados contienen el alcance y límites de cada revisión.
'''
    (output/'README.md').write_text(text, encoding='utf-8')
    return totals


if __name__ == '__main__':
    print(json.dumps(report(Path('documentacion/auditoria_corpus/procesados')), ensure_ascii=False))
