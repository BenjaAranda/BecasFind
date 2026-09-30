# Plan vigente de BecasFind

Actualizado el 30 de septiembre de 2026 tras revisar duplicados y contrastar el listado con el código. Este es el único listado de trabajo pendiente. El [historial](documentacion/PLAN_MEJORAS_HISTORICO.md) conserva propuestas, resultados y próximos pasos de etapas anteriores; no constituye un segundo to do.

Objetivo acordado: frontend en Vercel, backend y PostgreSQL 17 en Oracle Always Free. La aplicación todavía no está publicada. Recursos, acceso y condiciones del destino se verificarán antes de desplegar; no hay garantía de disponibilidad gratuita continua.

## Siguiente tarea

**P09 — prueba de correo real**, pendiente de cuenta/clave y remitente autorizado Resend y dirección del usuario. P06, P07, P08 y P11 local están verificados; P10 espera el resultado del pipeline GitHub de esta entrega. P12–P14 no se iniciarán: el usuario pidió terminar antes del despliegue. Evidencia: [calidad previa](documentacion/CALIDAD_PRE_DESPLIEGUE.md).

## Hecho: no volver a abrir sin un hallazgo nuevo

- [x] PostgreSQL acordado y contrato actualizado; perfiles dev/prod, secretos externos, UTF-8, esquema validado en producción y seeder restringido. Migraciones 001–005 aplicadas a la base local con respaldo/restauración y validación; el destino pertenece a P12.
- [x] Autorización con cuenta/rol actuales, límites de intentos y CORS restringido. Recuperar contraseña invalida sesiones previas mediante marca HMAC; JWT sin hash ni contraseña.
- [x] Recuperación con token de un uso, caducidad, bloqueo concurrente, API Resend y pantallas públicas. La entrega a una bandeja real corresponde exclusivamente a P09.
- [x] Errores de controladores y autenticación/permisos estandarizados: ApiResponse, data:null, validaciones, códigos HTTP y cabeceras correspondientes.
- [x] Validación backend de registro/login/reset, perfil y CRUD: límites de almacenamiento, 72 bytes UTF-8 en contraseñas, referencias, fechas y documentos. Formularios preservan datos y permiten reintentar.
- [x] Reglas de búsqueda de vigencia/RSH/NEM/región/nacional, fechas de Chile, recomendaciones, orden estable, URL/debounce/paginación, respuestas antiguas y reintentos. Login/search antiguos reescritos con aserciones concretas.
- [x] CRUD administrativo funcional, listado de becas vencidas/inactivas, usuarios inactivos visibles sin acceso y edición de nombre/correo de cuentas activas.
- [x] CSV atómico: validación, upsert, rollback y verificación de UTF-8. P05 verificó lotes JDBC reales [50,1]; P08 registra lectura bajo carga.
- [x] Sesión restaurada antes del render, caducidad y cierre sincronizado entre pestañas. Perfil/favoritos persistentes; bloqueos concurrentes de favoritos y creación inicial de perfil verificados.
- [x] Diseño de portada, autenticación, navegación, buscador/detalle, administración y perfil/favoritos renovado; controles accesibles y recorridos móviles registrados. P07 agrega la matriz global de ambos navegadores, contraste y reflujo.
- [x] FASES 1/2/5 de cobertura: DDL/migración 002 repetible; entidad/DTOs/tipos; validación y persistencia en CRUD/detalle/búsqueda/favoritos. Texto original conservado, decimales JSON exactos, tipos monetario/porcentual/no monetario/desconocido y orden numérico por moneda/periodicidad. Desconocidos al final; sin inferir cifras ni convertir monedas.
- [x] Lint sin errores/advertencias, compilaciones y verificaciones registradas. Avances subidos con Conventional Commits al [PR #10](https://github.com/BenjaAranda/BecasFind/pull/10), aún en borrador.

## Pendientes únicos y criterios de cierre

P01–P05 están implementadas y verificadas. P04 cierra la auditoría y el tratamiento seguro de desconocidos, no certifica que todo el histórico esté confirmado. P06/P07/P08 y P11 local completadas. P09 requiere configuración externa; P10 pendiente del resultado GitHub; P12–P14 fuera de esta entrega. Los IDs permanecen estables aunque cambie el orden; cada entrega tiene una sola fila responsable. Una dependencia no significa que la tarea ya esté hecha.

| ID | Trabajo pendiente | Cierre verificable y dependencias |
|---|---|---|
| P01 | COMPLETADO — FASE 10 — editar cobertura en administración | Controles de tipo/importe/moneda/periodicidad/porcentaje, validación coherente, vaciado explícito, errores recuperables y persistencia tras recarga con PostgreSQL real. Preservar texto original y precisión decimal. |
| P02 | COMPLETADO — FASE 9 — explicar orden monetario | Buscador explica grupos de moneda/periodicidad y desconocidos al final; etiquetas no prometen una comparación global ni conversiones. Verificar dirección/empates/páginas y móvil/teclado. Backend terminado; no rehacer P01. |
| P03 | COMPLETADO — Resolver contrato de identificadores públicos | Acordar identificadores para búsqueda/detalle/favoritos y adaptar DTOs/enlaces en sus fases. Contrato acordado: idBeca es UUID en DTOs públicos; números solo en administración/catálogos. No confundirlos. |
| P04 | COMPLETADO — FASE 14 — corpus y metadatos de importación | Auditar fuentes oficiales, tildes, enlaces profundos, requisitos/documentos/fechas y duplicados de registros reales. Política aprobada: conservar desconocidos sin inventar fechas ni requisitos. Enriquecer cobertura solo con evidencia e incorporar metadatos CSV validados sin romper formato antiguo. Toda calidad/enriquecimiento histórico vive aquí, no en P01/P02. |
| P05 | COMPLETADO — Concurrencia administrativa/importación y batch real | Probar CRUD y catálogos/importaciones simultáneos, conflictos/rollback y batch INSERT efectivo con PostgreSQL. Medir resultados y corregir fallos por fase. Perfil/favoritos y atomicidad CSV ya cerrados; no repetirlos como pendientes generales. |
| P06 | COMPLETADO — Trazabilidad de requisitos y cobertura funcional restante | Leer Office de requisitos/planilla/casos, mapear requisito a prueba y registrar brechas. Ampliar detalle/fuente y límites faltantes. Los ocho recorridos reales existentes son regresiones aprobadas, no trabajo nuevo. Recuperación con bandeja real pertenece a P09; nuevas funciones exigen alcance concreto. |
| P07 | COMPLETADO — Accesibilidad y compatibilidad global | Revisar teclado/foco/contraste/zoom 200 %, 360/390/768/1440 px y un segundo navegador en todos los flujos. Registrar defectos y evidencia de cierre; capturas parciales no cierran esta fila. |
| P08 | COMPLETADO — Rendimiento de lectura y frontend | Medir peso/carga y búsqueda bajo volumen/carga documentados; fijar objetivos y corregir cuellos reales. LCP/CLS y p95 medidos con alcance y presupuestos documentados en la evidencia previa; resultados locales/sintéticos, no promesas de producción. Escrituras/batch se registran en P05. |
| P09 | Correo real | Configurar clave Resend y remitente autorizado; verificar bandeja, enlace, caducidad, consumo único y login con contraseña nueva. Depende de configuración externa. La integración y el proveedor simulado ya existen. |
| P10 | Pipeline de calidad en GitHub | Versionar workflows reproducibles para compilaciones/lint/pruebas apropiadas, secretos fuera del repo y fallo visible ante regresión. Workflow Quality versionado: backend, PostgreSQL y frontend, sin despliegue. Resultado GitHub de esta entrega por confirmar. |
| P11 | COMPLETADO LOCAL — aplicar migraciones 002–005 | Identificar base/versión efectiva, respaldar y ensayar restauración; aplicar 002–005 antes del backend actualizado y comprobar datos/Hibernate validate. Local: PostgreSQL 17, respaldo restaurado, 001–005 aplicadas, campos originales de 14 tablas conservados y backend actualizado con validate. No existe destino validado; su instalación/migración es dependencia de P12. Guía: infra/COBERTURA_MONETARIA.md. |
| P12 | Preparar vista previa Vercel + Oracle | Confirmar cuenta/capacidad/condiciones vigentes, validar Docker en arquitectura real y configurar prod, reinicio, persistencia, Nginx/HTTPS, BD privada, secretos, CORS y locale español. Vercel: raíz frontend, dist, API pública y rutas SPA. Depende de recursos externos y P11 (002–005) antes del nuevo backend; datos de prueba aislados. Dockerfile/vercel.json existentes no equivalen a despliegue validado. |
| P13 | Operación en el destino | Probar copias/restauración, reinicio sin pérdida, rollback de aplicación y conservación de esquema/datos; documentar mantenimiento y diagnóstico. Depende de P12. Los ensayos PostgreSQL locales previos no verifican Oracle. |
| P14 | Publicación y verificación pública | Revisar cierre o aceptación explícita de bloqueantes P01–P13; validar vista previa, publicar y comprobar URL/HTTPS/rutas directas/conexión API y recorridos con todos los roles. Depende de P12/P13; no declarar publicada por un build local. |

## Dependencias y decisiones

- **Alcance de esta entrega:** P06–P11 autorizado conjuntamente. No iniciar P12–P14. P09 necesita configuración del usuario; se dejó una pregunta pendiente sin solicitar credenciales en el chat.
- **Decisiones resueltas:** UUID públicos (P03), desconocidos sin inferencia (P04) y cobertura estructurada. No pedir nuevamente estas aprobaciones.
- **Configuración externa:** P09 y recursos de P12; después P13/P14. P11 requiere la identificación de la base efectiva y un respaldo válido antes de aplicar.
- **Fuera del alcance aprobado:** ampliar precisión NEM, convertir divisas/anualizar beneficios o añadir unidades indexadas como UF. No convertir ideas opcionales en bloqueantes ni en tareas obligatorias. NEM conserva un decimal; cobertura desconocida conserva texto.
- Institución/carrera/año se guardan como referencias del perfil, pero no son criterios actuales de recomendación. Añadirlos sería una función nueva, no corregir una implementación pendiente.

## Evidencia registrada y límites

Resultados del cierre de FASES 1/2/5 del 30 de septiembre, no pruebas repetidas durante esta revisión documental:

- 160 pruebas H2; siete MonetaryCoverageTest y doce CsvImportIntegrityTest con PostgreSQL 17/DDL real/Hibernate validate. Comprobación SQL de migración repetida, preservación de texto/tildes/metadatos y restricciones.
- Ocho recorridos Chromium con backend prod/PostgreSQL reales: autenticación/firma/roles, CRUD administrativo, CSV, perfil/favoritos, registro/login y búsqueda. Package/compile/lint/build aprobados.
- 38 casos controlados de autenticación pertenecen al cierre anterior de FASE 8; no sumarlos como casos nuevos ni como pruebas de correo real.
- Evidencia temporal: becasfind-profile-pg-ab30422a0d5245adac772f9927c8cb88 y becasfind-browser-pg-33f0213dc6af4baca9f1d08fa1efdd9a. Esos archivos temporales pueden dejar de estar disponibles; no son un pipeline reproducible ni prueba de producción.
- La migración 002 se ensayó en bases temporales. La base local no se actualizó en esa entrega. No hay entrega real de correo ni publicación confirmadas.

## Duplicados y estados antiguos reconciliados

- La antigua tarea conjunta «montos» mezclaba backend terminado, interfaz y corpus: backend cerrado; interfaz en P01/P02 y corpus/CSV en P04.
- «Datos históricos» y «enriquecer montos» se consolidaron en P04, incluyendo auditoría de duplicados de becas. Esta revisión elimina duplicados del listado; no ha auditado registros de una base real.
- Recuperación end-to-end y correo real se registran una vez en P09; P06 solo apunta a la cobertura faltante documentada.
- Batch/concurrencia se delimitan en P05; carga/búsqueda/frontend en P08, sin dos tareas para la misma medición.
- CI, aplicación de esquema, vista previa, operación y publicación se separan en P10–P14 con criterios distintos; no repetir «desplegar» en todas las filas.
- Historial y propuestas A–G se archivaron íntegros para evitar reabrir login, búsqueda, errores, usuarios y modelo monetario ya cerrados.

### Verificación de P01–P03

163 pruebas backend H2, tres pruebas de UUID con PostgreSQL/DDL real, 98 casos Chromium controlados y ocho recorridos con PostgreSQL/backend prod aprobados. Migración 003 repetida y estabilidad/unicidad de UUID comprobadas. P01 permite crear, editar, vaciar y recargar cobertura exacta. P02 explica grupos y se verificó con teclado a 390/1280 px. P03 usa UUID públicos y mantiene números en administración; favoritos y permisos están cubiertos. En aquella entrega 002/003 estaban pendientes; P11 actual las aplicó a la base local.

### Cierre de P04/P05 y límites del corpus

- P04: 94 CSV/645 filas auditadas; 577 claves y 48 grupos candidatos a duplicados. 387 fuentes comprobadas por HTTP; 294 respuestas 200 no equivalen a verificación editorial. Originales intactos y copia de 645 filas en cuarentena sin fechas/requisitos/cobertura inventados. Dos modalidades de cobertura MINEDUC tienen evidencia directa; sus cierres/documentos/RSH siguen desconocidos y no se publican como vigentes. La auditoría no libera automáticamente el histórico ni corrige la base del usuario. Revisar cada fuente es condición para liberar sus datos, no un resultado ya obtenido.
- CSV extendido opcional y compatible: tipo/importe/moneda/periodicidad/porcentaje; validación previa, precisión exacta, preservación con formato antiguo, vaciado explícito y rollback. Fechas ausentes nulas en CRUD/importación; búsqueda vigente las excluye; interfaz indica Fecha por confirmar.
- P05: lotes JDBC reales [50,1] para 51 becas; secuencias, precarga y bloqueo transaccional de importaciones. Versiones/409 protegen edición administrativa y cambios exclusivos de hijos. Importaciones simultáneas reutilizan catálogos y hacen upsert sin duplicados. Migraciones 004/005 repetidas y conservación de avance/IDs comprobadas. No es una medición de carga de P08.
- En aquel cierre las migraciones 002–005 estaban pendientes; la entrega actual de P11 las aplicó a la base local con respaldo/restauración. El destino se tratará en P12. Las pruebas usan bases temporales; no hubo publicación ni merge de main.

Verificación final: 171 pruebas H2 aprobadas; PostgreSQL con CsvImportIntegrityTest (15), CsvBatchTest (1) y ScholarshipConcurrencyTest (4), más ensayos SQL repetibles. 98 pruebas Chromium controladas más un caso específico de cierre desconocido/409 (99 en total); ocho recorridos reales aprobados. Package, compile, frontend build y lint sin fallos.

## Entrega antes del despliegue — 30 de septiembre de 2026

- P06: tres Office leídos; 67 casos/19 requisitos trazados; catálogo público y aserciones débiles corregidos.
- P07: 210 casos Chromium/Firefox aprobados sobre build; 12 comprobaciones de matriz/contraste repetidas tras corregir el enlace público administrativo. 11 rutas a 360/390/768/1440 px y reflujo simulado 200 %. Texto administrativo oscurecido; UUID en enlaces. Limitaciones de auditoría en CALIDAD_PRE_DESPLIEGUE.md.
- P08: presupuestos de frontend aprobados (JS gzip ~120 kB, CSS ~7,6 kB; LCP local escritorio 120 ms/móvil limitado 1.312 ms; CLS 0). PostgreSQL 5.000 becas/4 lectores/80 muestras: p95 124,68 ms. Laboratorio local; no rendimiento de producción.
- P09: el usuario confirmó que no tiene cuenta ni configuración Resend. Integración y proveedor simulado listos; no se ha enviado ni recibido correo real. Crear/verificar la cuenta y obtener clave/remitente/dirección es requisito externo.
- P10: workflow Quality versionado y ejecutándose en GitHub; requiere confirmar los tres jobs antes de cerrar la fila.
- P11: respaldo custom restaurado; 001–005 aplicadas localmente y campos originales de 14 tablas idénticos. Backend actualizado validado sin seeder. Respaldo privado fuera de Git. No se ha tocado Oracle.
- Dependencias frontend actualizadas dentro del stack; React/ReactDOM 19.2.5 y Tailwind 4.3.0 conservados. npm audit: cero vulnerabilidades. 171 pruebas H2 y empaquetado aislado aprobados.

**Pendientes antes de iniciar despliegue:** P09 (externo) y confirmación final de P10. P12/P13/P14 se mantienen sin iniciar; corpus histórico sin confirmar permanece en cuarentena según P04. No se ha fusionado main ni publicado una página.
