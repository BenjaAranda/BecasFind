# Recuperación gratuita con una cuenta Gmail dedicada

Gmail envía el enlace para recuperar la contraseña de BecasFind. No aloja la web ni guarda las becas. Se utiliza una cuenta gratuita dedicada; no hace falta comprar un dominio ni contratar Google Workspace. Tiene cuotas y controles de Google: no se promete envío ilimitado ni entrega garantizada.

## Lo que hace el usuario

1. Crear una cuenta dedicada en [Google](https://accounts.google.com/signup). Elegir una dirección disponible; no se ha reservado ninguna en nombre del usuario. Completar personalmente contraseña, teléfono/códigos y verificaciones que Google solicite.
2. Activar la [verificación en dos pasos](https://myaccount.google.com/signinoptions/two-step-verification).
3. Abrir [Contraseñas de aplicación](https://myaccount.google.com/apppasswords) y crear una para «BecasFind». Google puede ocultar esta opción en determinadas cuentas/configuraciones; consultar su [ayuda oficial](https://support.google.com/mail/answer/185833?hl=es). Nunca usar la contraseña normal de la cuenta como clave SMTP.
4. Guardar estos valores únicamente en `backend/.env`, archivo privado ignorado por Git. Conservar las variables existentes de PostgreSQL y JWT:

```dotenv
RESET_EMAIL_ENABLED=false
RESET_EMAIL_PROVIDER=gmail
GMAIL_USERNAME=cuenta_dedicada@gmail.com
GMAIL_APP_PASSWORD=clave_de_aplicacion_de_16_caracteres
FRONTEND_URL=http://127.0.0.1:5173
```

Reemplazar los ejemplos por valores reales. Se admiten los espacios de separación que muestra Google en la contraseña de aplicación. No pegar la clave en el chat, frontend, capturas o GitHub. El remitente será «BecasFind» con esa misma dirección Gmail; no se puede indicar una dirección ajena.

5. Informar que la configuración está guardada e indicar una dirección propia autorizada para recibir la prueba. No habilitar todavía el envío: la comprobación debe usar una cuenta de prueba y una base aislada para no cambiar contraseñas del usuario ni sembrar datos en la base local.

## Configuración y prueba técnica

El proveedor Gmail se selecciona mediante `RESET_EMAIL_PROVIDER=gmail` y también es el valor por defecto cuando la variable no existe. `RESET_EMAIL_ENABLED=false` mantiene la recuperación indisponible con 503 y no genera enlaces inútiles. Habilitar con `true` exige configuración válida; un error de configuración detiene el arranque sin mostrar la clave.

El backend usa `smtp.gmail.com:587`, autenticación y STARTTLS obligatorio, validación del nombre del certificado y tiempos de conexión/lectura/escritura de cinco segundos. No habilita depuración SMTP. La contraseña y el servidor no se configuran desde el navegador. Referencia: [SMTP de Google](https://support.google.com/a/answer/176600) y [correo en Spring Boot](https://docs.spring.io/spring-boot/3.4/reference/io/email.html).

HTTP en `FRONTEND_URL` solo se permite con perfil `dev`, sin `prod`, y origen localhost/127.0.0.1. **No arrancar el perfil dev directamente sobre la base local existente para probar correo:** ese perfil puede inicializar datos y actualizar el esquema. La prueba se hará con una base temporal preparada y configuración de inicialización deshabilitada. En producción se exige el origen HTTPS público.

La prueba real debe verificar recepción en la bandeja (también spam), enlace, contraseña nueva, login, rechazo del enlace reutilizado y caducidad. El enlace lleva el token en el fragmento, vence en 15 minutos y admite un uso. Un rechazo del proveedor revierte la creación del token y conserva el enlace anterior. No hay reintentos automáticos de SMTP que puedan duplicar mensajes.

Si Google revoca la clave (por ejemplo, al cambiar la contraseña de la cuenta), generar otra y actualizar solo el backend. Antes del despliegue hay que verificar conexión al puerto 587 desde Oracle y disponibilidad real del envío. El servicio sigue siendo dependiente de una cuenta externa gratuita.

## Estado verificable

Integración implementada; pruebas locales cubren mensaje UTF-8, origen confiable, errores sanitizados, selección del proveedor y rechazo de un servidor SMTP sin STARTTLS antes de enviar credenciales o contenido.

**P09 completado:** con autorización del titular se verificaron SMTP/IMAP TLS, dos mensajes recibidos en INBOX y la recuperación de una cuenta temporal: contraseña nueva/login, enlace reutilizado rechazado, enlace vencido rechazado con fecha forzada en base temporal y sesión previa invalidada. No se cambió la contraseña de una cuenta real ni se marcaron los correos como leídos. No se esperaron 15 minutos: la caducidad se probó adelantando el estado de vencimiento exclusivamente en la base temporal.

Runner: `python infra/verify-gmail-delivery.py --jar <ruta-al-jar-actualizado>`. Requiere Java 17/PostgreSQL 17 y credenciales privadas en backend/.env. Envía dos mensajes al titular; no ejecutarlo sin esa autorización. Crea y detiene base/backend temporales; no se conecta a la base local. Resultados sin dirección, clave ni token. No almacenar la contraseña normal de Google.

El envío local sigue deshabilitado. La activación del correo público requiere origen HTTPS y comprobación del destino en P12. Renovar las credenciales compartidas en el chat antes de activarlo; guardar únicamente la nueva contraseña de aplicación en backend/.env, que está fuera de Git. La navegación pública sin cuenta no depende del correo.
