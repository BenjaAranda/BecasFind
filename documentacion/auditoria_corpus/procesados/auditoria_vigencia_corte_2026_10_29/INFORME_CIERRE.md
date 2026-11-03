# Auditoría de vigencia — cierre documental del corte 30/10/2026

La cohorte inicial de **466 UUID tiene dictamen individual**. Este es un cierre de corte con resultados inconclusos, no una certificación de todas las convocatorias ni una afirmación de investigación exhaustiva de Internet. Se conservan originales, UUID, fuentes, límites y todas las fichas del catálogo. No se descarta ninguna beca por falta de fechas.

| Resultado de la cohorte | Fichas | Alcance |
|---|---:|---|
| Vigente con cierre confirmado | 4 | Dos activadas antes y dos en esta entrega; postulación no garantiza adjudicación. |
| Convocatoria cerrada confirmada | 68 | Corresponde a la edición indicada; algunas son históricas. No acredita desaparición del programa ni ausencia de otra edición. |
| Calendario por modalidad | 88 | Matrícula, asignación automática, renovación, semestre o llamado particular; no implica recepción abierta hoy. |
| Sin calendario publicado en el expediente | 119 | Programa identificado; falta un calendario utilizable para acreditar recepción actual. |
| Revisión inconclusa | 187 | Barreras, contradicciones o evidencia insuficiente para acreditar la vigencia de esa modalidad. Se conservan visibles con información en revisión. |
| Permanente confirmada | 0 | No se verificó una recepción explícitamente permanente para una ficha de esta cohorte. No significa que no exista. |

Los 279 dictámenes delimitados no son 279 becas abiertas. La ausencia de calendario en un expediente no demuestra que nunca se haya publicado. Las 187 inconclusas tampoco son descartes, programas falsos ni cierres probados. No quedan filas sin dictamen en este corte; sí quedan incógnitas identificadas.

## Investigación y criterios

Se releyeron los razonamientos y límites individuales del inventario de 27/10, junto con las investigaciones ya documentadas. Se buscaron y leyeron fuentes primarias adicionales y se revisaron páginas pertinentes de escaneos. No se presenta esta relectura como 466 nuevas lecturas íntegras de fuentes. La fecha de consulta anterior se conserva cuando no hubo nueva consulta. Los cambios de criterio se registran en `nuevos_dictamenes.json`; cada fila de `inventario.json` conserva el resultado anterior para comparar.

La distribución de trabajo se puede consultar en `lotes.json`: ocho grupos de 50 y uno de 66. Esta organización y los conteos son mecánicos; las decisiones no se dedujeron de HTTP, palabras clave, OCR o número de descargas.

Se distinguieron las ediciones, las cuotas y las modalidades. No se transfirieron fechas de matrícula, resultados, rendición o pagos a la recepción. Se mantuvieron separados los UUID de variantes sin evidencia de duplicidad. Rauco y San Pedro de la Paz conservan su identidad inconclusa; las fuentes de Arauco y Melipilla no se utilizaron para activarlas.

## Decisiones adicionales y correcciones

- Pitrufquén: las bases de Pasajes de Excelencia 2026 fijan recepción del 20/07 al 20/08; no se tomó el plazo de Cultura. Fuente: [bases municipales, apartado V](https://www.mpitrufquen.cl/portal/publicaciones/2026/publicaciones/Postulacion_a_Becas_de_Pasajes_para_Estudiantes_de_Educacion_Superior_2026_6a5e6d15e3545/BASES_BECAS_ESTUDIANTES_2026.pdf).
- Maullín: la lectura visual del artículo 27, página 9, acredita recepción del 12/01 al 20/03/2026. Difusión y pagos son otras etapas. [Ordenanza municipal](https://munimaullin.cl/wp-content/uploads/2025/12/ordenanza-municipal-beca-ensen%CC%83anza-superior.pdf).
- Yungay: recepción documental del 09/03 al 31/03/2026 a las 13:00; agosto es acreditación de segunda cuota. [Reglamento 2026, apartados II y V](https://www.yungay.cl/wp-content/uploads/2026/03/Reglamento-Beca-Municipal-2026-PDF.pdf).
- Purranque: lectura visual del calendario de la página 3: 18/08–01/09/2026; la ceremonia de octubre no amplía el plazo. [Bases oficiales](https://purranque.cl/descargas/BASES-BECA-ED-SUPERIOR.pdf).
- Puerto Varas, Zapallar y Conchalí: los reglamentos permiten delimitar llamados semestrales o periodos variables; no prueban una convocatoria actual abierta. No se inventaron días de cierre. Coltauco remite los plazos a un decreto anual. Retiro acredita pagos históricos, no una nueva recepción. Las páginas y huellas están en `fuentes_documentales_leidas.json`.
- UMAG: las cinco modalidades se encuentran expresamente enumeradas en el calendario institucional. Se registró la segunda ventana 02/03–30/04/2026 y se conservó la primera en el texto. [Resolución 117/VRAC/2026, páginas 2 y 4](https://umag.cl/wp-content/uploads/2026/05/CalendarioAcademico2026.pdf).
- Juan Gómez Millas y Bicentenario: se conciliaron las fichas específicas con FUAS 2027 y su prórroga. Se activaron individualmente hasta el 05/11/2026 a las 14:00 de Santiago; sin inventar un filtro RSH equivalente a FUAS. [Ficha actual Juan Gómez Millas](https://www.ventanillaunicasocial.gob.cl/ficha/255/beca-juan-gomez-millas), [Bicentenario](https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-bicentenario-bb), [FUAS oficial](https://postulacion.beneficiosestudiantiles.cl/fuas/) y [hora de cierre UCEN](https://www.ucentral.cl/postulacion-fuas-2027/).
- U. Mayor mantiene anualidades contradictorias; Nuevo Milenio II conserva una referencia de acreditación anterior. No se activaron esas modalidades. La ficha BAB es una asignación automática futura; su fecha de resultados discordante sigue explícita.
- Se rectificaron cuatro etiquetas que no sustentaban un calendario por modalidad y se conservó inconclusa la contradicción de Mulchén. El cierre histórico del instructivo UNAB no resuelve sus condiciones ni un llamado posterior.

## Aplicación verificada

**56 fichas modificadas en esta entrega: 54 calendarios cerrados de 2026 y dos activaciones individualizadas.** Las tres aplicaciones de la auditoría anterior se conservan. No hubo eliminación, fusión, reimportación del catálogo ni cambios de requisitos numéricos sin fuente. Solo las dos becas ministeriales recibieron indicadores de primer ingreso y cursos superiores, de acuerdo con sus fichas.

Antes de cada bloque se hizo respaldo privado y restauración aislada de 14 tablas. Los SQL tienen guardas de UUID, versión, fechas e inactividad previas. Ambos bloques se conciliaron contra las 528 filas; conservaron los UUID y el texto anterior. Los SQL están aplicados: **no repetirlos**. Los recibos son `conciliacion_aplicacion.json` y `conciliacion_umag_5.json`.

El recurso de información en revisión se ajustó a los 187 UUID del dictamen. Backend compilado y publicado en la misma preview con reversión conservada, sin cambiar el frontend, el diseño, las credenciales o el correo. Maven compiló las fuentes y terminó correctamente; no se ejecutó una batería de pruebas ajena a la investigación. Se comprobaron listado anónimo, búsquedas por nombre, 56 detalles y CORS de la preview.

Al comprobar el 30/10, el catálogo conserva **528 fichas: 8 abiertas, 112 con cierre registrado vencido, 221 con fechas por confirmar y 187 en revisión**. Son métricas de la web, distintas de las clasificaciones documentales de la cohorte. BUCH fue excluida de abiertas por el temporizador del 30/10 a las 12:00; no es un descarte de esta auditoría. Su etiqueta genérica queda en fechas por confirmar durante el resto del día de cierre porque la representación pública compara fechas, mientras el temporizador controla la hora. Esta limitación de etiqueta no reabre su recepción.

El temporizador FUAS existente incluye ahora los cuatro UUID correspondientes y conserva el cierre del 05/11 a las 14:00. Una ejecución anticipada no desactivó las altas. No se cambió BR-VIGENCIA ni se iniciaron P13/P14.

## Inconclusas y reapertura

`inconclusas.csv` contiene los 187 casos, sus fuentes, fecha realmente consultada, motivo individual, límite y documento o acción que permitiría resolverlos. No se han convertido en exclusiones editoriales. Una barrera no demuestra cierre; un portal contaminado no se utiliza como prueba; una convocatoria homónima de otro nivel o comuna no sustituye al programa original.

El cierre de corte conserva esos resultados como inconclusos y no promete que se hayan agotado todas las fuentes públicas. Reabrir un dictamen exige información pertinente que resuelva su límite, o una petición de investigación adicional con alcance definido. No contactar instituciones ni utilizar Firecrawl.

Los beneficios automáticos, permanentes o con calendario por modalidad deben conservar su naturaleza y calendario real. La propuesta de producto es mostrar esos alcances en el catálogo informativo sin cierre artificial. Incorporarlos a postulaciones abiertas o recomendaciones sin cumplir BR-VIGENCIA requiere una decisión expresa; no se implementó aquí.

## Archivos de consulta

- `inventario.json` / `inventario.csv`: los 466 UUID con evidencia, clasificación anterior/nueva, motivo y aplicación.
- `inconclusas.csv`: los 187 resultados inconclusos, sin perder fuentes ni próximos documentos útiles.
- `calendarios_por_modalidad.csv`: 88 casos con sus límites por periodo o procedimiento.
- `avance.json`: métricas del corte; `verificacion_publica.json`: métricas y comprobaciones de publicación.
- `fuentes_iniciales_sha256.json`: las instantáneas iniciales no se sobrescribieron. El informe y generador de 27/10 son históricos; no regenerarlos para sustituir este corte.
