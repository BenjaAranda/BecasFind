# Contexto operativo de BecasFind

Actualizado el 21 de octubre de 2026. Este archivo es un índice breve de continuidad, no reemplaza las fuentes de verdad. Al retomar, leer `AGENTS.md`, `PLAN_MEJORAS.md`, este archivo y `tasks/plan.md`; comprobar `git status` y reconstruir el estado desde los artefactos indicados abajo.

## Objetivo activo

Cerrar la revisión esencial de candidatas de becas con evidencia pública oficial, sin contactar instituciones, usar Firecrawl, ejecutar pruebas de aplicación, importar datos ni desplegar. Preservar originales y trazas. No descartar por falta de resultados, enlace caído, antigüedad o ausencia en catálogos. Descartar falsedad o duplicidad solo con evidencia positiva individual. Mantener separadas la confirmación histórica y la vigencia actual.

## Estado vigente verificado

Fuente autoritativa: `documentacion/auditoria_corpus/procesados/avance/resumen.json` y cola exacta `documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv`.

- 93 archivos fuente; 647 referencias; 568 candidatas únicas.
- 525 confirmaciones esenciales; 2 completas; 16 descartes ratificados.
- 25 abiertas: 19 requieren aclaración y 6 exclusiones históricas siguen sin ratificar.
- Última comprobación: 21/10/2026. El análisis adicional de fuentes oficiales no resolvió identidades: la Ordenanza N.º 10 de Lo Espejo (LeyChile/BCN) nombra dos becas históricas distintas pero no incluye el articulado íntegro; las publicaciones de Puerto Montt describen líneas específicas que no se vinculan a la candidata genérica; la página de acreditación ENAC 2016 no expone el anexo citado y su API REST respondió 403. El contraste del PADEM Victoria 2014 y las Cuentas Públicas Valparaíso 2012–2013 separa becas JUNAEB y el Programa BETA de las candidatas municipales genéricas; no vincula ni refuta las identidades alegadas. Hallazgos en `CONTRASTES_OFICIALES_MODALIDADES_2026_10_21.md`; no repetir esas fuentes como si resolvieran los casos. No se cerró ni descartó ninguna candidata; el conteo no cambió. Ignorar cifras históricas de 132, 157 y 291.
- La cola nombra los 25 casos, su carencia y los informes/fuentes pertinentes. Leer solo las filas del grupo elegido y sus informes vinculados; no volcar la cola completa ni reconstruirla desde planes antiguos.

## Método de trabajo

Agrupar por institución y seleccionar una fuente pública específica que pueda resolver identidad, beneficio o requisitos principales. Confirmar cuando una fuente oficial identifica el programa exacto; investigar el resto en fuentes oficiales y marcar «No especificado» solo dentro del alcance consultado. Una búsqueda vacía u omisión de catálogo no demuestra inexistencia. Registrar evidencia nueva una sola vez en el informe adecuado y actualizar datos canónicos solo si la fuente corresponde al mismo programa.

Después de un cambio editorial respaldado, ejecutar en orden `python infra/report-corpus-progress.py` y `python infra/audit-editorial-evidence.py`, revisar el diff y crear commit Conventional Commit con descripción en español. No hacer commit si no hay cambio sustantivo. No repetir búsquedas generales ya documentadas; si una técnica no aporta evidencia, pasar a otra fuente o candidata.

## Decisiones y restricciones persistentes

- Solo fuentes públicas; no correos ni solicitudes de transparencia. No Firecrawl.
- No pruebas backend/frontend, importaciones, activaciones ni despliegue durante la revisión documental. P12–P14 siguen sin autorización.
- Becas y archivos originales no se borran. `BecasFind - ET.docx` y `spa.traineddata` son archivos personales sin seguimiento: no tocar.
- Meta de costo mensual: $0; búsqueda/detalle públicos sin sesión; cuenta solo para datos guardados y administración; estética institucional azul y blanca.
- PostgreSQL 17; perfiles locales `dev` y producción `prod`; secretos externos; producción valida esquema preinstalado. Recuperación por Gmail SMTP gratuito, con la cuenta/secretos pendientes de configuración por el usuario.
- Los commits nuevos llevan prefijos Conventional Commits y descripciones en español.

## Espacio y rendimiento

La limpieza histórica documentada eliminó 609 imágenes regenerables (647.954.754 bytes); no repetirla. La descarga temporal propia `tmp/enac-acreditacion-2016.html` se usó para verificar la página oficial y se retiró después; el sitio no publicó un enlace al informe/anexo citado. La mayor parte de `tmp/` contiene fuentes oficiales o archivos de trabajo vinculados a candidatas abiertas y se conserva. No borrar `graphify-out/`, `test-results/`, OCR ni fuentes respaldatorias sin comprobar primero sus referencias.

En esta sesión se retiraron las descargas temporales propias `tmp/INACAP-informe-acreditacion-2024.pdf` (30.800.266 bytes) y `tmp/elmonte-cuenta-publica-2024-oficial.pdf` (80.437.590 bytes) junto con su extracción `.txt` (587.811 bytes), después de registrar sus hallazgos en informes que conservan enlaces a las fuentes oficiales. El contraste adicional del 21/10 volvió a comprobar El Monte, Concepción y Valparaíso sin resolver sus candidatas; no se deben repetir búsquedas generales ni cambiar sus estados por omisión. Los otros archivos temporales no se consideran descartables sin análisis de referencias. Los dos archivos personales sin seguimiento siguen intactos.

Para reducir contexto: consultar el resumen JSON, elegir pocas filas relacionadas de la cola y abrir solo sus informes citados. Los informes individuales conservan el historial probatorio; `tasks/plan.md` conserva el procedimiento y `PLAN_MEJORAS.md` el plan global.
