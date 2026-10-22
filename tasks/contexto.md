# Contexto operativo de BecasFind

Actualizado el 21 de octubre de 2026. Este archivo es un índice de continuidad, no una segunda base de datos. Para retomar, leer `AGENTS.md`, `PLAN_MEJORAS.md`, `tasks/plan.md` y comprobar `git status`.

## Estado editorial vigente

- Repositorio `BenjaAranda/BecasFind`; rama observada: `bugfix/security-and-recovery`, siguiendo `origin/bugfix/security-and-recovery`. Comprobar Git al retomar; no fijar aquí el hash del último commit porque cambia con cada actualización.
- Corpus: 93 archivos originales, 647 referencias y 568 candidatas únicas.
- Conteos autoritativos: 525 confirmadas esenciales, 2 completas, 16 descartes ratificados y **25 pendientes** (19 requieren aclaración; 6 exclusiones históricas sin ratificar). Reconstruirlos desde `documentacion/auditoria_corpus/procesados/avance/resumen.json`; la cola exacta es `documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv`. Ignorar cifras históricas de 132, 157 y 291.
- La revisión vigente se centra solo en candidatas de becas: verificar identidad, fuente oficial específica, beneficio y requisitos publicados. Registrar desconocidos como «No especificado», conservar originales y trazas, y separar confirmación histórica de vigencia/publicación actual. No cerrar por búsquedas sin resultado, HTTP fallido, antigüedad u omisión de un catálogo.
- Contraste público 21/10/2026: se ampliaron las fuentes oficiales de INACAP para «Beca Red de Egresados» (`34caa8ab…`): Bienvenida 2027 y Red de Exalumnos Destacados describen empleabilidad/actualización y 30% de descuento en Educación Continua, distintos del 15% familiar de pregrado del original. No prueban inexistencia histórica ni resuelven relación con el Reglamento de Becas 2016. Sigue `EXCLUSION_HISTORICA_SIN_RATIFICAR`; sin cierre.
- Contraste público 21/10/2026: Talca (`49a1cf45…`) contrastado además con Cuentas Públicas 2019–2021 y guía DIDECO; describen JUNAEB, residencia y servicios sociales, sin identificar la beca genérica. Omisión no descarta; falta acto/bases/ficha DIDECO. Se agregó a `CONTRASTE_PADEM_TALCA_2020_2026_10_20.md`.
- En esta continuación la cola sigue en 25; no hubo decisión editorial que cambie estado. Los nuevos contrastes están en `CONTRASTE_PADEM_TALCA_2020_2026_10_20.md` y `CONTRASTES_OFICIALES_MODALIDADES_2026_10_21.md`.
- Contraste oficial 21/10/2026 de la Cuenta Pública Iquique 2019 (p. 213): DIDECO registra 362 casos agrupados como «Otros (Informes de Beca e Intendencia)», sin desglose que identifique la candidata de mantención superior, fuente del pago o requisitos. Se añadió a `RECONTRASTE_OFICIAL_MUNICIPALIDADES_PENDIENTES_2026_10_19.md`; no confirma ni descarta las dos fichas genéricas ni permite fusionarlas.
- Contraste archivístico nuevo de Valparaíso: se revisaron íntegramente dos PDF DIDECO archivados de 2019. Uno no identifica becas superiores ni transporte; el otro menciona colaboración en procesos de becas JUNAEB Presidente de la República e Indígena. Esto acota la gestión documentada en esos materiales, pero no confirma ni demuestra inexistencia de las tres candidatas municipales. Las tres siguen pendientes y separadas. Informe: `documentacion/auditoria_corpus/procesados/CONTRASTE_ARCHIVO_DIDECO_VALPARAISO_2026_10_21.md`. El total sigue en 25.
- Contraste oficial histórico adicional de Valdivia (21/10/2026): la Cuenta Pública 2016 distingue las becas estatales y las fichas sociales municipales; las noticias de 2003–2005 describen ayudas deportivas/escolares y un convenio USS para poblaciones específicas. Ninguna vincula la candidata genérica de mantención superior con esas modalidades. Se conservaron las diferencias sin trasladar montos ni cerrar por omisión; el total sigue en 25. Informe actualizado: `documentacion/auditoria_corpus/procesados/RECONTRASTE_OFICIAL_UNIVERSITARIO_Y_VALDIVIA_2026_10_19.md`.
- Contraste oficial adicional de Victoria (21/10/2026): recuperado y leído visualmente el Reglamento de Ayuda Social aprobado por Decreto Alcaldicio N.º 1148 (23/04/2012), enlazado por la transparencia municipal. Regula ayudas DIDECO generales y apoyo financiero a familias vulnerables, pero no identifica la beca superior ni sus reglas. Se mantiene aclaración; no se transfiere el fondo social global ni se descarta por omisión. Informe: `CONTRASTE_REGLAMENTO_AYUDA_SOCIAL_VICTORIA_2026_10_21.md`.
- Recontraste público 21/10/2026: la noticia municipal de General Lagos localizada trata de ropa y enseres para un jardín infantil; no acredita ni refuta una beca superior. Las páginas oficiales ENAC revisadas para admisión actual identifican beneficios Mineduc/JUNAEB y una campaña distinta de matrícula $0, sin nombrar las cuatro modalidades históricas pendientes. No se usa la omisión para descartarlas. Se incorporó al informe `CONTRASTES_OFICIALES_MODALIDADES_2026_10_21.md`; la cola sigue en 25.
- Historial reciente y decisiones por hash: consultar los informes nombrados en la columna `carencia_documentada` de la cola, no releer lotes históricos completos.

## Siguiente acción

Tomar un hash de `pendientes_esenciales_actuales.csv`, leer su original en `originales.jsonl` y solo los apartados/informes vinculados. Buscar una fuente pública oficial nueva que pueda resolver su identidad; no repetir búsquedas generales ya documentadas. Si no aparece evidencia resolutiva, conservar el estado y pasar a otro caso. El procedimiento completo está en `tasks/plan.md`.

Al haber una decisión respaldada, actualizar el informe individual y los registros canónicos, preservar los originales, ejecutar en este orden `python infra/report-corpus-progress.py` y `python infra/audit-editorial-evidence.py`, revisar el diff y hacer un commit Conventional Commit en español. No hacer un commit si no hay cambio sustantivo.

## Límites de esta etapa

- Solo fuentes públicas oficiales; el usuario rechazó contactar instituciones. No usar Firecrawl.
- No ejecutar pruebas de backend/frontend, importaciones, activaciones ni despliegues en la revisión de becas. El despliegue no ha comenzado; P12–P14 no están autorizadas.
- No borrar originales, trazas, datos personales ni carpetas de compilación cuya eliminación previa fue rechazada. No tocar `BecasFind - ET.docx`: es un archivo personal sin seguimiento. No hay una limpieza adicional de archivos segura identificada; reducir contexto redundante, no eliminar datos del proyecto.
- Costo objetivo mensual $0, sin contratar servicios ni comprar dominios. Búsqueda/detalle públicos sin sesión; sesión solo para datos guardados y administración. Mantener estética azul y blanca institucional.
- PostgreSQL 17; entorno local mediante perfil `dev`, producción `prod`, secretos externos, esquema preinstalado y `ddl-auto: validate`. Recuperación por Gmail SMTP sin costo mediante `spring-boot-starter-mail`; el usuario configurará la cuenta y los secretos. No incluir credenciales en el repositorio.

## Limpieza y continuidad

La limpieza autorizada anterior eliminó 609 imágenes regenerables y liberó 647.954.754 bytes. Se conservaron 27 PDF, 611 páginas OCR y las dos imágenes necesarias para verificación visual. No repetir esa limpieza ni borrar artefactos protegidos. Para ahorrar contexto, cargar solo el hash en curso y sus informes pertinentes; `tasks/plan.md` contiene el método y `PLAN_MEJORAS.md` el plan general.
