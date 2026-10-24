# Contexto operativo de BecasFind

Actualizado el 23 de octubre de 2026. Este archivo es un resumen de arranque; no acumular bitácoras aquí. La evidencia histórica permanece en los informes por caso y en `documentacion/historial/`.

## Objetivo vigente

Completar P04: revisar las candidatas restantes usando solo fuentes públicas oficiales. No contactar instituciones ni usar Firecrawl. Preservar fuentes originales y trazas. No importar ni activar becas, ejecutar pruebas de backend/frontend o iniciar despliegue.

## Estado autoritativo

Reconstruido por `python infra/report-corpus-progress.py`: 93 fuentes, 647 referencias, 568 candidatas únicas; **526 confirmadas esenciales, 2 completas, 17 descartadas y 23 pendientes** (18 `REQUIERE_ACLARACION`, 5 `EXCLUSION_HISTORICA_SIN_RATIFICAR`).

- Cola individual y siguiente acción: [`pendientes_esenciales_actuales.csv`](../documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv).
- Resumen derivado: [`resumen.json`](../documentacion/auditoria_corpus/procesados/avance/resumen.json).
- Plan y fases: [`PLAN_MEJORAS.md`](../PLAN_MEJORAS.md).
- Método de revisión: [`plan.md`](plan.md).
- Contrato: [`AGENTS.md`](../AGENTS.md).

Siempre volver a generar el resumen; no reutilizar cifras antiguas de 132, 157, 222, 291 o 24 pendientes.

## Regla de decisión

Confirmar lo esencial solo con fuente oficial que individualice la existencia e identidad del programa, su beneficio y los requisitos principales. Corregir solo campos que esa fuente contradiga; los campos que no publique quedan «No especificado» dentro del alcance/año consultado. Confirmación histórica no acredita vigencia actual. No descartar por búsqueda vacía, omisión, antigüedad o enlace caído. Duplicidad, falsedad o fuera de alcance requieren evidencia positiva para cada caso. No transferir datos entre programas o modalidades parecidos.

## Cómo retomar

1. Leer la fila de la candidata en la cola: identidad alegada, carencia, fuentes y próxima acción.
2. Abrir solo los informes que esa fila cita; evitar repetir rutas agotadas salvo que haya una fuente nueva.
3. Trabajar candidatas agrupadas por institución/modalidad y registrar una sola vez cada documento compartido.
4. Si una fuente pública nueva no resuelve identidad, documentar el límite y dejar la candidata abierta. No forzar cierres para completar lotes.
5. Tras un cambio probatorio, ejecutar `python infra/report-corpus-progress.py`, luego `python infra/audit-editorial-evidence.py`, revisar el diff y `git diff --check`. No correr pruebas de aplicación para esta tarea.
6. El usuario autorizó GitHub; usar Conventional Commits con descripción en español. Base de esta actualización: rama `bugfix/security-and-recovery`, commit `2411964`; los elementos personales sin seguimiento eran `BecasFind - ET.docx` y `spa.traineddata`. No modificarlos.

## Rutas agotadas: reabrir solo con una fuente nueva y específica

- **ENAC (4):** no se recuperó el Reglamento Anexo 52; páginas actuales y acta CNA no identifican las cuatro modalidades. Ver referencias por hash en la cola y `ANEXO52_REGLAMENTO_BECAS_ENAC_2026_10_20.md`.
- **Puerto Montt:** Incentivo PAES, ayuda a hijos de pescadores y Reglamento 0004/2017 son modalidades distintas. Fuentes municipales de 2026 distinguen becas Social, Cultural y Deportiva; la publicación deportiva no define la candidata genérica de educación superior. Siguen sin publicarse los Ord. 132/2026 y 193/2026 y el reglamento. No repetir noticias deportivas ni de hijos de pescadores salvo nueva fuente para la beca general. Ver `CONTRASTES_PUBLICOS_FOCALIZADOS_2026_10_23.md`.
- **General Lagos/Visviri:** 27 actas 2026, OCR y transparencia 2013–2015 revisadas; no individualizan la candidata. No repetir ese corpus.
- **Valparaíso (3):** revisados catálogos, decretos, cuentas públicas y archivos disponibles. BETA es escolar; beneficios JUNAEB son estatales; ninguno identifica estas candidatas superiores. Ver informes citados en las tres filas.
- **Lo Espejo:** DIDECO confirma un trámite de postulación y la fuente 2024 identifica beneficios JUNAEB; no identifica aporte municipal propio. Ver `CONTRASTE_DIDECO_LO_ESPEJO_2026_10_23.md`.
- **Camiña:** el directorio oficial enlaza el portal de transparencia, que devuelve 403. El acceso fallido no demuestra inexistencia.
- **Huara:** el registro de Asistencia Social existe, pero el detalle 2026 no es legible ni identifica beca. No repetir hasta que cambie el acceso.
- **Romeral:** La Cuenta Pública 2023 registra acuerdos 18 y 19 («Programas estudiantiles» y «Ordenanza apoyo estudiantil»), sin adjuntar sus textos. Acta Ordinaria 20/2026, p. 27, menciona residencia de estudiantes en Talca; no la identifica como beca ni como la candidata. OCR revisado visualmente. Recuperar acta/acuerdo del 9/02/2023 y ordenanza; no volver a usar acta 20/2026 para intentar confirmar. Ver `CONTRASTE_ROMERAL_ORDENANZA_ESTUDIANTIL_2026_10_23.md`.
- **Iquique:** la beca artística Sixto Rojas es distinta; el Decreto 061/2016 no individualiza la candidata general.
- **Tierra Amarilla:** iniciativa con Universidad Nacional de La Rioja no prueba firma ni corresponde necesariamente a la candidata municipal general; no transferir montos o requisitos.
- **Valdivia:** fuentes halladas describen programas escolares, convenio para funcionarios/familias y trámites JUNAEB, no la candidata DIDECO general.
- **Talca:** la Cuenta Pública 2025, p. impresa 109, enumera BPR, Beca Indígena y TIC; en las pp. 118–119 DIDECO reporta ayudas sociales básicas y 650 informes socioeconómicos para estudiantes que postulan a becas externas. No identifica la beca municipal general ni prueba que no exista. Reabrir con bases/acto específico; ver `CONTRASTES_PUBLICOS_FOCALIZADOS_2026_10_23.md`.
- **Tierra Amarilla:** el sitio municipal actual `tierramarilla.com` ya responde; su índice público recupera Becas Deportivas 2025 y Residencia Familiar JUNAEB. La UDA confirma el preuniversitario PAES 2026 como programa distinto. No se encontró vínculo oficial con la beca superior general ni se infiere inexistencia. Ver `CONTRASTE_TIERRA_AMARILLA_SITIO_OFICIAL_2026_10_23.md`; no repetir esas modalidades.
- **Victoria:** revisión oficial adicional 23/10: el Reglamento Interno asigna a DIDECO canalizar becas del Estado; el PADEM 2014 registra un complemento histórico a Beca Vocación de Profesor (700 PSU, aporte libre), modalidad distinta; el catastro propio 2025–2026 lista ayudas generales y subvenciones. Ninguno identifica la candidata genérica; mantener abierta y no transferir datos. Véase `CONTRASTE_ADICIONAL_VICTORIA_2026_10_23.md`. Para avanzar, hace falta acto, bases, convocatoria o nómina municipal que nombre expresamente esa beca; no repetir estas fuentes.
- **El Monte, Concepción, Estación Central y Río Claro:** consultar la acción y los informes de cada fila; las fuentes revisadas no identifican inequívocamente las fichas.
- **Universidad Autónoma:** su exclusión histórica, junto con las cuatro de ENAC, suma cinco sin ratificar; el catálogo/reglamento 2026 no prueba que una ayuda separada o histórica no existiera.

Los informes citados en la cola son la bitácora detallada; no volver a copiar su contenido aquí. `tmp/` contenía 228.574.744 bytes en 86 archivos al 23/10/2026, en su mayoría fuentes/OCR usados en expedientes. Se verificó y eliminó una copia idéntica de 11.837.380 bytes de `romeral_acta_20_2026.pdf`; se conserva la copia canónica y toda evidencia única. No borrar los demás documentos probatorios.
