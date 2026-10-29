# Método vigente para cerrar la revisión esencial

Actualizado el 24 de octubre de 2026. El alcance y las fases están en [`PLAN_MEJORAS.md`](../PLAN_MEJORAS.md); el estado operativo y las rutas ya agotadas, en [`contexto.md`](contexto.md).

## Cola y avance

La revisión de campos solicitada el 28/10 tiene una cola distinta de la confirmación esencial: [informe de correcciones](../documentacion/auditoria_corpus/procesados/correccion_campos_2026_10_28/README.md). Aplicadas y verificadas correcciones en 356 fichas; 168 categorías pendientes en `pendientes_tipo.csv` de esa carpeta. Continuar primero conciliando contradicciones de identidad y recuperando datos ya acreditados que no llegaron a los campos públicos. No asignar categorías ni completar requisitos por el nombre de la beca. No repetir los SQL aplicados ni confundir clasificación documental con comprobación actual de vigencia.

La única cola vigente es [`pendientes_esenciales_actuales.csv`](../documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv), regenerada desde la evidencia del corpus. Tras el cierre editorial autorizado del 24/10/2026 contiene **0 candidatas abiertas**. El informe individual de las 23 resoluciones está en [`CIERRE_CANDIDATAS_PENDIENTES_2026_10_24.md`](../documentacion/auditoria_corpus/procesados/CIERRE_CANDIDATAS_PENDIENTES_2026_10_24.md). No reconstruir colas desde informes antiguos ni usar sus conteos históricos.

## Procedimiento

1. Agrupar por institución/modalidad. Leer de cada fila la identidad alegada, carencia, antecedentes y próxima acción; cargar únicamente los informes citados.
2. Elegir una fuente pública oficial nueva que pueda resolver la carencia. No repetir catálogos generales ni búsquedas ya agotadas sin una pista nueva.
3. Leer el documento completo en el apartado pertinente y comprobar institución, programa/modalidad, beneficio y requisitos principales. Corregir solo lo que la fuente diga sobre esa misma beca.
4. Confirmar lo esencial cuando la fuente individualice identidad, beneficio y requisitos principales. Campos no publicados: «No especificado», delimitando año y alcance.
5. Instrucción autorizada el 24/10/2026 para la cola restante: si tras revisar las fuentes públicas oficiales no existe evidencia sustancial para identificar y sustentar una candidata, excluirla editorialmente del catálogo confirmable por insuficiencia de evidencia; no presentarla como falsa o inexistente. Preservar originales y trazas. La confirmación histórica no prueba vigencia actual.
6. Registrar un documento compartido una vez y distinguir hallazgo, corrección, confirmación, descarte y variantes resueltas. No activar una candidata excluida ni publicar una convocatoria sin cierre vigente confirmado.
7. Para cambios probatorios, regenerar con `python infra/report-corpus-progress.py`; después ejecutar `python infra/audit-editorial-evidence.py`, revisar el diff y `git diff --check`. Commits autorizados: prefijo Conventional Commits y descripción en español.

## Rendimiento y límites

- Trabajar tandas amplias por fuente/institución; limitar salidas a las filas y apartados relevantes.
- Si una tanda no encuentra evidencia específica, cambiar a una fuente pública distinta o dejar claramente documentado qué archivo público falta.
- Solo fuentes públicas oficiales; no contactar instituciones ni usar Firecrawl.
- Durante esta tarea no importar ni activar becas, no correr pruebas de backend/frontend y no iniciar fases de despliegue.

El método histórico se conserva en [`PLAN_REVISION_ANTES_CONSOLIDACION_2026_10_19.md`](../documentacion/historial/PLAN_REVISION_ANTES_CONSOLIDACION_2026_10_19.md).
