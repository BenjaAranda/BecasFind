# Plan vigente de BecasFind

Actualizado el 1 de octubre de 2026 tras incorporar el histórico procesado y contrastar el listado con el código y sus evidencias. Este es el único listado de trabajo pendiente. El [historial](documentacion/PLAN_MEJORAS_HISTORICO.md) conserva propuestas, resultados y próximos pasos de etapas anteriores; no constituye un segundo to do.

Objetivo acordado: frontend en Vercel, backend y PostgreSQL 17 en Oracle Always Free. La aplicación todavía no está publicada. Recursos, acceso y condiciones del destino se verificarán antes de desplegar; no hay garantía de disponibilidad gratuita continua.

## Siguiente tarea

**Conteo editorial vigente:** 568 becas únicas del corpus; 197 con revisión parcial y 371 sin revisión individual. Ninguna certificada íntegramente: 568 pendientes de cierre, aunque todas están incorporadas administrativamente. [Desglose de los 93 archivos](documentacion/auditoria_corpus/procesados/avance/README.md), [cada uno de los 647 registros](documentacion/auditoria_corpus/procesados/avance/por_registro.csv) y [por institución](documentacion/auditoria_corpus/procesados/avance/por_institucion.csv). El [lote ampliado](documentacion/auditoria_corpus/REVISION_UNIVERSIDADES_45.md) revisó 45 becas de siete universidades y corrigió parcialmente 12 registros inactivos; otros 561 idénticos. Base local: 573, sin activaciones.

**Continuar confirmación editorial del corpus incorporado.** Los 93 originales se conservan. Tras reparar 17 anomalías estructurales y recuperar seis identidades absorbidas por descripciones, hay 647 registros reconstruidos y 568 candidatos; base local de 573 becas. Las seis nuevas quedaron inactivas y los 567 registros anteriores idénticos. Siete UChile tienen correcciones parciales; ENAC/IPCHILE cuentan con revisión oficial parcial. Falta confirmar las demás fuentes y resolver 59 grupos de variantes. Evidencia: [recuperación](documentacion/auditoria_corpus/procesados/reparaciones/README.md). P09 ya está completado y no se reabre; P12–P14 siguen fuera del alcance.

## Hecho: no volver a abrir sin un hallazgo nuevo

- [x] Santiago/La Serena: cuatro grupos de variantes (13 referencias) contrastados parcialmente. Un registro de Santiago corregido con aporte único de $450.000 CLP para 2026, sin activarlo; otros 572 preservados. Los 59 grupos siguen pendientes de cierre editorial completo, incluidos estos cuatro. [Evidencia](documentacion/auditoria_corpus/REVISION_SANTIAGO_LASERENA.md).

- [x] PostgreSQL acordado y contrato actualizado; perfiles dev/prod, secretos externos, UTF-8, esquema validado en producción y seeder restringido. Migraciones 001–005 aplicadas a la base local con respaldo/restauración y validación; el destino pertenece a P12.
- [x] Autorización con cuenta/rol actuales, límites de intentos y CORS restringido. Recuperar contraseña invalida sesiones previas mediante marca HMAC; JWT sin hash ni contraseña.
- [x] Recuperación con token de un uso, caducidad, bloqueo concurrente, Gmail SMTP gratuito y pantallas públicas. Entrega real verificada en P09; Resend es alternativa opcional.
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

P01–P05 están implementadas y verificadas. P04 cierra la auditoría y el tratamiento seguro de desconocidos, no certifica que todo el histórico esté confirmado. P06–P10 y P11 local completadas; P12–P14 fuera de esta entrega. El pendiente previo al despliegue es completar la revisión editorial del catálogo que se quiera publicar. Los IDs permanecen estables aunque cambie el orden; cada entrega tiene una sola fila responsable. Una dependencia no significa que la tarea ya esté hecha.

| ID | Trabajo pendiente | Cierre verificable y dependencias |
|---|---|---|
| P01 | COMPLETADO — FASE 10 — editar cobertura en administración | Controles de tipo/importe/moneda/periodicidad/porcentaje, validación coherente, vaciado explícito, errores recuperables y persistencia tras recarga con PostgreSQL real. Preservar texto original y precisión decimal. |
| P02 | COMPLETADO — FASE 9 — explicar orden monetario | Buscador explica grupos de moneda/periodicidad y desconocidos al final; etiquetas no prometen una comparación global ni conversiones. Verificar dirección/empates/páginas y móvil/teclado. Backend terminado; no rehacer P01. |
| P03 | COMPLETADO — Resolver contrato de identificadores públicos | Acordar identificadores para búsqueda/detalle/favoritos y adaptar DTOs/enlaces en sus fases. Contrato acordado: idBeca es UUID en DTOs públicos; números solo en administración/catálogos. No confundirlos. |
| P04 | IMPLEMENTACIÓN CERRADA; CONFIRMACIÓN EDITORIAL EN CURSO — corpus e importación | Histórico incorporado de forma inactiva con originales y existentes preservados; 17 anomalías estructurales resueltas y seis identidades recuperadas. Fuentes revisadas parcialmente. Pendiente confirmar individualmente los beneficios a publicar y resolver 59 grupos de variantes. Conservar desconocidos, enlaces específicos y cobertura con evidencia; no inventar fechas/requisitos. Toda calidad/enriquecimiento histórico vive aquí, no en P01/P02. |
| P05 | COMPLETADO — Concurrencia administrativa/importación y batch real | Probar CRUD y catálogos/importaciones simultáneos, conflictos/rollback y batch INSERT efectivo con PostgreSQL. Medir resultados y corregir fallos por fase. Perfil/favoritos y atomicidad CSV ya cerrados; no repetirlos como pendientes generales. |
| P06 | COMPLETADO — Trazabilidad de requisitos y cobertura funcional restante | Leer Office de requisitos/planilla/casos, mapear requisito a prueba y registrar brechas. Ampliar detalle/fuente y límites faltantes. Los ocho recorridos reales existentes son regresiones aprobadas, no trabajo nuevo. Recuperación con bandeja real pertenece a P09; nuevas funciones exigen alcance concreto. |
| P07 | COMPLETADO — Accesibilidad y compatibilidad global | Revisar teclado/foco/contraste/zoom 200 %, 360/390/768/1440 px y un segundo navegador en todos los flujos. Registrar defectos y evidencia de cierre; capturas parciales no cierran esta fila. |
| P08 | COMPLETADO — Rendimiento de lectura y frontend | Medir peso/carga y búsqueda bajo volumen/carga documentados; fijar objetivos y corregir cuellos reales. LCP/CLS y p95 medidos con alcance y presupuestos documentados en la evidencia previa; resultados locales/sintéticos, no promesas de producción. Escrituras/batch se registran en P05. |
| P09 | COMPLETADO — correo real con Gmail gratuito | Dos mensajes enviados y recibidos por SMTP/IMAP TLS en la bandeja autorizada; cambio de contraseña y login de usuario temporal, enlace reutilizado/vencido y sesión anterior rechazados. Vencimiento forzado en base temporal, sin esperar 15 minutos. Base aislada y procesos detenidos; cuenta real intacta. Credencial privada; envío local aún deshabilitado. Guía: documentacion/GMAIL.md. |
| P10 | COMPLETADO — pipeline de calidad en GitHub | Versionar workflows reproducibles para compilaciones/lint/pruebas apropiadas, secretos fuera del repo y fallo visible ante regresión. Workflow Quality versionado: backend, PostgreSQL y frontend, sin despliegue. Backend, PostgreSQL y frontend aprobados en la ejecución 36786469707, código 19c7512. |
| P11 | COMPLETADO LOCAL — aplicar migraciones 002–005 | Identificar base/versión efectiva, respaldar y ensayar restauración; aplicar 002–005 antes del backend actualizado y comprobar datos/Hibernate validate. Local: PostgreSQL 17, respaldo restaurado, 001–005 aplicadas, campos originales de 14 tablas conservados y backend actualizado con validate. No existe destino validado; su instalación/migración es dependencia de P12. Guía: infra/COBERTURA_MONETARIA.md. |
| P12 | Preparar vista previa Vercel + Oracle | Confirmar cuenta/capacidad/condiciones vigentes, validar Docker en arquitectura real y configurar prod, reinicio, persistencia, Nginx/HTTPS, BD privada, secretos, CORS y locale español. Vercel: raíz frontend, dist, API pública y rutas SPA. Depende de recursos externos y P11 (002–005) antes del nuevo backend; datos de prueba aislados. Dockerfile/vercel.json existentes no equivalen a despliegue validado. |
| P13 | Operación en el destino | Probar copias/restauración, reinicio sin pérdida, rollback de aplicación y conservación de esquema/datos; documentar mantenimiento y diagnóstico. Depende de P12. Los ensayos PostgreSQL locales previos no verifican Oracle. |
| P14 | Publicación y verificación pública | Revisar cierre o aceptación explícita de bloqueantes P01–P13; validar vista previa, publicar y comprobar URL/HTTPS/rutas directas/conexión API y recorridos con todos los roles. Depende de P12/P13; no declarar publicada por un build local. |

## Dependencias y decisiones

- **Alcance de esta entrega:** P06–P11 autorizado conjuntamente y completado. Continuar revisión editorial; no iniciar P12–P14.
- **Decisiones resueltas:** UUID públicos (P03), desconocidos sin inferencia (P04) y cobertura estructurada. No pedir nuevamente estas aprobaciones.
- **Configuración externa pendiente:** recursos y activación del correo en HTTPS en P12; después P13/P14. P11 local ya cuenta con respaldo/restauración y migraciones verificados.
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
- P10: workflow Quality verificado en GitHub: [ejecución 36786469707](https://github.com/BenjaAranda/BecasFind/actions/runs/36786469707), código 19c7512. Backend, PostgreSQL y frontend aprobados: 171 H2, 40 PostgreSQL y 210 Chromium/Firefox; audit cero vulnerabilidades. Origen API explícito en CI y build rechaza configuración ausente/inválida.
- P11: respaldo custom restaurado; 001–005 aplicadas localmente y campos originales de 14 tablas idénticos. Backend actualizado validado sin seeder. Respaldo privado fuera de Git. No se ha tocado Oracle.
- Dependencias frontend actualizadas dentro del stack; React/ReactDOM 19.2.5 y Tailwind 4.3.0 conservados. npm audit: cero vulnerabilidades. 171 pruebas H2 y empaquetado aislado aprobados.

**Estado histórico anterior al cierre de P09:** faltaba cuenta y entrega real de correo, ahora completadas. El corpus histórico sin confirmar permanece en cuarentena según P04. P12/P13/P14 siguen sin iniciar; no se ha fusionado main ni publicado una página.

El runner local reproducible también pasó: Maven/H2, npm ci, lint, audit, build y 210 casos de navegador. Revisión independiente sin hallazgos requeridos pendientes. La actualización documental final registra la ejecución CI del código 19c7512; no agrega cambios de aplicación.

## Acceso público autorizado

El buscador, filtros y detalle son gratuitos y no requieren cuenta. Perfil, favoritos, recomendaciones guardadas y administración requieren sesión. El visitante no solicita APIs privadas ni se redirige automáticamente al login. No se contrató ningún plan ni dominio. P09 quedó resuelto mediante Gmail dentro del presupuesto cero; la navegación pública no depende de Resend.

## Corrección de identidad visual

Azul institucional y blanco restaurados en portada, navegación, buscador/detalle, autenticación, perfil/favoritos y administración. Tipografía sans-serif, encabezados sobrios y controles accesibles; se conservan las mejoras funcionales y el acceso público. Compilación/lint frontend, compile backend y 220 pruebas Chromium/Firefox aprobados; revisión independiente y verificación de UTF-8 completadas. Esta corrección no representa una nueva publicación.

## Actualización de P09: opción elegida

Gmail SMTP gratuito y cuenta dedicada autorizados. Proveedor predeterminado Gmail; deshabilitado hasta completar la configuración externa. Resend queda como alternativa explícita, no como dependencia obligatoria. STARTTLS obligatorio, certificado verificado, timeouts de cinco segundos, remitente igual a la cuenta autenticada, enlace confiable y errores sanitizados. Siete pruebas nuevas Gmail, cinco Resend y seis de recuperación transaccional aprobadas, incluida negativa real contra SMTP local sin TLS; revisión independiente sin hallazgos requeridos. No se creó ninguna cuenta ni se envió correo externo. Lo histórico sobre Resend conserva su contexto y queda sustituido por esta decisión vigente.

Pendientes reales antes de publicación: comprobación editorial por fuente para liberar corpus histórico en cuarentena y recursos/operación/publicación P12–P14. Gmail real (P09) y la corrección visual están cerrados; no reabrirlos como tareas generales salvo defectos nuevos. El despliegue sigue fuera del alcance de esta etapa.

Avance editorial: nueve registros Duoc UC/AIEP contrastados con páginas oficiales; discrepancias de cobertura/requisitos y cierres sin confirmar documentadas en [revisión de fuentes](documentacion/auditoria_corpus/REVISION_DUOC_AIEP.md). No se liberaron filas ni se modificó la base local. Continúa pendiente la revisión completa; los registros visibles en desarrollo no equivalen a un catálogo certificado.

Segundo lote editorial: cinco registros MINEDUC contrastados en [revisión MINEDUC](documentacion/auditoria_corpus/REVISION_MINEDUC.md). Calendario FUAS para ingreso 2027 confirmado, coberturas diferenciadas y fechas institucionales contradictorias documentadas. Las dos modalidades Nuevo Milenio amplían una revisión parcial previa, sin contar copias como registros adicionales. Ninguna fila liberada; completar bases/documentos y revisar las demás instituciones sigue pendiente.

Tercer lote editorial: [Universidad de Talca](documentacion/auditoria_corpus/REVISION_UTALCA.md), diez filas correspondientes a siete beneficios; tres pares candidatos a duplicado documentados con archivo/registro. Coberturas alternativas y unidades indexadas conservadas como texto; fechas/documentos sin confirmar. Pendiente por lote: obtener bases/calendario, comparar originales y preparar correcciones trazables. Ninguna fila liberada ni fusionada; continuar las demás instituciones.

## Cierre vigente de P09

El titular autorizó usar Gmail para la recuperación. Autenticación SMTP e IMAP con contraseña de aplicación verificada; dos mensajes recibidos sin marcar como leídos. Prueba sobre PostgreSQL temporal: rechazo de enlace vencido con fecha forzada al pasado, cambio de contraseña, login nuevo, rechazo de reutilización y de sesión previa. No cambió la contraseña de una cuenta real. Runner reproducible: infra/verify-gmail-delivery.py; solo ejecutar con autorización para enviar dos mensajes al titular. SMTP exige TLS/certificado y los logs/resultados públicos no incluyen claves, dirección, contraseñas ni tokens. backend/.env está ignorado por Git y restringido mediante ACL al usuario/SYSTEM.

P09 deja de ser pendiente externo. El envío local permanece deshabilitado; activación en destino HTTPS pertenece a P12. Como las credenciales se compartieron en el chat, renovarlas antes de habilitar correo público, guardando solo la nueva contraseña de aplicación en el backend; la contraseña normal de Google no fue utilizada ni almacenada. Las notas anteriores sobre cuenta/recepción pendientes son históricas y quedan sustituidas por este cierre.

## Histórico procesado — estado vigente del 1 de octubre de 2026

- [x] Revisar los 93 CSV de `03_procesados`: 641 registros lógicos, 17 con estructura mal formada. Este subconjunto no sustituye el conteo previo de 94 archivos/645 filas que incluía pendientes.
- [x] Conservar originales y hashes; preparar 562 candidatos con trazabilidad de todas las variantes y 59 grupos candidatos a duplicados.
- [x] Incorporar localmente 549 candidatos inactivos y conservar 13 existentes sin sobrescribirlos. Total 567 becas; las 18 previas permanecen idénticas. Respaldo restaurado antes de cargar, UTF-8 comprobado, carga repetida sin cambios y búsqueda/catálogo públicos preservados.
- [x] Proteger importaciones con `solo_crear`, ocultar candidatos y catálogos provisionales al público y permitir eliminar favoritos de becas posteriormente desactivadas. 184 pruebas backend, 22 PostgreSQL y diez recorridos reales aprobados, además de compile/package/lint/build y cuatro pruebas del helper.
- [x] Añadir revisión parcial de ocho beneficios UAndes (11 referencias históricas); conservar cinco candidatos MINEDUC con campos y referencias oficiales parciales sin activarlos.
- [x] Contrastar siete registros UChile y aplicar siete correcciones parciales con respaldo/restauración; los otros 560 registros permanecen idénticos. BUCH: corregir RSH/NEM/cobertura y registrar cierre al mediodía; BAB: corregir cobertura/NEM y dejar fechas contradictorias desconocidas. Ninguna activación.
- [x] Verificar 220 casos Chromium/Firefox sobre el build actualizado; conservar diseño institucional azul/blanco.
- [ ] Completar confirmación editorial de las demás instituciones y resolver bases/calendarios/documentos contradictorios de los lotes ya revisados.
- [ ] Resolver individualmente las 17 estructuras mal formadas y los 59 grupos de variantes antes de fusionar o corregir datos.
- [ ] Aplicar correcciones por beneficio con evidencia y publicar únicamente convocatorias confirmadas. Incorporación administrativa no equivale a publicación ni certificación completa.

Evidencia y procedimiento: [histórico procesado](documentacion/auditoria_corpus/procesados/README.md). Los tres hallazgos requeridos de la primera revisión independiente se corrigieron; la segunda revisión no pudo ejecutarse por límite de uso. P12–P14 siguen fuera del alcance autorizado y sin iniciar.

[Quality 36925713036](https://github.com/BenjaAranda/BecasFind/actions/runs/36925713036) aprobó backend, PostgreSQL y frontend para `4aee0e0`. El cierre posterior actualiza únicamente estados/documentación, sin cambios de aplicación.


Lote regional: [49 candidatos de diez universidades](documentacion/auditoria_corpus/REVISION_REGIONALES_49.md). Contraste inicial registrado individualmente. Correcciones posteriores aplicadas a cinco registros inactivos; otros 568 iguales. Cierres y certificación completa pendientes. Evidencia: [resultado local](documentacion/auditoria_corpus/procesados/CORRECCION_REGIONALES_49_LOCAL.json).


USM: seis modalidades del lote regional recibieron correcciones de cobertura y fuente. Siguen inactivas y parcialmente revisadas; las otras 567 becas locales permanecen idénticas. [Evidencia de importación](documentacion/auditoria_corpus/procesados/CORRECCION_USM_6_LOCAL.json). El conteo de revisión individual no aumenta: estos seis candidatos ya forman parte de los 152 parciales.


UMAG Mayor Puntaje: una corrección adicional de cobertura y fuente; 572 becas preservadas. [Resultado](documentacion/auditoria_corpus/procesados/CORRECCION_UMAG_PAES_LOCAL.json). El nombre genérico Excelencia sigue sin identidad institucional confirmada; una ficha estatal histórica no certifica una beca interna. Total de correcciones parciales en el lote regional: 12 de 49; todas sin activación.


Nuevo [lote de 45 candidatas de ocho universidades](documentacion/auditoria_corpus/REVISION_OTRAS_UNIVERSIDADES_45.md): UAI 8; UNAP 6; UCSC 5; UCN 4; UCT 6; UCentral 4; UDLA 7; UTA 5. Ocho correcciones parciales inactivas; otras 565 becas locales idénticas. Conteo editorial vigente: 197 parciales y 371 sin revisión individual; 568 pendientes de confirmación completa.
