"""Read-only API flow checks against P12; keep login credentials only in memory."""
import argparse
import getpass
import json
import urllib.error
import urllib.request
from datetime import datetime, timezone
from pathlib import Path
from uuid import UUID

BASE = 'https://155-181-41-231.sslip.io/api'
ORIGIN = 'https://becasfind-afeqpkmym-benjatlou13-1274.vercel.app'
BUCH = 'c8d21ab3-66b0-45ad-8d2b-17c764918549'
PARENT = 'dc6f8e70-8943-43f6-a9c1-2d78896987f1'
UDD = '9635ce70-13f6-427d-a012-6d470a51d2d0'
ECON = 'bc2eb567-a143-4bf6-9fdb-ef1e722e9df1'
MILENIO = 'b5866285-b077-4806-b0cb-2d8f277956f6'
GRATUIDAD = '1178ad3c-4894-4f76-a060-e0d75cacfa1e'
EXPECTED = {BUCH, PARENT, ECON, MILENIO, GRATUIDAD}


def request(path, payload=None, token=None, method=None, headers=None):
    hdr = {'Origin': ORIGIN, **(headers or {})}
    if payload is not None:
        hdr['Content-Type'] = 'application/json'
    if token:
        hdr['Authorization'] = 'Bearer ' + token
    req = urllib.request.Request(BASE + path,
        data=json.dumps(payload).encode('utf-8') if payload is not None else None,
        headers=hdr, method=method)
    with urllib.request.urlopen(req, timeout=30) as response:
        body = response.read()
        return response.status, dict(response.headers), json.loads(body) if body else None


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--admin', action='store_true')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    checks = []
    status, headers, _ = request('/becas/buscar', method='OPTIONS', headers={
        'Access-Control-Request-Method': 'POST', 'Access-Control-Request-Headers': 'content-type'})
    assert status == 200 and headers.get('Access-Control-Allow-Origin') == ORIGIN
    checks.append('CORS preview exacto')
    _, _, page = request('/becas')
    page = page['data']
    assert page['totalElements'] == 5
    assert {x['idBeca'] for x in page['content']} == EXPECTED
    for value in page['content']:
        UUID(value['idBeca'])
    checks.append('Listado público: cinco UUID esperados')
    for query, expected in [('Funcionarios', {PARENT}), ('Universidad', {BUCH})]:
        _, _, result = request('/becas/buscar', {'query': query})
        assert {x['idBeca'] for x in result['data']['content']} == expected
    checks.append('Búsqueda textual por ambas fichas')
    for filters, expected in [({'rsh': 90, 'nem': 6.0}, {BUCH}),
                              ({'rsh': 91, 'nem': 6.0}, set()),
                              ({'rsh': 50, 'nem': 5.9}, set()),
                              ({'nem': 5.9}, {MILENIO}),
                              ({'regionId': 16}, EXPECTED)]:
        _, _, result = request('/becas/buscar', filters)
        assert {x['idBeca'] for x in result['data']['content']} == expected
    checks.append('Filtros RSH/NEM y región nacional con datos reales')
    _, _, result = request('/becas/buscar', {'sort': 'fechaAsc'})
    assert [x['idBeca'] for x in result['data']['content']] == [BUCH, MILENIO, GRATUIDAD, PARENT, ECON]
    checks.append('Orden ascendente de cierre')
    for public_id, closing in [(BUCH, '2026-10-30'), (PARENT, '2026-12-31'),
                               (MILENIO, '2026-11-05'), (GRATUIDAD, '2026-11-05'), (ECON, '2027-01-28')]:
        _, _, result = request('/becas/' + public_id)
        assert result['data']['fechaCierrePostulacion'] == closing
        assert result['data']['tipoBeca']['nombre'] == 'Beca de Arancel'
        assert 'TRAZABILIDAD EDITORIAL:' not in result['data']['descripcionLarga']
    checks.append('Detalle público con cierres oficiales')
    try:
        request('/becas/' + UDD)
        raise AssertionError('La ficha inactiva está expuesta')
    except urllib.error.HTTPError as error:
        assert error.code == 404
    checks.append('Ficha UDD inactiva excluida del detalle público')
    try:
        request('/becas/administracion')
        raise AssertionError('Administración abierta sin sesión')
    except urllib.error.HTTPError as error:
        assert error.code in (401, 403)
    checks.append('Administración protegida sin sesión')
    if args.admin:
        password = getpass.getpass('Contraseña de la cuenta ADMIN (entrada oculta): ')
        _, _, login = request('/auth/login', {
            'email': 'benjamin.aranda.dev@gmail.com', 'password': password})
        password = None
        assert login['data']['nombreRol'] == 'ADMIN'
        token = login['data']['token']
        _, _, result = request('/becas/administracion?size=100', token=token)
        assert result['data']['totalElements'] == 528
        for internal_id, public_id in [(104, BUCH), (356, PARENT), (310, UDD)]:
            _, _, result = request('/becas/administracion/' + str(internal_id), token=token)
            assert result['data']['nombre']
        token = None
        checks.append('Cuenta propia ADMIN: 528 fichas y 3 detalles reales')
    report = dict(verificado_utc=datetime.now(timezone.utc).isoformat(), api=BASE,
                  origen=ORIGIN, comprobaciones=checks, todas_aprobadas=True,
                  alcance='API HTTPS real; no sustituye una prueba visual en navegador.')
    args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    print(json.dumps(report, ensure_ascii=True))


if __name__ == '__main__':
    main()
