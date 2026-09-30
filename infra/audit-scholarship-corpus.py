"""Read-only corpus audit. HTTP success never counts as verified requirements or deadlines."""
import argparse
import collections
import concurrent.futures
import csv
import hashlib
import io
import ipaddress
import json
from pathlib import Path
import re
import socket
import unicodedata
import urllib.error
import urllib.parse
import urllib.request


def normalized(value):
    return ''.join(c for c in unicodedata.normalize('NFKD', value.lower()) if not unicodedata.combining(c)).strip()


def public_url(url):
    parsed = urllib.parse.urlsplit(url)
    if parsed.scheme not in ('http', 'https') or not parsed.hostname or parsed.username or parsed.password:
        raise ValueError('URL no pública o no HTTP/HTTPS')
    if parsed.port not in (None, 80, 443):
        raise ValueError('Puerto no permitido para una fuente pública')
    addresses = socket.getaddrinfo(parsed.hostname, parsed.port or (443 if parsed.scheme == 'https' else 80))
    if not addresses or any(not ipaddress.ip_address(item[4][0]).is_global for item in addresses):
        raise ValueError('Destino privado o no verificable')
    return parsed


class PublicRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, request, response, code, message, headers, newurl):
        public_url(newurl)
        return super().redirect_request(request, response, code, message, headers, newurl)


def check_source(url):
    result = {'url': url, 'status': '', 'final_url': '', 'content_sha256': '', 'error': ''}
    try:
        public_url(url)
        opener = urllib.request.build_opener(PublicRedirect())
        request = urllib.request.Request(url, headers={'User-Agent': 'BecasFind-source-audit/1.0'})
        with opener.open(request, timeout=8) as response:
            result.update(status=str(response.status), final_url=response.url)
            result['content_sha256'] = hashlib.sha256(response.read(2_000_000)).hexdigest()
    except urllib.error.HTTPError as error:
        result.update(status=str(error.code), final_url=error.url, error='HTTP no accesible')
    except (OSError, ValueError, urllib.error.URLError) as error:
        result['error'] = type(error).__name__
    return result


def write_csv(path, fields, rows):
    with path.open('w', encoding='utf-8', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=fields, extrasaction='ignore')
        writer.writeheader()
        writer.writerows(rows)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--corpus', type=Path, default=Path('ScrapperBecasFind/data_lake_becas'))
    parser.add_argument('--output', type=Path, default=Path('documentacion/auditoria_corpus'))
    parser.add_argument('--check-links', action='store_true')
    args = parser.parse_args()
    rows, file_errors = [], []
    files = sorted(args.corpus.rglob('*.csv'))
    for path in files:
        try:
            raw = path.read_bytes()
            reader = csv.DictReader(io.StringIO(raw.decode('utf-8-sig')))
            for index, row in enumerate(reader, 1):
                rows.append({'archivo': path.as_posix(), 'registro': index, 'bom': raw.startswith(b'\xef\xbb\xbf'), 'row': row})
        except (UnicodeError, csv.Error) as error:
            file_errors.append({'archivo': path.as_posix(), 'error': type(error).__name__})
    grouped = collections.defaultdict(list)
    for item in rows:
        row = item['row']
        grouped[(normalized(row.get('nombre', '')), normalized(row.get('institucion', '')))].append(item)
    duplicates = [dict(nombre=key[0], institucion=key[1], ocurrencias=len(items), referencias='; '.join(f"{i['archivo']}#{i['registro']}" for i in items)) for key, items in grouped.items() if len(items) > 1]
    urls = sorted({item['row'].get('url', '').strip() for item in rows if item['row'].get('url')})
    source_results = {}
    if args.check_links:
        with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:
            for index, result in enumerate(pool.map(check_source, urls), 1):
                source_results[result['url']] = result
                if index % 40 == 0:
                    print(f'Fuentes revisadas: {index}/{len(urls)}', flush=True)
    audited, quarantine = [], []
    for item in rows:
        row = item['row']; url = row.get('url', '').strip()
        parsed = urllib.parse.urlsplit(url)
        flags = ['REQUISITOS_FECHAS_DOCUMENTOS_SIN_EVIDENCIA_REGISTRADA']
        if not parsed.hostname or parsed.path in ('', '/'):
            flags.append('URL_RAIZ_O_AUSENTE')
        if row.get('fecha_cierre') == '2026-12-31':
            flags.append('CIERRE_FIN_DE_ANO_REQUIERE_FUENTE')
        text = ' '.join(str(value) for value in row.values())
        if any(pattern in text for pattern in ('Ã', 'Â', '\ufffd')):
            flags.append('POSIBLE_MOJIBAKE')
        if re.search(r'\b(educacion|matricula|institucion|ensenanza|Valparaiso|Vina|Nuble|Republica|Catolica|postulacion)\b', text, re.I):
            flags.append('TILDES_POR_REVISAR')
        if 'DOCUMENTOS REQUERIDOS:' not in row.get('descripcion_larga', ''):
            flags.append('DOCUMENTOS_SIN_SECCION')
        if item['bom']:
            flags.append('UTF8_CON_BOM')
        source = source_results.get(url, {})
        if args.check_links and source.get('status') != '200':
            flags.append('FUENTE_NO_ACCESIBLE')
        key = (normalized(row.get('nombre', '')), normalized(row.get('institucion', '')))
        audited.append(dict(archivo=item['archivo'], registro=item['registro'], nombre=row.get('nombre', ''), institucion=row.get('institucion', ''), url=url, estado='CUARENTENA', http_status=source.get('status', ''), ocurrencias=len(grouped[key]), hallazgos=';'.join(flags)))
        # Preserve originals elsewhere. This file cannot present unsupported dates/requirements as confirmed.
        quarantine.append(dict(row, fecha_inicio='', fecha_cierre='', rsh_maximo='', nem_minimo='',
            descripcion='Registro histórico pendiente de confirmación oficial.',
            descripcion_larga='Información histórica no verificada. DOCUMENTOS REQUERIDOS: no confirmados.',
            documentos_requeridos='', cobertura_tipo='DESCONOCIDA', cobertura_importe='', cobertura_moneda='', cobertura_periodicidad='', cobertura_porcentaje=''))
    args.output.mkdir(parents=True, exist_ok=True)
    write_csv(args.output/'filas.csv', ['archivo','registro','nombre','institucion','url','estado','http_status','ocurrencias','hallazgos'], audited)
    write_csv(args.output/'duplicados.csv', ['nombre','institucion','ocurrencias','referencias'], duplicates)
    write_csv(args.output/'fuentes.csv', ['url','status','final_url','content_sha256','error'], source_results.values())
    csv_fields = ['nombre','institucion','tipo_beca','monto','fecha_inicio','fecha_cierre','rsh_maximo','nem_minimo','regiones','descripcion','descripcion_larga','url','documentos_requeridos','cobertura_tipo','cobertura_importe','cobertura_moneda','cobertura_periodicidad','cobertura_porcentaje']
    write_csv(args.output/'cuarentena.csv', csv_fields, quarantine)
    summary = dict(files=len(files), rows=len(rows), unique_keys=len(grouped), duplicate_keys=len(duplicates), sources=len(urls), checked_sources=len(source_results), status_counts=dict(collections.Counter(r['status'] or r['error'] for r in source_results.values())), file_errors=file_errors)
    (args.output/'resumen.json').write_bytes(json.dumps(summary, ensure_ascii=False, indent=2).encode('utf-8'))
    print(json.dumps(summary, ensure_ascii=True), flush=True)


if __name__ == '__main__':
    main()
