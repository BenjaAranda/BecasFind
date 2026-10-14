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

## Confirmaciones registradas el 9 de octubre

Estado actual del 9 de octubre: [ocho confirmaciones nuevas con correcciones individuales](../documentacion/auditoria_corpus/procesados/CONFIRMACIONES_MUNICIPALES_2026_10_09.md). Total: **420 esenciales, dos completas y 146 sin resolución esencial** (104 aclaraciones y 42 exclusiones sin ratificar). Dos candidatas de Machalí corresponden a un programa. Se revierte la exclusión de alimentación UPLA, con historial conservado. La cohorte de 291 queda en 187 esenciales y 104 aclaraciones. [Lista única de pendientes actuales](../documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv). No se ha completado la meta de treinta cierres ni la revisión global. Quality del commit anterior aprobado en sus dos ejecuciones de GitHub.

Actualización posterior del 9 de octubre: [diagnóstico individual de las 146 pendientes](../documentacion/auditoria_corpus/procesados/DIAGNOSTICO_INDIVIDUAL_146_2026_10_09.md). Se cotejan 170 referencias y se identifican 14 candidatas con campos contradictorios. [21 grupos de variantes conciliados](../documentacion/auditoria_corpus/procesados/variantes/CONCILIACION_VARIANTES_21_2026_10_09.md): total 43 de 59; quedan 13 grupos y tres exclusiones históricas sin ratificar. [Comparación de 21 pares de nombres](../documentacion/auditoria_corpus/procesados/DECISIONES_ALIAS_2026_10_09.md): 15 recomendaciones individuales de consolidación del catálogo revisado; Nuevo Milenio I/II separados; cinco pares sin equivalencia resuelta. Relectura de cuatro fuentes institucionales para 11 candidatas y del catastro municipal completo para otras cinco; la descarga incompleta de Lebu queda resuelta. No se suman nuevas confirmaciones: continúan 420 esenciales, dos completas y 146 sin resolución esencial. Ningún original eliminado. Quality del último commit `00a1cc1`: dos ejecuciones aprobadas. Pendiente: comprobar los programas que faltan; consolidar los alias documentados al preparar el catálogo; resolver las 16 variantes restantes; verificar cierres vigentes antes de activar. Sin despliegue.

La recuperación pública de noticias y archivos municipales permitió leer fuentes específicas que no aparecieron en el método anterior. Las bases de Los Lagos se leyeron visualmente; las de Illapel 2026 publican beneficio, exclusiones y cronograma. Para las confirmaciones históricas se conserva expresamente el año de la fuente. Las restantes carencias están individualizadas en la lista unificada; no se ratifican exclusiones por ausencia de fuentes.

Estado de variantes al 9 de octubre: 22 grupos conciliados; 34 pendientes y tres exclusiones históricas sin ratificar (37 sin conciliación verificada). La comparación de alimentación UPLA queda cerrada con evidencia de rectoría 2011. No equivale a confirmar reglas actuales.


Consolidación documental del 9 de octubre: [15 alias aplicados y mapa completo de las 568 candidatas](../documentacion/auditoria_corpus/procesados/CATALOGO_DOCUMENTAL_CONSOLIDADO_2026_10_09.md). El catálogo contiene 553 fichas: 405 esenciales; dos completas; 146 sin resolución. Los conteos por candidata siguen en 420 esenciales y dos completas. Purranque: fuente municipal específica confirma 100.000 CLP por beneficiario en 2025; queda comprobar selección. No hubo importación, activación, eliminación ni despliegue.


Cierres posteriores del 9 de octubre: [Cartagena histórica 2025 y Mérito Deportivo de Punitaqui 2026](../documentacion/auditoria_corpus/procesados/CONFIRMACIONES_CARTAGENA_PUNITAQUI_2026_10_09.md). Total actualizado: 422 candidatas esenciales; dos completas; 144 sin resolución (102 aclaraciones y 42 exclusiones históricas sin ratificar). Catálogo: 553 fichas; 407 esenciales y dos completas. Los 15 alias conservan sus originales. Cartagena no mezcla el importe 2026 con requisitos 2025; Punitaqui queda deportiva y prohíbe pagar matrícula/arancel. Los dos controles de GitHub para eba37e4 concluyeron correctamente.


Actualización del 12 de octubre de 2026: 430 candidatas esenciales; dos completas; 136 pendientes. Cohorte 291: 197 esenciales y 94 aclaraciones. Catálogo: 553 fichas; 415 esenciales. Detalle: CONFIRMACIONES_MUNICIPALES_2026_10_12.md. Ningún original eliminado; sin importación, activación ni despliegue.

Lote de 50 candidatas contrastadas: ocho confirmaciones esenciales y 42 contrastes sin cierre; detalle individual en CONTRASTES_INDIVIDUALES_50_2026_10_12.md. No se descarta por ausencia ni se cuenta revisión parcial como confirmación.


### Continuación sin Firecrawl — 12 de octubre de 2026

Dos cierres esenciales históricos: Lota y Los Vilos. Contraste de fuentes de 59 candidatas; 57 sin cierre, incluidos fallos de acceso. Total vigente del seguimiento: 432 esenciales, dos completas y 134 pendientes (92 aclaraciones + 42 exclusiones históricas sin ratificar). Cohorte 291: 199 esenciales y 92 aclaraciones. Catálogo: 417 fichas esenciales de 553. Ningún original eliminado. Detalle: `REVISION_FUENTES_59_SIN_FIRECRAWL_2026_10_12.md`. No confundir contraste de fuentes con confirmación.


### Segundo lote sin Firecrawl — 12 de octubre de 2026

Se contrastaron 50 candidatas; dos cierres esenciales históricos nuevos: Coltauco y Taltal. Los otros 48 casos permanecen sin cierre, con carencias individuales actualizadas. Total: 434 esenciales, dos completas y 132 pendientes (90 aclaraciones + 42 exclusiones históricas sin ratificar). Cohorte 291: 201 esenciales y 90 aclaraciones. Catálogo: 419 fichas esenciales de 553. No se eliminó ningún original. Detalle: `REVISION_SEGUNDO_LOTE_50_SIN_FIRECRAWL_2026_10_12.md`.


## Seguimiento de confirmación de pendientes (12-10-2026)

Revisado íntegramente y confirmado en alcance histórico el expediente Colchane por Decreto 494/2023. Quedan 131 pendientes: 89 aclaraciones y 42 exclusiones históricas sin ratificar. Continúa pendiente el contraste individual de cada uno; no iniciar despliegue.


Actualización 12-10-2026: Colchane histórico 2023 y Excelencia Académica UMAG histórica 2017 revisados y confirmados esencialmente con límites documentados. Restan 130 pendientes (88 aclaraciones y 42 exclusiones históricas sin ratificar). No iniciar despliegue.

Actualización 12-10-2026: confirmación esencial histórica del Subsidio de Pasajes de La Serena para 2023 con ficha oficial de transparencia. Se corrigió el beneficio a entrega de pasajes y se conservaron como desconocidos el monto individual, el 60% exacto, la nota y el calendario posterior. El corpus queda en 437 confirmaciones esenciales, 2 completas y 129 pendientes (87 aclaraciones y 42 exclusiones históricas sin ratificar); cero descartes nuevos. Respaldo previo: `C:\Users\benja\Documents\BecasFind-respaldos\corpus-antes-la-serena-20261012.zip` (SHA-256 `7FF4958F2FB7A6C0F9F5F982445D768635D6BB65E79D284ED1E7CC58545F645E`). No iniciar despliegue.

Actualización 12-10-2026: tras incorporar expedientes cerrados después de ese corte, el estado verificable del corpus es 459 confirmaciones esenciales, 2 completas, 4 descartes con evidencia, 34 exclusiones históricas aún sin ratificar y 69 aclaraciones; total 103 pendientes de resolución. Esto reduce en 29 la cola que se informó como 132, pero no significa que se hayan resuelto todas. Se documentó un nuevo contraste de siete candidatas universitarias con fuentes institucionales; ninguna alcanzó confirmación esencial y permanecen pendientes. Informe: `documentacion/auditoria_corpus/procesados/CONTRASTE_UNIVERSITARIO_OFICIAL_2026_10_12.md`. Se regeneraron los reportes de avance/cierre y pasaron sus 12 pruebas y `git diff --check`. No ejecutar pruebas de aplicación ni iniciar despliegue.

Continuación del 12-10-2026: se contrastaron diez candidatas adicionales de IPCHILE, UDD, INACAP y USACH con los catálogos oficiales vigentes; se anotaron las incompatibilidades concretas y se preservó la diferencia entre un catálogo actual y un programa histórico. Ninguna fuente individualizó completamente las becas atribuidas, por lo que las diez continúan abiertas. Informe: `documentacion/auditoria_corpus/procesados/CONTRASTE_CATALOGOS_INSTITUCIONALES_2026_10_12.md`. El total no cambia: 459 confirmadas esenciales, 2 completas y 103 pendientes (69 aclaraciones y 34 exclusiones históricas sin ratificar).

Contraste adicional del 12-10-2026: el formulario municipal de Yumbel documenta la Beca de Residencia de Enseñanza Superior para Concepción en 2025, con RSH y antecedentes académicos, pero no confirma que sea la beca genérica DIDECO del registro ni las cifras allí atribuidas. Expediente: `documentacion/auditoria_corpus/procesados/CONTRASTE_YUMBEL_RESIDENCIA_2025_2026_10_12.md`. Se mantiene pendiente sin descartar ni mezclar modalidades. Conteo sin cambio.

### Continuación documental — 12 de octubre de 2026

Se cotejaron ocho candidatas adicionales con fuentes institucionales específicas de la Universidad Autónoma, UBO, UCSC, UTA y municipalidades de Santiago, Iquique y Concepción. Los resultados separan UAlumni de postgrado de una supuesta beca para segunda carrera; ayudas socioeconómicas de descuentos de arancel; residencia y alimentación UTA de una ayuda mensual general; y la beca artística Sixto Rojas de una beca general iquiqueña. Las ocho siguen abiertas porque la evidencia consultada no prueba que las prestaciones encontradas sean las mismas candidatas. Informe: `CONTRASTE_UNIVERSITARIO_MUNICIPAL_8_CANDIDATAS_2026_10_12.md`. Se actualizaron ocho referencias individuales en `revisiones_parciales.csv`. No se modificaron originales ni estados.


Contraste oficial adicional — 13-10-2026: se revisaron dos candidatas de Valdivia frente a publicaciones municipales de 2004–2005. Se documentó una beca de implementos escolares para educación media y un convenio USS dirigido a funcionarios y sus hijos, ambos distintos del subsidio general de mantención alegado. Las dos fichas permanecen individualmente abiertas; no se fusionan ni se eliminan. Informe: documentacion/auditoria_corpus/procesados/CONTRASTE_VALDIVIA_2_CANDIDATAS_2026_10_13.md. La cola sigue en 102 (69 aclaraciones y 33 exclusiones históricas sin ratificar).

Confirmación esencial histórica del 13 de octubre de 2026: María Elena — línea municipal “Beca municipal, enseñanza superior 2015”, con requisitos académicos/socioeconómicos publicados en transparencia municipal; monto, modalidad de pago, documentos y vigencia no verificados. Informe: `documentacion/auditoria_corpus/procesados/CONFIRMACION_ESENCIAL_MARIA_ELENA_HISTORICA_2026_10_13.md`. El contraste de Valdivia mantiene dos candidatas abiertas porque las fuentes oficiales encontradas describen beneficios escolares y descuentos a funcionarios, no el subsidio general del registro. Estado recalculado: 461 confirmaciones esenciales, 2 completas, 4 descartes con evidencia y 101 pendientes (68 aclaraciones + 33 exclusiones históricas sin ratificar). No activar ni desplegar.

### Cierre de contraste de pendientes — 13 de octubre de 2026

Se recorrieron individualmente las 98 candidatas que el reconstructor actual identifica como pendientes: 66 `REVISION_PARCIAL` y 32 exclusiones históricas sin ratificar. La cifra de 132 era un corte anterior; el conjunto vigente contiene 568 identidades, 464 confirmaciones esenciales, dos completas y cuatro descartes ratificados con evidencia. Los contrastes individuales de los 98 registros están enlazados en `revisiones_parciales.csv`, incluyendo cuatro informes publicados el 13/10 para bloques de 30, 30, 30 y 8 candidatas.

El contraste documental no cerró como confirmadas las 98: las fuentes oficiales encontradas para varios casos describen beneficios cercanos pero distintos; otros registros carecen de bases o convocatoria recuperable. No se trasladaron requisitos, montos o identidades entre modalidades; tampoco se descartó por una búsqueda sin resultado o por enlaces inaccesibles. Por tanto, el trabajo de contraste del conjunto actual está cubierto, pero el cierre probatorio queda pendiente para las candidatas que aún requieren correspondencia o fuente específica. No significa que la cola esté vacía ni autoriza publicar esos casos como vigentes.

Informes de este cierre: `CONTRASTE_COMPLEMENTARIO_30_CANDIDATAS_2026_10_13.md`, `CONTRASTE_COMPLEMENTARIO_30_CANDIDATAS_BLOQUE_2_2026_10_13.md`, `CONTRASTE_OFICIAL_30_PENDIENTES_BLOQUE_3_2026_10_13.md` y `CONTRASTE_OFICIAL_8_CANDIDATAS_PENDIENTES_BLOQUE_FINAL_2026_10_13.md`. Se regeneró el detalle por registro y se verificó coherencia con `infra/report-corpus-progress.py` y `git diff --check`. No se ejecutaron pruebas de aplicación, no se iniciaron despliegues, y se preservaron los originales.


### Actualización de la cola y descartes probados — 13 de octubre de 2026

El reconstructor vigente registra 72 pendientes entre 568 identidades; la cifra 132 corresponde a un corte anterior. El estado actual es 483 confirmaciones esenciales, 2 completas, 11 descartes ratificados con evidencia y 72 pendientes de cierre. Las 20 exclusiones históricas sin ratificar son parte de la cola pendiente, no casos ya resueltos. Se cerró la candidata de Universidad Central con fuente oficial específica; de las dos fichas de La Florida, una se mantiene pendiente y la otra se registra como duplicado porque los datos históricos coinciden y se conservan íntegros. En La Florida se descartó la Ordenanza 120 como fuente por corresponder a Florida, Biobío.

También se descartaron dos fichas UMayor con evidencia positiva: el reglamento 2026 enumera las becas institucionales y contradice el descuento deportivo de 25% y el beneficio emprendedor de 20% atribuidos; los apoyos deportivos reconocidos son de otra clase, y “Espíritu Emprendedor” es el nombre del sistema completo. Los originales permanecen intactos. Informes: `CONFIRMACION_ESENCIAL_UCENTRAL_BECAS_PRIMER_INGRESO_2026_10_13.md`, `REVISION_DUPLICADO_Y_DISTINCION_FLORIDA_2026_10_13.md` y `DESCARTE_RATIFICADO_UMAYOR_BECAS_DEPORTIVA_Y_TALENTO_2026_10_13.md`. Cola recalculada con `infra/report-corpus-progress.py`; pruebas documentales de progreso (11) y descarte (2) aprobadas. Quedan pendientes las 72 que no se pueden cerrar sin evidencia que resuelva su identidad, beneficio y requisitos esenciales. No se inició despliegue.


Actualización correctiva — 13 de octubre de 2026: la cola reproducible antes de esta continuación era de 71 pendientes, no 72. Se confirmó esencialmente la candidata municipal de Tocopilla con alcance limitado a la planificación oficial 2024 del Programa de Becas para la Educación Superior, que figura en etapa de Diseño y Construcción. La función municipal confirma una Beca Municipal con beneficios económicos, pero no publica monto, requisitos ni destinatarios específicos de la línea superior. No se certifican ejecución, asignación, convocatoria ni vigencia. Informe: `documentacion/auditoria_corpus/procesados/CONFIRMACION_ESENCIAL_TOCOPILLA_2026_10_13.md`. Recuento recalculado: 485 confirmaciones esenciales, 2 completas, 11 descartes ratificados y 70 pendientes (51 con revisión parcial + 19 exclusiones históricas sin ratificar). Pasaron 11 pruebas documentales y `git diff --check`; no se usó Firecrawl ni se inició despliegue.
