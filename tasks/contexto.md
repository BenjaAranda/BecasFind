# Contexto operativo de BecasFind

Actualizado el 20 de octubre de 2026. Leer `AGENTS.md`, este archivo, `PLAN_MEJORAS.md` y el estado de Git al retomar. Para revisar becas, seguir `tasks/plan.md` y cargar únicamente los informes de los hashes en curso.

## Estado editorial

- Repositorio: `BenjaAranda/BecasFind`; rama habitual `bugfix/security-and-recovery` (comprobarla al retomar).
- Corpus: 93 archivos originales, 647 referencias y 568 candidatas únicas.
- Conteo vigente: **521 confirmadas esenciales, 2 completas, 13 descartes ratificados y 32 pendientes** (23 aclaraciones y 9 exclusiones históricas sin ratificar).
- Fuentes de verdad para conteos: `documentacion/auditoria_corpus/procesados/avance/resumen.json` y `pendientes_esenciales_actuales.csv`. No usar cifras antiguas de 132, 157 o 291.
- El último avance editorial fue `91252f6 docs: elimina candidata duplicada de Valdivia`. No hay cambios de código/documentación pendientes de esta sesión; el único elemento no rastreado observado es el documento personal `BecasFind - ET.docx`, que no se debe modificar ni borrar.

## Alcance y reglas de revisión

Priorizar la confirmación editorial de becas. Usar solo fuentes públicas y no contactar instituciones. No usar Firecrawl. No ejecutar pruebas de backend/frontend, importaciones, activaciones ni despliegue en esta tarea.

Confirmar identidad y existencia solo con evidencia oficial específica. Registrar los campos que la fuente publica y usar «No especificado» para los restantes. No inferir requisitos, fechas, montos ni equivalencias entre modalidades. No descartar por antigüedad, error HTTP o búsquedas sin resultado. Duplicidad o falsedad requieren evidencia positiva individual. Preservar originales y trazas; separar confirmación histórica de vigencia y publicación actual.

Antes de investigar cada candidata: leer su hash, carencia e informe pertinente en la cola; no repetir búsquedas documentadas. Si no aparece evidencia nueva que resuelva el caso, mantenerlo pendiente sin cambiar su estado. Al modificar el corpus, actualizar el informe y registros pertinentes, ejecutar `python infra/report-corpus-progress.py` y luego `python infra/audit-editorial-evidence.py`, revisar el diff y hacer commit español con prefijo Conventional Commits. Sin modificación real, no crear commit.

## Pistas focalizadas vigentes

- **Romeral** (`5ab3468f5021776c0496de2182244397e57fac292bee1f1a081a92dcc9dabd1b`): la Cuenta Pública 2023, p. 88, registra que el Concejo aprobó «Programas estudiantiles» y una «Ordenanza apoyo estudiantil» el 09/02/2023. No publica el texto, nivel, población, tipo de ayuda ni reglas; no demuestra que sea la beca superior de la candidata. El índice de actas disponible lista sesiones 2024–2026. Mantener abierta y no repetir las búsquedas ya anotadas. Informe: `CONTRASTE_ORDENANZA_APOYO_ESTUDIANTIL_ROMERAL_2026_10_20.md`.
- **ENAC**: el anexo 52 del Reglamento de Becas no se recuperó; no inferir inexistencia. El CSV original tiene una fila mezclada por comas sin escapar; `originales.jsonl` registra `COLUMNAS_AUSENTES` en Vocación. No usar esa fila como evidencia. Informes: `ANEXO52_REGLAMENTO_BECAS_ENAC_2026_10_20.md` y `CONFIRMACION_ESENCIAL_BECAS_INTERNAS_ENAC_2013_2015_2026_10_19.md`.
- **Timaukel**: confirmada solo la línea histórica de mantención anunciada en 2020; no se confirmó nivel superior, monto, requisitos ni vigencia actual. Informe: `CONFIRMACION_ESENCIAL_TIMAUKEL_2026_10_20.md`.
- **Santa María**: confirmadas ayudas universitarias municipales descritas en ficha DIDECO de 2016; no se acreditan nombre «beca», monto ni vigencia actual. Informe: `CONFIRMACION_ESENCIAL_AYUDAS_UNIVERSITARIAS_SANTA_MARIA_2026_10_20.md`.
- **Huara**: fuente municipal acredita una línea deportiva distinta de la candidata de mantención superior. Informe: `CONTRASTE_BECA_DEPORTIVA_HUARA_2018_2019_2026_10_20.md`.
- **UCT, UBO, UFRO, Iquique, General Lagos, Talca, Viña del Mar, Victoria, El Monte, Concepción, INACAP, Autónoma y candidatas con apoyos JUNAEB**: sus comparaciones y límites están en los informes citados en la carencia de cada fila de la cola; no transferir reglas de beneficios parecidos ni cerrar por omisión.
- Archivos y URLs históricos consultados están indexados en `tasks/indice_archivos_historicos.json`; leer resultados locales solo cuando el hash pendiente los requiera. Las actas de Romeral ya descargadas/OCR están en `LECTURA_ACTAS_ROMERAL_2026_10_19.md` y su manifiesto.

## Decisiones de producto conservadas

Costo mensual objetivo $0; sin contratar planes ni comprar dominios. Azul y blanco institucional, acceso público a búsqueda/detalle, inicio de sesión para datos guardados y administración. PostgreSQL 17; recuperación por Gmail SMTP con secretos externos. Despliegue aún no iniciado: P12–P14 no están autorizadas.

La limpieza anterior eliminó 609 imágenes regenerables y liberó 647.954.754 bytes; se conservaron 27 PDF, 611 páginas OCR y las dos imágenes necesarias para verificación visual. No borrar datos personales, originales, trazas ni los directorios de compilación cuya eliminación previa fue rechazada automáticamente. Regenerar derivados solo si se necesitan y existe una ruta segura.
