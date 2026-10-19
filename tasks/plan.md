# Método vigente de revisión esencial

Actualizado el 19 de octubre de 2026. Alcance y estado global: [PLAN_MEJORAS.md](../PLAN_MEJORAS.md). Contexto mínimo para retomar: [contexto.md](contexto.md).

## Punto de partida

Quedan **40 candidatas**: 28 aclaraciones y 12 exclusiones históricas sin ratificar. La cola única es `documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv`. Sus fuentes e informes ya consultados deben leerse antes de repetir consultas. La cifra de 132 es histórica; no reconstruir esa cola desde un informe antiguo.

## Ejecución

1. Agrupar las pendientes por institución. Extraer del registro la identidad alegada, el hecho esencial faltante y los documentos ya leídos. Cargar solo esos apartados.
2. Elegir una acción nueva que pueda resolver el hecho: recuperar bases enlazadas, abrir un decreto, leer un apartado pendiente o localizar otra publicación oficial específica. No volver al mismo catálogo general sin una pista nueva.
3. Leer una vez cada fuente compartida. Identificar institución, programa/modalidad y año. Registrar qué beneficio y destinatarios publica. Corregir datos contradichos del mismo programa; no sustituirlo por otro parecido.
4. Confirmar esencialmente cuando la fuente específica demuestra identidad y existencia. Investigar los campos restantes en fuentes oficiales; los que el expediente no publique quedan «No especificado», con año y alcance. La falta de importe, documentos o calendario no bloquea por sí sola. La falta de identidad sí.
5. Resolver variantes por modalidad y convocatoria. Duplicidad o falsedad requieren evidencia positiva individual. Preservar originales; no descartar por error HTTP, antigüedad o ausencia en búsqueda.
6. Actualizar el informe pertinente y sus registros una sola vez por bloque de decisiones. No crear otro informe si solo repite la carencia existente. Diferenciar consultas, cierres esenciales nuevos, descartes y variantes resueltas.
7. Comprobar coherencia con `python infra/audit-editorial-evidence.py`, regenerar el avance con `python infra/report-corpus-progress.py`, revisar cambios y subir un commit en español. No ejecutar pruebas de aplicación durante la revisión documental.

## Control de rendimiento

- Trabajar el conjunto restante agrupado; no convertir cada consulta en una entrega de una o dos candidatas.
- Si diez casos seguidos no producen evidencia nueva, cambiar la fuente o la técnica. No recorrer otra vez el mismo ciclo de búsquedas.
- Limitar salidas de herramientas al dato necesario. Consultar primero el resumen y luego los hashes en curso; evitar volcar CSV completos con notas acumuladas.
- No usar Firecrawl. Usar búsqueda web y lectura oficial directa; verificar contenido, no solo HTTP o fragmentos del buscador.
- Si solo una institución puede resolver la identidad, registrar el documento o respuesta exacta que falta. No enviar consultas sin autorización ni declarar confirmación por agotamiento de búsquedas.

## Cierre

Cada cierre exige evidencia individual enlazada. Una revisión sin evidencia nueva no cambia el conteo. No hay cierre global mientras existan candidatas sin resolución respaldada. La confirmación histórica y la vigencia publicable se verifican por separado; no activar, importar ni desplegar durante esta tarea.

El [método acumulado anterior](../documentacion/historial/PLAN_REVISION_ANTES_CONSOLIDACION_2026_10_19.md) se conserva solo para trazabilidad.
