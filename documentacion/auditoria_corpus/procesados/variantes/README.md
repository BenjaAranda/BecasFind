# Grupos de referencias históricas

Al 2 de octubre de 2026 hay 59 candidatos que aparecen más de una vez: reúnen 138 referencias. Son 79 referencias adicionales respecto de conservar una por candidato. No son 59 becas nuevas ni 59 duplicados demostrados.

La agrupación usa la identidad ya calculada por nombre e institución normalizados. Por ejemplo: «Aporte Económico para Educación Superior» de Santiago aparece tres veces. Un cambio de nombre puede dejar una beca equivalente fuera de estos grupos; la revisión de alias sigue siendo necesaria.

Los 59 grupos tienen al menos un campo distinto. Una diferencia puede ser de escritura o descripción; también puede afectar monto, requisitos, fechas o URL. El comparador no decide qué versión es correcta ni considera que un valor repetido sea una prueba oficial.

- `grupos.csv`: las 59 identidades; cantidad de referencias y campos distintos.
- `referencias.json`: valores de cada referencia y su archivo y registro de origen. Las filas malformadas sustituidas por reconstrucciones no se cuentan dos veces.
- `resumen.json`: conteos reproducibles.

Todos permanecen pendientes de conciliación. Para cerrar un grupo hay que identificar el beneficio oficial y su convocatoria; distinguir modalidades y años; contrastar los campos contradictorios; documentar qué referencias se conservan y cuáles describen otro beneficio. Los originales se mantienen intactos. Una conciliación no activa automáticamente la beca ni equivale por sí sola a confirmar todos sus requisitos.

Reproducir desde la raíz: `python infra/report-corpus-variants.py`.
