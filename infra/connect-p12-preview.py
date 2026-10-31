"""Añade el origen de la preview corregida; conserva origen y enlaces anteriores."""
import hashlib
import argparse
import json
import os
from pathlib import Path
import subprocess
import time
from datetime import datetime, timezone
import urllib.request

ORIGIN = 'https://becasfind-ejsx6hw61-benjatlou13-1274.vercel.app'
NAME = 'becasfind-api'


def docker(*args):
    return subprocess.check_output(['sudo', '-n', 'docker', *args], stderr=subprocess.PIPE).decode().strip()


def inspect():
    return json.loads(docker('inspect', NAME))[0]


def main(new_image=None):
    os.umask(0o077)
    envfile = Path.home() / '.config/becasfind/backend.env'
    original = envfile.read_bytes()
    values = dict(line.split('=', 1) for line in original.decode('utf-8').splitlines()
                  if line and not line.startswith('#') and '=' in line)
    current = inspect()
    host = current['HostConfig']
    actual_env = dict(item.split('=', 1) for item in current['Config']['Env'])
    if any(actual_env.get(key) != value for key, value in values.items()):
        raise RuntimeError('El archivo y el contenedor difieren; conciliar antes de continuar')
    origins = [item.strip() for item in values['CORS_ALLOWED_ORIGINS'].split(',') if item.strip()]
    if new_image:
        new_image = json.loads(docker('image', 'inspect', new_image))[0]['Id']
    if ORIGIN in origins and (not new_image or new_image == current['Image']):
        print(json.dumps({'cambio': False, 'origen_ya_configurado': True}))
        return
    if (not current['State']['Running'] or current['Mounts'] or host['Privileged']
            or set(current['NetworkSettings']['Networks']) != {'becasfind-private'}
            or host['PortBindings'] != {'8080/tcp': [{'HostIp': '127.0.0.1', 'HostPort': '8080'}]}
            or host['RestartPolicy']['Name'] != 'unless-stopped'
            or host['Memory'] != 2147483648
            or host['CapDrop'] != ['ALL']
            or not any(x.startswith('no-new-privileges') for x in host['SecurityOpt'])):
        raise RuntimeError('Configuración distinta de P12; requiere revisión individual')
    image_config = json.loads(docker('image', 'inspect', current['Image']))[0]['Config']
    inherited_env = dict(item.split('=', 1) for item in image_config.get('Env', []))
    if any(value != inherited_env.get(key) for key, value in actual_env.items() if key not in values):
        raise RuntimeError('Hay variables fuera del archivo que deben conservarse manualmente')
    if any(current['Config'].get(key) != image_config.get(key)
           for key in ('User', 'Entrypoint', 'Cmd', 'WorkingDir', 'Healthcheck')):
        raise RuntimeError('El contenedor tiene personalizaciones que deben conservarse manualmente')
    stamp = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%fZ')
    backup_dir = Path.home() / '.local/state/becasfind/preview-transitions' / stamp
    backup_dir.mkdir(parents=True, mode=0o700)
    (backup_dir / 'backend.env').write_bytes(original)
    staged = backup_dir / 'backend-new.env'
    lines = original.decode('utf-8').splitlines()
    lines = [line for line in lines if not line.startswith('CORS_ALLOWED_ORIGINS=')]
    lines.append('CORS_ALLOWED_ORIGINS=' + ','.join(dict.fromkeys(origins + [ORIGIN])))
    staged.write_text('\n'.join(lines) + '\n', encoding='utf-8')
    old_name = NAME + '-before-preview-' + stamp.lower()
    command = ['run', '-d', '--name', NAME, '--network', 'becasfind-private',
               '--restart', 'unless-stopped', '--memory', str(host['Memory']),
               '--cap-drop', 'ALL', '--security-opt', 'no-new-privileges:true',
               '--env-file', str(envfile), '-p', '127.0.0.1:8080:8080']
    command += ['--log-driver', host['LogConfig']['Type']]
    for key, value in host['LogConfig']['Config'].items():
        command += ['--log-opt', key + '=' + value]
    command += [new_image or current['Image']]
    if inspect()['Id'] != current['Id'] or envfile.read_bytes() != original:
        raise RuntimeError('Cambios concurrentes detectados; no se ha reiniciado la API')
    renamed = False
    created_id = None
    try:
        docker('stop', NAME)
        docker('rename', NAME, old_name)
        renamed = True
        envfile.write_bytes(staged.read_bytes())
        os.chmod(envfile, 0o600)
        created_id = docker(*command)
        for _ in range(60):
            try:
                request = urllib.request.Request('http://127.0.0.1:8080/api/regiones',
                                                 headers={'Origin': ORIGIN})
                with urllib.request.urlopen(request, timeout=3) as response:
                    if response.status == 200 and response.headers.get('Access-Control-Allow-Origin') == ORIGIN:
                        if new_image:
                            catalog_request = urllib.request.Request('http://127.0.0.1:8080/api/becas/catalogo/buscar',
                                data=b'{"size":100}', headers={'Content-Type': 'application/json', 'Origin': ORIGIN})
                            with urllib.request.urlopen(catalog_request, timeout=5) as catalog_response:
                                if json.load(catalog_response)['data']['totalElements'] != 528:
                                    raise RuntimeError('El catálogo no conserva las 528 fichas esperadas')
                        break
            except OSError:
                pass
            time.sleep(1)
        else:
            raise RuntimeError('No se verificó API y CORS; se restaurará el contenedor anterior')
    except Exception:
        if created_id:
            if inspect()['Id'] != created_id:
                raise RuntimeError('Otro proceso cambió la API; detener y revisar sin eliminar contenedores') from None
            docker('stop', NAME)
            docker('rm', NAME)
        envfile.write_bytes(original)
        os.chmod(envfile, 0o600)
        if renamed:
            docker('rename', old_name, NAME)
        docker('start', NAME)
        raise
    report = {'verificado_utc': datetime.now(timezone.utc).isoformat(),
              'origen_agregado': ORIGIN, 'origenes_anteriores_conservados': True,
              'frontend_url_conservada': True, 'api_y_cors_local': True,
              'contenedor_anterior': old_name, 'imagen_anterior': current['Image'],
              'imagen_actual': new_image or current['Image'], 'imagen_conservada': not bool(new_image),
              'env_anterior_sha256': hashlib.sha256(original).hexdigest(),
              'limite': 'No sustituye el preflight externo ni la prueba en navegador.'}
    (backup_dir / 'result.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(report))


if __name__ == '__main__':
    try:
        parser = argparse.ArgumentParser()
        parser.add_argument('--origin', default=ORIGIN)
        parser.add_argument('--image')
        args = parser.parse_args()
        if not args.origin.startswith('https://') or '/' in args.origin.removeprefix('https://'):
            raise RuntimeError('El origen debe ser HTTPS y no incluir una ruta')
        ORIGIN = args.origin
        main(args.image)
    except Exception as error:
        # No volcar excepciones de Docker: podrían contener configuración privada.
        print(json.dumps({'ok': False, 'error': type(error).__name__,
                          'detalle': str(error) if type(error) is RuntimeError else 'Error externo; contenido omitido',
                          'accion': 'Revisar configuración y estado de becasfind-api antes de repetir.'}))
        raise SystemExit(1) from None
