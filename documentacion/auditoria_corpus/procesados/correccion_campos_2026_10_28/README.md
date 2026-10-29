# Corrección de campos del catálogo — 28 de octubre de 2026

Se aplicaron cambios en **287 fichas** y se comprobaron públicamente las 528 entradas del catálogo. Se corrigieron **286 categorías**: 285 estaban sin especificar y una estaba equivocada. También se recuperaron tres beneficios que habían quedado vacíos al trasladar información ya documentada. No se borraron registros ni cambiaron UUID, activación, fechas, requisitos o importes numéricos.

## Continuación: lote 04

Se aplicaron otras 59 categorías tras revisar individualmente los expedientes: 43 de mantención, 11 de arancel/matrícula, tres deportivas y dos de alimentación. La beca de Lampa se clasificó como arancel conforme al alcance del expediente. Se separaron Putre (nivel educativo no acreditado), Calbuco (modalidad de excelencia que necesita precisar categoría) y Fomento Regional del Alba (conciliar institución antes de otros cambios). No se modificó ningún otro campo ni calendario. Respaldo y restauración de 14 tablas comprobados; 59 cambios exclusivos de tipo y versión conciliados.

## Alcance y procedencia

| Lote | Revisión | Resultado aplicado |
|---|---|---|
| 01 | 56 fichas universitarias; fuentes específicas consultadas y evidencia individual en JSON/CSV | 48 categorías corregidas; tres categorías conservadas; cinco casos sin asignación por evidencia insuficiente o contradicción |
| 02 | 55 fichas municipales; relectura individual de beneficio y alcance de sus expedientes esenciales | 53 categorías de mantención y dos de arancel/matrícula |
| 03 | Mejillones, Copiapó y Panquehue | Tres beneficios recuperados; además, categorías de mantención en Mejillones y Panquehue |
| 04 | 59 expedientes con finalidad acreditada; relectura individual del alcance y beneficio | 43 de mantención; 11 de arancel/matrícula; tres deportivas; dos de alimentación |

El lote 02 es una clasificación editorial de hechos previamente acreditados, **no una nueva consulta de todas las convocatorias oficiales**. Cada fila cita el expediente, su fecha y sus límites; la huella del archivo de procedencia queda en `procedencia_lote_02.json`. El dinero para continuidad de estudios, gastos educativos o transporte cotidiano se clasifica como mantención. Matrícula y arancel se agrupan bajo la categoría existente «Beca de Arancel». No se afirma que estas denominaciones sean el nombre oficial del programa.

En el lote 03 se reconsultaron las notas municipales de [Copiapó](https://copiapo.cl/index.php/2026/02/18/municipio-de-copiapo-se-reune-con-becados-de-medicina-y-proyecta-nuevas-alianzas-academicas-en-la-rioja/) y [Panquehue](https://www.impanquehue.cl/?p=8687). Mejillones conserva el alcance histórico de su expediente. El texto de Mejillones distingue inversión agregada y beneficio individual; Copiapó identifica el programa Carmen Vilches sin inventar monto; Panquehue conserva el alcance de 2024 y la obligación de rendir gastos. Los textos publicados caben en el límite de 255 caracteres del campo.

## Verificación de aplicación

Antes de cada lote se realizó un respaldo privado y una restauración aislada de las 14 tablas. Los SQL usan transacciones, bloqueo y comprobaciones de inventario, UUID, categoría y versión previa. **Los seis SQL ya están aplicados; no repetirlos**. Una primera ejecución del lote 01 se revirtió íntegramente al detectar una versión anterior distinta; se concilió ese antecedente antes de aplicar el lote definitivo.

Las comparaciones privadas antes/después comprobaron las 528 filas y únicamente los cambios previstos: categoría, beneficio textual en tres fichas y aumento de versión. Las credenciales y respaldos permanecen fuera del repositorio. Los manifiestos guardan las huellas de los SQL y los nombres de los respaldos, sin secretos.

La verificación pública final recorrió las 528 fichas de búsqueda y 290 detalles correspondientes a los resultados de los lotes. Comprobó categorías y beneficios esperados. Permanecen **528 fichas visibles: siete abiertas, 58 cerradas, 264 con fechas por confirmar y 199 en revisión**. No se cambiaron esos estados. Evidencia: `verificacion_publica_final.json` y `verificacion_lote_01.json` a `verificacion_lote_06.json`.

## Pendientes reales

**237 fichas mantienen categoría sin especificar**, frente a 522 inicialmente. Están individualizadas por UUID, fuente y beneficio en `pendientes_tipo.csv`; esta cola enumera carencias, no constituye una clasificación automática ni una nueva confirmación de vigencia.

Prioridades detectadas:

- Ficha 14: institución atribuida a Cunco, pero fuente y expediente de Villa Alegre. No trasladar condiciones ni cambiar institución hasta conciliar con el original.
- UDD Excelencia y PAES: falta recuperar la fuente propia; no sustituir por una beca ministerial homónima.
- UDD socioeconómica: el reglamento general admite varias finalidades; falta el instrumento de la modalidad.
- ULagos Interna: no identificar automáticamente la ficha genérica con la Beca Social actual.
- Hijo/a de Funcionario UDD: la fuente consultada acredita cupos de admisión, no un descuento. Mantener la contradicción explícita.
- Copiapó Carmen Vilches: el apoyo está acreditado, pero falta precisar qué gastos financia para elegir una categoría sin inferirla.
- Convenios vespertinos UNAB: el tipo arancel está acreditado; el porcentaje general de 15 % necesita corregirse por convenio. Este lote no certifica ese porcentaje universal.

La revisión de todos los campos del catálogo **sigue pendiente**. Los campos no publicados —fechas, documentos, requisitos o importes— conservan su condición desconocida. Esta entrega no cierra la auditoría de vigencia ni inicia P13/P14. Los archivos originales y la selección de publicación inicial permanecen intactos.

## Lote 05 — 29 de octubre de 2026

Otras 60 categorías aplicadas: 37 de mantención, 17 de arancel, cinco deportivas y una de alimentación. Se preservaron los límites históricos y las modalidades separadas; las residencias no implican gratuidad y el transporte cotidiano no se presenta como intercambio. Clasificación documental sobre expedientes previos, sin afirmar nueva comprobación de convocatorias. Comparación privada de 528 filas: únicamente 60 cambios de tipo y versión. Se comprobó búsqueda completa y 290 detalles acumulados. Quedan 299 tipos pendientes individualizados.

## Lote 06 — 29 de octubre de 2026

Aplicadas otras 62 categorías: 44 de mantención, 14 de arancel, tres deportivas y una de alimentación. Relectura individual de beneficio y alcance previamente documentados. La vivienda de Santa Bárbara conserva su aporte a cargo del estudiante; no se presume gratuidad. El transporte diario de Fresia y Caldera se clasifica como mantención, sin intercambio académico. Se mantienen fuera las modalidades de Colina y Santa María que necesitan aclarar su finalidad. Comparación privada: 528 UUID preservados y solamente 62 cambios de tipo y versión. Verificación pública: 528 entradas y 290 detalles acumulados. Quedan 237 categorías pendientes. No se alteraron fechas ni estados.
