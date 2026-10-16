"""Prueba autorizada de Gmail con PostgreSQL temporal; nunca imprime claves ni tokens.

Ejecutar solo con autorización del titular para enviar dos correos a GMAIL_USERNAME.
Requiere Python 3.11+, PostgreSQL 17, Java 17 y el JAR actualizado.
"""
import argparse
import email
import email.policy
import imaplib
import json
import os
from pathlib import Path
import re
import secrets
import socket
import ssl
import subprocess
import tempfile
import time
import urllib.error
import urllib.request


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--jar", type=Path, required=True)
    parser.add_argument("--postgres-bin", type=Path, default=Path(r"C:\Program Files\PostgreSQL\17\bin"))
    parser.add_argument("--java", default=r"C:\Program Files\Java\jdk-17\bin\java.exe")
    args = parser.parse_args()
    root = Path(__file__).resolve().parent.parent
    cfg = dict(line.split("=", 1) for line in (root / "backend/.env").read_text(encoding="utf-8").splitlines()
               if "=" in line and not line.startswith("#"))
    account = cfg.get("GMAIL_USERNAME", "")
    password = cfg.get("GMAIL_APP_PASSWORD", "").replace(" ", "")
    if not re.fullmatch(r"[A-Za-z0-9._%+-]+@(gmail\.com|googlemail\.com)", account) or not re.fullmatch(r"[A-Za-z0-9]{16}", password):
        raise ValueError("Configuración Gmail incompleta; no se mostrarán credenciales")
    jar = args.jar.resolve(strict=True)
    work = Path(tempfile.mkdtemp(prefix="becas-gmail-delivery-"))
    data = work / "data"
    flags = subprocess.CREATE_NO_WINDOW if os.name == "nt" else 0
    log = (work / "process.log").open("wb")
    backend = None
    started = False

    def run(tool, *values):
        subprocess.run([str(args.postgres_bin / (tool + (".exe" if os.name == "nt" else ""))), *map(str, values)],
                       check=True, stdout=log, stderr=log, creationflags=flags)

    def free_port():
        with socket.socket() as listener:
            listener.bind(("127.0.0.1", 0))
            return listener.getsockname()[1]

    pg_port, api_port = free_port(), free_port()

    def sql(command=None, file=None):
        run("psql", "-h", "127.0.0.1", "-p", pg_port, "-U", "recovery_verify", "-d", "recovery_test",
            "-v", "ON_ERROR_STOP=1", *( ["-f", file] if file else ["-c", command]))

    def request(path, body=None, token=None):
        headers = {"Content-Type": "application/json"}
        if token:
            headers["Authorization"] = "Bearer " + token
        req = urllib.request.Request(f"http://127.0.0.1:{api_port}" + path,
                                     data=json.dumps(body).encode() if body is not None else None, headers=headers)
        try:
            with urllib.request.urlopen(req, timeout=30) as response:
                return response.status, json.load(response)
        except urllib.error.HTTPError as error:
            return error.code, json.load(error)

    try:
        run("initdb", "-D", data, "-U", "recovery_verify", "--encoding=UTF8", "--locale=C", "--auth=trust")
        run("pg_ctl", "-D", data, "-l", work / "postgres.log", "-o", f"-h 127.0.0.1 -p {pg_port}", "-w", "start")
        started = True
        run("createdb", "-h", "127.0.0.1", "-p", pg_port, "-U", "recovery_verify", "recovery_test")
        sql(file=root / "infra/ddl.sql")
        sql("TRUNCATE roles, tipos_institucion, tipos_beca, regiones RESTART IDENTITY CASCADE")
        sql(file=root / "backend/src/test/resources/data-test.sql")
        env = os.environ.copy()
        env.update(DB_URL=f"jdbc:postgresql://127.0.0.1:{pg_port}/recovery_test", DB_USERNAME="recovery_verify", DB_PASSWORD="",
                   JWT_SECRET=secrets.token_hex(32), SPRING_PROFILES_ACTIVE="dev", PORT=str(api_port), SERVER_ADDRESS="127.0.0.1",
                   SPRING_DATASOURCE_URL=f"jdbc:postgresql://127.0.0.1:{pg_port}/recovery_test",
                   SPRING_DATASOURCE_USERNAME="recovery_verify", SPRING_DATASOURCE_PASSWORD="",
                   SPRING_JPA_HIBERNATE_DDL_AUTO="validate", SPRING_SQL_INIT_MODE="never",
                   RESET_EMAIL_PROVIDER="gmail", RESET_EMAIL_ENABLED="true", GMAIL_USERNAME=account, GMAIL_APP_PASSWORD=password,
                   FRONTEND_URL="http://127.0.0.1:5173", CORS_ALLOWED_ORIGINS="http://127.0.0.1:5173")
        backend = subprocess.Popen([args.java, "-jar", str(jar)], cwd=work, env=env, stdout=log, stderr=log, creationflags=flags)
        for _ in range(100):
            if backend.poll() is not None:
                raise RuntimeError("El backend temporal no arrancó")
            try:
                if request("/api/regiones")[0] == 200:
                    break
            except (urllib.error.URLError, TimeoutError):
                pass
            time.sleep(.5)
        else:
            raise TimeoutError("Arranque temporal fuera de plazo")
        sql(f"UPDATE usuarios SET email='{account}' WHERE email='estudiante@duoc.cl'")
        status, result = request("/api/auth/login", {"email": account, "password": "admin123"})
        assert status == 200, "Login inicial temporal falló"
        previous_session = result["data"]["token"]
        with imaplib.IMAP4_SSL("imap.gmail.com", ssl_context=ssl.create_default_context(), timeout=15) as mailbox:
            mailbox.login(account, password)
            mailbox.select("INBOX", readonly=True)

            def matching_uids():
                status, found = mailbox.uid("search", None, f'(FROM "{account}" SUBJECT "BecasFind")')
                if status != "OK":
                    raise RuntimeError("No se pudo consultar la bandeja")
                return set(found[0].split())

            seen = matching_uids()

            def receive_link():
                deadline = time.monotonic() + 90
                while time.monotonic() < deadline:
                    mailbox.noop()
                    for uid in sorted(matching_uids() - seen):
                        seen.add(uid)
                        status, content = mailbox.uid("fetch", uid, "(BODY.PEEK[])")
                        if status != "OK":
                            continue
                        message = email.message_from_bytes(content[0][1], policy=email.policy.default)
                        part = message.get_body(preferencelist=("plain",))
                        text = part.get_content() if part else ""
                        match = re.search(r"http://127\.0\.0\.1:5173/reset-password#token=([0-9a-f-]{36})", text)
                        if match:
                            return match.group(1)
                    time.sleep(3)
                raise TimeoutError("No se encontró el correo esperado en INBOX")

            assert request("/api/auth/forgot-password", {"email": account})[0] == 200
            first = receive_link()
            assert re.fullmatch(r"[0-9a-f-]{36}", first)
            sql(f"UPDATE password_reset_tokens SET fecha_expiracion=TIMESTAMP '2000-01-01 00:00:00' WHERE token='{first}'")
            new_password = secrets.token_urlsafe(24)
            assert request("/api/auth/reset-password", {"token": first, "newPassword": new_password})[0] == 401
            assert request("/api/auth/forgot-password", {"email": account})[0] == 200
            second = receive_link()
            assert second != first
            assert request("/api/auth/reset-password", {"token": second, "newPassword": new_password})[0] == 200
            assert request("/api/auth/login", {"email": account, "password": new_password})[0] == 200
            assert request("/api/auth/reset-password", {"token": second, "newPassword": new_password})[0] == 401
            assert request("/api/perfil", token=previous_session)[0] == 401
        result = {"smtp": True, "inbox_received": 2, "expired_link_rejected": True, "expiry_check": "forced_past_timestamp_in_temporary_database",
                  "password_changed": True, "new_login": True, "reuse_rejected": True, "previous_session_invalidated": True,
                  "isolated_database": True, "real_user_password_changed": False}
        (work / "result.json").write_text(json.dumps(result, indent=2), encoding="utf-8")
        print(json.dumps(result))
        print("Private evidence:", work)
    finally:
        if backend and backend.poll() is None:
            backend.terminate()
            try:
                backend.wait(timeout=15)
            except subprocess.TimeoutExpired:
                backend.kill()
                backend.wait()
        if started:
            run("pg_ctl", "-D", data, "-m", "fast", "-w", "stop")
        log.close()


if __name__ == "__main__":
    try:
        main()
    except Exception as error:
        print("Recovery verification failed:", type(error).__name__)
        raise SystemExit(1) from None
