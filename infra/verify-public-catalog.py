"""Comprueba catálogo público remoto sin iniciar sesión ni modificar registros."""
import json
import urllib.request
from collections import Counter
from pathlib import Path
from datetime import datetime, timezone

BASE = 'https://155-181-41-231.sslip.io/api'
ORIGIN = 'https://becasfind-pf8timp72-benjatlou13-1274.vercel.app'
ROOT = Path(__file__).resolve().parents[1]

def request(path, body=None, method=None, headers=None):
    req = urllib.request.Request(BASE + path,
        data=json.dumps(body).encode() if body is not None else None,
        headers={'Origin': ORIGIN, 'Content-Type': 'application/json', **(headers or {})}, method=method)
    with urllib.request.urlopen(req, timeout=30) as response:
        assert response.headers.get('Access-Control-Allow-Origin') == ORIGIN
        return response.status, json.loads(response.read() or b'null')

def main():
    status, _ = request('/becas/catalogo/buscar', method='OPTIONS', headers={
        'Access-Control-Request-Method': 'POST', 'Access-Control-Request-Headers': 'content-type'})
    assert status == 200
    rows = []
    for page in range(6):
        _, result = request('/becas/catalogo/buscar', {'page': page, 'size': 100})
        assert result['data']['totalElements'] == 528
        rows.extend(result['data']['content'])
    expected = set((ROOT/'backend/src/main/resources/catalogo-publico-uuid.txt').read_text().splitlines())
    assert len(rows) == len({r['idBeca'] for r in rows}) == 528
    assert {r['idBeca'] for r in rows} == expected
    states = dict(Counter(r['estadoPostulacion'] for r in rows))
    assert states['EN_REVISION'] == 199
    for state in states:
        item = next(row for row in rows if row['estadoPostulacion'] == state)
        _, result = request('/becas/catalogo/' + item['idBeca'])
        assert result['data']['estadoPostulacion'] == state
        assert result['data']['idBeca'] == item['idBeca']
    _, opened = request('/becas/buscar', {'size': 100})
    assert opened['data']['totalElements'] == 7
    assert all(r['estadoActiva'] and r['estadoPostulacion'] == 'ABIERTA' for r in opened['data']['content'])
    _, filtered = request('/becas/catalogo/buscar', {'query': 'Funcionarios', 'size': 100})
    assert filtered['data']['totalElements'] > 0
    _, institutions = request('/instituciones')
    institution_names = {item['nombre'] for item in institutions['data']}
    assert {row['nombreInstitucion'] for row in rows} <= institution_names
    report = {'verificado_utc': datetime.now(timezone.utc).isoformat(), 'origen': ORIGIN,
        'catalogo': len(rows), 'uuid_conservados': True, 'estados': states,
        'postulaciones_abiertas': opened['data']['totalElements'],
        'filtro_funcionarios': filtered['data']['totalElements'],
        'instituciones_en_selector': len(institution_names), 'selector_incluye_todo_el_catalogo': True,
        'preflight_y_cors': 'APROBADOS', 'detalles_por_estado': 'APROBADOS',
        'sin_sesion': True, 'sin_escrituras': True}
    output = ROOT/'documentacion/P12_CATALOGO_PREVIEW_2026_10_28.json'
    output.write_text(json.dumps(report, ensure_ascii=False, indent=2)+'\n', encoding='utf8')
    print(json.dumps(report, ensure_ascii=False))

if __name__ == '__main__':
    main()
