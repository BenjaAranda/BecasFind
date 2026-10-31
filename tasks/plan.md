# Método vigente para cerrar la revisión esencial

Actualizado el 24 de octubre de 2026. El alcance y las fases están en [`PLAN_MEJORAS.md`](../PLAN_MEJORAS.md); el estado operativo y las rutas ya agotadas, en [`contexto.md`](contexto.md).

## Vigencia: corte del 30/10/2026

Auditoría de vigencia cerrada al corte documental del 30/10 con resultados inconclusos conservados: 466 dictámenes; 4 con cierre no vencido, 68 cierres de convocatorias identificadas (incluidas históricas), 88 calendarios por modalidad, 119 sin calendario publicado en el expediente y 187 inconclusas. No equivale a investigación exhaustiva de todas las fuentes ni a 466 confirmaciones actuales. Fuente vigente: documentacion/auditoria_corpus/procesados/auditoria_vigencia_corte_2026_10_29/INFORME_CIERRE.md, inventario.json y avance.json. Aplicados y conciliados 56 cambios (54 calendarios cerrados y dos activaciones: 255/327); no repetir los SQL. Todos los UUID conservados. Web verificada: 528 fichas; 8 abiertas, 112 cierres vencidos, 221 fechas por confirmar y 187 en revisión. BUCH cerró por su temporizador el 30/10 a las 12:00. Backend con recurso de 187 UUID actualizado; frontend 719646b conservado. No iniciar P13/P14.

## Cola y avance

La tanda final de 19 quedó terminada el 29/10 con **19 INCONCLUSA, cero confirmaciones nuevas y cero casos sin dictamen**. Leer [resultado individual](../documentacion/auditoria_corpus/procesados/correccion_campos_2026_10_28/RESULTADO_FINAL_19.md). Las incógnitas siguen explícitas en casos_inconclusos_actuales.csv; las colas para dictaminar esta tanda están vacías. Reabrir por nueva fuente específica o alcance nuevo, no repetir búsquedas agotadas. La auditoría general de vigencia es otro trabajo y no se declara terminada.

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

La clasificación descriptiva anterior se conserva como antecedente. Los 17 detalles de cobertura y las dos identidades recibieron dictamen individual INCONCLUSA el 29/10; ya no quedan por dictaminar en esta tanda. Consultar `documentacion/auditoria_corpus/procesados/correccion_campos_2026_10_28/casos_inconclusos_actuales.csv`. No equivale a cierre de vigencia ni autoriza P13/P14.
