# Base de datos y configuración

El listado vigente de trabajo está en [PLAN_MEJORAS.md](../PLAN_MEJORAS.md). Las secciones de avances de este archivo conservan resultados y pendientes de su fecha; no forman un segundo to do. Para cobertura estructurada y migración 002, consultar [COBERTURA_MONETARIA.md](COBERTURA_MONETARIA.md).

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

La opción acordada es Gmail SMTP gratuito mediante Spring Boot Mail. Pasos del usuario y límites: [GMAIL.md](../documentacion/GMAIL.md). Resend se conserva como alternativa explícita mediante HttpClient/Jackson existentes. Variables exclusivas del backend:

| Variable | Configuración |
|---|---|
| RESET_EMAIL_ENABLED | false por defecto; true habilita el envío |
| RESET_EMAIL_PROVIDER | gmail por defecto; resend selecciona la alternativa |
| GMAIL_USERNAME | Cuenta Gmail dedicada; será también el remitente |
| GMAIL_APP_PASSWORD | Contraseña de aplicación de 16 caracteres; nunca la contraseña normal ni una variable VITE_* |
| RESEND_API_KEY | Clave privada con permiso para enviar; nunca usar una variable VITE_* |
| RESET_EMAIL_FROM | Solo Resend: remitente autorizado en la cuenta del proveedor |
| FRONTEND_URL | Origen del frontend, sin rutas, query ni fragmentos; HTTPS obligatorio fuera de dev |

En dev se acepta HTTP en localhost/127.0.0.1; producción exige HTTPS. Al habilitar el envío con configuración incompleta, el arranque falla sin imprimir secretos. Si permanece deshabilitado, la solicitud devuelve 503 tanto para cuentas existentes como inexistentes, sin generar enlaces inútiles. Las plantillas `.env.example` no contienen credenciales.

El correo incluye un enlace `/reset-password#token=...`. El fragmento no se envía al servidor web y la pantalla lo retira del historial al leerlo; nunca guarda el token en localStorage. El enlace caduca en 15 minutos y solo admite un uso. No hay que copiar tokens desde una consola. La pantalla diferencia contraseña confirmada, enlace incompleto/vencido, límite 429, indisponibilidad y error de conexión.

Una nueva solicitud reemplaza el token anterior dentro de una transacción. Si el proveedor rechaza el envío o hay error de conexión, se revierte la transacción y se conserva el enlace anterior. Se registra únicamente un aviso genérico, sin correo, token, clave ni cuerpo de respuesta. Para no revelar la cuenta, el cliente recibe la misma respuesta pública que una solicitud a un correo inexistente. Revisar el aviso y los registros del proveedor si no llega un mensaje.

El envío es síncrono: conexión limitada a 5 segundos y solicitud a 10; el proveedor puede aceptar el correo antes de que termine el commit de la BD. No hay cola ni reintentos automáticos en esta fase. La clave de idempotencia identifica cada token. La aceptación HTTP no garantiza recepción: activar con la cuenta y el remitente autorizados, comprobar recepción en una dirección controlada, abrir el enlace y confirmar acceso con la nueva contraseña antes de publicar. Revisar también cuotas y autorización de remitente del plan elegido.

Vercel debe usar `frontend` como Root Directory. `frontend/vercel.json` configura el acceso directo a las rutas de la SPA siguiendo la [documentación de Vite en Vercel](https://vercel.com/docs/frameworks/frontend/vite). Esta fase prepara las rutas; no realiza un despliegue.

Pruebas: `mvn test` verifica API, transacciones y un proveedor HTTP local de pruebas. Con el frontend iniciado en 5173, `npx playwright test e2e/tests/password-recovery.spec.ts` verifica siete recorridos de interfaz con respuestas API controladas. Esas pruebas no envían correos reales. Las pruebas generales existentes usan un mock explícito del servicio de correo.

## Reglas del buscador — FASE 5

El listado público y las recomendaciones incluyen únicamente becas activas con fecha de cierre igual o posterior al día actual en America/Santiago. La fecha de inicio no participa en este criterio, conforme a BR-VIGENCIA. No se modifica la fecha de ninguna beca para hacerla visible.

Si se suministra RSH o NEM, se exigen valores registrados que satisfagan respectivamente RSH máximo >= RSH del estudiante y NEM mínimo <= NEM del estudiante. Un requisito nulo no certifica compatibilidad y se excluye para ese filtro. Si el filtro no se suministra, no restringe los resultados. Es una aplicación conservadora de las comparaciones del contrato; revisar y completar requisitos desconocidos sin inventarlos.

La región coincide exactamente o la beca es nacional (sin regiones). La tarjeta recibe todos los nombres de región en un orden estable. La búsqueda textual distingue porcentajes, guiones bajos y signos de exclamación literales; no permite que actúen como comodines. Sigue usando LIKE parametrizado, sin dependencias de búsqueda nuevas.

Las recomendaciones ejecutan la misma búsqueda con RSH, NEM y región del perfil. No excluyen instituciones por identificadores numéricos de tipo. No prueban por sí solas carrera, PAES, año académico ni requisitos externos; no presentarlas como garantía de elegibilidad.

Se rechazan con 400 los RSH fuera de 0–100, NEM no finito o fuera de 1–7, identificadores no positivos, texto de más de 200 caracteres, órdenes desconocidos y páginas de más de 100 registros. El orden predeterminado es cierre ascendente con id interno como desempate estable de paginación.

Pendientes antes de publicar: fechas y filtros de interfaz; definición y almacenamiento de monto numérico/unidad. Los órdenes montoAsc/montoDesc todavía operan sobre texto heredado y no son una comparación monetaria correcta. No extraer cifras arbitrarias de coberturas porcentuales o de importes con periodos distintos. El listado administrativo queda separado en el avance siguiente.

## Listado administrativo — FASE 6

`GET /api/becas/administracion?page=0&size=20&query=texto` requiere rol ADMIN. Devuelve ApiResponse con Page<BecaDTO>, incluyendo estadoActiva. El panel utiliza este endpoint para listar y buscar becas activas, inactivas y vencidas. La consulta pública mantiene BR-VIGENCIA; no se ha agregado una opción pública para omitirla.

La búsqueda administrativa admite texto literal de hasta 200 caracteres, páginas de 1–100 registros y orden de cierre con desempate estable. Valores de paginación inválidos, tipos incorrectos y JSON mal formado en BecaController reciben 400. Visitantes y estudiantes no acceden al listado completo.

El panel distingue Inactiva, Vigente y Vencida; la vigencia del estado es inclusiva para el día de Chile. Se adaptó la conexión existente sin rediseñar el CRUD. Siguen pendientes las fechas de presentación, los errores anteriores de calidad y el resto de los filtros de interfaz. La comprobación de interfaz usa respuestas controladas; los permisos y resultados se prueban por HTTP real contra la base de test.

## Interfaz de búsqueda — FASE 13

La URL mantiene filtros, texto, pestaña (`mode=recomendar`), página y tamaño. Volver desde el detalle restaura esos valores; reiniciar elimina los parámetros. Los cambios de filtros esperan 400 ms antes de pedir resultados, mientras el botón Buscar Becas ejecuta inmediatamente el texto actual y cancela la petición pendiente. Las solicitudes anteriores se cancelan y sus respuestas no actualizan una búsqueda posterior.

Recomendaciones utiliza su propio endpoint también al cambiar página/tamaño. Cambiar un filtro, pestaña o tamaño vuelve a la primera página. El selector de tamaño sigue disponible con una sola página. Errores de carga muestran un aviso con Reintentar y limpian los totales anteriores; los catálogos fallidos muestran un aviso, en lugar de aparentar que no existen opciones.

`src/utils/dates.ts` muestra fechas YYYY-MM-DD sin desplazarlas por la zona del navegador. Tarjetas, detalle y listado administrativo usan esta función. El cierre de hoy sigue vigente hasta terminar el día de Chile. El detalle distingue activación y vencimiento; los títulos de tarjetas se abren con teclado y los favoritos tienen nombre accesible y estado presionado.

Verificación reproducible, con el frontend iniciado: `npx playwright test e2e/tests/search-state.spec.ts`. Diez casos cubren debounce con una sola petición, búsqueda inmediata, reinicio, recomendaciones, regreso desde detalle, respuesta lenta, errores/reintento, fecha chilena, móvil y selector de tamaño. Usan respuestas API controladas; no sustituyen la prueba completa con datos reales antes de desplegar.

Pendientes: orden monetario/unidades, datos/importación, diseño general y calidad global. El orden por monto sigue siendo heredado por texto; esta fase no cambia el modelo. La revisión estática global aún contiene siete errores y dos advertencias existentes fuera del buscador corregido.

## Formularios administrativos — FASE 10

El editor envía `regionesIds: []` y `documentosRequeridos: []` para vaciar asociaciones; enviar `null` mantiene los valores anteriores en el servicio existente. Sin regiones seleccionadas, la beca tiene cobertura nacional. Los requisitos con valor cero se conservan al abrir la edición.

Los catálogos fallidos bloquean el guardado y ofrecen reintento. Los formularios validan campos y fechas antes de enviar, conservan datos tras un fallo y bloquean nuevos cambios/envíos mientras guardan. El listado cancela consultas antiguas, espera 400 ms al buscar y muestra totalElements. Errores de consulta, edición, eliminación y desactivación son visibles; las confirmaciones fallidas permanecen abiertas para reintentar.

Verificación: `npx playwright test e2e/tests/admin-forms.spec.ts e2e/tests/admin-listing.spec.ts`, diez casos aprobados con respuestas API controladas. Compilaciones frontend/backend y revisión estática de archivos modificados aprobadas. La revisión global conserva tres errores fuera de administración (AuthContext y prueba de detalle). Las validaciones de interfaz no sustituyen controles del servidor; la política de borrado y las escrituras reales no cambiaron ni se ejecutaron sobre datos locales. Importación CSV y despliegue permanecen pendientes.

## Importación CSV — FASE 14

El archivo se acepta completo o se revierte completo. Un informe con errores contiene cero creadas y cero actualizadas; corregir el CSV y reenviarlo. No mover un archivo a procesados si errores es distinto de cero. El endpoint sigue entregando el informe en ApiResponse/HTTP 200; superar 10 MB devuelve ApiResponse/413. El límite del archivo es 5000 filas, 10 MB; el request multipart y max-swallow-size de Tomcat se limitan a 11 MB para permitir entregar el rechazo sin cerrar prematuramente la conexión.

Encabezados estándar requeridos, en cualquier orden:
`nombre,institucion,tipo_beca,monto,fecha_inicio,fecha_cierre,rsh_maximo,nem_minimo,regiones,descripcion,descripcion_larga,url`.
Puede añadirse `documentos_requeridos`; otras columnas, encabezados duplicados o ausentes se rechazan. Si la columna de documentos está presente reemplaza la lista y vacía elimina documentos; si está ausente conserva los anteriores al actualizar. Cada documento proporcionado debe llevar [OBLIGATORIO] o [OPCIONAL], separado por punto y coma. Regiones vacías representan cobertura nacional; una abreviatura desconocida rechaza el archivo entero.

Nombre/institución/tipo obligatorios, límites de longitud del esquema, RSH 0–100, NEM 1–7 con máximo un decimal, fechas estrictas y cierre no anterior al inicio. La URL debe estar presente y apuntar a una subpágina HTTP/HTTPS; no se realiza una petición a la fuente. Reimportar una beca existente respeta su desactivación y cambia su tipo/regiones/requisitos; los requisitos faltantes se crean. La institución existente conserva su clasificación. El creador de una beca nueva es el administrador autenticado.

Entrada UTF-8 (BOM tolerado) con fallback Windows-1252 para archivos antiguos. Patrones conocidos de doble codificación y bytes nulos se rechazan; no se reparan textos silenciosamente. Los CSV nuevos deben seguir escribiéndose en UTF-8 sin BOM. Para verificar PostgreSQL después de importar:

```sql
SELECT id_beca, nombre, encode(convert_to(nombre, 'UTF8'), 'hex')
FROM becas
WHERE encode(convert_to(nombre || coalesce(descripcion_corta, '') || coalesce(descripcion_larga, ''), 'UTF8'), 'hex') ~ 'c383c2|c383e2|c382c2';
SELECT id_institucion, nombre, encode(convert_to(nombre, 'UTF8'), 'hex')
FROM instituciones
WHERE encode(convert_to(nombre, 'UTF8'), 'hex') ~ 'c383c2|c383e2|c382c2';
```

Prueba reproducible: desde backend, `mvn -Dtest=CsvImportIntegrityTest test`. Las pruebas usan datos temporales, provocan errores de persistencia y comprueban rollback/reintento. Al ejecutarlas contra una base PostgreSQL desechable verifican HEX después de cada importación; nunca apuntarlas a una base con datos que conservar, pues el perfil test recrea el esquema.

Batch size 50 y flush cada 50/final no garantizan INSERT en lotes con IDs IDENTITY y consultas intermedias. La optimización real y la revisión del corpus siguen abiertas. El cierre vacío conserva el valor contractual 2026-12-31; confirmar fechas oficiales antes de publicar. Esta fase no importa los CSV históricos sobre la base local ni activa un scraper o despliegue.

Resultados finales: 114 pruebas del backend y empaquetado aprobados; las doce pruebas de integridad CSV también aprobadas sobre PostgreSQL 17 temporal. Cada importación de esa ejecución incluye consulta HEX contra becas/instituciones; los nombres con tildes/ñ coinciden con sus bytes UTF-8. El fallo de carga demasiado grande inicialmente cerraba la conexión; max-swallow-size acotado a 11 MB permite responder 413 en la prueba real. Las bases de prueba son desechables y se detuvieron; los datos de la aplicación no se modificaron.

## Sesión frontend y calidad estática — FASE 7

AuthProvider restaura la sesión al inicializar el estado. useAuth/contexto están en src/context/useAuth.ts; el provider permanece en AuthContext.tsx. Los consumidores utilizan el hook separado. Token, identidad y vencimiento se mantienen juntos; no se restaura identidad desde el caché user. Tokens vencidos, mal formados o sin los campos esperados se descartan antes de abrir rutas protegidas.

Una sesión abierta caduca según exp, sin esperar una petición fallida. El temporizador se cancela/rearma al cambiar sesión; storage propaga login/logout entre pestañas. La decodificación JWT no verifica la firma en frontend: el backend mantiene la autorización real por firma y estado/rol actuales.

Comprobaciones: npm run lint sin errores/advertencias, npm run build y mvn compile aprobados. Desde frontend: `npx playwright test e2e/tests/auth-session.spec.ts e2e/tests/beca-detail.spec.ts` valida catorce casos con respuestas controladas, incluidos token de Axios, restauración, expiración, pestañas, login, registro, perfil protegido y contenido de detalle. Otras 27 regresiones de buscador, administración y recuperación también pasaron durante la fase. Dos selectores incorrectos de los tests nuevos se corrigieron durante la verificación; el cierre de esos catorce casos pasó completo.

No representa aún la batería global de navegador con backend/correo reales. Las pruebas antiguas de login/search-ux necesitan revisar su dependencia de datos y sus aserciones; diseño y despliegue siguen pendientes. La última suite backend completa permanece en 114 casos aprobados.

### Verificación de interfaz — FASE 8 (30 de septiembre de 2026)

Acceso/registro y navegación pública/administrativa renovados sin dependencias nuevas. Menús móviles comprobados, controles de contraseña accesibles y retorno administrativo a `/explorar` corregido. Pasaron 47 pruebas Chromium con API controlada, revisión estática global, build frontend y `mvn compile`. Capturas de escritorio/móvil revisadas; esto no confirma correo real ni despliegue. Continúan pendientes la validación integrada con servicios reales y la configuración de producción acordada.

### Exploración y detalle — FASE 9

Buscador, filtros y tarjetas renovados; filtros plegables en móvil y eliminación individual de texto/RSH/NEM. Detalle comparte navegación y ofrece error/reintento, con cancelación de peticiones y vuelta segura al buscador desde un enlace directo. Favoritos fallidos informan y revierten su estado; bloquean escrituras simultáneas por beca. Parser de documentos acepta ítems solo opcionales y separa líneas/marcadores.

Se aprobaron 54 casos Chromium distintos con API controlada durante esta fase; los 19 de buscador/detalle se ejecutaron después del cambio final en favoritos. Desde frontend: `npx playwright test search-design search-state beca-detail --workers=1`. Build, revisión estática y `mvn compile` aprobados; capturas a 390 y 1280 px revisadas. Sin backend ni datos modificados. Correo, integración real y despliegue continúan pendientes.

### Portada — FASE 11

Portada renovada con acciones distintas según sesión. El buscador sigue protegido; se informa que necesita cuenta. Retiradas cifras/promesas sin respaldo y explicados criterios reales y límites de recomendaciones. Enlace para saltar al contenido comprobado con teclado; cuatro anchos 360/390/768/1440 px sin desbordamiento y capturas revisadas.

`npx playwright test landing-design navigation-auth-design auth-session password-recovery --workers=1` aprobó 32 casos con respuestas controladas. Lint global, build y mvn compile aprobados. Sin nuevas dependencias, datos ni backend modificados; correo real y despliegue siguen pendientes.

### Perfil y favoritos — FASE 12, interfaz

Carga de perfil/catálogos fallida bloquea guardado y ofrece reintento. Guardar preserva RSH cero, valida campos según esquema actual, envía null para asociaciones vaciadas y conserva cambios si falla. Favoritos separa error/carga/vacío, cancela cargas al salir y gestiona fallos/envíos pendientes al quitar; muestra becas inactivas guardadas.

`npx playwright test profile-favorites auth-session search-design search-state --workers=1` aprobó 39 casos con API controlada. Lint, build y mvn compile aprobados; capturas 390/1280 px revisadas. No se cambiaron DTOs, servicios backend ni datos locales: validación servidor, concurrencia e integración real continúan pendientes.

### Validación de solicitudes — FASE 2

DTOs de perfil/becas/documentos/usuarios administrativos validan rangos, longitudes, identificadores, elementos anidados, fechas y URL HTTP/HTTPS sin credenciales. Contraseña administrativa limitada a 72 bytes UTF-8 además de 8–72 caracteres. Null opcional y listas vacías se conservan; no cambia esquema ni controladores.

`mvn package` aprobó 119 pruebas (cinco nuevas con varios casos HTTP contra H2), además de compilación/empaquetado. `mvn compile` aprobado. Se comprueba rechazo 400 sin cambios y persistencia/vaciado válidos. PostgreSQL/local/frontend no fueron modificados ni probados nuevamente en esta fase. Validación de referencias, concurrencia, borrado e integración real siguen pendientes.


### Verificación de servicios — 30 de septiembre de 2026

FASE 5 rechaza referencias regionales inexistentes, crea requisitos al editar becas que carecen de ellos y serializa favoritos/guardado de perfil mediante bloqueos transaccionales por usuario. Guardar favoritos comprueba y bloquea la beca referenciada. La política de eliminación no cambia.

CoreServiceIntegrityTest añade seis pruebas sobre referencias y rollback, beca inexistente, favoritos concurrentes, perfil inicial concurrente, requisitos y limpieza de asociaciones al eliminar. Suite completa: 125 pruebas, cero fallos/errores; Maven package y compile aprobados. Estas comprobaciones usan H2 aislado. Repetirlas en PostgreSQL 17 antes de publicar; esta fase no modifica la base local ni despliega servicios.


### Verificación HTTP — 30 de septiembre de 2026

FASE 6 corrige errores 400/405/415, conserva Allow en 405 y alinea respuestas de creación HTTP/cuerpo en 201. ApiResponse conserva data:null. HttpContractTest cubre JSON/tipos inválidos en varios controladores, archivo ausente, métodos/contenido incompatibles, registro y creación administrativa con autorización por rol. Suite completa: 131 pruebas aprobadas; Maven package y compile aprobados con H2 aislado. ErrorResponse conserva sus campos actuales; unificación completa y verificación PostgreSQL siguen pendientes. Sin cambios de infraestructura ni despliegues.


### Verificación administrativa — 30 de septiembre de 2026

FASE 10 introduce diálogo nativo para formularios, confirmaciones e importación CSV; foco contenido/restaurado, Escape condicionado al estado de escritura y fondo inerte. Diseño y adaptación de administración actualizados sin dependencias nuevas. Veinte casos Chromium aprobados con API controlada; cuatro nuevos casos de accesibilidad/adaptación. Lint/build y Maven compile aprobados. Un fallo inicial de búsqueda en paralelo no se reprodujo aislado ni en la suite completa en serie; causa no confirmada. Capturas a 390/1280 px inspeccionadas. La integración con backend/PostgreSQL, segundo navegador y auditoría global de accesibilidad siguen pendientes. Sin despliegues.


### Perfil y favoritos sobre PostgreSQL 17 — 30 de septiembre de 2026

Ejecutar desde la raíz en PowerShell, con Java 17 en JAVA_HOME y Maven disponible:

```powershell
./infra/verify-profile-postgres.ps1 -MavenPath 'ruta/absoluta/mvn.cmd'
```

PostgresBin permite indicar otra instalación de PostgreSQL 17. El verificador crea un clúster aislado en TEMP, limitado a loopback, con autenticación trust solo para ese entorno efímero. Cada clase recibe una base nueva instalada con ddl.sql; sus catálogos se sustituyen por fixtures de pruebas y Hibernate valida el esquema. Nunca apuntarlo a la base de la aplicación: no acepta una URL externa. El servidor se detiene y las variables se restauran en finally; los logs quedan en TEMP para diagnóstico.

Resultado: 10 pruebas PostgreSQL aprobadas (cuatro de persistencia HTTP y seis de integridad/concurrencia). Suite completa adicional H2: 135 pruebas aprobadas; package y compile aprobados. La primera ejecución falló por duplicación de semillas DDL/test y se corrigió el montaje aislado. Pendiente: navegador real conectado al backend/PostgreSQL sin mocks. Sin cambios de producción ni despliegues.


### Recorrido real de navegador — 30 de septiembre de 2026

Requisitos: Java 17, PostgreSQL 17, Node, dependencias frontend y Chromium Playwright instalados. Empaquetar primero la versión actual del backend con Maven package. Desde la raíz:

```powershell
./infra/verify-profile-browser.ps1
```

El parámetro PostgresBin permite otra instalación local. Se usa el JAR backend/target/becasfind-api-1.0.0-SNAPSHOT.jar; regenerarlo tras cambios. El script crea PostgreSQL temporal con DDL/fixtures, fija datasource/schema y perfil prod, inicia API/Vite en loopback con puertos temporales y ejecuta playwright.live.config.ts. La suite e2e/live está separada de e2e/tests y no intercepta respuestas ni inventa JWT. Fixtures fechadas en 2026 deben actualizarse antes de ejecutar en otro período.

Un recorrido real aprobado: login, perfil cero/decimal/tildes, recarga/vaciado, recomendaciones y favoritos persistidos/eliminados. Se comprueban resultados en interfaz y API real. Lint/build y Maven compile aprobados; suite completa backend no repetida en esta etapa. Al terminar se detienen los procesos y se restauran variables; logs quedan en TEMP. Base local intacta. No equivale a cobertura integral de administración, correo, despliegue o segundo navegador.


### Ampliación administrativa del recorrido real — 30 de septiembre de 2026

verify-profile-browser.ps1 ejecuta ahora cuatro casos live: CRUD de becas, creación/desactivación de usuarios, restricciones de estudiante y perfil/favoritos. Verificación final aprobada con PostgreSQL temporal/backend prod y comprobación SQL adicional de soft delete: la cuenta sigue almacenada con activo=false. Lint/build y Maven compile aprobados; backend de producción sin cambios.

Limitación descubierta: el filtro @Where de Usuario oculta las cuentas inactivas también en administración. Sigue pendiente corregir su visualización mediante una consulta administrativa controlada y añadir edición de usuarios en interfaz. El token de la cuenta desactivada devuelve 403; login nuevo devuelve 401. La suite no simula respuestas y comprueba esos estados exactos. Sin despliegues.


### CSV real y configuración regional — 30 de septiembre de 2026

verify-profile-browser.ps1 ejecuta cinco casos live. El caso CSV importa desde la interfaz, crea/actualiza sin duplicar y comprueba rechazo sin escrituras parciales; errores de fila se expresan como HTTP 200 con ImportResultDTO.errores. Después de cada importación consulta los bytes PostgreSQL de nombres y ausencia de patrones de mojibake. Son fixtures sintéticas, no becas oficiales ni auditoría del corpus histórico.

El clúster temporal ahora usa --locale-provider=icu --icu-locale=es-CL: la búsqueda de un nombre con Ñ no coincidió bajo locale C y sí con ICU. La instalación PostgreSQL debe incluir ICU. Antes de publicar comprobar proveedor/locale y búsquedas españolas en la base destino; este verificador no migra la configuración regional de bases existentes.

Cinco recorridos reales aprobados, lint/build y Maven compile aprobados. No se repitió suite completa backend. Los servicios temporales se detuvieron; base local intacta. Pendientes calidad de datos históricos, batch/concurrencia y operación real.


### Consulta de usuarios administrativos — 30 de septiembre de 2026

verify-profile-postgres.ps1 incluye ahora AdminUserProjectionTest: 11 pruebas PostgreSQL aprobadas y DDL validado. La proyección administrativa lee campos controlados de usuarios activos/inactivos; las consultas habituales conservan el filtro de actividad. Regresión H2: 136 pruebas aprobadas; package/compile aprobados. No se conecta aún al servicio (pendiente FASE 5), por lo que la interfaz sigue excluyendo usuarios inactivos. No hubo cambios de frontend ni despliegues.


### Servicio de listado administrativo — 30 de septiembre de 2026

La proyección administrativa ya está conectada a UsuarioServiceImpl.findAll y al endpoint existente mediante UsuarioDTO. Usuarios inactivos visibles con sus campos controlados; acceso ADMIN, filtros de identidad y soft delete conservados. Prueba HTTP descarta exposición de contraseñas. Cinco recorridos live PostgreSQL aprobados: cuenta visible como Inactivo, botón de desactivación ausente, token previo bloqueado y login denegado, junto a regresiones de becas/permisos/CSV/perfil.

136 pruebas H2, package, compile, lint/build aprobados. No se repitió la suite PostgreSQL específica de 11 casos. Falta edición de usuarios en interfaz; sin despliegues ni modificaciones en la base local.


### Edición de usuarios activos — 30 de septiembre de 2026

Interfaz administrativa permite editar nombre/correo de cuentas activas mediante el PUT existente. Los campos de rol/contraseña no forman parte del payload de edición. Valores precargados, controles bloqueados durante guardado y conservación/reintento ante errores. Cuentas inactivas visibles sin botones de edición/desactivación.

14 casos Chromium con API controlada y cinco recorridos live aprobados; el recorrido real edita nombre y comprueba recarga antes de desactivar. Lint/build y Maven compile aprobados. Backend sin cambios: no se repitieron completas las suites H2/PostgreSQL anteriores. Sin despliegue ni cambios en la base local.

### Invalidación de sesiones tras recuperación — 30 de septiembre de 2026

Los JWT nuevos incluyen una marca HMAC vinculada a las credenciales almacenadas; la API rechaza sesiones anteriores al cambio de contraseña. La contraseña y su hash no se incluyen en el token. Al aplicar esta versión, tokens antiguos sin la marca requieren un nuevo login; no hay migración de base de datos.

verify-profile-postgres.ps1 -MavenPath <ruta-mvn.cmd> -TestClasses AccountSecurityTest ejecuta esta suite en una base temporal con DDL real y validate. Verificación: 14 casos PostgreSQL aprobados, 140 casos H2 aprobados, package/compile aprobados y cinco recorridos Chromium reales aprobados. La recuperación usa un servicio de correo simulado en pruebas; no confirma entrega a una bandeja real. Sin despliegues ni cambios en la base local.

### Contrato de errores del manejador global — 30 de septiembre de 2026

GlobalExceptionHandler usa ApiResponse con data:null para todos sus errores y conserva error/path/validationErrors cuando corresponden. Se mantienen códigos HTTP y Allow; se elimina ErrorResponse sin usos restantes. Los filtros de seguridad todavía requieren unificar respuestas por separado.

verify-profile-postgres.ps1 -MavenPath <ruta-mvn.cmd> -TestClasses HttpContractTest verifica ocho casos de contrato HTTP sobre PostgreSQL temporal/DDL real/validate. Resultado: ocho aprobados, 142 pruebas H2 aprobadas, cinco recorridos Chromium reales aprobados y Maven package/compile aprobados. Sin cambios de frontend, base local ni despliegues.

### Respuestas de autenticación y permisos — 30 de septiembre de 2026

Sesiones ausentes/inválidas reciben 401 JSON con ApiResponse y WWW-Authenticate: Bearer. Un usuario autenticado sin permisos recibe 403; no debe perder su sesión por ese rechazo. Tokens de cuentas desactivadas o anteriores al cambio de contraseña pasan de 403 a 401. El listado administrativo exige autenticación explícita antes de las reglas públicas.

Verificación: 146 pruebas H2 y 18 casos PostgreSQL (seleccionar -TestClasses SecurityResponseTest,AccountSecurityTest) aprobados. Seis recorridos Chromium reales, lint/build y Maven package/compile aprobados. El nuevo caso comprueba firma inválida, JSON 401, redirección al login y eliminación del token. El correo sigue simulado en pruebas de recuperación.

verify-profile-browser.ps1 -BackendJarPath <ruta-absoluta.jar> permite usar un empaquetado aislado cuando el JAR habitual está ocupado; omitirlo mantiene la ruta habitual. Esta fase se empaquetó en TEMP mediante un POM temporal, sin interrumpir el proceso que usaba el JAR local. No se publica ni se reinicia el servicio local automáticamente; sin cambios en la base local.

### Validación pública de autenticación — 30 de septiembre de 2026

Registro limita nombre/correo según almacenamiento; login y recuperación rechazan contraseñas que superen 72 bytes UTF-8. El token de recuperación malformado devuelve 400; un UUID inexistente mantiene 401. Una contraseña inválida no modifica el hash ni consume el token válido.

Seleccionar -TestClasses PublicAuthValidationTest en el verificador PostgreSQL ejecuta siete casos con DDL real/validate. Resultado: siete aprobados, 153 pruebas H2 aprobadas y seis recorridos Chromium reales aprobados. Package/compile aprobados mediante empaquetado temporal aislado y BackendJarPath. Sin cambios de frontend, esquema, base local ni despliegues; entrega de correo simulada en pruebas.

### Formularios públicos — 30 de septiembre de 2026

Registro/login/reset alinean longitud y validación UTF-8; errores de campo del servidor visibles y valores conservados para reintentar. Reset usa controles compartidos con visibilidad de contraseña, ayuda asociada y foco por teclado.

34 casos Chromium con API controlada aprobados (public-auth-validation, password-recovery, navigation-auth-design y auth-session); nueve son nuevos. Capturas de recuperación a 390/1280 px inspeccionadas. Lint/build y Maven compile aprobados. El mock de catálogos se corrigió para devolver listas; la prueba de registro exige destino visible sin errores de página.

verify-profile-browser.ps1 ejecuta ahora siete casos reales, incluido public-auth.spec.ts: registro/login y acceso con JWT real usando nombre español y contraseña de 72 bytes UTF-8. Siete aprobados con backend prod/PostgreSQL temporal. Se usó BackendJarPath del empaquetado aislado anterior. Backend sin cambios: no se repitieron suites completas H2/DTO PostgreSQL. No verifica bandeja de correo ni despliegue.


### Pruebas de búsqueda — 30 de septiembre de 2026

search-ux.spec.ts ahora es reproducible con API controlada y verifica CP-18/63/66 mediante resultados/payloads concretos, reinicio y reloj Playwright (cero solicitudes a 399 ms; una a 400 ms). Junto a search-state/search-design: 20 casos aprobados.

verify-profile-browser.ps1 ejecuta ocho casos reales. search.spec.ts comprueba filtros combinados/orden, límites RSH/NEM y texto sin coincidencias con API y tarjetas reales. El helper de login espera las cargas iniciales antes de modificar tokens y public-auth reutiliza la respuesta del login UI, evitando un intento redundante; rate limit sigue activo y sin cambios.

Ocho recorridos reales, lint/build y Maven compile aprobados. Código de producción sin cambios; no se repitieron suites backend completas. Empaquetado aislado anterior usado con BackendJarPath, servicios temporales detenidos y base local intacta. Fixtures de 2026 no representan fuentes oficiales ni deben usarse fuera de su período sin revisión. Sin despliegue/correo real.

### Pruebas de login — 30 de septiembre de 2026

login-flow.spec.ts verifica CP-01/04/05/67 con API controlada: validación nativa sin solicitudes, payload exacto, token/identidad, contenido de destino, persistencia tras recarga y rechazo con campos conservados. No depende de credenciales locales; el JWT controlado solo prueba la interfaz.

38 casos de autenticación controlada y ocho recorridos Chromium con backend prod/PostgreSQL reales aprobados. public-auth.spec.ts compara el token almacenado con la respuesta real y verifica identidad/sesión tras recarga y acceso protegido. No añade intentos de login ni altera límites. Lint/build y Maven compile aprobados; backend sin cambios y suites completas backend no repetidas. Servicios temporales detenidos. Sin despliegue ni correo real.

Modelo monetario autorizado para las próximas FASES 1/2/5, por separado: texto original más importe, moneda y periodicidad conocidos; porcentajes/beneficios sin importe diferenciados sin conversiones inventadas. El esquema aún no se ha modificado.

### Cobertura estructurada — 30 de septiembre de 2026

FASES 1/2/5 completadas juntas por petición explícita. Modelo/migración/compatibilidad y procedimiento de despliegue en [COBERTURA_MONETARIA.md](COBERTURA_MONETARIA.md). montoCobertura sigue conservando el texto; la API añade cobertura validada y ordena importes numéricos dentro de grupos de moneda/periodicidad. Lo desconocido permanece al final; no hay inferencia ni conversión de importes históricos.

160 pruebas H2, siete MonetaryCoverageTest y doce CsvImportIntegrityTest en PostgreSQL 17, comprobación SQL de migración repetida y ocho recorridos Chromium reales aprobados. Package/compile/lint/build aprobados. Los decimales JSON se devuelven como cadenas, incluido el límite 9999999999999999.99 verificado por HTTP y lectura posterior. Se utilizó un empaquetado nuevo en TEMP y se detuvieron servicios aislados; la base local no se modificó. Pendientes controles de edición/explicación visual y enriquecimiento histórico. No hay despliegue ni entrega real de correo.
