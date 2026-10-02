# Evidencia para el cierre editorial

La solicitud es cerrar las 568 candidatas y los 59 grupos. Este directorio permite recorrerlas sin perder identidades, referencias ni informes. No declara terminado ese trabajo.

`casos.csv` y `casos.json` contienen un caso por candidata: estado, institución, referencias originales o reconstruidas y revisiones relacionadas. Los extractos identificados por hash conservan la observación del informe. Si un informe no contiene ese hash, se indica expresamente; hay que consultar su sección o tabla y no atribuirle automáticamente todas sus fuentes.

`informe_conciliacion` enlaza la decisión de los trece grupos cerrados. El generador comprueba que exista el informe y que el grupo esté conciliado; conserva pendiente la confirmación completa de la beca cuando corresponda.

`informes.json` conserva hashes y URLs de 26 informes: los 24 de la primera pasada, el contraste del reglamento escaneado Duoc y el lote de 26 candidatas por fuentes compartidas. `acceso_fuentes.json` conserva la comprobación del 2 de octubre de 2026 de los 438 enlaces de los primeros 24: 396 respuestas HTTP; 18 errores HTTP y 24 errores de acceso. Un HTTP 200 puede ser una plantilla vacía, un bloqueo o contenido de otro beneficio. Esta comprobación no sustituye lectura ni confirma requisitos, vigencia o identidad. Un error tampoco demuestra que la beca haya desaparecido.

Las fuentes nuevas de las confirmaciones se documentan en sus informes y evidencias de importación. La comprobación masiva es una fotografía de acceso, no se sobrescribe por volver a generar el inventario sin `--comprobar-acceso`.

`../confirmaciones_completas.json` contiene únicamente decisiones editoriales con alcance explícito, fuentes, informe y verificaciones de identidad, convocatoria, cobertura, requisitos, documentos y discrepancias. El generador rechaza confirmaciones incompletas o sin informe. Nunca convierte respuestas HTTP en confirmaciones.

Estado actual: dos confirmaciones documentales con alcance explícito —Dalcahue superior 2026 y BUCH ingreso 2027—; 566 candidatas pendientes. Trece grupos USM/UCN/UV/UANDES/UTalca/UFT conciliados por identidad y decisiones de los campos discrepantes; 46 grupos pendientes. La conciliación no certifica todos los requisitos de esas becas. Las fichas siguen inactivas. Sus límites y datos desconocidos permanecen expresos.

Reproducir: `python infra/report-corpus-progress.py` y `python infra/audit-editorial-evidence.py`. Para comprobar acceso nuevamente: `python infra/audit-editorial-evidence.py --comprobar-acceso`.
