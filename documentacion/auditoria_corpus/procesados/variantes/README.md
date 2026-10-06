# Grupos de referencias históricas

Al 2 de octubre de 2026 hay 59 candidatos que aparecen más de una vez: reúnen 138 referencias. Son 79 referencias adicionales respecto de conservar una por candidato. No son 59 becas nuevas ni 59 duplicados demostrados.

La agrupación usa la identidad ya calculada por nombre e institución normalizados. Por ejemplo: «Aporte Económico para Educación Superior» de Santiago aparece tres veces. Un cambio de nombre puede dejar una beca equivalente fuera de estos grupos; la revisión de alias sigue siendo necesaria.

Los 59 grupos tienen al menos un campo distinto. Una diferencia puede ser de escritura o descripción; también puede afectar monto, requisitos, fechas o URL. El comparador no decide qué versión es correcta ni considera que un valor repetido sea una prueba oficial.

- `grupos.csv`: las 59 identidades; cantidad de referencias y campos distintos.
- `referencias.json`: valores de cada referencia y su archivo y registro de origen. Las filas malformadas sustituidas por reconstrucciones no se cuentan dos veces.
- `resumen.json`: conteos reproducibles.

Los 59 grupos están cerrados al 6 de octubre: 29 conciliados y 30 excluidos editorialmente; cero pendientes. `conciliaciones.json` contiene las decisiones activas por identidad y campo discrepante. Diez grupos ya confirmados se resolvieron en [conciliación final](CONCILIACION_FINAL_10.md). Las dos conciliaciones previas de Deportiva UV y UTalca se sustituyen por exclusión del candidato; sus decisiones anteriores y fuentes se conservan íntegramente en el [cierre editorial](../CIERRE_EDITORIAL_RESTANTES_291.md). No se cuenta un grupo como conciliado y excluido a la vez. Los originales permanecen intactos; ninguna decisión activa automáticamente una beca.

Reproducir desde la raíz: `python infra/report-corpus-variants.py`.


Cierre final: las exclusiones afectan todas las referencias del candidato; no certifican inexistencia ni concilian sus campos. Evidencia individual en [descartes.json](../descartes.json) y [cierre de 291 candidatas](../CIERRE_EDITORIAL_RESTANTES_291.md).
