# Calidad antes del despliegue

Actualización P09: Gmail real verificado con autorización del titular. SMTP/IMAP TLS; dos mensajes recibidos en INBOX sin marcarlos como leídos. PostgreSQL temporal: cambio de contraseña/login, rechazo de reutilización, enlace vencido con fecha forzada al pasado y sesión anterior invalidada. Cuenta real intacta; base/backend temporales detenidos. No se esperaron 15 minutos. Runner infra/verify-gmail-delivery.py y resultados sin datos sensibles; no enviar correos al ejecutar CI. La instalación local conserva RESET_EMAIL_ENABLED=false; el origen público HTTPS/activación pertenecen a P12. Las referencias posteriores a P09 pendiente son evidencia histórica.

Fecha: 30 de septiembre de 2026. Alcance autorizado: P06–P11; P12–P14 no se han iniciado.

## Trazabilidad (P06)

Los tres documentos Office se leyeron sin modificarlos. La matriz [TRAZABILIDAD.md](TRAZABILIDAD.md) relaciona 67 casos con 19 requisitos y distingue contratos históricos del alcance vigente. Se corrigió el acceso público al catálogo de tipos de institución; las pruebas de detalle, fechas, favoritos y recomendaciones ahora exigen resultados concretos. No se agregaron criterios de recomendación ni funciones de postulación ajenos al alcance.

## Accesibilidad y compatibilidad (P07)

La suite usa el frontend compilado con preview aislado y dos motores: Chromium y Firefox. La matriz recorre portada, login, registro, recuperación, reset, detalle, buscador, perfil, favoritos y ambos paneles a 360, 390, 768 y 1440 px. Comprueba nombres accesibles de controles, un único main, navegación inicial con teclado, errores JavaScript, contraste de texto y ausencia de desbordamiento de la página.

Para ampliación se aplica CSS zoom=2 sobre un viewport de 720 px y se comprueba reflujo: es una simulación automatizada al 200 %, no una certificación del zoom nativo ni una auditoría completa WCAG con lector de pantalla. Las tablas administrativas admiten desplazamiento horizontal interno. Los recorridos existentes cubren formularios, modales, foco, errores/reintentos, sesión, filtros y favoritos. Las capturas se generan como artefactos de pruebas; se inspeccionaron ejemplos móviles en ambos motores.

Hallazgos corregidos: texto secundario del panel administrativo con contraste inferior a 4,5:1 y enlace administrativo de detalle construido con ID numérico. El listado administrativo entrega publicId para abrir el UUID público; el CRUD sigue usando números. Las respuestas públicas conservan su contrato sin IDs internos.

## Rendimiento (P08)

Medición sintética local, no resultados de Oracle ni de producción:

- Frontend: build de producción; cinco cargas por modo. Escritorio 1280 px y móvil 390 px con CPU x4, latencia 80 ms y descarga 200.000 bytes/s. Presupuestos: JS gzip total 150 KiB, CSS gzip 30 KiB, mediana LCP 2,5 s, CLS máximo 0,1.
- Búsqueda HTTP PostgreSQL: 5.000 becas sintéticas con requisitos explícitos, página de 20, consulta de texto/RSH/NEM/región, diez solicitudes de calentamiento y 80 muestras con cuatro lectores. Resultado local: p50 81,02 ms; p95 124,68 ms; máximo 183,37 ms. Presupuesto local p95 < 1 s. No se sustituyen requisitos desconocidos por valores inferidos en los datos del usuario.
- Las pruebas de búsqueda comprueban una sola petición tras 400 ms de escritura y descarte de respuestas antiguas. Las escrituras y lotes se registran en P05.

Comandos reproducibles:

```powershell
npm --prefix frontend ci
npm --prefix frontend run lint
npm --prefix frontend run build
node frontend/node_modules/@playwright/test/cli.js install chromium firefox
node frontend/node_modules/@playwright/test/cli.js test -c frontend/playwright.config.ts --workers 1
# Desde frontend:
node measure-performance.mjs
# Desde raíz; indicar el Maven instalado:
./infra/verify-profile-postgres.ps1 -MavenPath <mvn.cmd> -TestClasses ReadPerformanceIT
```

Resultado del frontend local: JS gzip 119048 bytes; CSS gzip 7478 bytes; LCP mediano escritorio 120 ms y móvil 1.312 ms; CLS máximo 0. Todos dentro del presupuesto.

Los JSON de medidas se generan en frontend/performance-report y backend/target; no contienen datos reales. CI conserva informes de pruebas y mediciones. Estos objetivos acotan regresiones de laboratorio; habrá que medir el destino y usuarios reales después del despliegue. No se afirma un INP de producción.

## Correo real (P09)

Guía concreta del usuario: [RESEND.md](RESEND.md).

Pendiente de configuración externa: el usuario confirmó que no tiene cuenta Resend, clave ni remitente. La integración, validación de URL/remitente, errores del proveedor, caducidad de quince minutos, consumo único e invalidación de sesiones tienen pruebas locales. Esto no demuestra entrega a una bandeja.

En backend/.env (ignorado por Git), completar RESEND_API_KEY y RESET_EMAIL_FROM; indicar FRONTEND_URL del entorno de prueba y habilitar RESET_EMAIL_ENABLED. HTTP solo se permite en dev y localhost; prod exige HTTPS. No publicar claves ni tokens en informes. Con una dirección autorizada del usuario: crear una cuenta de prueba aislada, solicitar recuperación, comprobar recepción y enlace, cambiar la contraseña, verificar login nuevo y rechazo del antiguo y del enlace reutilizado. Repetir con un token caducado. Conservar evidencia sin credenciales ni URL del token. No enviar correos a terceros.

## Pipeline (P10)

.github/workflows/quality.yml ejecuta verify de Java 17, DDL/migraciones y pruebas PostgreSQL 17 aisladas, npm ci/lint/audit/build, medición y Chromium/Firefox. Acciones fijadas por SHA; permisos contents:read; sin credenciales de producción ni pasos de despliegue. Los informes se adjuntan incluso si falla un job. Una regresión hace fallar el pipeline. No se ha modificado la protección de ramas ni se ha fusionado el PR.

## Base local (P11)

Las migraciones 001–005 se aplicaron únicamente a la base local con la aplicación detenida. Antes se generó un respaldo pg_dump en formato custom y se restauró en PostgreSQL temporal; Hibernate validate comprobó el esquema y la conservación de usuarios. El backend actualizado también arrancó en perfil prod contra la base local, con Hibernate validate y sin alterar usuarios. Tras aplicar, las huellas de los campos originales de las 14 tablas permanecieron idénticas. El respaldo contiene datos privados y permanece fuera de Git, bajo LocalAppData/BecasFind/backups.

migrate-local.ps1 permite solo localhost, exige ausencia de otras conexiones, ensaya el respaldo antes de Apply y aborta ante cualquier fallo. verify-schema.ps1 admite un JAR empaquetado aislado y aplica todas las migraciones dos veces sobre la copia. La base del destino se instalará o migrará durante P12, cuando exista; este trabajo local no valida Oracle.

## Dependencias

El audit inicial encontró once vulnerabilidades en frontend. Se actualizaron dependencias dentro de los rangos permitidos; React/ReactDOM siguen en 19.2.5 y Tailwind en 4.3.0. npm audit terminó con cero vulnerabilidades. El lockfile queda versionado. No se agregaron bibliotecas de producción.

## Verificación registrada

171 pruebas backend H2 aprobadas y JAR actualizado empaquetado en una ruta temporal aislada (el JAR anterior en target estaba bloqueado por Windows). Suite de navegador: 210 casos aprobados; matriz de 12 casos repetida tras corregir el UUID administrativo. Build, lint y audit aprobados. Ocho recorridos adicionales con backend prod y PostgreSQL reales aprobados. Respaldo original restaurado y las cinco migraciones repetidas dos veces sobre su copia; arranque actual contra PostgreSQL local 17.10 aprobado con usuarios conservados. [Mediciones y resultados](EVIDENCIA_PRE_DESPLIEGUE.json). El resultado de GitHub se registra en el plan vigente al cerrar la entrega.

El primer pipeline detectó que un build sin VITE_API_URL generaba rutas undefined/api. CI y el runner local ahora declaran un origen aislado para mocks, y Vite rechaza builds sin un origen HTTP(S) canónico (sin ruta, credenciales, query ni fragmento). No se relajaron las pruebas de login ni se agregaron reintentos.

CI remoto aprobado: [Quality 36786469707](https://github.com/BenjaAranda/BecasFind/actions/runs/36786469707), código 19c7512. Tres jobs en verde; 171 H2, 40 PostgreSQL y 210 casos de navegador. Medidas de CI: JS gzip 119.068 bytes, CSS 7.478 bytes, LCP escritorio 80 ms/móvil limitado 1.016 ms, CLS 0; búsqueda p95 227,96 ms. Datos sintéticos en runner Ubuntu, no producción. Runner local y revisión independiente aprobados.

## Acceso público sin cuenta

Autorizado por el usuario: coste cero y búsqueda/detalle públicos. Solo POST /api/becas/buscar se añadió a la lista pública; las rutas privadas y las escrituras administrativas siguen protegidas. El frontend no carga favoritos ni recomendaciones guardadas para visitantes. Portada permite explorar directamente; los datos guardados y administración requieren sesión. Build/lint aprobados; 220 casos Chromium/Firefox y nueve recorridos PostgreSQL/backend prod aprobados, incluido visitante real. Diez pruebas backend de seguridad aprobadas y empaquetado aislado. Revisión independiente sin hallazgos requeridos. Ningún servicio contratado ni dominio comprado.
# Actualización: identidad institucional y Gmail gratuito

Estado posterior del 1 de octubre: P09 fue cerrado con entrega real autorizada según [GMAIL.md](GMAIL.md) y PLAN_MEJORAS.md; las notas de configuración pendiente que siguen conservan su contexto histórico. La entrega actual incorpora [93 CSV procesados](auditoria_corpus/procesados/README.md): 641 registros preservados, 562 candidatos, 549 nuevos inactivos/13 existentes conservados y siete correcciones parciales UChile inactivas. Dos respaldos custom restaurados y comparados antes de cada carga; las 18 becas previas se conservaron. Repetir el archivo completo no duplica ni sobrescribe y búsqueda/catálogos públicos permanecen iguales.

184 pruebas backend H2, 22 PostgreSQL (18 CSV y cuatro UUID/favoritos), diez recorridos con backend/PostgreSQL reales, 220 casos Chromium/Firefox y cuatro pruebas del helper aprobadas. Compile, package, lint y build aprobados. Los tres hallazgos requeridos de la primera revisión independiente se corrigieron: conservación de datos existentes, eliminación de favoritos desactivados y ocultación de catálogos provisionales. La segunda revisión independiente no pudo ejecutarse por límite de uso; no afirmar aprobación independiente final de estos cambios. La verificación editorial completa del corpus y P12–P14 permanecen pendientes; no se desplegó ni se fusionó main.

GitHub: [Quality 36925713036](https://github.com/BenjaAranda/BecasFind/actions/runs/36925713036), commit de aplicación/datos `4aee0e0`: backend, PostgreSQL y frontend aprobados, incluido el helper del histórico. Las modificaciones posteriores de esta entrega solo precisan estados y evidencia documental.

Se restauró azul/blanco y tipografía sans-serif en todas las vistas, conservando navegación pública y controles protegidos. Build/lint y 220 casos Chromium/Firefox aprobados; 16 casos de portada/contraste repetidos después del último ajuste visual. Compile backend aprobado y revisión independiente sin defectos obligatorios restantes. Capturas generadas por Playwright y comprobación visual del buscador local.

Gmail SMTP es el proveedor predeterminado y permanece deshabilitado hasta guardar las credenciales externas. STARTTLS obligatorio, identidad del certificado, timeouts de cinco segundos, UTF-8 y errores sanitizados. Siete pruebas Gmail (incluida conexión real a SMTP local sin TLS que no recibe AUTH ni contenido), cinco Resend y seis recuperación transaccional aprobadas. Suite backend completa: 180 pruebas, cero fallos/errores/omitidas. Empaquetado aislado aprobado; nueve recorridos con backend prod/PostgreSQL real aprobados tras la integración. Revisión independiente sin hallazgos requeridos.

La entrega en una bandeja Gmail no está verificada: faltan la cuenta dedicada/contraseña de aplicación y dirección autorizada del usuario. No se enviaron mensajes externos ni se cambió la contraseña de una cuenta real. Pasos: [GMAIL.md](GMAIL.md). No hay despliegue ni merge de main. Las cifras históricas que siguen corresponden a sus entregas originales.
# Recuperación estructural del 1 de octubre de 2026


Ocho pruebas de helpers Python aprobadas (cuatro de preparación y cuatro de recuperación); `mvn compile` aprobado. Los 93 SHA-256 originales permanecen idénticos. Lectura estricta de todos los CSV reconstruidos: 647 registros sin anomalías de columnas/comillas. Diecisiete registros lógicos afectados se sustituyen por 23 filas reconstruidas; seis identidades nuevas quedan archivadas inactivas. Base local: 573 becas; las 567 anteriores idénticas. Respaldo restaurado antes de importar, repetición sin cambios y búsqueda/catálogo públicos conservados. Evidencia: [recuperación](auditoria_corpus/procesados/reparaciones/README.md). Las matrices completas de aplicación de la entrega anterior no se ejecutaron de nuevo: esta entrega no modifica código de backend/frontend.


## Correcciones regionales y URLs de fichas por identificador

Se admite un único `page_id` positivo en una URL HTTP/HTTPS con host y sin credenciales. Se rechazan raíces sin identificador; seguimiento sin página; identificadores vacíos; cero; negativos; texto; duplicados y fragmentos. Regresión mediante importación real: suite backend completa 185 pruebas sin fallos; paquete aprobado; clase de integridad CSV repetida en base PostgreSQL 17 temporal con DDL real y Hibernate validate: 19 pruebas sin fallos. Diez pruebas de helpers aprobadas.

Cinco correcciones importadas en PostgreSQL local con perfil prod; correo deshabilitado. Respaldo restaurado antes de importar; otros 568 registros de becas idénticos; cinco inactivas y sin fechas ni umbrales inferidos. Búsqueda/catálogo públicos conservados; conversión UTF-8/hex sin mojibake detectado en nombres y descripciones. Los 93 CSV originales conservan sus hashes y el CSV importado coincide con la evidencia. [Resultado](auditoria_corpus/procesados/CORRECCION_REGIONALES_49_LOCAL.json). No se repite la matriz frontend porque no hay cambios de interfaz. Las 152 revisiones parciales y 416 sin revisión individual siguen pendientes de cierre completo.


## Coberturas USM y Mayor Puntaje UMAG

Seis modalidades USM y una UMAG recibieron correcciones parciales inactivas en dos importaciones. Cero creaciones y errores; otras 567/572 becas respectivamente idénticas. En ambas se restauró el respaldo antes de escribir; búsqueda y catálogo públicos preservados. Porcentajes fijos precisos; alternativas y máximos como texto; fechas y umbrales no inferidos. SHA de CSV importados y 93 originales verificados; UTF-8 sin BOM; PostgreSQL hex sin mojibake detectado en nombres/descripciones. Diez pruebas de helpers y compile aprobados en esta entrega. Sin cambios de código de aplicación: las 185 pruebas backend y 19 PostgreSQL de la entrega anterior mantienen su alcance; no se atribuyen como ejecución nueva. [USM](auditoria_corpus/procesados/CORRECCION_USM_6_LOCAL.json); [UMAG](auditoria_corpus/procesados/CORRECCION_UMAG_PAES_LOCAL.json).
