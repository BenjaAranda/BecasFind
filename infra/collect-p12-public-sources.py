"""Collect known public sources for calendar review; never confirm or activate records."""
import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
import hashlib
from html.parser import HTMLParser
import io
import json
from pathlib import Path
import re
import urllib.request
from urllib.parse import urlsplit

ROOT = Path(__file__).resolve().parents[1]
FOLDER = ROOT / 'documentacion/auditoria_corpus/procesados/despliegue_p12'
CACHE = ROOT / 'tmp/p12-fuentes-20261026'
MAXIMUM = 12 * 1024 * 1024


class VisibleText(HTMLParser):
    def __init__(self):
        super().__init__()
        self.hidden = 0
        self.parts = []

    def handle_starttag(self, tag, attrs):
        if tag in ('script', 'style'):
            self.hidden += 1
        if tag in ('p', 'br', 'div', 'li', 'h1', 'h2', 'h3', 'h4', 'tr'):
            self.parts.append('\n')

    def handle_endtag(self, tag):
        if tag in ('script', 'style') and self.hidden:
            self.hidden -= 1

    def handle_data(self, data):
        if not self.hidden:
            self.parts.append(data)


def fetch(url):
    key = hashlib.sha256(url.encode()).hexdigest()[:20]
    metadata = CACHE / (key + '.json')
    if metadata.exists():
        return json.loads(metadata.read_text(encoding='utf-8'))
    result = dict(url=url, texto_certificado=False)
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'BecasFind source review'})
        with urllib.request.urlopen(req, timeout=18) as response:
            raw = response.read(MAXIMUM + 1)
            result.update(http=response.status, url_final=response.url,
                          content_type=response.headers.get('Content-Type', ''))
            charset = response.headers.get_content_charset() or 'utf-8'
        if len(raw) > MAXIMUM:
            raise ValueError('Documento supera el límite de descarga; requiere lectura específica')
        result['sha256'] = hashlib.sha256(raw).hexdigest()
        if raw.startswith(b'%PDF'):
            from pypdf import PdfReader
            reader = PdfReader(io.BytesIO(raw))
            text = '\n'.join('PAGE '+str(i+1)+'\n'+(p.extract_text() or '')
                             for i, p in enumerate(reader.pages))
            result['formato'] = 'PDF'
        else:
            parser = VisibleText()
            parser.feed(raw.decode(charset, errors='replace'))
            text = ''.join(parser.parts)
            result['formato'] = 'HTML'
        lines = [re.sub(r'\s+', ' ', line).strip() for line in text.splitlines()]
        text = '\n'.join(line for line in lines if line)
        path = CACHE / (key + '.txt')
        path.write_text(text, encoding='utf-8')
        result['texto'] = path.relative_to(ROOT).as_posix()
        result['caracteres'] = len(text)
        relevant = []
        for i, line in enumerate(lines):
            if re.search(r'cierre|hasta el|plazo|octubre|noviembre|diciembre|2027', line, re.I):
                relevant.append(' '.join(lines[max(0, i-1):i+2])[:650])
        result['pasajes_calendario'] = list(dict.fromkeys(relevant))[:14]
        result['estado_recuperacion'] = 'TEXTO_RECUPERADO_PENDIENTE_LECTURA'
    except Exception as error:
        result.update(estado_recuperacion='NO_RECUPERADA', error=type(error).__name__+': '+str(error)[:180])
    metadata.write_text(json.dumps(result, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--workers', type=int, default=6)
    args = parser.parse_args()
    ledger = json.loads((FOLDER/'seleccion_publicacion_2026_10_26.json').read_text(encoding='utf-8'))
    groups = {}
    for row in ledger['registros']:
        if not row['nueva_revision_de_fuente_pendiente']:
            continue
        urls = [u for u in row['fuentes'] if urlsplit(u).scheme in ('http', 'https')
                and urlsplit(u).path.strip('/')]
        if urls:
            groups.setdefault(urls[0], []).append(dict(candidato=row['candidato'], nombre=row['nombre']))
    CACHE.mkdir(exist_ok=True, parents=True)
    results = []
    with ThreadPoolExecutor(max_workers=min(args.workers, 8)) as executor:
        futures = {executor.submit(fetch, u): u for u in groups}
        for future in as_completed(futures):
            result = future.result()
            result['candidatas'] = groups[futures[future]]
            results.append(result)
            if len(results) % 25 == 0:
                print(json.dumps(dict(fuentes_procesadas=len(results), total_fuentes=len(groups))), flush=True)
    results.sort(key=lambda x: x['url'])
    output = FOLDER/'fuentes_calendario_recuperadas_2026_10_26.json'
    output.write_text(json.dumps(results, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    print(json.dumps(dict(fuentes=len(results), candidatas=sum(len(x['candidatas']) for x in results),
                         textos=sum(x['estado_recuperacion'].startswith('TEXTO') for x in results),
                         no_recuperadas=sum(x['estado_recuperacion']=='NO_RECUPERADA' for x in results),
                         confirmadas_por_este_script=0)))
