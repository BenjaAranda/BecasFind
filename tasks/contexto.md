# Contexto operativo de BecasFind

Actualizado el 23 de octubre de 2026. Índice de continuidad: la evidencia completa está en los informes citados y las instrucciones contractuales en `AGENTS.md`. Al retomar, comprobar `git status` y reconstruir las cifras desde el resumen JSON y la cola actual.

## Objetivo y límites

Revisar las candidatas pendientes con evidencia pública oficial. El usuario confirmó que no se contacte a instituciones; no usar Firecrawl. Durante esta revisión no ejecutar pruebas de aplicación, importar datos, activar becas ni desplegar. Preservar originales y trazas. Confirmar identidad, beneficio y requisitos principales cuando una fuente específica los sustente; dejar «No especificado» solo para campos no publicados dentro del alcance revisado. No concluir inexistencia por búsqueda vacía, omisión, enlace caído o antigüedad. Descartar falsedad o duplicidad solo con evidencia positiva individual. Mantener separadas confirmación histórica y vigencia actual.

## Estado vigente

Fuentes autoritativas:

- `documentacion/auditoria_corpus/procesados/avance/resumen.json` — cifras agregadas.
- `documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv` — cola exacta, carencia y siguiente acción por candidata.

Última cifra registrada: 93 archivos fuente, 647 referencias y 568 candidatas; 526 confirmadas esenciales, 2 completas, 16 descartadas y 24 abiertas (18 requieren aclaración, 6 exclusiones históricas sin ratificar). Regenerar y confirmar antes de comunicar progreso. Ignorar conteos históricos de 132, 157, 222, 291 y 568 como pendientes.

## No repetir; avanzar desde aquí

- **Puerto Montt:** el registro del Concejo identifica el Reglamento N.º 0004 (2017) sobre incentivos PAES y otros incentivos, pero no publica su texto. La candidata genérica sigue abierta; localizar públicamente el reglamento o una fuente municipal que describa la línea exacta. Informe: `CONTRASTE_PROGRAMAS_PUERTO_MONTT_2026_10_20.md`.
- **ENAC (4 candidatas históricas):** CDX/TimeMap devolvieron `[]` para la URL exacta del anexo 52; páginas vigentes y el acta CNA no identifican las cuatro modalidades. Buscar otra publicación oficial; no repetir esas consultas ni corregir el CSV defectuoso. Informes: `ANEXO52_REGLAMENTO_BECAS_ENAC_2026_10_20.md`, `CONTRASTES_OFICIALES_MODALIDADES_2026_10_21.md`.
- **General Lagos / Visviri:** las 27 actas ordinarias 2026 (285 páginas) y el documento social municipal 2012–2013 describen/consignan otros apoyos, incluidos JUNAEB; no identifican ni refutan la beca municipal genérica. No repetir el OCR ni transferir montos o requisitos JUNAEB.
- **Iquique:** las bases oficiales Sixto Rojas (2021) describen una beca artística con línea superior específica; no identifican la ayuda municipal general de la candidata. No trasladar condiciones. Ambos contrastes están en `CONTRASTES_OFICIALES_MODALIDADES_2026_10_21.md`.
- **Otros contrastes municipales ya consultados:** Tierra Amarilla, Concepción, Lo Espejo, Victoria, Valdivia, Valparaíso, Huara, Río Claro y Camiña. Las fuentes y límites están en `CONTRASTES_OFICIALES_MODALIDADES_2026_10_21.md`, `CONTRASTE_PUBLICO_MUNICIPALES_2026_10_22.md`, `CONTRASTE_VALPARAISO_HISTORICO_2026_10_22.md`, `CONTRASTE_BECA_TRANSPORTE_VALPARAISO_BETA_2026_10_21.md` y `CONTRASTE_VALDIVIA_2_CANDIDATAS_2026_10_13.md`. No repetir búsquedas generales ni tratar omisiones como evidencia negativa.
- **El Monte:** la Cuenta Pública 2024 distingue ayudas generales/JUNAEB y no identifica la beca superior; no prueba inexistencia para 2026. Informe: `CONTRASTE_CUENTA_PUBLICA_EL_MONTE_2024_2026_10_20.md`.
- **Talca:** además del DAEM ya revisado, la Cuenta Pública de Gestión 2025, pp. impresas 117–119, describe asistencia social familiar y 650 informes para estudiantes que postulaban a becas; no identifica una beca propia de educación superior DIDECO. Mantener abierta y no repetir este capítulo; véase `CONTRASTE_PADEM_TALCA_2020_2026_10_20.md`.
- **UFRO:** familia de Becas de Mantención confirmada esencialmente por Resolución Exenta 1458/2021; retirar RSH 60% no respaldado. No hay monto individual ni vigencia 2026 confirmados. Informe: `CONFIRMACION_ESENCIAL_BECAS_MANTENCION_UFRO_2026_10_22.md`.

Antes de investigar, elegir un grupo pequeño de la cola y leer únicamente su fila y los informes citados. Si la fuente solo permite separar una modalidad parecida, registrar el contraste una vez y pasar a otra candidata; no contar ese paso como confirmación.

## Flujo de documentación y Git

Tras un cambio probatorio sustantivo, ejecutar `python infra/report-corpus-progress.py`, luego `python infra/audit-editorial-evidence.py`, revisar `git diff --check` y el diff. Crear commits solo cuando haya cambio sustantivo, con prefijo Conventional Commits y descripción en español; GitHub ya está autorizado. No alterar fuentes originales.

## Decisiones persistentes del producto

- Costo mensual $0; buscador/detalle públicos; sesión para favoritos, perfil y administración; diseño azul/blanco institucional.
- PostgreSQL 17, backend Spring Boot 3.4.5/Java 17+, frontend React 19.2.5/Vite, recuperación por Gmail SMTP gratuito con secretos externos.
- Oracle Always Free + Nginx y frontend Vercel son la opción acordada, pero despliegue no autorizado en esta etapa. P12–P14 tampoco están autorizadas.
- Commits con prefijos Conventional Commits y descripciones en español.

## Espacio de trabajo

La limpieza previa eliminó 609 imágenes regenerables; no repetirla. Mantener `tmp/` mientras sus fuentes correspondan a candidatas abiertas: revisar referencias e informes antes de borrar. No borrar `graphify-out/`, OCR ni fuentes de respaldo sin verificar su uso. No tocar los archivos personales sin seguimiento `BecasFind - ET.docx` y `spa.traineddata`.
