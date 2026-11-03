# Instrucciones para el agente: auditoría de vigencia de BecasFind

## Constitución conciliada en catálogo — 3 de noviembre de 2026

La ficha 357 muestra el cierre oficial del 3 de mayo de 2026 y cobertura de 100.000 o 200.000 pesos según el lugar de estudios. Se conservan las 528 fichas y los UUID. Catálogo comprobado: 133 cerradas, 11 abiertas, 282 con fechas por confirmar y 102 en revisión.

Cola vigente: documentacion/auditoria_corpus/procesados/seguimiento_incertidumbres_31_2026_11_02/incertidumbres_102.csv. Evidencia, límites y aplicación: documentacion/auditoria_corpus/procesados/seguimiento_incertidumbres_31_2026_11_02/RECONSULTA_2026_11_03.md y verificacion_constitucion_357.json. Las cifras de los cortes siguientes son históricas.

## Seguimiento de 31 fichas aplicado — 2 de noviembre de 2026

**31 seguimientos individuales, siete fichas modificadas y cinco dictámenes precisados**: Paine (51/378) y UDD NEM (158) sin calendario publicado; UANDES Funcionario (331) y Armada (376) con anuncio de postulaciones cerradas. Los Muermos (127) incorpora reglamento histórico de 2022 sin extrapolarlo; Constitución (357) corrige su enlace municipal. Quedan **103 inconclusas**: 26 de esta tanda y 77 no reconsultadas aquí. Siete consultas limitadas: 218, 231, 240, 248, 312, 513, 515. No se declara concluida la investigación.

Catálogo público verificado: **528 fichas; 11 abiertas, 132 cerradas, 282 fechas por confirmar y 103 en revisión**. Cero activaciones/eliminaciones. 528 UUID y originales conservados; 521 filas ajenas y 13 tablas idénticas. Respaldo/restauración de 14 tablas aprobados. El intento inicial de renombrado de Paine se revirtió por restricción única; el bloque aplicado conserva nombres. Solo se actualizó el recurso backend de 103 UUID; clases/dependencias y temporizador FUAS sin cambios.

Fuente vigente: `documentacion/auditoria_corpus/procesados/seguimiento_incertidumbres_31_2026_11_02/INFORME.md`, `avance.json`, `inventario_466.json`, `incertidumbres_103.csv`, `revision_31.csv` y `consultas_limitadas_7.csv`.

- [x] Documentar 31 seguimientos y aplicar/verificar siete correcciones sustentadas.
- [ ] Resolver las 103 incertidumbres según el campo y límite individual; no sustituir evidencia faltante por probabilidad.
- [ ] Recuperar fuentes suficientes para las siete consultas limitadas actuales y reconsultar las otras 77 inconclusas.

No repetir los SQL aplicados de 54, 96 o siete ni ejecutar el intento revertido. Ante nueva evidencia, nuevo bloque con respaldo y guardas. P13/P14 y promoción a producción no iniciadas. Los encabezados siguientes son cortes históricos.

## Incertidumbres: tanda de 96 aplicada — 2 de noviembre de 2026

Aplicadas y verificadas **96 fichas adicionales**: nueve dictámenes precisados y 87 inconclusos; ocho consultas limitadas por acceso o recuperación parcial. Las 150 reabiertas tienen ahora notas de reconsulta (54 + 96): **42 dictámenes precisados y 108 inconclusos**. Esto no significa que todas las convocatorias actuales estén leídas o que todos los campos estén resueltos.

Catálogo verificado: **528 fichas; 11 abiertas, 132 cerradas, 277 fechas por confirmar y 108 en revisión**. Cero activaciones/eliminaciones en esta tanda. 528 UUID y originales conservados; 432 fichas y 13 tablas ajenas idénticas, respaldo/restauración de 14 tablas aprobado. Solo se publicó el recurso backend de 108 UUID; clases y dependencias idénticas. Temporizador FUAS de siete UUID sin cambios.

Fuente vigente: `documentacion/auditoria_corpus/procesados/reconsulta_incertidumbres_96_2026_11_02/INFORME.md`, `inventario_466.json`, `avance.json`, `incertidumbres_108.csv` y `consultas_limitadas_8.csv`. No repetir el SQL de 96 ni el de 54; no regenerar expedientes aplicados con borradores de `tmp/`. P13/P14 y promoción a producción no iniciadas.

- [x] Aplicar y verificar las 96 notas/correcciones, preservando UUID y originales.
- [x] Precisar cinco adjudicaciones 2026, Talcahuano sin cupos y calendario cerrado de Tucapel y prestaciones publicadas de Huasco/Monte Patria.
- [ ] Recuperar fuentes actuales suficientes para las ocho consultas limitadas (68, 202, 218, 240, 248, 312, 357, 463).
- [ ] Resolver los campos sustentables de las 108 inconclusas según su límite individual; conservar desconocidos y contradicciones cuando no haya prueba pública suficiente.

Los encabezados siguientes conservan cortes históricos y no sustituyen este estado.

## Incertidumbres: primer bloque de 54 aplicado — 2 de noviembre de 2026

Investigación reabierta sobre 150 fichas: **54 con nueva revisión individual; 33 dictámenes precisados y 21 inconclusos; 96 sin nueva revisión individual todavía**. Aplicadas y conciliadas las 54; tres activaciones (Nuevo Milenio II y dos fichas BEA Mineduc) con cierre automático FUAS del 05/11/2026 a las 14:00 de Santiago. Catálogo comprobado: **528 fichas; 11 abiertas, 131 cerradas, 269 fechas por confirmar y 117 en revisión**. Cero eliminaciones y 528 UUID preservados.

Fuente vigente: `documentacion/auditoria_corpus/procesados/resolucion_incertidumbres_150_2026_11_02/INFORME.md`, `inventario_466.json`, `avance.json`, `sin_reconsulta_96.csv` e `incertidumbres_117.csv`. Las cifras de las secciones anteriores son históricas. No repetir el SQL de 54 ni regenerar el expediente aplicado con los borradores de `tmp/`. Los 33 dictámenes precisados no significan 33 fichas sin incógnitas. P13/P14 no iniciadas.

- [x] Aplicar y comprobar el bloque de 54 con respaldo/restauración de 14 tablas y originales conservados.
- [ ] Reconsultar individualmente las 96 restantes y continuar con las contradicciones de las 21 inconclusas de este bloque.
- [ ] Completar la petición de resolver todas las incertidumbres sustentables; conservar explícitamente los datos que la fuente no publique.

Los apartados siguientes conservan los cortes anteriores y no sustituyen el estado de este encabezado.

Estado al 01/11/2026: la tanda de 177 está documentada y aplicada en `documentacion/auditoria_corpus/procesados/cierre_vigencia_177_2026_11_01/`. Conserva 150 conclusiones inconclusas, sin fichas de esa tanda sin dictamen. Leer su `INFORME.md` antes de reabrir casos o repetir operaciones; estas instrucciones son el método, no una orden para volver a ejecutar SQL ya aplicado.

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
