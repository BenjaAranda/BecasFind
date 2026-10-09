# Plan de cierre de la revisión esencial de becas

Actualizado el 8 de octubre de 2026 por petición del usuario. Sustituye el método de selección y cierre anterior de P04. El único listado de pendientes continúa en [PLAN_MEJORAS.md](../PLAN_MEJORAS.md). El replanteamiento inicial modificó únicamente la planificación. La ejecución comenzó con la cola de 157 y la lectura visual de Colchane; no se han registrado confirmaciones nuevas, exclusiones, importaciones ni activaciones en este bloque.

## Diagnóstico y punto de partida

Hay 568 identidades candidatas: 412 confirmaciones esenciales; dos completas; 111 pendientes y 43 exclusiones históricas sin ratificar. La cola real contiene ahora 154 candidatas sin resolver; el archivo de cola conserva las 157 de partida. Son registros candidatos, no necesariamente 568 programas distintos. Las 647 referencias originales tampoco son 647 becas distintas.

Los últimos informes anunciaron 51 y 50 candidatas, pero produjeron una y dos confirmaciones nuevas respectivamente. El primer archivo de revisiones contiene 50 aclaraciones y documenta la recuperación adicional por separado. Los dos archivos de revisiones comparten cuatro candidatas. Las dos fichas de Paine corresponden a un programa. El volumen de consultas no demuestra progreso de cierre.

El fallo del método consiste en seleccionar lotes grandes sin identificar previamente el dato esencial que falta y volver a consultar páginas generales que ya no resolvían ese dato. Además, las cifras originales y las condiciones exactas deben contrastarse sin exigir que el CSV sea literalmente correcto para poder confirmar el programa. La estadística heredada llama descartadas a las 43 exclusiones; durante este trabajo deben contarse entre los casos por resolver.

## Criterios de confirmación

| Control obligatorio | Evidencia suficiente | Lo que no basta |
|---|---|---|
| Identidad | Institución y programa o modalidad identificables en la fuente; correspondencia documentada con la candidata | Sustituir por la beca más parecida o asumir equivalencia por nombre |
| Fuente | Página, convocatoria o documento oficial específico cuyo contenido se haya leído | HTTP exitoso, portada, resultado de búsqueda o URL sin lectura |
| Beneficio | Qué entrega o financia: arancel, matrícula, aporte económico, alimentación, residencia u otro apoyo descrito | Inferir cobertura a partir del nombre; repartir un fondo total entre beneficiarios |
| Requisitos principales | Destinatarios y condiciones esenciales que la fuente establece para esa modalidad | Trasladar requisitos desde otra beca, institución o año |

No bloquean por sí solos: importe exacto, porcentaje, periodicidad, umbral numérico de RSH/NEM, documentos y fechas no publicados. Se conservan desconocidos con límites explícitos. Si un umbral es necesario para distinguir modalidades o resolver una contradicción de elegibilidad, sí debe aclararse. No se certifica una lista completa de requisitos cuando solo se acredita su alcance principal.

Si el programa está identificado y una cifra original está contradicha, registrar valor anterior, corrección y fuente; esa discrepancia corregible no mantiene toda la beca bloqueada. Si la cifra no tiene respaldo, dejarla desconocida. Si cambian institución, nivel, modalidad o destinatarios y no está demostrada la correspondencia, no sustituir la candidata por otro programa.

Una fuente histórica puede cerrar la confirmación esencial de su convocatoria con año explícito. No acredita vigencia actual. La publicación exige por separado cierre confirmado no vencido y estado activo. No se inicia despliegue ni se activa ninguna beca.

## Secuencia de trabajo

### 1. Preparar una sola cola de 157 candidatas

- [x] Unir las 114 pendientes y las 43 exclusiones sin ratificar mediante sus hashes, sin modificar sus estados. [Cola de 157](../documentacion/auditoria_corpus/procesados/COLA_REVISION_ESENCIAL_157_2026_10_08.md).
- [ ] Para cada candidata registrar los cuatro controles: respaldado, contradicho o falta evidencia; enlazar el apartado y el informe existentes.
- [ ] Identificar el único próximo paso útil: leer apartado pendiente, recuperar documento, resolver identidad/modalidad o localizar fuente específica. Agrupar por institución y fuente compartida.

Aceptación: 157 hashes distintos; ninguna exclusión heredada queda fuera; cada caso tiene una carencia concreta y una acción distinta de repetir una búsqueda genérica. Dependencia: inventarios actuales. Verificación exclusivamente documental.

### 2. Resolver primero lo que ya tiene evidencia recuperable

- [ ] Seleccionar bloques de 30 candidatas por petición del 9 de octubre de 2026 por institución/programa y disponibilidad de evidencia; objetivo de entrega: al menos 30 confirmaciones nuevas, sin imponer resultados sin respaldo.
- [ ] Leer una vez cada fuente compartida y mapear sus apartados a las candidatas; aprovechar los datos y documentos ya reunidos.
- [ ] Corregir discrepancias del mismo programa y cerrar los cuatro controles esenciales sin reconstruir calendario anual ni documentación exhaustiva.

Aceptación: cada confirmación tiene evidencia individual de los cuatro controles y límites; las correcciones no sustituyen programas. Dependencia: paso 1. Verificación: comparación con contenido oficial leído.

Punto de control tras las primeras diez candidatas: si no aparecen cierres, revisar el tipo de bloqueo y cambiar fuente o método antes de recorrer las restantes del bloque. Este control es interno; no convertirlo en una entrega de una o dos confirmaciones. Una consulta repetida sin evidencia nueva no cuenta como avance.

### 3. Resolver acceso difícil y variantes dentro del mismo bloque

- [ ] Ante fallo de extracción, leer la página en navegador o las páginas pertinentes del PDF; usar otra publicación o archivo oficial cuando exista. Un fallo de acceso no equivale a inexistencia.
- [ ] Comparar variantes juntas: institución, programa, modalidad, año, beneficio y destinatarios. Conservar modalidades distintas y separar condiciones de años distintos.
- [ ] Para casos todavía bloqueados, registrar el hecho esencial exacto que falta y la siguiente fuente concreta a obtener; no volver a cerrar otro lote con la misma aclaración genérica.

Aceptación: toda conciliación tiene correspondencia explícita; toda carencia es individual y concreta. Dependencia: paso 2. Verificación documental. Los 59 grupos se comprueban según las candidatas afectadas; ni las conciliaciones ni las exclusiones antiguas se aceptan sin evidencia. Si únicamente la institución puede resolver un hecho, identificar esa necesidad; enviar consultas requiere autorización aparte.

### 4. Registrar resultados y continuar hasta agotar la cola

- [ ] Actualizar los registros existentes una sola vez al cerrar el bloque; conservar originales y respaldar antes de modificar evidencias.
- [ ] Informar por separado candidatas confirmadas nuevas, programas distintos identificados, variantes resueltas, correcciones y casos todavía sin evidencia esencial. Si no se conoce el número de programas, no inventarlo.
- [ ] Comprobar coherencia de conteos, fuentes, enlaces, UTF-8 y cambios documentales; commit en español y subida a GitHub. No ejecutar pruebas de backend/frontend ni importaciones durante esta revisión.

Aceptación: 568 candidatas contabilizadas sin doble conteo y reducción real de las 157 por decisiones respaldadas. Dependencia: pasos 2 y 3; repetirlos con el siguiente bloque. El cierre global exige que cada caso tenga resolución sustentada o una carencia esencial individual explícita; no permite llamar confirmado a un caso sin evidencia ni descartarlo para vaciar la cola.

## Reglas de seguimiento

No publicar otro informe de cincuenta intentos como si fueran cincuenta confirmaciones. Priorizar cierres y completar el bloque antes de informar. Si la evidencia impide alcanzar treinta confirmaciones, explicar los bloqueos concretos y el cambio de método; no rellenar el objetivo con duplicados, exclusiones o confirmaciones repetidas. No prometer que todas las candidatas serán confirmables antes de conocer sus fuentes.

Los resultados de informes anteriores siguen como antecedentes. Este plan cambia el proceso, no rebaja el requisito de evidencia oficial ni reabre trabajo del backend, frontend o despliegue.

## Contraste iniciado el 8 de octubre de 2026

Bloque inicial de 50: tres confirmaciones históricas nuevas (Nueva Imperial 2024, Santa Cruz 2020 y programa de Requínoa con reglamento 2014); 47 sin cierre esencial. [Informe individual](../documentacion/auditoria_corpus/procesados/REVISION_BLOQUE_ESENCIAL_50_2026_10_08.md). Total: 412 esenciales, dos completas, 111 aclaraciones y 43 exclusiones antiguas sin ratificar; 154 por resolver. El objetivo de treinta cierres sigue abierto.

La selección inicial no garantizaba documentos suficientes: varias rutas corresponden a deportes, convenios o becas estatales. Antes del siguiente bloque deben distinguirse esas modalidades y buscarse el documento específico; repetir esas páginas no constituye progreso. Los intentos de acceso están diferenciados de lectura. No se ejecutaron pruebas de aplicación.

## Ejecución del 9 de octubre de 2026

Se contrastaron 107 candidatas adicionales en bloques de 30, 30, 30 y 17. Se recuperó contenido de 68 de 77 enlaces distintos; nueve fallaron. Recuperar contenido no equivale a confirmar. Los informes separan programas diferentes, fuentes generales y carencias esenciales. La revisión no permite dar por confirmadas todas las candidatas; deben resolverse las correspondencias documentadas. Quality quedó corregido con `source-map-js` 1.2.2: audit sin vulnerabilidades, lint y compilación local correctos; ejecuciones GitHub 38004778577 y 38004772848 satisfactorias.
