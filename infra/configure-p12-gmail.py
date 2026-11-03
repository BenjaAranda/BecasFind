"""Configure existing Oracle container using a private two-key Gmail file."""
import argparse
import json
import os
from pathlib import Path
import smtplib
import ssl
import subprocess
import time
import urllib.request

FRONTEND = 'https://becasfind-afeqpkmym-benjatlou13-1274.vercel.app'


def read_env(path):
    return dict(line.split('=', 1) for line in path.read_text(encoding='utf-8').splitlines()
                if '=' in line and not line.startswith('#'))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('private_file', type=Path)
    args = parser.parse_args()
    os.umask(0o077)
    gmail = read_env(args.private_file)
    username = gmail['GMAIL_USERNAME']
    password = gmail['GMAIL_APP_PASSWORD'].replace(' ', '')
    if not username.endswith('@gmail.com') or len(password) != 16:
        raise RuntimeError('Configuración privada incompleta')
    with smtplib.SMTP('smtp.gmail.com', 587, timeout=20) as sender:
        sender.ehlo()
        sender.starttls(context=ssl.create_default_context())
        sender.ehlo()
        sender.login(username, password)
    print('Oracle: STARTTLS y autenticación Gmail aprobados; sin envío todavía.', flush=True)
    docker = ['sudo', '-n', 'docker']
    current = json.loads(subprocess.check_output(docker + ['inspect', 'becasfind-api']))[0]
    config = current['HostConfig']
    if current['Mounts'] or list(current['NetworkSettings']['Networks']) != ['becasfind-private']:
        raise RuntimeError('Configuración Docker distinta; revisar manualmente')
    if config['PortBindings'] != {'8080/tcp': [{'HostIp': '127.0.0.1', 'HostPort': '8080'}]}:
        raise RuntimeError('Puerto Docker distinto')
    if config['Memory'] != 2147483648 or config['CapDrop'] != ['ALL']:
        raise RuntimeError('Límites Docker distintos')
    old = 'becasfind-api-pre-gmail'
    if subprocess.run(docker + ['inspect', old], check=False, stdout=subprocess.DEVNULL,
                      stderr=subprocess.DEVNULL).returncode == 0:
        raise RuntimeError('Ya existe un contenedor de reserva; revisar antes de reemplazar')
    folder = Path.home() / '.config/becasfind'
    environment = folder / 'backend.env'
    previous = environment.read_bytes()
    values = read_env(environment)
    if values.get('CORS_ALLOWED_ORIGINS') != FRONTEND:
        raise RuntimeError('Origen CORS distinto al autorizado')
    backup = folder / ('backend.pre-gmail-' + str(int(time.time())) + '.env')
    backup.write_bytes(previous)
    backup.chmod(0o600)
    values.update(RESET_EMAIL_ENABLED='true', RESET_EMAIL_PROVIDER='gmail',
                  GMAIL_USERNAME=username, GMAIL_APP_PASSWORD=password, FRONTEND_URL=FRONTEND)
    environment.write_text(''.join(k + '=' + v + '\n' for k, v in values.items()), encoding='utf-8')
    environment.chmod(0o600)
    subprocess.run(docker + ['stop', 'becasfind-api'], check=True, stdout=subprocess.DEVNULL)
    subprocess.run(docker + ['rename', 'becasfind-api', old], check=True)
    try:
        subprocess.run(docker + ['run', '-d', '--name', 'becasfind-api', '--restart', 'unless-stopped',
                       '--network', 'becasfind-private', '-p', '127.0.0.1:8080:8080', '--memory', '2g',
                       '--cap-drop', 'ALL', '--security-opt', 'no-new-privileges:true',
                       '--log-driver', 'json-file', '--log-opt', 'max-size=10m', '--log-opt', 'max-file=3',
                       '--env-file', str(environment), current['Image']], check=True,
                       stdout=subprocess.DEVNULL)
        for attempt in range(45):
            try:
                with urllib.request.urlopen('http://127.0.0.1:8080/api/regiones', timeout=3) as response:
                    if response.status == 200:
                        break
            except OSError:
                time.sleep(2)
        else:
            raise RuntimeError('La API no volvió a responder')
    except Exception:
        subprocess.run(docker + ['rm', '-f', 'becasfind-api'], check=False, stdout=subprocess.DEVNULL)
        environment.write_bytes(previous)
        subprocess.run(docker + ['rename', old, 'becasfind-api'], check=True)
        subprocess.run(docker + ['start', 'becasfind-api'], check=True, stdout=subprocess.DEVNULL)
        raise
    args.private_file.unlink()
    print('Gmail habilitado. API recuperada; contenedor previo detenido conservado para reversión.')


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        print('Configuración detenida:', type(error).__name__)
        raise SystemExit(1)
