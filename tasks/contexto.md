# Contexto operativo de BecasFind

Actualizado el 24 de octubre de 2026. Este archivo es un resumen de arranque; no acumular bitácoras aquí. La evidencia histórica permanece en los informes por caso y en `documentacion/historial/`.

## Objetivo vigente

P04 quedó cerrado editorialmente el 24 de octubre de 2026: las 23 candidatas que seguían abiertas se revisaron y excluyeron del catálogo confirmable por insuficiencia de evidencia pública oficial específica. «Excluida» no significa falsa ni inexistente. Preservar fuentes originales y trazas. No importar ni activar becas, ejecutar pruebas de backend/frontend o iniciar despliegue.

## Estado autoritativo

Reconstruido por `python infra/report-corpus-progress.py`: 93 fuentes, 647 referencias, 568 candidatas únicas; **526 confirmadas esenciales, 2 completas, 40 descartadas editorialmente y 0 pendientes**. De los 40 descartes editoriales, los 23 registrados el 24/10/2026 son por evidencia insuficiente y no afirman falsedad o inexistencia.

- Cola individual y siguiente acción: [`pendientes_esenciales_actuales.csv`](../documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv).
- Resumen derivado: [`resumen.json`](../documentacion/auditoria_corpus/procesados/avance/resumen.json).
- Plan y fases: [`PLAN_MEJORAS.md`](../PLAN_MEJORAS.md).
- Método de revisión: [`plan.md`](plan.md).
- Contrato: [`AGENTS.md`](../AGENTS.md).

Siempre volver a generar el resumen; no reutilizar cifras antiguas de 132, 157, 222, 291 o 24 pendientes.

## Revisión de continuidad — 24 de octubre de 2026

Se revisaron y resolvieron las **23 candidatas** que quedaban. La fuente municipal nueva del [Incentivo PAES de Puerto Montt 2023](https://www.puertomontt.cl/4-de-abril-vence-plazo-de-postulacion-para-el-incentivo-paes-2023/) acredita esa modalidad específica, pero no la ficha genérica DIDECO; no se transfirieron sus datos. Los expedientes de las restantes tampoco sostienen la identidad y beneficio principal de las fichas genéricas. Las 23 se excluyeron editorialmente por insuficiencia de evidencia; no se calificaron como falsas o inexistentes y sus originales y trazas siguen preservados. Véase [`CIERRE_CANDIDATAS_PENDIENTES_2026_10_24.md`](../documentacion/auditoria_corpus/procesados/CIERRE_CANDIDATAS_PENDIENTES_2026_10_24.md). La cola regenerada quedó en **0 pendientes**.

Limpieza de espacio: `tmp/` contiene 640,6 MiB en PDFs y renders/OCR de expedientes. La búsqueda de duplicados exactos previa encontró solo 121 KiB recuperables en textos OCR redundantes; se conservaron para no romper trazas. `backend/target` (64,6 MiB) y `frontend/dist` (0,5 MiB) se conservaron. No tocar los archivos personales no rastreados `BecasFind - ET.docx` y `spa.traineddata`.

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
- **Romeral:** La Cuenta Pública 2023 registra acuerdos 18 y 19 («Programas estudiantiles» y «Ordenanza apoyo estudiantil»), sin adjuntar sus textos. Acta Ordinaria 20/2026, p. 27, menciona residencia de estudiantes en Talca; no la identifica como beca ni como la candidata. OCR revisado visualmente. El portal de trámites enlazado desde el sitio municipal (`portal.muniromeral.cl`) devolvió 403 el 23/10/2026; es una barrera de acceso, no evidencia de inexistencia. No repetir esa ruta hasta que cambie el acceso. Sigue pendiente recuperar el acta/acuerdo del 9/02/2023 y la ordenanza. Ver `CONTRASTE_ROMERAL_ORDENANZA_ESTUDIANTIL_2026_10_23.md`.
- **Iquique:** la beca artística Sixto Rojas es distinta; el Decreto 061/2016 no individualiza la candidata general.
- **Tierra Amarilla:** iniciativa con Universidad Nacional de La Rioja no prueba firma ni corresponde necesariamente a la candidata municipal general; no transferir montos o requisitos.
- **Valdivia:** fuentes halladas describen programas escolares, convenio para funcionarios/familias y trámites JUNAEB, no la candidata DIDECO general.
- **Talca:** la Cuenta Pública 2025, p. impresa 109, enumera BPR, Beca Indígena y TIC; en las pp. 118–119 DIDECO reporta ayudas sociales básicas y 650 informes socioeconómicos para estudiantes que postulan a becas externas. No identifica la beca municipal general ni prueba que no exista. Reabrir con bases/acto específico; ver `CONTRASTES_PUBLICOS_FOCALIZADOS_2026_10_23.md`.
- **Tierra Amarilla:** el sitio municipal actual `tierramarilla.com` ya responde; su índice público recupera Becas Deportivas 2025 y Residencia Familiar JUNAEB. La UDA confirma el preuniversitario PAES 2026 como programa distinto. No se encontró vínculo oficial con la beca superior general ni se infiere inexistencia. Ver `CONTRASTE_TIERRA_AMARILLA_SITIO_OFICIAL_2026_10_23.md`; no repetir esas modalidades.
- **Victoria:** revisión oficial adicional 23/10: el Reglamento Interno asigna a DIDECO canalizar becas del Estado; el PADEM 2014 registra un complemento histórico a Beca Vocación de Profesor (700 PSU, aporte libre), modalidad distinta; el catastro propio 2025–2026 lista ayudas generales y subvenciones. Ninguno identifica la candidata genérica; mantener abierta y no transferir datos. Véase `CONTRASTE_ADICIONAL_VICTORIA_2026_10_23.md`. Para avanzar, hace falta acto, bases, convocatoria o nómina municipal que nombre expresamente esa beca; no repetir estas fuentes.
- **El Monte, Concepción, Estación Central y Río Claro:** consultar la acción y los informes de cada fila; las fuentes revisadas no identifican inequívocamente las fichas.
- **Universidad Autónoma:** su exclusión histórica, junto con las cuatro de ENAC, suma cinco sin ratificar; el catálogo/reglamento 2026 no prueba que una ayuda separada o histórica no existiera.

Los informes citados en la cola son la bitácora detallada; no volver a copiar su contenido aquí. `tmp/` contenía 228.574.744 bytes en 86 archivos al 23/10/2026, en su mayoría fuentes/OCR usados en expedientes. Se verificó y eliminó una copia idéntica de 11.837.380 bytes de `romeral_acta_20_2026.pdf`; se conserva la copia canónica y toda evidencia única. No borrar los demás documentos probatorios.\n