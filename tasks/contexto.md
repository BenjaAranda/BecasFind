# Continuidad de la revisión de becas BecasFind

Actualizado el 23 de octubre de 2026. Leer primero `AGENTS.md`; aquí queda solo el estado operativo para retomar sin repetir búsquedas. La cola y sus informes enlazados son la autoridad para cada candidata.

## Objetivo y límites

- Terminar la revisión esencial de candidatas usando exclusivamente fuentes públicas oficiales. El usuario indicó que no se contacte a instituciones. No usar Firecrawl.
- Preservar originales y trazas. No importar registros, activar becas, desplegar ni correr pruebas de backend/frontend mientras se revisa el corpus.
- Confirmar solo cuando evidencia oficial individual sustente identidad y existencia del programa. Registrar únicamente los campos publicados; dejar otros como `No especificado` dentro del alcance consultado. No inferir inexistencia por búsquedas vacías, omisiones, enlaces caídos o antigüedad.
- Distinguir confirmación histórica de vigencia actual. Descartar falsedad, fuera de alcance o duplicidad solo con evidencia positiva individual. Las exclusiones históricas aún sin ratificar siguen abiertas.
- Se autorizó seguir las 132 candidatas que entonces estaban pendientes; la cifra vigente es distinta y siempre se reconstruye desde los artefactos actuales.

## Estado vigente reconstruido

`documentacion/auditoria_corpus/procesados/avance/resumen.json` y `pendientes_esenciales_actuales.csv` son las referencias de estado. En la revisión del 23/10: 93 fuentes, 647 referencias, 568 candidatas únicas; 526 confirmadas esenciales, 2 completas, 16 descartadas y 24 abiertas (18 requieren aclaración y 6 exclusiones históricas sin ratificar). No presentar conteos anteriores de 132/157/222/291/568 como pendientes actuales.

Para el siguiente lote, leer primero la fila individual de `pendientes_esenciales_actuales.csv` (incluye carencia y acción siguiente); luego solo los informes citados en esa fila. El informe de Lo Espejo creado el 23/10 es `CONTRASTE_DIDECO_LO_ESPEJO_2026_10_23.md`.

## Rutas ya agotadas; no repetir sin fuente nueva

- **ENAC:** cuatro candidatas internas. El reglamento Anexo 52 exacto no se recuperó (CDX/TimeMap vacíos); las páginas actuales y el acta CNA no identifican las categorías. Revisar fuentes oficiales distintas, no repetir esas consultas ni arreglar el CSV fuente corrupto. Referencias: `ANEXO52_REGLAMENTO_BECAS_ENAC_2026_10_20.md`, `CONTRASTES_OFICIALES_MODALIDADES_2026_10_21.md` y el informe individual que indique la cola.
- **Puerto Montt:** se distinguieron Incentivo PAES, ayudas a hijos de pescadores y Reglamento N.º 0004/2017 de la candidata genérica. El registro municipal de requerimientos identifica solicitud de su versión actualizada y respuesta mediante Ord. 132/2026 y Ord. 193/2026, pero los documentos y el reglamento no aparecen; véase `CONTRASTES_PUBLICOS_FOCALIZADOS_2026_10_23.md`. No volver a usar convocatorias PAES ni ayudas pesqueras para validar la ficha. Reabrir con el oficio o reglamento legible.
- **General Lagos/Visviri:** no repetir las 27 actas ordinarias 2026 (285 páginas), OCR ni transparencia 2013–2015. Los hallazgos fueron ayudas en especie/JUNAEB, sin resolver una beca municipal superior. No transferirles sus reglas. `CONTRASTES_OFICIALES_MODALIDADES_2026_10_21.md`.
- **Valparaíso:** ya se revisaron índice de decretos, buscador, catálogo de beneficios propios, página de becas, nómina DIDECO 2017 y Cuenta Pública/auditoría 2024. No se obtuvo el Oficio 156; sus tres candidatas siguen separadas. No inferir cobertura por omisión. `CONTRASTE_VALPARAISO_HISTORICO_2026_10_22.md`, `CONTRASTE_BECA_TRANSPORTE_VALPARAISO_BETA_2026_10_21.md` y `CONTRASTES_PUBLICOS_FOCALIZADOS_2026_10_23.md`.
- **Lo Espejo:** la página DIDECO confirma el trámite “Postulación a Becas de Educación Superior”, no un aporte municipal, sus requisitos o su monto. La candidata de aporte monetario continúa abierta; no repetir esa página sin nueva fuente que identifique la prestación. `CONTRASTE_DIDECO_LO_ESPEJO_2026_10_23.md`.
- **Camiña:** el directorio del Consejo para la Transparencia identifica el organismo MU025 y enlaza su portal TA, pero el destino devuelve HTTP 403; el sitio municipal antiguo tampoco resuelve. Esto no prueba inexistencia. Contraste del 23/10 incorporado a `CONTRASTES_PUBLICOS_FOCALIZADOS_2026_10_23.md`; no repetir hasta que el portal sea legible o aparezca una fuente municipal específica nueva.
- **Huara:** MU107 registra Asistencia Social 2017–2026; el detalle 2026 (62105416) falla y la API no devuelve “beca”. No repetir esta ruta mientras el detalle no cambie. `CONTRASTE_PUBLICO_MUNICIPALES_2026_10_22.md`.
- **Romeral:** Cuenta Pública 2023 registra los acuerdos 18 y 19 sobre programas/ordenanza estudiantil, pero no el texto. El detalle de beneficios propios 2023 está en mantenimiento. Se revisó el Acta 20/2026 y otras prestaciones escolares/JUNAEB; no prueban ni refutan la candidata general. Retomar al recuperar la ordenanza o ficha. `CONTRASTE_ORDENANZA_APOYO_ESTUDIANTIL_ROMERAL_2026_10_20.md`.
- **Iquique:** las bases Sixto Rojas confirman línea artística superior, distinta de la candidata general. No trasladar requisitos. `CONTRASTES_OFICIALES_MODALIDADES_2026_10_21.md`.
- **Municipios ya contrastados sin cierre:** Tierra Amarilla, Concepción, Camiña, Río Claro, Victoria, Valdivia, Talca y El Monte. Para Valdivia, la Cuenta Pública 2014 separa las becas de mantención JUNAEB y la acreditación socioeconómica para estudiantes superiores de una eventual beca municipal; detalle en `CONTRASTES_PUBLICOS_FOCALIZADOS_2026_10_23.md`. Las demás cuentas públicas y programas cercanos tampoco cierran las candidatas generales. Consultar la fila y el informe que aparecen en la cola antes de buscar más; no repetir consultas generales. Referencias principales: `CONTRASTES_OFICIALES_MODALIDADES_2026_10_21.md`, `CONTRASTE_PUBLICO_MUNICIPALES_2026_10_22.md` y `CONTRASTES_PUBLICOS_FOCALIZADOS_2026_10_23.md`.
- **INACAP, Universidad Autónoma y Estación Central:** catálogos, reglamentos y páginas actuales distinguen beneficios parecidos, pero no ratifican ni refutan sus candidatas históricas. Mantener las exclusiones históricas abiertas hasta prueba positiva. Referencias en `CONTRASTES_PUBLICOS_FOCALIZADOS_2026_10_23.md` y `CONTRASTE_ESTACION_CENTRAL_TALENTO_2026_2026_10_13.md`.

## Flujo, Git y espacio

- Tras cada cambio probatorio: `python infra/report-corpus-progress.py`, después `python infra/audit-editorial-evidence.py`, `git diff --check` y revisión del diff. No contar una distinción de modalidades como confirmación.
- El usuario autorizó GitHub. Cometer cambios sustantivos con prefijo Conventional Commits y descripción en español.
- Tras quitar la copia duplicada, el inventario de `tmp/` quedó en 628,6 MB (558,8 MB en PDFs); `frontend/node_modules` ocupa 178,2 MB y `graphify-out/` 7,4 MB. Se eliminaron 609 imágenes regenerables en una limpieza anterior; no repetirla. Se preservan fuentes vinculadas a casos abiertos, OCR, `graphify-out/` y dependencias instaladas.
- En esta sesión se eliminó una copia binaria idéntica de un acta de Romeral; se conservaron 11,29 MB. La fuente idéntica permanece en `tmp/romeral_acta_20_2026.pdf`.
- No tocar los archivos personales sin seguimiento `BecasFind - ET.docx` ni `spa.traineddata`.
