# Auditoría de vigencia: informe de trabajo

Fecha: 27 de octubre de 2026, America/Santiago. **Investigación en curso.** El avance por ficha está en `inventario.csv` y `inventario.json`; los conteos actualizados se calculan en `avance.json`.

## Corrección del cierre anterior

Las 466 becas no fueron eliminadas ni descartadas: conservaban sus confirmaciones editoriales y sus UUID. Sí hubo un error de alcance al presentar como resuelta la selección de publicación mientras quedaba investigación de convocatorias por hacer. La recuperación de 320 textos y las 59 barreras de acceso no demostraban una revisión suficiente por beca. Se reabre esa investigación sin sobrescribir las instantáneas ni reimportar datos.

Esta auditoría distingue expresamente los calendarios por modalidad, beneficios automáticos, plazos desconocidos y contradicciones. No cambia las 526 confirmaciones esenciales, las dos completas ni los 40 descartes editoriales previos. Una fuente inaccesible no demuestra cierre ni inexistencia.

## Primer lote: 55 fichas

Se compararon las modalidades de UCN, Talca, USS, USM, UDP, Autónoma, Central, UNAB, AIEP y beneficios ministeriales. Cada hallazgo contiene la referencia de la sección consultada, los límites y la siguiente acción. No se da por leído un expediente completo por recuperar su archivo.

- UCN vincula distintas ayudas a matrícula; su calendario de admisión no es una solicitud independiente de beca.
- Talca publica apoyos de primer ingreso y renovación sin un cierre propio utilizable en la ficha.
- USM y algunas secciones USS/UDP conservan anualidad 2026 pese a navegación general 2027; no se trasladan automáticamente las condiciones.
- La beca de excelencia USS es automática y no postulable. No necesita una fecha inventada para aparentar apertura.
- UNAB Cursos Superiores: el instructivo sí contiene un cierre, el 4 de enero de 2026, pero mezcla requisitos 2025/2026. Se conserva inconclusa la revisión de condiciones y de un llamado posterior.
- Juan Gómez Millas y Bicentenario están explícitamente vinculadas al FUAS 2027 por MINEDUC; calendario identificado, aplicación aún pendiente de conciliación de condiciones. No se activaron en este bloque.

## Cambios efectivamente aplicados

| Ficha | Antes | Cambio comprobado |
|---|---|---|
| Deportiva UNAB, ID 314 | Inactiva; fechas desconocidas | Fuente específica publicada el 08/09/2026: recepción 01/09/2026–31/01/2027. Activada; versión 1; mismo UUID. |
| UAlumni Autónoma, ID 518 | Inactiva; fechas desconocidas | Segunda convocatoria 04–25/09/2026 cerrada. Fechas registradas; conserva inactividad; versión 1. |

Fuentes: [Beca Deportiva UNAB](https://explora.unab.cl/deportes-unab-formacion-apoyo-y-oportunidades-para-compatibilizar-los-estudios-con-el-alto-rendimiento/) y [segunda convocatoria UAlumni](https://postgrados.uautonoma.cl/2da-convocatoria-ualumni-2026/).

Respaldo privado `pre-catalogo-20261028T012824Z-56ae0d43.dump`, restauración aislada y comparación de las 14 tablas comprobadas antes de la transacción. Guardas de UUID, versión y fechas previas evitaron sobrescrituras. Conciliación posterior: 528 UUID conservados, solo las dos fichas previstas cambiaron; las otras 526 permanecen idénticas al corte previo. No se tocaron favoritos, cuentas ni correo.

Estado de la BD después del bloque: **528 conservadas, 6 activas, 58 con cierre vencido y 464 sin cierre registrado**. Estas cifras describen la BD; la cohorte inicial de investigación sigue siendo de 466. No se convierten las 464 en descartes ni en investigaciones concluidas. El listado HTTPS, la búsqueda por texto y el detalle público por UUID de Deportiva UNAB quedaron comprobados. Recibo en `aplicacion_lote_01.json`.

## Continuación y decisiones de producto

El segundo lote incorpora 50 investigaciones municipales. Hay cierres 2026 documentados en Quilicura (31/05), Hijuelas (14/04 a las 14:00), San Antonio (12/04), Vichuquén y San Vicente (31/03), y Primavera (13/03 a las 13:00). Panquehue solo permite acreditar un cierre histórico de 2024. Arauco distingue canal online y presencial; Ovalle distingue ingreso y renovación. Ninguno de estos cierres se interpreta como desaparición del programa.

Quilicura exigió leer visualmente las bases escaneadas: su página de calendario acredita 4–31 de mayo de 2026. Los textos de cursos anteriores de la portada no se usaron para sustituir esas bases. Melipeuco, Lautaro, Tomé y Melipilla conservan barreras o contradicciones concretas pendientes; no se certificó el contenido de documentos inaccesibles. Las dos fichas de Tomé, San Joaquín y Chiguayante conservan sus UUID y no se fusionaron por compartir fuente.

El tercer lote incorpora otras 50 investigaciones de instituciones de educación superior. Se detectó una convocatoria de Alimentación UANDES con fechas explícitas 19/10/2026–28/01/2027; su aplicación permanece sin ejecutar hasta conciliar condiciones y copia pública. UChile BAE distingue el calendario FOCES de los cierres por unidad y primer ingreso; Residencia presenta anualidades contradictorias. UDD aclara que admisión directa deportiva y programa de descuentos son procesos distintos. Las ventanas de otros beneficios no se trasladaron a estas fichas.

Avance documental al terminar estos lotes: **155 de 466 investigadas; 101 con clasificación documental concluyente para el alcance descrito, 54 inconclusas y 311 todavía sin investigar**. Las conclusiones incluyen ausencia de calendario publicado o calendarios por modalidad; no equivalen a 101 convocatorias abiertas. No se aplicaron cambios adicionales a Oracle durante los lotes segundo y tercero. El inventario conserva las limitaciones, el campo no publicado y la siguiente acción por ficha. La investigación de la cohorte completa continúa pendiente.

## Cuarto lote y segunda aplicación

Se incorporan 51 investigaciones de UVM, UMAG, UCSH, UBO, UPLA, PUCV, UAH, UC Temuco, ULagos y UNAP. UMAG enumera expresamente las cinco modalidades investigadas en su calendario actualizado: recepción enero y marzo–abril 2026. UCSH Don Bosco recibió solicitudes 5–19 de octubre de 2026. ULagos distingue el cierre de becas del cierre FAS; el llamado enumera Alimentación Interna, Trayectoria Formativa y Delia Domínguez. PAI UAH 2026 recibió solicitudes en septiembre de 2025. Las búsquedas de otras convocatorias no se usaron para convertir esos plazos en una edición nueva.

Avance acumulado: **206 investigadas; 129 con conclusión limitada al alcance documentado, 77 inconclusas y 260 sin investigar**. No se declara concluida la auditoría.

Después de contrastar las condiciones de Alimentación UANDES con Económica 2027 se aplicó únicamente la corrección de la ficha 445: recepción 19/10/2026–28/01/2027; mismo UUID; versión 1. Su calendario de ingreso no certifica la recepción interna por Banner de estudiantes antiguos. El beneficio conserva los montos diferenciados según BAES y el uso exclusivo en campus.

Respaldo privado `pre-catalogo-20261028T015421Z-599baf0e.dump`, restauración aislada de 14 tablas y transacción con guardas comprobados. La conciliación de las 528 filas contra el bloque anterior detectó únicamente el cambio previsto en 445; conservó todos los UUID. Listado, filtro por nombre y detalle HTTPS aprobados. Recibo: `aplicacion_lote_02.json`. **Estado real posterior: 528 conservadas; 7 activas; 58 con cierre vencido; 463 sin cierre registrado.** En la cohorte auditada hay dos activaciones aplicadas y una corrección de calendario cerrado; ninguna eliminación.

## Quinto lote: 50 investigaciones adicionales

Se incorporan las 47 fichas restantes de instituciones superiores y programas nacionales, junto con dos variantes de San Bernardo y Pasajes de Viña del Mar. UBB y UdeC publican ventanas propias de modalidades identificadas; no se transfieren los plazos de postgrado a pregrado. UDLA distingue beneficios solo renovables de solicitudes nuevas. BMES y BAES son asignaciones o continuidades sin postulación directa; no se convierten en becas de recepción permanente. UAI advierte que las condiciones 2027 aún se publicarán. PRFE presenta una contradicción entre título de educación superior y requisitos de media que sigue documentada como inconclusa.

**Avance: 256 de 466 investigadas; 161 con conclusión documental limitada; 95 inconclusas; 210 sin investigar.** Las cuatro fichas con calendario no vencido incluyen dos activaciones ya aplicadas y dos ministeriales pendientes de conciliación. No se infiere activabilidad de esa clasificación. Los cambios remotos acumulados siguen siendo únicamente 314, 518 y 445; el quinto lote no modificó Oracle. Permanecen pendientes la investigación de las 210 municipales restantes y las acciones concretas de los casos inconclusos.

Si aparece una postulación explícitamente permanente, la propuesta es conservar su calendario sin fecha de cierre artificial y mostrarla en el catálogo informativo con la etiqueta correspondiente. Publicarla dentro del filtro de postulaciones abiertas o recomendarla como vigente requeriría una autorización específica para modificar BR-VIGENCIA. Esa regla no se cambia en esta auditoría. El catálogo público con estados fue aprobado previamente, pero su implementación local sigue separada y no desplegada.

No se inició P13/P14, no se promovió producción y no se contrataron recursos. La auditoría **no está concluida**; el inventario muestra el trabajo que falta y los casos inconclusos con sus rutas de investigación.
