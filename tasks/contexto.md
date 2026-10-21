# Contexto operativo de BecasFind

Actualizado el 20 de octubre de 2026. Leer `AGENTS.md`, este archivo, `PLAN_MEJORAS.md` y el estado de Git al retomar. Para revisar becas, seguir `tasks/plan.md` y cargar únicamente los informes de los hashes en curso.

## Estado editorial

- Repositorio: `BenjaAranda/BecasFind`; rama habitual `bugfix/security-and-recovery` (comprobarla al retomar).
- Corpus: 93 archivos originales, 647 referencias y 568 candidatas únicas.
- Conteo vigente: **522 confirmadas esenciales, 2 completas, 14 descartes ratificados y 30 pendientes** (21 aclaraciones y 9 exclusiones históricas sin ratificar).
- Fuentes de verdad para conteos: `documentacion/auditoria_corpus/procesados/avance/resumen.json` y `pendientes_esenciales_actuales.csv`. No usar cifras antiguas de 132, 157 o 291.
- El 20 de octubre se excluyó la ficha Iquique `1d5e0e1a3d7093d6cd170875d30b640fc8e17c11a5ee6e1a0adf27f48e46680a` como copia documental de `b8b0e486aadb5a9ea10a112dcb4f875f4b70455792e81803392506fd81120baf`; se preservan ambos originales y la ficha canónica permanece pendiente. Véase `REVISION_DUPLICADO_IQUIQUE_2026_10_20.md`. El avance editorial actual confirma la línea histórica municipal de becas monetarias de estudio de Putre, con campos no acreditados conservados como desconocidos. El elemento no rastreado `BecasFind - ET.docx` es un documento personal y no se debe modificar ni borrar.
- Nuevo contraste público UBO (20/10): la DAE confirma Beca de Contingencia para dificultades económicas extraordinarias/sobrevinientes y beca de alimentación; Admisión lista sus beneficios internos vigentes. Ninguna vincula estos beneficios con el descuento general 15–40%/RSH 60% de `1f5b64abcd3fbfbdb0f07a9c4b8f3e27c33931d3c570c7cb6b9a3ccc0d48d97c`. No confundir ni descartar por omisión; sigue como exclusión histórica sin ratificar. Véase `RECONTRASTE_PUBLICO_UBO_SOCIOECONOMICA_2026_10_20.md`.

## Alcance y reglas de revisión

Priorizar la confirmación editorial de becas. Usar solo fuentes públicas y no contactar instituciones. No usar Firecrawl. No ejecutar pruebas de backend/frontend, importaciones, activaciones ni despliegue en esta tarea.

Confirmar identidad y existencia solo con evidencia oficial específica. Registrar los campos que la fuente publica y usar «No especificado» para los restantes. No inferir requisitos, fechas, montos ni equivalencias entre modalidades. No descartar por antigüedad, error HTTP o búsquedas sin resultado. Duplicidad o falsedad requieren evidencia positiva individual. Preservar originales y trazas; separar confirmación histórica de vigencia y publicación actual.

Antes de investigar cada candidata: leer su hash, carencia e informe pertinente en la cola; no repetir búsquedas documentadas. Si no aparece evidencia nueva que resuelva el caso, mantenerlo pendiente sin cambiar su estado. Al modificar el corpus, actualizar el informe y registros pertinentes, ejecutar `python infra/report-corpus-progress.py` y luego `python infra/audit-editorial-evidence.py`, revisar el diff y hacer commit español con prefijo Conventional Commits. Sin modificación real, no crear commit.

## Pistas focalizadas vigentes

- **Romeral** (`5ab3468f5021776c0496de2182244397e57fac292bee1f1a081a92dcc9dabd1b`): la Cuenta Pública 2023, p. 88, registra que el Concejo aprobó «Programas estudiantiles» y una «Ordenanza apoyo estudiantil» el 09/02/2023. No publica el texto, nivel, población, tipo de ayuda ni reglas; no demuestra que sea la beca superior de la candidata. El índice de actas disponible lista sesiones 2024–2026. Mantener abierta y no repetir las búsquedas ya anotadas. Informe: `CONTRASTE_ORDENANZA_APOYO_ESTUDIANTIL_ROMERAL_2026_10_20.md`.
- **ENAC**: el anexo 52 del Reglamento de Becas no se recuperó; no inferir inexistencia. El CSV original tiene una fila mezclada por comas sin escapar; `originales.jsonl` registra `COLUMNAS_AUSENTES` en Vocación. No usar esa fila como evidencia. Informes: `ANEXO52_REGLAMENTO_BECAS_ENAC_2026_10_20.md` y `CONFIRMACION_ESENCIAL_BECAS_INTERNAS_ENAC_2013_2015_2026_10_19.md`.
- **Timaukel**: confirmada solo la línea histórica de mantención anunciada en 2020; no se confirmó nivel superior, monto, requisitos ni vigencia actual. Informe: `CONFIRMACION_ESENCIAL_TIMAUKEL_2026_10_20.md`.
- **Santa María**: confirmadas ayudas universitarias municipales descritas en ficha DIDECO de 2016; no se acreditan nombre «beca», monto ni vigencia actual. Informe: `CONFIRMACION_ESENCIAL_AYUDAS_UNIVERSITARIAS_SANTA_MARIA_2026_10_20.md`.
- **Putre**: confirmada en alcance histórico la línea municipal de becas monetarias de estudio gestionadas por DIDECO, registrada en la Cuenta Pública 2011. Nivel educativo, destinatarios, importe, requisitos de adjudicación y vigencia actual no especificados. No equiparar con la Beca de Residencia Familiar para estudiantes que estudiaban en Putre. Informe: `CONFIRMACION_ESENCIAL_BECAS_ESTUDIO_PUTRE_2026_10_20.md`.
- **Huara**: fuente municipal acredita una línea deportiva distinta de la candidata de mantención superior. Informe: `CONTRASTE_BECA_DEPORTIVA_HUARA_2018_2019_2026_10_20.md`.
- **UCT, UBO, UFRO, Iquique, General Lagos, Talca, Viña del Mar, Victoria, El Monte, Concepción, INACAP, Autónoma y candidatas con apoyos JUNAEB**: sus comparaciones y límites están en los informes citados en la carencia de cada fila de la cola; no transferir reglas de beneficios parecidos ni cerrar por omisión.
- Archivos y URLs históricos consultados están indexados en `tasks/indice_archivos_historicos.json`; leer resultados locales solo cuando el hash pendiente los requiera. Las actas de Romeral ya descargadas/OCR están en `LECTURA_ACTAS_ROMERAL_2026_10_19.md` y su manifiesto.

## Decisiones de producto conservadas

Costo mensual objetivo $0; sin contratar planes ni comprar dominios. Azul y blanco institucional, acceso público a búsqueda/detalle, inicio de sesión para datos guardados y administración. PostgreSQL 17; recuperación por Gmail SMTP con secretos externos. Despliegue aún no iniciado: P12–P14 no están autorizadas.

La limpieza anterior eliminó 609 imágenes regenerables y liberó 647.954.754 bytes; se conservaron 27 PDF, 611 páginas OCR y las dos imágenes necesarias para verificación visual. No borrar datos personales, originales, trazas ni los directorios de compilación cuya eliminación previa fue rechazada automáticamente. Regenerar derivados solo si se necesitan y existe una ruta segura.
