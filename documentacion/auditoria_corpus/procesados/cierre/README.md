# Evidencia para el cierre editorial

La solicitud es cerrar las 568 candidatas y los 59 grupos. Este directorio permite recorrerlas sin perder identidades, referencias ni informes. La selección editorial está cerrada; las exclusiones no son confirmaciones.

`casos.csv` y `casos.json` contienen un caso por candidata: estado, institución, referencias originales o reconstruidas y revisiones relacionadas. Los extractos identificados por hash conservan la observación del informe. Si un informe no contiene ese hash, se indica expresamente; hay que consultar su sección o tabla y no atribuirle automáticamente todas sus fuentes.

`informe_conciliacion` enlaza la decisión de los 29 grupos conciliados. El generador comprueba que exista el informe y que el grupo esté conciliado; no convierte una comparación de variantes en confirmación esencial de la beca.

`informes.json` conserva hashes y URLs de los 50 informes enlazados actualmente en las revisiones individuales. `acceso_fuentes.json` conserva la comprobación del 2 de octubre de 2026 de los 438 enlaces de los primeros 24: 396 respuestas HTTP; 18 errores HTTP y 24 errores de acceso. Un HTTP 200 puede ser una plantilla vacía, un bloqueo o contenido de otro beneficio. Esta comprobación no sustituye lectura ni confirma requisitos, vigencia o identidad. Un error tampoco demuestra que la beca haya desaparecido.

Las fuentes nuevas de las confirmaciones se documentan en sus informes y evidencias de importación. La comprobación masiva es una fotografía de acceso, no se sobrescribe por volver a generar el inventario sin `--comprobar-acceso`.

`../confirmaciones_completas.json` contiene únicamente decisiones editoriales con alcance explícito, fuentes, informe y verificaciones de identidad, convocatoria, cobertura, requisitos, documentos y discrepancias. El generador rechaza confirmaciones incompletas o sin informe. Nunca convierte respuestas HTTP en confirmaciones.

`../confirmaciones_esenciales.json` registra el nuevo criterio autorizado: identidad, fuente oficial específica, beneficio y requisitos principales. Los documentos y el calendario no publicados no bloquean este cierre; permanecen desconocidos. No se certifican años futuros ni se publica una beca sin cierre confirmado. El inventario distingue `CONFIRMADA_ESENCIAL` de `CONFIRMADA_COMPLETA`.

Estado actual al 6 de octubre: 172 confirmaciones esenciales; dos exhaustivas; 394 exclusiones editoriales y cero candidatas pendientes. Grupos: 29 conciliados; 30 excluidos y cero pendientes. Diez conciliaciones nuevas; dos decisiones anteriores sustituidas por exclusión y conservadas íntegramente en [cierre final](../CIERRE_EDITORIAL_RESTANTES_291.md). Los descartes conservan originales y registros administrativos inactivos; no afirman inexistencia ni cuentan como confirmaciones. ../descartes.json contiene motivos; alcance y evidencia individual. No hubo activaciones.

Reproducir: `python infra/report-corpus-progress.py` y `python infra/audit-editorial-evidence.py`. Para comprobar acceso nuevamente: `python infra/audit-editorial-evidence.py --comprobar-acceso`.

Validación final: [conteos e integridad](../CIERRE_EDITORIAL_VALIDACION.json); 21 pruebas Python y compilación Maven con Java 17 aprobadas en esta entrega.
