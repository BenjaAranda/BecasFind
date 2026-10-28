# Instrucciones para el agente: auditoría de vigencia de BecasFind

Continúa en este repositorio hasta completar una auditoría individual de las becas
que quedaron inactivas por calendario desconocido o vigencia no acreditada. El objetivo
es recuperar todas las convocatorias realmente publicables mediante investigación
oficial suficiente. No hay una cuota de activaciones ni un resultado predeterminado.

## Contexto y límites

Lee AGENTS.md, tasks/contexto.md, PLAN_MEJORAS.md e infra/P12_DESPLIEGUE.md.
El corte del 27/10/2026 registra 528 fichas: 5 activas, 57 cerradas y 466 sin
vigencia acreditada. Reconstruye el estado actual antes de trabajar; estas cifras
son una referencia histórica. Las 466 no están descartadas ni demostradas como cerradas.
P12 está desplegada en preview; esta tarea amplía su revisión de catálogo, sin
invalidar las pruebas técnicas ya aprobadas. No iniciar P13/P14, promover producción,
comprar servicios ni crear recursos facturables. Coste objetivo $0.

Este agente asume la revisión del catálogo. No ejecutar importaciones o cambios
concurrentes con otro agente. Preservar originales, UUID, favoritos, evidencias y
los estados editoriales de las 526 esenciales y 2 completas. No reabrir los 40
descartes editoriales ni eliminar fichas por esta tarea.

## Primero: auditar la decisión anterior

Consulta en documentacion/auditoria_corpus/procesados/despliegue_p12/:

- CIERRE_SELECCION_2026_10_27.md.
- seleccion_publicacion_2026_10_27.json.
- conciliacion_oracle_2026_10_27.json y trazabilidad.json.
- fuentes_calendario_recuperadas_2026_10_26.json.

Para cada ficha objetivo, identifica qué evidencia sostiene la inactividad y qué
investigación falta. Descargar texto, obtener HTTP 200, encontrar palabras clave o
reutilizar una etiqueta anterior no equivale a leer una convocatoria. No certifiques
que las 466 están revisadas solo porque existe una decisión para cada una.

## Investigación individual

1. Relaciona UUID, ID administrativo y hash de candidata con su expediente editorial.
2. Lee la fuente oficial específica y busca la convocatoria actual del mismo programa.
   Consulta admisión, bienestar/DAE, noticias y bases oficiales pertinentes. Utiliza
   búsquedas dirigidas por institución, nombre, variantes y año; lee los resultados.
3. Confirma identidad, modalidad, población elegible, beneficio y calendario. Distingue
   postulantes nuevos, renovación y convocatorias de cursos o programas específicos.
4. No transfieras fechas entre años, modalidades o becas relacionadas. Las fechas de
   clases, matrícula, resultados o entrega de documentos no son automáticamente el
   cierre de postulación. Un proceso común como FUAS solo aplica a una ficha cuando
   la fuente oficial vincule expresamente ese beneficio al proceso correspondiente.
5. Si una URL falla, busca fuentes oficiales alternativas y documentos públicos.
   Una barrera técnica o búsqueda vacía no demuestra cierre ni inexistencia.
6. Si el expediente no publica calendario, registra exactamente esa limitación.
   No inventes fechas ni describas como abierta una beca cuya vigencia no se acredita.

Trabaja en lotes de 50 o más para organizar avances, con evidencia individual.
Prioriza fuentes institucionales que permitan resolver varias modalidades, pero
compara y registra cada modalidad por separado. Continúa con el siguiente lote sin
pedir confirmación rutinaria. No reduzcas el alcance a las fichas fáciles de investigar.

## Clasificación de la auditoría

Clasifica cada ficha, separadamente de su confirmación editorial y estado en la BD:

- VIGENTE_CON_CIERRE_CONFIRMADO: fuente acredita convocatoria actual y cierre no vencido.
  Registra también apertura futura cuando corresponda; no la llames abierta todavía.
- CERRADA_CONFIRMADA: fuente acredita cierre de la convocatoria identificada. Indica
  si solo se conoce la convocatoria histórica y falta comprobar una edición nueva.
- PERMANENTE_CONFIRMADA: fuente afirma explícitamente postulación permanente.
- CALENDARIO_POR_MODALIDAD: fuente define plazos por curso, sede u otra modalidad;
  especifica cuál y si la ficha actual realmente corresponde a ella.
- SIN_CALENDARIO_PUBLICADO: expediente consultado identifica la beca, pero no publica
  un calendario utilizable para acreditar vigencia actual.
- REVISION_INCONCLUSA: barrera de acceso, contradicción o falta de evidencia suficiente;
  registra las rutas investigadas y la siguiente acción concreta.

La regla vigente de publicación exige estado_activa=true y cierre confirmado no
vencido. No la cambies, no uses 31 de diciembre como relleno y no actives becas
permanentes sin cierre mediante fechas artificiales. Para esos casos entrega una
propuesta concreta de representación y visualización, separada de la implementación,
que requiera autorización explícita para modificar la regla arquitectónica.

## Evidencia y aplicación

Crea una carpeta nueva de auditoría; no sobrescribas las instantáneas iniciales.
Guarda JSON/CSV UTF-8 sin BOM, con una fila por UUID y estos campos mínimos:
hash de candidata, ID administrativo, nombre, institución, modalidad/año, estado previo,
evidencia anterior, clasificación nueva, fuentes oficiales específicas, fecha de consulta,
extracto breve o referencia a sección/página, apertura/cierre conocidos, zona horaria
cuando corresponda, razonamiento, limitaciones, propuesta de cambio y estado de aplicación.

Prepara cambios individualizados y revisables únicamente para fuentes concluyentes.
Aplica dentro de P12 las correcciones/activaciones que cumplan las reglas ya autorizadas,
con respaldo privado y restauración aislada comprobada antes de cada bloque, transacción,
guardas de estado previo y conciliación posterior. Conserva UUID y versionado de fichas.
Comprueba listado, filtros y detalle públicos por UUID después de aplicar. Para cierre
con hora concreta reutiliza el mecanismo existente tras revisarlo. No repitas scripts
ya aplicados ni sobrescribas cambios recientes sin comprobarlos. No cambies cuentas,
contraseñas, Gmail ni infraestructura técnica para realizar esta auditoría.

Si no hay acceso remoto, completa la investigación y genera el conjunto de cambios
con sus guardas; marca aplicación PENDIENTE. No afirmes que la BD cambió.

## Entrega y condición de cierre

Actualiza el avance tras cada lote: fichas objetivo, leídas individualmente, resueltas,
inconclusas, activables, activadas y pendientes de aplicar. Distingue métricas de revisión
y métricas reales de la BD; deben conciliar con la cohorte inicial. Versiona solo el trabajo
de esta auditoría con commits en español; conserva cambios ajenos y no fusiones el PR.

No cierres la auditoría con una clasificación automática masiva. Recorre la cohorte
completa. Si una ficha sigue inconclusa después de la investigación pertinente, conserva
ese estado y sus límites: no la presentes como cerrada ni como revisión concluyente.
Entrega el inventario de evidencia por beca, los cambios efectivamente aplicados,
los casos permanentes/por modalidad que requieren decisión de producto y los bloqueos
específicos que requieran intervención del usuario. No prometas un número de activaciones.
