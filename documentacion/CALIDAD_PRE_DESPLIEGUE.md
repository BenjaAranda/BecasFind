# Calidad antes del despliegue

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

Se restauró azul/blanco y tipografía sans-serif en todas las vistas, conservando navegación pública y controles protegidos. Build/lint y 220 casos Chromium/Firefox aprobados; 16 casos de portada/contraste repetidos después del último ajuste visual. Compile backend aprobado y revisión independiente sin defectos obligatorios restantes. Capturas generadas por Playwright y comprobación visual del buscador local.

Gmail SMTP es el proveedor predeterminado y permanece deshabilitado hasta guardar las credenciales externas. STARTTLS obligatorio, identidad del certificado, timeouts de cinco segundos, UTF-8 y errores sanitizados. Siete pruebas Gmail (incluida conexión real a SMTP local sin TLS que no recibe AUTH ni contenido), cinco Resend y seis recuperación transaccional aprobadas. Suite backend completa: 180 pruebas, cero fallos/errores/omitidas. Empaquetado aislado aprobado; nueve recorridos con backend prod/PostgreSQL real aprobados tras la integración. Revisión independiente sin hallazgos requeridos.

La entrega en una bandeja Gmail no está verificada: faltan la cuenta dedicada/contraseña de aplicación y dirección autorizada del usuario. No se enviaron mensajes externos ni se cambió la contraseña de una cuenta real. Pasos: [GMAIL.md](GMAIL.md). No hay despliegue ni merge de main. Las cifras históricas que siguen corresponden a sus entregas originales.
