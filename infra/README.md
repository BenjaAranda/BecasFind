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

La recuperación no registra tokens y no revela si un correo existe. El consumo del mismo token queda protegido con bloqueo de fila y probado con dos solicitudes simultáneas en PostgreSQL real. El envío real por correo sigue pendiente; se eligió integrar una API de correo y configurar posteriormente la cuenta y el remitente. No publicar la recuperación como completa hasta verificar el envío y la interfaz. Los demás paquetes de búsqueda, datos, diseño y calidad siguen pendientes; aún no se conecta a Oracle.

Los POST de autenticación tienen límites por dirección de conexión y operación cada 15 minutos: 10 para login/restablecimiento y 5 para registro/solicitud de recuperación. Todas las solicitudes cuentan, incluidas las exitosas. Al superar el límite se devuelve ApiResponse con estado 429 y Retry-After en segundos. La búsqueda pública no consume este presupuesto. AUTH_RATE_LIMIT_ENABLED permite desactivarlo explícitamente; dejarlo activo en producción.

El contador reside en memoria y admite como máximo 4096 combinaciones de dirección y operación; al llenarse rechaza nuevas combinaciones hasta que expire una ventana. Reiniciar la aplicación reinicia los contadores. Se ignora X-Forwarded-For enviado por el cliente. Antes del despliegue se debe configurar y comprobar la identificación de clientes detrás del proxy confiable: sin ese ajuste todos sus clientes comparten la dirección del proxy. Varias instancias requieren un límite compartido o aplicado en el proxy.

Para repetir la comprobación PostgreSQL de concurrencia, usar `infra/verify-schema.ps1 -ConcurrencyTestMaven <ruta a mvn.cmd>` después de empaquetar. La prueba usa una base temporal separada de la instalación y de la base local; al terminar se detienen sus procesos y se restauran las variables del entorno.
