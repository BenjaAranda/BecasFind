"""Reconcile the fixed audit cohort with explicit, individually written findings."""
import csv
import hashlib
import io
import json
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'documentacion/auditoria_corpus/procesados/despliegue_p12/seleccion_publicacion_2026_10_27.json'
FOLDER = ROOT / 'documentacion/auditoria_corpus/procesados/auditoria_vigencia_2026_10_27'
STATES = {'VIGENTE_CON_CIERRE_CONFIRMADO', 'CERRADA_CONFIRMADA', 'PERMANENTE_CONFIRMADA',
          'CALENDARIO_POR_MODALIDAD', 'SIN_CALENDARIO_PUBLICADO', 'REVISION_INCONCLUSA'}


def main():
    previous = json.loads(SOURCE.read_text(encoding='utf-8'))
    cohort = [row for row in previous['registros']
              if row['decision'] == 'INACTIVA_CALENDARIO_DESCONOCIDO_O_VIGENCIA_NO_ACREDITADA']
    assert len(cohort) == len({row['public_id'] for row in cohort}) == 466
    findings = json.loads((FOLDER / 'hallazgos.json').read_text(encoding='utf-8'))
    by_id = {row['id_beca']: row for row in findings}
    assert len(by_id) == len(findings)
    assert set(by_id).issubset({row['id_beca'] for row in cohort})
    rows = []
    for old in cohort:
        finding = by_id.get(old['id_beca'])
        row = dict(candidato=old['candidato'], id_beca=old['id_beca'], public_id=old['public_id'],
                   nombre=old['nombre'], institucion=old['institucion'], estado_editorial=old['estado_editorial'],
                   modalidad_anio=old['alcance'], estado_previo=old['decision'],
                   evidencia_anterior=dict(informe=old['informe'], fuentes=old['fuentes'],
                                           observacion=old['observacion_vigencia'],
                                           recuperacion=old.get('consulta_publica')),
                   revision_individual_realizada=False, clasificacion_nueva=None, fuentes=[],
                   fecha_consulta=None, referencia=None, apertura=None, cierre=None, hora_cierre=None, zona_horaria=None,
                   razonamiento='No investigada todavía en esta auditoría. La etiqueta previa no sustituye la lectura.',
                   limitaciones='Vigencia actual sin comprobar.', propuesta_cambio='No modificar la BD sin evidencia.',
                   estado_aplicacion='SIN_CAMBIO', siguiente_accion='Leer expediente y buscar convocatoria oficial actual.')
        if finding:
            assert finding['clasificacion_nueva'] in STATES
            for field in ('fuentes', 'fecha_consulta', 'referencia', 'razonamiento', 'limitaciones',
                          'propuesta_cambio', 'estado_aplicacion', 'modalidad_anio', 'siguiente_accion'):
                assert finding.get(field), (old['id_beca'], field)
            row.update(finding)
            row['revision_individual_realizada'] = True
        rows.append(row)
    summary = dict(cohorte=466, fuente_inicial=SOURCE.relative_to(ROOT).as_posix(),
                   sha256_fuente=hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
                   leidas_individualmente=len(findings), sin_revisar=466-len(findings),
                   resueltas=sum(x['clasificacion_nueva'] != 'REVISION_INCONCLUSA' for x in findings),
                   inconclusas=sum(x['clasificacion_nueva'] == 'REVISION_INCONCLUSA' for x in findings),
                   clasificaciones=dict(Counter(x['clasificacion_nueva'] for x in findings)),
                   aplicacion=dict(Counter(x['estado_aplicacion'] for x in findings)),
                   activadas=sum(x.get('activacion_aplicada') is True for x in findings),
                   activables=sum(x.get('activable_acreditada') is True for x in findings),
                   pendientes_de_aplicar=sum(x['estado_aplicacion'] == 'PENDIENTE' for x in findings),
                   auditoria_concluida=False,
                   limite='Leídas individualmente incluye investigaciones inconclusas y no implica lectura íntegra de cada expediente. Activable exige valoración explícita adicional al calendario; no se infiere de su clasificación. La aplicación remota exige recibo y conciliación.')
    (FOLDER / 'inventario.json').write_text(json.dumps(rows, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    (FOLDER / 'avance.json').write_text(json.dumps(summary, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    buffer = io.StringIO(newline='')
    fields = list(dict.fromkeys(key for row in rows for key in row))
    writer = csv.DictWriter(buffer, fieldnames=fields, lineterminator='\n')
    writer.writeheader()
    for row in rows:
        writer.writerow({key: json.dumps(value, ensure_ascii=False) if isinstance(value, (dict, list)) else value
                         for key, value in row.items()})
    (FOLDER / 'inventario.csv').write_text(buffer.getvalue(), encoding='utf-8', newline='')
    print(json.dumps(summary, ensure_ascii=False))


if __name__ == '__main__':
    main()
