# Plan vigente de BecasFind

Actualizado el 30 de septiembre de 2026 tras revisar duplicados y contrastar el listado con el código. Este es el único listado de trabajo pendiente. El [historial](documentacion/PLAN_MEJORAS_HISTORICO.md) conserva propuestas, resultados y próximos pasos de etapas anteriores; no constituye un segundo to do.

Objetivo acordado: frontend en Vercel, backend y PostgreSQL 17 en Oracle Always Free. La aplicación todavía no está publicada. Recursos, acceso y condiciones del destino se verificarán antes de desplegar; no hay garantía de disponibilidad gratuita continua.

## Siguiente tarea

**P01 — FASE 10: edición administrativa de cobertura estructurada.** El modelo/backend está implementado, pero BecaForm solo permite editar el texto original. Después sigue P02, en FASE 9. Ejecutar una fase por petición, salvo autorización explícita como la dada para completar juntas FASES 1/2/5.

## Hecho: no volver a abrir sin un hallazgo nuevo

- [x] PostgreSQL acordado y contrato actualizado; perfiles dev/prod, secretos externos, UTF-8, esquema validado en producción y seeder restringido. La alineación local anterior corresponde a la migración 001; no implica que la migración 002 esté aplicada.
- [x] Autorización con cuenta/rol actuales, límites de intentos y CORS restringido. Recuperar contraseña invalida sesiones previas mediante marca HMAC; JWT sin hash ni contraseña.
- [x] Recuperación con token de un uso, caducidad, bloqueo concurrente, API Resend y pantallas públicas. La entrega a una bandeja real corresponde exclusivamente a P09.
- [x] Errores de controladores y autenticación/permisos estandarizados: ApiResponse, data:null, validaciones, códigos HTTP y cabeceras correspondientes.
- [x] Validación backend de registro/login/reset, perfil y CRUD: límites de almacenamiento, 72 bytes UTF-8 en contraseñas, referencias, fechas y documentos. Formularios preservan datos y permiten reintentar.
- [x] Reglas de búsqueda de vigencia/RSH/NEM/región/nacional, fechas de Chile, recomendaciones, orden estable, URL/debounce/paginación, respuestas antiguas y reintentos. Login/search antiguos reescritos con aserciones concretas.
- [x] CRUD administrativo funcional, listado de becas vencidas/inactivas, usuarios inactivos visibles sin acceso y edición de nombre/correo de cuentas activas.
- [x] CSV atómico: validación, upsert, rollback y verificación de UTF-8. Tener batch_size=50 configurado no demuestra batch INSERT efectivo; esa medición pertenece a P05.
- [x] Sesión restaurada antes del render, caducidad y cierre sincronizado entre pestañas. Perfil/favoritos persistentes; bloqueos concurrentes de favoritos y creación inicial de perfil verificados.
- [x] Diseño de portada, autenticación, navegación, buscador/detalle, administración y perfil/favoritos renovado; controles accesibles y recorridos móviles registrados. La auditoría global sigue en P07.
- [x] FASES 1/2/5 de cobertura: DDL/migración 002 repetible; entidad/DTOs/tipos; validación y persistencia en CRUD/detalle/búsqueda/favoritos. Texto original conservado, decimales JSON exactos, tipos monetario/porcentual/no monetario/desconocido y orden numérico por moneda/periodicidad. Desconocidos al final; sin inferir cifras ni convertir monedas.
- [x] Lint sin errores/advertencias, compilaciones y verificaciones registradas. Avances subidos con Conventional Commits al [PR #10](https://github.com/BenjaAranda/BecasFind/pull/10), aún en borrador.

## Pendientes únicos y criterios de cierre

Todas las filas están abiertas. Los IDs permanecen estables aunque cambie el orden; cada entrega tiene una sola fila responsable. Una dependencia no significa que la tarea ya esté hecha.

| ID | Trabajo pendiente | Cierre verificable y dependencias |
|---|---|---|
| P01 | FASE 10 — editar cobertura en administración | Controles de tipo/importe/moneda/periodicidad/porcentaje, validación coherente, vaciado explícito, errores recuperables y persistencia tras recarga con PostgreSQL real. Preservar texto original y precisión decimal. |
| P02 | FASE 9 — explicar orden monetario | Buscador explica grupos de moneda/periodicidad y desconocidos al final; etiquetas no prometen una comparación global ni conversiones. Verificar dirección/empates/páginas y móvil/teclado. Backend terminado; no rehacer P01. |
| P03 | Resolver contrato de identificadores públicos | Acordar identificadores para búsqueda/detalle/favoritos y adaptar DTOs/enlaces en sus fases. El contrato prohíbe IDs internos en respuestas públicas, pero BecaDTO sigue usando idBeca. No confundir IDs administrativos con públicos. |
| P04 | FASE 14 — corpus y metadatos de importación | Auditar fuentes oficiales, tildes, enlaces profundos, requisitos/documentos/fechas y duplicados de registros reales. Acordar representación de desconocidos antes de cambiar inferencia/fecha por defecto contractual. Enriquecer cobertura solo con evidencia e incorporar metadatos CSV validados sin romper formato antiguo. Toda calidad/enriquecimiento histórico vive aquí, no en P01/P02. |
| P05 | Concurrencia administrativa/importación y batch real | Probar CRUD y catálogos/importaciones simultáneos, conflictos/rollback y batch INSERT efectivo con PostgreSQL. Medir resultados y corregir fallos por fase. Perfil/favoritos y atomicidad CSV ya cerrados; no repetirlos como pendientes generales. |
| P06 | Trazabilidad de requisitos y cobertura funcional restante | Leer Office de requisitos/planilla/casos, mapear requisito a prueba y registrar brechas. Ampliar detalle/fuente y límites faltantes. Los ocho recorridos reales existentes son regresiones aprobadas, no trabajo nuevo. Recuperación con bandeja real pertenece a P09; nuevas funciones exigen alcance concreto. |
| P07 | Accesibilidad y compatibilidad global | Revisar teclado/foco/contraste/zoom 200 %, 360/390/768/1440 px y un segundo navegador en todos los flujos. Registrar defectos y evidencia de cierre; capturas parciales no cierran esta fila. |
| P08 | Rendimiento de lectura y frontend | Medir peso/carga y búsqueda bajo volumen/carga documentados; fijar objetivos y corregir cuellos reales. LCP/CLS y p95 son mediciones pendientes, no resultados prometidos. Escrituras/batch se registran en P05. |
| P09 | Correo real | Configurar clave Resend y remitente autorizado; verificar bandeja, enlace, caducidad, consumo único y login con contraseña nueva. Depende de configuración externa. La integración y el proveedor simulado ya existen. |
| P10 | Pipeline de calidad en GitHub | Versionar workflows reproducibles para compilaciones/lint/pruebas apropiadas, secretos fuera del repo y fallo visible ante regresión. No existen workflows versionados. Pruebas locales aprobadas no sustituyen CI. |
| P11 | Aplicar migración monetaria a las bases que se usarán | Identificar base/versión efectiva, respaldar y ensayar restauración; aplicar 002 antes del backend actualizado y comprobar datos/Hibernate validate. Pendiente tanto en base local como en el destino, si existe. La 001 y los ensayos temporales no cierran este paso. Guía: infra/COBERTURA_MONETARIA.md. |
| P12 | Preparar vista previa Vercel + Oracle | Confirmar cuenta/capacidad/condiciones vigentes, validar Docker en arquitectura real y configurar prod, reinicio, persistencia, Nginx/HTTPS, BD privada, secretos, CORS y locale español. Vercel: raíz frontend, dist, API pública y rutas SPA. Depende de recursos externos y P11 antes del nuevo backend; datos de prueba aislados. Dockerfile/vercel.json existentes no equivalen a despliegue validado. |
| P13 | Operación en el destino | Probar copias/restauración, reinicio sin pérdida, rollback de aplicación y conservación de esquema/datos; documentar mantenimiento y diagnóstico. Depende de P12. Los ensayos PostgreSQL locales previos no verifican Oracle. |
| P14 | Publicación y verificación pública | Revisar cierre o aceptación explícita de bloqueantes P01–P13; validar vista previa, publicar y comprobar URL/HTTPS/rutas directas/conexión API y recorridos con todos los roles. Depende de P12/P13; no declarar publicada por un build local. |

## Dependencias y decisiones

- **Autónomo inmediato:** P01/P02, revisión documental P06, auditoría sin modificar reglas de P04, P05/P07/P08 y preparación de P10. Se abordarán en entregas verificables, no todas en una fase.
- **Decisión de producto/contrato antes de cambios:** P03 y política de datos desconocidos de P04. El modelo monetario básico ya está autorizado; no pedirlo nuevamente.
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
