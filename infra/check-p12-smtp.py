"""Comprueba STARTTLS de Gmail desde Oracle sin credenciales ni envío de correo."""
import argparse
from datetime import datetime, timezone
import json
from pathlib import Path
import smtplib
import socket
import ssl


def check():
    result = {
        "verificado_utc": datetime.now(timezone.utc).isoformat(),
        "servidor": "smtp.gmail.com",
        "puerto": 587,
        "conexion_tls": False,
        "autenticacion_comprobada": False,
        "envio_comprobado": False,
    }
    try:
        with smtplib.SMTP("smtp.gmail.com", 587, timeout=10) as smtp:
            smtp.ehlo()
            if not smtp.has_extn("starttls"):
                raise smtplib.SMTPNotSupportedError("STARTTLS no disponible")
            smtp.starttls(context=ssl.create_default_context())
            code, _ = smtp.ehlo()
            if code != 250:
                raise smtplib.SMTPHeloError(code, b"EHLO tras TLS rechazado")
            result.update(conexion_tls=True, version_tls=smtp.sock.version(),
                          certificado_validado=True,
                          autenticacion_anunciada=smtp.has_extn("auth"))
    except (OSError, smtplib.SMTPException) as error:
        # Solo se registra la clase; no se conserva contenido recibido del servidor.
        result["error"] = type(error).__name__
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, help="Informe JSON opcional")
    args = parser.parse_args()
    result = check()
    result["equipo"] = socket.gethostname()
    serialized = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        args.output.write_text(serialized, encoding="utf-8")
    print(serialized, end="")
    return 0 if result["conexion_tls"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
