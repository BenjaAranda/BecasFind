# Contexto operativo de BecasFind

Actualizado el 23 de octubre de 2026. Este archivo es un índice breve de continuidad, no reemplaza las fuentes de verdad. Al retomar, leer `AGENTS.md`, `PLAN_MEJORAS.md`, este archivo y `tasks/plan.md`; comprobar `git status` y reconstruir el estado desde los artefactos indicados abajo.

## Objetivo activo

Cerrar la revisión esencial de candidatas de becas con evidencia pública oficial, sin contactar instituciones, usar Firecrawl, ejecutar pruebas de aplicación, importar datos ni desplegar. Preservar originales y trazas. No descartar por falta de resultados, enlace caído, antigüedad o ausencia en catálogos. Descartar falsedad o duplicidad solo con evidencia positiva individual. Mantener separadas la confirmación histórica y la vigencia actual.

## Estado vigente verificado

Fuente autoritativa: `documentacion/auditoria_corpus/procesados/avance/resumen.json` y cola exacta `documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv`.

- 93 archivos fuente; 647 referencias; 568 candidatas únicas.
- 526 confirmaciones esenciales; 2 completas; 16 descartes ratificados.
- 24 abiertas: 18 requieren aclaración y 6 exclusiones históricas siguen sin ratificar.
- Verificación del 22/10 para ENAC: CDX y TimeMap de Internet Archive respondieron HTTP 200 con `[]` para la URL exacta del Reglamento de Becas anexo 52. No repetir la consulta de esa URL; buscar otra publicación oficial. Detalle en `ANEXO52_REGLAMENTO_BECAS_ENAC_2026_10_20.md`; las cuatro candidatas siguen abiertas.
- Última comprobación: 23/10/2026. El análisis adicional de fuentes oficiales no resolvió identidades: la Ordenanza N.º 10 de Lo Espejo (LeyChile/BCN) nombra dos becas históricas distintas pero no incluye el articulado íntegro; las publicaciones de Puerto Montt describen líneas específicas que no se vinculan a la candidata genérica; la página de acreditación ENAC 2016 no expone el anexo citado y su API REST respondió 403. El contraste del PADEM Victoria 2014 y las Cuentas Públicas Valparaíso 2012–2013 separa becas JUNAEB y el Programa BETA de las candidatas municipales genéricas; no vincula ni refuta las identidades alegadas. Hallazgos en `CONTRASTES_OFICIALES_MODALIDADES_2026_10_21.md`; no repetir esas fuentes como si resolvieran los casos. El 22/10 se confirmó esencialmente la familia institucional de Becas de Mantención UFRO mediante la Resolución Exenta 1458/2021. Se retiró como no respaldado el RSH máximo 60%; no hay monto individual ni vigencia 2026 confirmados. Informe: `CONFIRMACION_ESENCIAL_BECAS_MANTENCION_UFRO_2026_10_22.md`. Ignorar cifras históricas de 132, 157 y 291.
- La cola nombra los 24 casos, su carencia y los informes/fuentes pertinentes. Leer solo las filas del grupo elegido y sus informes vinculados; no volcar la cola completa ni reconstruirla desde planes antiguos.
- Contraste oficial nuevo del 22/10: Huara (beca deportiva 2018), Río Claro (incentivo laboral/emprendimiento 2021) y Camiña (PEI escolar 2026–2029) documentan modalidades o redes distintas; no identifican ni refutan las tres candidatas de educación superior. Informe: `CONTRASTE_PUBLICO_MUNICIPALES_2026_10_22.md`. No repetir estas fuentes; los estados y el conteo siguen sin cambios.
- Contraste oficial nuevo del 22/10 para Valparaíso: la Cuenta Pública 2011 registra cero becas municipales y diez becas técnico-superiores “Súmate” como otras becas de la comuna. Por ser anterior a las candidatas 2026 y no identificar sus bases, no las confirma ni descarta ni permite fusionar sus variantes. Informe: `CONTRASTE_VALPARAISO_HISTORICO_2026_10_22.md`.
- Contraste oficial adicional del 22/10 para Valparaíso: el Manual de Beneficios 2026 del Servicio de Bienestar municipal documenta prestaciones educativas para funcionarios y cargas familiares; no describe la ayuda general de transporte alegada para estudiantes comunales. No confirma ni descarta esa candidata. Véase el apartado añadido a `CONTRASTE_BECA_TRANSPORTE_VALPARAISO_BETA_2026_10_21.md`.
- Contraste oficial adicional del 22/10 para General Lagos: se revisaron con OCR en español las 27 actas ordinarias del concejo 2026 enlazadas por su portal de transparencia (285 páginas); no se halló una mención legible que identifique la beca. La omisión no demuestra inexistencia. La candidata sigue abierta; no repetir esa colección. Véase `CONTRASTES_OFICIALES_MODALIDADES_2026_10_21.md`.
- Contraste oficial nuevo del 22/10 para Valdivia: la Cuenta Pública 2016, p. impresa 25, describe el Programa de Becas e Informes Sociales DIDECO como colaboración JUNAEB y emisión de informes FUAS para estudiantes superiores (734 atenciones); no identifica el aporte municipal general alegado ni descarta una línea distinta o posterior. Informe actualizado: `CONTRASTE_VALDIVIA_2_CANDIDATAS_2026_10_13.md`. La candidata canónica sigue pendiente; conteo sin cambios.
- Contraste público adicional del 23/10 para Valparaíso: la página municipal vigente de becas describe la orientación para Beca Presidente e Indígena como gestión de beneficios estatales JUNAEB; no identifica ni refuta las tres candidatas municipales y no enumera bases o reglas. El portal de fondos concursables 2026 enumera convocatorias a personas jurídicas y no corresponde a becas individuales. Informe: `CONTRASTE_VALPARAISO_HISTORICO_2026_10_22.md`. Se mantienen abiertas; no repetir estas páginas como si resolvieran la identidad.

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
