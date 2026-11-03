"""Compare a read-only Oracle scholarship snapshot with the original P12 import."""
import argparse
import csv
import hashlib
import json
import re
from collections import Counter
from decimal import Decimal
from pathlib import Path
from uuid import UUID


ROOT = Path(__file__).resolve().parents[1]
FOLDER = ROOT / 'documentacion/auditoria_corpus/procesados/despliegue_p12'
FIELDS = {
    'nombre': 'nombre', 'institucion': 'institucion', 'tipo_beca': 'tipo_beca',
    'descripcion': 'descripcion_corta', 'descripcion_larga': 'descripcion_larga',
    'monto': 'monto_cobertura', 'url': 'url_oficial',
    'fecha_inicio': 'fecha_inicio_postulacion', 'fecha_cierre': 'fecha_cierre_postulacion',
    'cobertura_tipo': 'cobertura_tipo', 'cobertura_importe': 'cobertura_importe',
    'cobertura_moneda': 'cobertura_moneda', 'cobertura_periodicidad': 'cobertura_periodicidad',
    'cobertura_porcentaje': 'cobertura_porcentaje', 'rsh_maximo': 'rsh_maximo_porcentaje',
    'nem_minimo': 'nem_minimo',
}
NUMERIC = {'cobertura_importe', 'cobertura_porcentaje', 'rsh_maximo', 'nem_minimo'}


def normalized(value, numeric=False):
    if value is None or value == '':
        return None
    return Decimal(str(value)) if numeric else value


def reconcile(snapshot_path, baseline_path=None):
    raw = snapshot_path.read_bytes()
    snapshot = json.loads(raw)
    manifest = json.loads((FOLDER / 'trazabilidad.json').read_text(encoding='utf-8'))
    csv_path = FOLDER / 'confirmadas_inactivas.csv'
    if hashlib.sha256(csv_path.read_bytes()).hexdigest() != manifest['csv_sha256']:
        raise ValueError('El CSV inicial cambió respecto a su trazabilidad')
    with csv_path.open(encoding='utf-8', newline='') as stream:
        rows = list(csv.DictReader(stream))
    expected = {item['candidato']: (item, rows[item['fila_csv'] - 2])
                for item in manifest['registros']}
    baseline = {}
    if baseline_path:
        baseline = {item['public_id']: item['candidato'] for item in
                    json.loads(baseline_path.read_text(encoding='utf-8'))['registros']}
    actual, public_ids, internal_ids = {}, set(), set()
    for row in snapshot['filas']:
        matches = re.findall(r'TRAZABILIDAD EDITORIAL: ([0-9a-f]{64});', row['descripcion_larga'])
        public_id = str(UUID(row['public_id']))
        if not matches and public_id in baseline:
            matches = [baseline[public_id]]
        if len(matches) != 1 or matches[0] in actual:
            raise ValueError('Trazabilidad ausente, repetida o ambigua en Oracle')
        if baseline and baseline.get(public_id) != matches[0]:
            raise ValueError('La candidata cambió de UUID respecto al inventario inicial')
        if public_id in public_ids or row['id_beca'] in internal_ids:
            raise ValueError('Identificador repetido en Oracle')
        public_ids.add(public_id)
        internal_ids.add(row['id_beca'])
        actual[matches[0]] = row
    if len(rows) != 528 or set(expected) != set(actual):
        raise ValueError('Las 528 candidatas no coinciden exactamente con Oracle')

    results = []
    for candidate, (trace, imported) in expected.items():
        found = actual[candidate]
        differences = [field for field, target in FIELDS.items()
                       if normalized(imported[field], field in NUMERIC)
                       != normalized(found[target], field in NUMERIC)]
        if found['estado_activa'] != (imported['estado_activa'] == 'true'):
            differences.append('estado_activa')
        regions = sorted(x.strip().casefold() for x in imported['regiones'].split(',') if x.strip())
        if regions != sorted(x.casefold() for x in (found['regiones'] or [])):
            differences.append('regiones')
        documents = []
        for value in imported['documentos_requeridos'].split(';'):
            if value.strip():
                documents.append((re.sub(r'\[(OBLIGATORIO|OPCIONAL)\]', '', value,
                                         flags=re.I).strip(), '[OBLIGATORIO]' in value.upper()))
        if sorted(documents) != sorted((x['nombre'], x['obligatorio']) for x in (found['documentos'] or [])):
            differences.append('documentos_requeridos')
        results.append(dict(candidato=candidate, id_beca=found['id_beca'],
                            public_id=found['public_id'], version=found['version'],
                            nombre=found['nombre'], institucion=found['institucion'],
                            estado_editorial=trace['estado'], campos_diferentes=differences,
                            estado_activa=found['estado_activa'],
                            fecha_inicio=found['fecha_inicio_postulacion'],
                            fecha_cierre=found['fecha_cierre_postulacion']))
    report = dict(capturado_utc=snapshot['capturado_utc'], fecha_santiago=snapshot['fecha_santiago'],
                  snapshot_sha256=hashlib.sha256(raw).hexdigest(), csv_sha256=manifest['csv_sha256'],
                  total=len(results), uuid_unicos=len(public_ids), candidatas_unicas=len(actual),
                  fichas_identicas=sum(not x['campos_diferentes'] for x in results),
                  fichas_con_diferencias=sum(bool(x['campos_diferentes']) for x in results),
                  activas=sum(x['estado_activa'] for x in results),
                  editoriales=dict(Counter(x['estado_editorial'] for x in results)),
                  alcance='Conciliación íntegra de campos importados; no certifica convocatoria vigente.',
                  registros=results)
    return report


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('snapshot', type=Path)
    parser.add_argument('--baseline', type=Path)
    parser.add_argument('--output', type=Path, default=FOLDER / 'conciliacion_oracle_inicial.json')
    args = parser.parse_args()
    report = reconcile(args.snapshot, args.baseline)
    args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({key: value for key, value in report.items() if key != 'registros'}, ensure_ascii=True))
