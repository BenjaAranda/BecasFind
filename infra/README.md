# Base de datos y configuración

La base acordada es PostgreSQL 17. `ddl.sql` instala el esquema en una base vacía, con claves y catálogos iniciales. Ejecutarlo con `psql -v ON_ERROR_STOP=1 -f infra/ddl.sql` permite detener la instalación ante errores. El script no altera columnas de tablas existentes: `IF NOT EXISTS` no es una migración.

## Entornos

- Local: activar `SPRING_PROFILES_ACTIVE=dev` desde `backend/`. Solo este perfil lee el archivo local `.env`, actualiza el esquema y carga `data.sql`.
- Producción: activar `SPRING_PROFILES_ACTIVE=prod`. Definir `DB_URL`, `DB_USERNAME`, `DB_PASSWORD` y `JWT_SECRET` fuera del repositorio. `PORT` es opcional y vale 8080 por defecto. Ninguna variable de contraseña tiene un valor alternativo.
- Pruebas: el perfil `test` conserva su base H2 y sus datos aislados. Además se comprueba la instalación con PostgreSQL real.

Comprobación reproducible en Windows: empaquetar el backend y ejecutar `infra/verify-schema.ps1`. El script usa Java 17 y PostgreSQL 17 instalados (rutas configurables), crea una base temporal, prueba la repetición del esquema y arranca el jar con validación JPA usando únicamente `prod`. Comprueba que se conservan íntegros los usuarios, incluidas sus contraseñas. Se detienen los procesos propios y se conservan los registros temporales para diagnóstico; no modifica el servidor PostgreSQL local existente.

Sin perfil local, la aplicación usa configuración conservadora: valida el esquema y no importa datos SQL. `JWT_SECRET` debe tener al menos 32 bytes para la firma actual. No colocar secretos en variables frontend `VITE_*`.

## Bases existentes

Antes de cualquier migración: respaldo, prueba de restauración, inventario del esquema y comprobación de duplicados en `(nombre, id_institucion)` y tokens. No ejecutar cambios sobre la base local actual como parte de esta instalación. Los campos Java `LocalDateTime` se almacenan como `timestamp without time zone`; una conversión desde `timestamptz` exige acordar qué zona representan los datos existentes. Los UUID de recuperación se almacenan como texto de 36 caracteres, coherente con la entidad actual.

Los catálogos pueden cargarse una vez con `backend/src/main/resources/data.sql` en la instalación inicial; el script no crea cuentas. La aplicación necesita roles ADMIN y STUDENT.

Para la base local existente: `infra/migrate-local.ps1` crea un respaldo fuera del repositorio, lo restaura en PostgreSQL temporal, aplica `migrations/001_align_schema.sql` dos veces y valida el arranque. Sin parámetros no modifica el original; `-Apply` aplica la migración después del ensayo y compara las filas de las 14 tablas antes y después. Los respaldos quedan bajo `%LOCALAPPDATA%\BecasFind\backups`. Usar fuera de sesiones de edición concurrente. La migración añade unicidad de tokens y cascadas en becas_regiones; rechaza duplicados y fechas que requieran una conversión de zona horaria no acordada.

## Verificación de texto en PostgreSQL

```sql
SELECT nombre, encode(convert_to(nombre, 'UTF8'), 'hex') AS utf8_hex
FROM regiones WHERE nombre IN ('Ñuble', 'Valparaíso', 'Biobío');

SELECT id_beca, nombre
FROM becas
WHERE encode(convert_to(nombre, 'UTF8'), 'hex') ~ '(c383c2|c383e2|c382c2)';
```

No usar las reparaciones MySQL `UNHEX`/`RLIKE` en PostgreSQL. Reparar sobre copias y verificar los bytes antes de escribir en la base definitiva.

## Seguridad y publicación pendiente

DatabaseSeeder solo se registra con `dev` cuando no están activos `prod` ni `test`. Incluso en dev preserva usuarios existentes, incluidos los desactivados; no restablece contraseñas. El administrador inicial de producción se debe provisionar por un procedimiento separado, sin habilitar el perfil de demostración.

CORS tiene una única configuración en Spring Security. Producción exige `CORS_ALLOWED_ORIGINS` con orígenes exactos separados por comas; no admite comodines. Dev permite los puertos locales 5173, 5174 y 3000. La autenticación usa Bearer y no necesita cookies entre orígenes.

La recuperación no registra tokens y su respuesta no indica si un correo existe. El consumo del mismo token queda protegido con bloqueo de fila y probado con dos solicitudes simultáneas en PostgreSQL real. La integración HTTP de correo y la interfaz están implementadas; configurar la cuenta y el remitente y verificar la recepción real siguen pendientes. Los demás paquetes de búsqueda, datos, diseño y calidad siguen pendientes; aún no se conecta a Oracle.

Los POST de autenticación tienen límites por dirección de conexión y operación cada 15 minutos: 10 para login/restablecimiento y 5 para registro/solicitud de recuperación. Todas las solicitudes cuentan, incluidas las exitosas. Al superar el límite se devuelve ApiResponse con estado 429 y Retry-After en segundos. La búsqueda pública no consume este presupuesto. AUTH_RATE_LIMIT_ENABLED permite desactivarlo explícitamente; dejarlo activo en producción.

El contador reside en memoria y admite como máximo 4096 combinaciones de dirección y operación; al llenarse rechaza nuevas combinaciones hasta que expire una ventana. Reiniciar la aplicación reinicia los contadores. Se ignora X-Forwarded-For enviado por el cliente. Antes del despliegue se debe configurar y comprobar la identificación de clientes detrás del proxy confiable: sin ese ajuste todos sus clientes comparten la dirección del proxy. Varias instancias requieren un límite compartido o aplicado en el proxy.

Para repetir la comprobación PostgreSQL de concurrencia, usar `infra/verify-schema.ps1 -ConcurrencyTestMaven <ruta a mvn.cmd>` después de empaquetar. La prueba usa una base temporal separada de la instalación y de la base local; al terminar se detienen sus procesos y se restauran las variables del entorno.

## Recuperación por correo — configuración pendiente

Se integra [Resend por su API HTTP](https://resend.com/docs/api-reference/emails/send-email) usando HttpClient de Java 17 y Jackson existentes, sin SDK ni dependencias nuevas. Variables exclusivas del backend:

| Variable | Configuración |
|---|---|
| RESET_EMAIL_ENABLED | false por defecto; true habilita el envío |
| RESEND_API_KEY | Clave privada con permiso para enviar; nunca usar una variable VITE_* |
| RESET_EMAIL_FROM | Remitente autorizado en la cuenta del proveedor |
| FRONTEND_URL | Origen del frontend, sin rutas, query ni fragmentos; HTTPS obligatorio fuera de dev |

En dev se acepta HTTP en localhost/127.0.0.1; producción exige HTTPS. Al habilitar el envío con configuración incompleta, el arranque falla sin imprimir secretos. Si permanece deshabilitado, la solicitud devuelve 503 tanto para cuentas existentes como inexistentes, sin generar enlaces inútiles. Las plantillas `.env.example` no contienen credenciales.

El correo incluye un enlace `/reset-password#token=...`. El fragmento no se envía al servidor web y la pantalla lo retira del historial al leerlo; nunca guarda el token en localStorage. El enlace caduca en 15 minutos y solo admite un uso. No hay que copiar tokens desde una consola. La pantalla diferencia contraseña confirmada, enlace incompleto/vencido, límite 429, indisponibilidad y error de conexión.

Una nueva solicitud reemplaza el token anterior dentro de una transacción. Si el proveedor rechaza el envío o hay error de conexión, se revierte la transacción y se conserva el enlace anterior. Se registra únicamente un aviso genérico, sin correo, token, clave ni cuerpo de respuesta. Para no revelar la cuenta, el cliente recibe la misma respuesta pública que una solicitud a un correo inexistente. Revisar el aviso y los registros del proveedor si no llega un mensaje.

El envío es síncrono: conexión limitada a 5 segundos y solicitud a 10; el proveedor puede aceptar el correo antes de que termine el commit de la BD. No hay cola ni reintentos automáticos en esta fase. La clave de idempotencia identifica cada token. La aceptación HTTP no garantiza recepción: activar con la cuenta y el remitente autorizados, comprobar recepción en una dirección controlada, abrir el enlace y confirmar acceso con la nueva contraseña antes de publicar. Revisar también cuotas y autorización de remitente del plan elegido.

Vercel debe usar `frontend` como Root Directory. `frontend/vercel.json` configura el acceso directo a las rutas de la SPA siguiendo la [documentación de Vite en Vercel](https://vercel.com/docs/frameworks/frontend/vite). Esta fase prepara las rutas; no realiza un despliegue.

Pruebas: `mvn test` verifica API, transacciones y un proveedor HTTP local de pruebas. Con el frontend iniciado en 5173, `npx playwright test e2e/tests/password-recovery.spec.ts` verifica siete recorridos de interfaz con respuestas API controladas. Esas pruebas no envían correos reales. Las pruebas generales existentes usan un mock explícito del servicio de correo.
