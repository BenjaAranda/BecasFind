"""Inventory review evidence and check access; neither operation certifies a scholarship."""
import argparse
import csv
import hashlib
import json
import re
import threading
import urllib.error
import urllib.request
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime, timezone
from pathlib import Path
from urllib.parse import urlparse


def read_csv(path):
    with path.open(encoding='utf-8', newline='') as stream:
        return list(csv.DictReader(stream))


def inventory(folder):
    cases = {}
    for row in read_csv(folder/'avance/por_registro.csv'):
        case = cases.setdefault(row['candidato'], dict(candidato=row['candidato'], nombre=row['nombre'],
                                institucion=row['institucion'], estado=row['estado'], referencias=[], revisiones=[]))
        case['referencias'].append(dict(archivo=row['archivo'], referencia=row['referencia']))
    reports = {}
    for row in read_csv(folder/'revisiones_parciales.csv'):
        if row['candidato'] not in cases:
            raise ValueError('Revisión sin candidata')
        name = row['informe']
        if name not in reports:
            text = (folder/name).read_text(encoding='utf-8')
            reports[name] = dict(sha256=hashlib.sha256((folder/name).read_bytes()).hexdigest(),
                                 urls=sorted(set(re.findall(r'https?://[^\s)<>`]+', text))), texto=text)
        case = cases[row['candidato']]
        report = reports[name]
        lines = report['texto'].splitlines()
        hits = [index for index, line in enumerate(lines) if row['candidato'] in line]
        excerpts = []
        for index in hits:
            end = index+1
            if not lines[index].startswith('|'):
                while end < len(lines) and not lines[end].startswith('## '):
                    end += 1
            excerpts.append('\n'.join(lines[index:end]).strip())
        if not excerpts:
            excerpts = ['El informe enlazado no tiene un apartado identificado por este hash. Requiere lectura de la sección correspondiente; no se atribuyen automáticamente sus fuentes al candidato.']
        case['revisiones'].append(dict(informe=name, informe_sha256=report['sha256'], extractos=excerpts))
    if any(not case['revisiones'] for case in cases.values()):
        raise ValueError('Candidata sin evidencia de revisión')
    variants = {row['candidato']:row for row in read_csv(folder/'variantes/grupos.csv')}
    path = folder/'variantes/conciliaciones.json'
    reconciliations = {entry['candidato']:entry for entry in json.loads(path.read_text(encoding='utf-8'))} if path.exists() else {}
    for candidate, entry in reconciliations.items():
        if candidate not in variants or variants[candidate].get('estado') != 'CONCILIADO' or not (folder/'variantes'/entry['informe']).is_file():
            raise ValueError('Conciliación sin grupo cerrado o informe')
    for key, case in cases.items():
        case.update(estado=case['estado'] if case['estado'] in ('CONFIRMADA_COMPLETA', 'CONFIRMADA_ESENCIAL') else 'PENDIENTE_CONFIRMACION_COMPLETA', grupo_variantes=key in variants,
                    estado_variantes=variants.get(key, {}).get('estado', 'SIN_GRUPO_REPETIDO'),
                    campos_historicos_distintos=variants.get(key, {}).get('campos_distintos', ''),
                    informe_conciliacion='variantes/'+reconciliations[key]['informe'] if key in reconciliations else '',
                    accion='Contrastar identidad y convocatoria; verificar cobertura, requisitos y documentos; resolver discrepancias antes de certificar.')
    path = folder/'confirmaciones_completas.json'
    for entry in json.loads(path.read_text(encoding='utf-8')) if path.exists() else []:
        cases[entry['candidato']]['confirmacion'] = entry
        cases[entry['candidato']]['accion'] = 'Conservar alcance documentado; no activar convocatorias cerradas ni extender la certificación a otro año.'
    path = folder/'confirmaciones_esenciales.json'
    for entry in json.loads(path.read_text(encoding='utf-8')) if path.exists() else []:
        case = cases[entry['candidato']]
        if case['estado'] != 'CONFIRMADA_ESENCIAL' or not (folder/entry['informe']).is_file():
            raise ValueError('Confirmación esencial sin estado validado o informe')
        case['confirmacion_esencial'] = entry
        case['accion'] = 'Revisión esencial cerrada; conservar desconocidos y límites. No activar sin cierre confirmado.'
    return list(cases.values()), {name:{key:value for key,value in report.items() if key!='texto'} for name,report in reports.items()}


def check_sources(urls, workers):
    limits = defaultdict(lambda: threading.Semaphore(2))
    checked = datetime.now(timezone.utc).isoformat()
    def check(url):
        parsed = urlparse(url)
        if parsed.scheme not in ('http','https') or not parsed.hostname or parsed.username or parsed.password:
            return dict(url=url, consultado=checked, estado='URL_NO_ADMITIDA')
        with limits[parsed.hostname]:
            try:
                request = urllib.request.Request(url, headers={'User-Agent':'BecasFind/1.0 (editorial source access check)'})
                with urllib.request.urlopen(request, timeout=12) as response:
                    data = response.read(2*1024*1024+1)
                    truncated = len(data)>2*1024*1024
                    return dict(url=url, consultado=checked, estado='HTTP_RECIBIDO', http=response.status,
                                url_final=response.url, tipo=response.headers.get('Content-Type',''),
                                bytes_leidos=len(data), lectura_truncada=truncated,
                                sha256_lectura=hashlib.sha256(data).hexdigest(), contenido_certificado=False)
            except urllib.error.HTTPError as error:
                return dict(url=url, consultado=checked, estado='ERROR_HTTP', http=error.code, contenido_certificado=False)
            except (urllib.error.URLError, TimeoutError, OSError, ValueError):
                return dict(url=url, consultado=checked, estado='ERROR_ACCESO', contenido_certificado=False)
    with ThreadPoolExecutor(max_workers=workers) as executor:
        return list(executor.map(check, sorted(urls)))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--comprobar-acceso', action='store_true')
    parser.add_argument('--workers', type=int, default=8)
    args = parser.parse_args()
    folder = Path('documentacion/auditoria_corpus/procesados')
    cases, reports = inventory(folder)
    output = folder/'cierre'
    output.mkdir(exist_ok=True)
    for filename, value in [('casos.json',cases),('informes.json',reports)]:
        (output/filename).write_text(json.dumps(value, ensure_ascii=False, indent=2)+'\n',encoding='utf-8')
    fields = ['candidato','nombre','institucion','estado','grupo_variantes','estado_variantes','campos_historicos_distintos','informe_conciliacion','informes']
    with (output/'casos.csv').open('w',encoding='utf-8',newline='') as stream:
        writer = csv.DictWriter(stream,fieldnames=fields,lineterminator='\n')
        writer.writeheader()
        writer.writerows({**{key:case[key] for key in fields if key!='informes'},
                         'informes':'; '.join(sorted({review['informe'] for review in case['revisiones']}))} for case in cases)
    if args.comprobar_acceso:
        urls = {url.rstrip('.') for report in reports.values() for url in report['urls']}
        sources = check_sources(urls,args.workers)
        (output/'acceso_fuentes.json').write_text(json.dumps(sources,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
        counts = defaultdict(int)
        for source in sources:
            counts[source['estado']] += 1
        print(json.dumps(dict(candidatas=len(cases),grupos_variantes=sum(case['grupo_variantes'] for case in cases),
                             fuentes=len(sources),acceso=dict(counts),confirmadas_por_este_script=0)))


if __name__ == '__main__':
    main()
