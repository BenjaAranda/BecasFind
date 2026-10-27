"""Run on Oracle via the user's SSH session; keep credentials out of files and logs."""
import csv
import getpass
import hashlib
import io
import json
import os
from pathlib import Path
import re
import secrets
import subprocess
import sys
from datetime import datetime, timezone
import urllib.error
import urllib.request


EXPECTED_SHA = '757cec62e2dcb3ac980c65bc4a33c2ea204b6c2eba1b9d536188108400732d16'
DOCKER = ['sudo', '-n', 'docker', 'exec', 'becasfind-db']


def mojibake_query():
    text = ("coalesce(nombre,'') || E'\\n' || coalesce(descripcion_corta,'') "
            "|| E'\\n' || coalesce(descripcion_larga,'')")
    conditions = [f"position(decode('{pattern}','hex') in convert_to({text},'UTF8')) > 0"
                  for pattern in ('c383c2', 'c383e2', 'c382c2')]
    return 'SELECT count(*) FROM becas WHERE ' + ' OR '.join(conditions)


def sql(database, query):
    return subprocess.check_output(
        DOCKER + ['psql', '-AtX', '-U', 'postgres', '-d', database,
                  '-v', 'ON_ERROR_STOP=1', '-c', query], text=True).strip()


def fingerprints(database):
    tables = sql(database, "SELECT tablename FROM pg_tables WHERE schemaname='public' ORDER BY tablename").splitlines()
    result = {}
    for table in tables:
        quoted = '"' + table.replace('"', '""') + '"'
        result[table] = sql(database,
            "SELECT count(*)::text || ':' || md5(coalesce(string_agg("
            "md5(to_jsonb(t)::text), '' ORDER BY md5(to_jsonb(t)::text)), '')) "
            f'FROM public.{quoted} t')
    return result


def verify_backup():
    folder = Path.home() / '.local/state/becasfind/backups'
    folder.mkdir(parents=True, exist_ok=True)
    folder.chmod(0o700)
    name = datetime.now(timezone.utc).strftime('pre-catalogo-%Y%m%dT%H%M%SZ-') + secrets.token_hex(4)
    backup = folder / (name + '.dump')
    log = folder / (name + '.log')
    restore_db = 'becasfind_restore_' + secrets.token_hex(6)
    created = False
    with log.open('xb') as errors:
        with backup.open('xb') as output:
            subprocess.run(DOCKER + ['pg_dump', '-U', 'postgres', '-d', 'becasfind', '-Fc'],
                           check=True, stdout=output, stderr=errors)
        if not backup.stat().st_size:
            raise RuntimeError('El respaldo esta vacío. No se importara.')
        try:
            subprocess.run(DOCKER + ['createdb', '-U', 'postgres', restore_db],
                           check=True, stdout=subprocess.DEVNULL, stderr=errors)
            created = True
            with backup.open('rb') as source:
                subprocess.run(['sudo', '-n', 'docker', 'exec', '-i', 'becasfind-db',
                                'pg_restore', '-U', 'postgres', '-d', restore_db, '--exit-on-error'],
                               stdin=source, check=True, stdout=subprocess.DEVNULL, stderr=errors)
            original = fingerprints('becasfind')
            restored = fingerprints(restore_db)
            if len(original) != 14 or original != restored:
                raise RuntimeError('La restauración no coincide con las 14 tablas del destino. No se importara.')
        finally:
            if created and re.fullmatch(r'becasfind_restore_[0-9a-f]{12}', restore_db):
                subprocess.run(DOCKER + ['dropdb', '-U', 'postgres', restore_db],
                               check=True, stdout=subprocess.DEVNULL, stderr=errors)
    print('Respaldo privado y restauración aislada verificados en las 14 tablas.')
    print('Respaldo conservado:', backup)


def api_request(path, payload, content_type, token=None):
    headers = {'Content-Type': content_type}
    if token:
        headers['Authorization'] = 'Bearer ' + token
    request = urllib.request.Request('http://127.0.0.1:8080/api/' + path,
                                     data=payload, headers=headers, method='POST')
    try:
        with urllib.request.urlopen(request, timeout=180) as response:
            return json.load(response)
    except urllib.error.HTTPError as error:
        raise RuntimeError(f'La API rechazó {path}: HTTP {error.code}. No se mostrarán credenciales.') from None


def main():
    os.umask(0o077)
    if len(sys.argv) != 2:
        raise RuntimeError('Indica la ruta del CSV confirmado.')
    raw = Path(sys.argv[1]).read_bytes()
    if hashlib.sha256(raw).hexdigest() != EXPECTED_SHA:
        raise RuntimeError('El archivo no coincide con el paquete revisado. No se importara.')
    rows = list(csv.DictReader(io.StringIO(raw.decode('utf-8'))))
    if len(rows) != 528 or any(row.get('estado_activa') != 'false'
                               or row.get('solo_crear') != 'true' for row in rows):
        raise RuntimeError('Se requieren 528 filas inactivas y solo_crear=true.')

    email = input('Correo administrador [benjamin.aranda.dev@gmail.com]: ').strip()
    email = email or 'benjamin.aranda.dev@gmail.com'
    password = getpass.getpass('Contraseña de BecasFind (no se muestra): ')
    login = api_request('auth/login', json.dumps({'email': email, 'password': password}).encode('utf-8'),
                        'application/json')
    password = None
    token = login.get('data', {}).get('token')
    if not token:
        raise RuntimeError('No se recibio una sesion valida.')
    normalized_email = email.replace("'", "''")
    is_admin = sql('becasfind', "SELECT count(*) FROM usuarios u JOIN roles r ON r.id_rol=u.id_rol "
                   f"WHERE u.email='{normalized_email}' AND u.activo=true AND r.nombre_rol='ADMIN'")
    if is_admin != '1':
        raise RuntimeError('La cuenta no es un administrador activo.')

    verify_backup()
    before = int(sql('becasfind', 'SELECT count(*) FROM becas'))
    active_before = int(sql('becasfind', 'SELECT count(*) FROM becas WHERE estado_activa=true'))
    boundary = 'becasfind_' + secrets.token_hex(16)
    body = (f'--{boundary}\r\nContent-Disposition: form-data; name="file"; filename="confirmadas_inactivas.csv"\r\n'
            'Content-Type: text/csv; charset=utf-8\r\n\r\n').encode('ascii')
    body += raw + f'\r\n--{boundary}--\r\n'.encode('ascii')
    response = api_request('becas/importar-csv', body, 'multipart/form-data; boundary=' + boundary, token)
    result = response.get('data')
    if not isinstance(result, dict):
        raise RuntimeError('Respuesta de importación inesperada; comprobar la base antes de repetir.')
    print(json.dumps(result, ensure_ascii=False, indent=2))
    if result.get('errores') != 0:
        raise RuntimeError('La API informa errores. Se detuvo la carga; conservar el respaldo y revisar el mensaje.')
    if result.get('actualizadas') != 0:
        raise RuntimeError('La API informa actualizaciones inesperadas; comprobar el destino antes de continuar.')
    after = int(sql('becasfind', 'SELECT count(*) FROM becas'))
    active_after = int(sql('becasfind', 'SELECT count(*) FROM becas WHERE estado_activa=true'))
    if after != before + result.get('creadas', -1) or active_after != active_before:
        raise RuntimeError('Los conteos no coinciden; detener la publicacion y revisar el destino.')
    corrupt = sql('becasfind', mojibake_query())
    if corrupt != '0':
        raise RuntimeError('Se detecto posible doble codificación. No activar ni repetir la carga.')
    print(f'Comprobado: {before} -> {after} fichas; activas sin cambios ({active_after}); UTF-8 sin patrones de doble codificación.')
    print('Carga administrativa finalizada. La activacion requiere cierre oficial vigente comprobado.')


if __name__ == '__main__':
    try:
        main()
    except (RuntimeError, subprocess.CalledProcessError, OSError, ValueError, EOFError) as error:
        if isinstance(error, subprocess.CalledProcessError):
            print('ERROR: fallo una comprobacion PostgreSQL. Revisar el registro privado del respaldo.', file=sys.stderr)
        else:
            print('ERROR:', str(error), file=sys.stderr)
        sys.exit(1)
