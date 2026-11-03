# Publicación de 102 aclaraciones en BecasFind

El 3 de noviembre de 2026 se publicaron aclaraciones en las 102 fichas en revisión. Cada nota indica la evidencia disponible y el límite de esa evidencia para la modalidad de la ficha. El detalle muestra la nota antes de los antecedentes originales.

La actualización añadió únicamente la nota a la descripción larga e incrementó la versión de cada ficha. Se aplicó en una transacción con comprobaciones de UUID, versión y huella de la descripción anterior. El respaldo se verificó mediante restauración aislada de 14 tablas. Las otras 426 fichas y 13 tablas se conciliaron sin diferencias. Se conservaron todas las descripciones anteriores y el temporizador FUAS.

Se comprobaron las 102 notas por UUID desde la API pública con el origen de la preview. El catálogo devuelve 528 fichas: 133 cerradas, 11 abiertas, 282 con fechas por confirmar y 102 en revisión. La búsqueda estricta devuelve 11 abiertas.

- `aclaraciones_publicadas_102.json` conserva el texto publicado por UUID.
- `verificacion_aclaraciones_102.json` registra el resultado público por ficha.
- `incertidumbres_102.csv` conserva las incógnitas de cada modalidad.

La publicación informa de los límites de la evidencia existente. Cada ficha conserva su dictamen de vigencia y sus campos de postulación. El bloque de datos ya aplicado tiene SHA-256 `7806d64e74271927a42b2196dd9acd841f0274735c9a207291c1a5b4ed5c7b03`.
