# Grupos de referencias históricas

Estado reconstruido al 9 de octubre: **22 grupos conciliados, 34 pendientes de conciliación y tres exclusiones históricas sin ratificar**. Total 59. Los 37 no conciliados siguen requiriendo revisión. La reconstrucción sustituye los conteos históricos de los párrafos siguientes: el inventario no se había regenerado después de varias reversiones anteriores. Alimentación UPLA se concilia con fuente de rectoría de 2011; alcance histórico, sin confirmar vigencia actual. [Decisión individual](CONCILIACION_ALIMENTACION_UPLA.md).

Corrección del 6 de octubre: el cierre masivo de 291 candidatas queda revertido. Los conteos y decisiones anteriores de este inventario son antecedentes del nuevo [plan de revisión](../../../../PLAN_MEJORAS.md). Se revisarán las 568 candidatas, incluidas las 103 excluidas anteriormente, con sus datos y fuentes existentes. No se descartará por información incompleta ni se forzará el cierre de un lote.

Al 2 de octubre de 2026 hay 59 candidatos que aparecen más de una vez: reúnen 138 referencias. Son 79 referencias adicionales respecto de conservar una por candidato. No son 59 becas nuevas ni 59 duplicados demostrados.

La agrupación usa la identidad ya calculada por nombre e institución normalizados. Por ejemplo: «Aporte Económico para Educación Superior» de Santiago aparece tres veces. Un cambio de nombre puede dejar una beca equivalente fuera de estos grupos; la revisión de alias sigue siendo necesaria.

Los 59 grupos tienen al menos un campo distinto. Una diferencia puede ser de escritura o descripción; también puede afectar monto, requisitos, fechas o URL. El comparador no decide qué versión es correcta ni considera que un valor repetido sea una prueba oficial.

- `grupos.csv`: las 59 identidades; cantidad de referencias y campos distintos.
- `referencias.json`: valores de cada referencia y su archivo y registro de origen. Las filas malformadas sustituidas por reconstrucciones no se cuentan dos veces.
- `resumen.json`: conteos reproducibles.

Trece grupos están conciliados: dos USM, tres UCN, dos UV, dos UANDES, tres UTalca y uno UFT. Quedan 46 pendientes. `conciliaciones.json` enlaza el informe individual de cada decisión de identidad y campo discrepante; los documentos no corroborados quedan desconocidos. Los informes también explican por qué PAES UANDES y Excelencia UFT continúan pendientes. Para cerrar un grupo hay que identificar el beneficio oficial; distinguir modalidades y años; contrastar los campos contradictorios y documentar la decisión. Los originales se mantienen intactos. Una conciliación no activa automáticamente la beca ni equivale por sí sola a confirmar todos sus requisitos.

Reproducir desde la raíz: `python infra/report-corpus-variants.py`.


Actualización del 6 de octubre: 21 grupos conciliados; nueve descartados editorialmente y 29 por resolver. Los descartes excluyen todas las referencias del candidato; no concilian sus campos ni eliminan originales. Evidencia: [primer lote](../DESCARTE_EDITORIAL_INSTITUCIONES_53.md) y [segundo lote](../DESCARTE_EDITORIAL_SEGUNDO_LOTE_50.md).
