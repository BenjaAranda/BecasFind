"""Verify deployed recovery using only the owner's dedicated Gmail account."""
from datetime import datetime, timezone
import email
import email.policy
import imaplib
import json
import os
from pathlib import Path
import re
import secrets
import ssl
import time
import urllib.error
import urllib.request

API = 'https://155-181-41-231.sslip.io/api'
FRONTEND = 'https://becasfind-afeqpkmym-benjatlou13-1274.vercel.app'


def request(path, body=None, token=None, method=None):
    headers = {'Content-Type': 'application/json'}
    if token:
        headers['Authorization'] = 'Bearer ' + token
    query = urllib.request.Request(API + path, headers=headers,
                                  data=json.dumps(body).encode() if body is not None else None,
                                  method=method)
    try:
        with urllib.request.urlopen(query, timeout=35) as response:
            return response.status, json.load(response)
    except urllib.error.HTTPError as error:
        return error.code, json.load(error)


def main():
    os.umask(0o077)
    cfg = dict(line.split('=', 1) for line in
               (Path.home()/'.config/becasfind/backend.env').read_text().splitlines() if '=' in line)
    account = cfg['GMAIL_USERNAME']
    app_password = cfg['GMAIL_APP_PASSWORD']
    folder = Path.home()/'.local/state/becasfind'
    credentials = folder/'cuenta-propia-validacion.json'
    if credentials.exists():
        saved = json.loads(credentials.read_text())
        if saved['email'] != account:
            raise RuntimeError('La cuenta privada no coincide')
    else:
        saved = {'email': account, 'password': secrets.token_urlsafe(30)}
        status, _ = request('/auth/register', dict(nombreCompleto='BecasFind', **saved))
        if status != 201:
            raise RuntimeError('La cuenta ya existe o no se pudo registrar; no se cambió su contraseña')
        credentials.write_text(json.dumps(saved))
        credentials.chmod(0o600)
    status, initial = request('/auth/login', saved)
    assert status == 200, 'Login inicial'
    previous_session = initial['data']['token']
    with imaplib.IMAP4_SSL('imap.gmail.com', ssl_context=ssl.create_default_context(), timeout=20) as inbox:
        inbox.login(account, app_password)
        inbox.select('INBOX', readonly=True)

        def ids():
            status, found = inbox.uid('search', None, f'(FROM "{account}" SUBJECT "BecasFind")')
            if status != 'OK':
                raise RuntimeError('No se pudo consultar el correo propio')
            return set(found[0].split())

        seen = ids()
        assert request('/auth/forgot-password', {'email': account})[0] == 200
        deadline = time.monotonic()+90
        token = None
        while time.monotonic() < deadline and token is None:
            inbox.noop()
            for uid in sorted(ids()-seen):
                seen.add(uid)
                status, content = inbox.uid('fetch', uid, '(BODY.PEEK[])')
                if status != 'OK':
                    continue
                message = email.message_from_bytes(content[0][1], policy=email.policy.default)
                part = message.get_body(preferencelist=('plain',))
                text = part.get_content() if part else ''
                match = re.search(re.escape(FRONTEND)+r'/reset-password#token=([0-9a-f-]{36})', text)
                if match:
                    token = match.group(1)
                    break
            if token is None:
                time.sleep(3)
        if token is None:
            raise RuntimeError('No llegó el enlace HTTPS esperado')
    new_password = secrets.token_urlsafe(30)
    assert request('/auth/reset-password', {'token': token, 'newPassword': new_password})[0] == 200
    saved['password'] = new_password
    credentials.write_text(json.dumps(saved))
    assert request('/auth/reset-password', {'token': token, 'newPassword': new_password})[0] == 401
    assert request('/perfil', token=previous_session)[0] == 401
    status, fresh = request('/auth/login', saved)
    assert status == 200
    token = fresh['data']['token']
    assert request('/becas/administracion', token=token)[0] == 403
    assert request('/perfil', {}, token=token, method='PUT')[0] == 200
    assert request('/becas/recomendadas', token=token)[0] == 200
    scholarship = 'c8d21ab3-66b0-45ad-8d2b-17c764918549'
    assert request('/favoritos/'+scholarship, token=token, method='POST')[0] == 200
    assert request('/favoritos/'+scholarship+'/check', token=token)[1]['data']['favorito']
    assert request('/favoritos', token=token)[0] == 200
    assert request('/favoritos/'+scholarship, token=token, method='DELETE')[0] == 200
    assert not request('/favoritos/'+scholarship+'/check', token=token)[1]['data']['favorito']
    report = dict(verificado_utc=datetime.now(timezone.utc).isoformat(), api=API,
                  smtp_oracle=True, entrega_real=True, enlace_https_preview=True,
                  cambio_clave=True, reutilizacion_rechazada=True, sesion_anterior_invalidada=True,
                  login_nuevo=True, student_admin_403=True, perfil_sin_datos_inventados=True,
                  recomendaciones=True, favoritos_guardar_consultar_eliminar=True,
                  cuenta='Cuenta Gmail dedicada propiedad del usuario; credenciales privadas fuera del repositorio',
                  caducidad='No se forzó ni esperó la expiración en la base remota; cubierta por P09 local')
    (folder/'prueba-recuperacion-p12.json').write_text(json.dumps(report, ensure_ascii=False, indent=2)+'\n')
    print(json.dumps(report, ensure_ascii=True))


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        print('Verificación detenida:', type(error).__name__)
        raise SystemExit(1)
