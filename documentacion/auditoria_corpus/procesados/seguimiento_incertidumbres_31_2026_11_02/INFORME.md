# Seguimiento de 31 fichas · siete cambios aplicados

Fecha local: 2 de noviembre de 2026. Se revisaron individualmente 31 fichas de las 108 inconclusas anteriores. **Siete recibieron cambios comprobados y cinco dictámenes se precisaron**. Veintiséis conservan incertidumbres en esta tanda; otras 77 no se reconsultaron aquí. Quedan **103 inconclusas** y 47 dictámenes precisados acumulados en la cohorte reabierta de 150. No se declara concluida la investigación.

## Cambios sustentados

- **51 y 378 · Paine:** formulario y banner oficial 2026 identifican el programa y antecedentes exigidos. Importe, cupos y cierre no publicados; pasan a SIN_CALENDARIO_PUBLICADO. Se conservan ambos registros, nombres y UUID: la documentación no acredita dos programas distintos ni autoriza fusionarlos.
- **158 · UDD NEM:** se leyó la tabla cargada tras seleccionar Arquitectura Santiago, Admisión 2027: 30 % para NEM desde 6,7; 20 % entre 6,6 y 6,69; 10 % entre 6,3 y 6,59. No son porcentajes universales para todas las carreras. Se corrige la interpretación previa de tabla no publicada; porcentaje estructurado desconocido por variación de carrera/tramo. SIN_CALENDARIO_PUBLICADO, sin fechas inventadas.
- **331 · UANDES Hijo Funcionario:** ficha específica confirma 50 % del arancel anual para hijos de funcionarios Universidad/ESE bajo condiciones contractuales; Clínica tiene reglas distintas. No se confunde el descuento con la bonificación de puntaje. La página anuncia postulaciones cerradas; meses noviembre 2026/enero 2027 sin días y referencias Admisión 2026 delimitadas. CERRADA_CONFIRMADA.
- **376 · UANDES Armada:** 50 % del arancel anual, sin matrícula y con restricciones de ingreso, renovación y compatibilidad. Aviso actual de postulaciones cerradas; no se mezclan días históricos con meses de la próxima convocatoria. CERRADA_CONFIRMADA.
- **127 · Los Muermos:** reglamento oficial modificado de 2022 confirma históricamente NEM 5,5 y $350.000 anuales en dos cuotas. Se documenta la contradicción con el procedimiento que indicaba 5,3; no se extrapolan presupuesto, cupos ni vigencia a 2026. Sigue inconclusa; solo se añade nota documentada.
- **357 · Constitución:** se corrige el enlace a la ficha municipal específica operativa. La página identifica ayuda económica y proceso, sin importe, umbrales ni calendario. No se reconstruye un decreto inaccesible a partir del índice. Sigue inconclusa.

Las fuentes específicas, lectura realizada y límites de las otras 24 fichas constan en `revision_31.csv` y `revision_31.json`. Siete consultas limitadas se separan en `consultas_limitadas_7.csv`: 218, 231, 240, 248, 312, 513 y 515. Descarga, índice o acceso al portal no se presentan como lectura completa de convocatoria. Las demás lecturas están delimitadas por documento, sección y año; no implican agotar todas las fuentes posibles.

## Aplicación y verificación

Respaldo privado y restauración aislada de 14 tablas verificados antes de aplicar. El primer intento de renombrar ambas fichas Paine chocó con la restricción única de nombre/institución: la transacción completa se revirtió. Antes del segundo intento se comprobaron de nuevo las 14 tablas contra el respaldo. La versión aplicada conserva nombres y UUID. `intento_1_revertido.sql` es únicamente antecedente; no ejecutarlo.

Aplicadas siete filas en una transacción con guardas de versión, UUID y texto original. **521 filas ajenas y 13 tablas idénticas; 528 UUID y originales conservados. Cero activaciones y eliminaciones.** Temporizador FUAS sin cambios. Los recibos conservan la secuencia: el recibo de base dice publicación pendiente porque precede al posterior recibo de publicación y verificación externa.

Catálogo público comprobado anónimamente: **528 fichas: 11 abiertas, 132 cerradas, 282 con fechas por confirmar y 103 en revisión**. Se verificaron listado completo, siete detalles modificados, sus campos, origen CORS de la preview y búsqueda estricta de 11 abiertas. UANDES se clasifica documentalmente cerrada por su aviso; al faltar días exactos conserva la etiqueta pública «Fechas por confirmar», explicada en la nota. No se inventan fechas para cambiar una etiqueta.

El empaquetado backend cambia exclusivamente el recurso de 103 UUID; clases Java y dependencias idénticas. Frontend y preview conservados. Sin promoción a producción ni inicio de P13/P14. No se repitieron baterías de pruebas de la aplicación.

**No repetir** `aplicar_bloque_7.sql`, SHA256 `f260576c2e51026caafbdf09f7b27facce8c67a06779d291e5c684a64405c75e`, ni los bloques anteriores aplicados. Para nuevas fuentes crear un bloque nuevo con respaldo y guardas nuevos. Los generadores usados de `tmp/` no deben regenerar este expediente.
