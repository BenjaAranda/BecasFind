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

El segundo lote aborda 50 fichas municipales, incluidas fuentes históricas o de acceso difícil. No se reduce el alcance a las activables. Sus decisiones se incorporan solo después de investigar cada ficha; las filas aún no investigadas permanecen identificadas como tales.

Si aparece una postulación explícitamente permanente, la propuesta es conservar su calendario sin fecha de cierre artificial y mostrarla en el catálogo informativo con la etiqueta correspondiente. Publicarla dentro del filtro de postulaciones abiertas o recomendarla como vigente requeriría una autorización específica para modificar BR-VIGENCIA. Esa regla no se cambia en esta auditoría. El catálogo público con estados fue aprobado previamente, pero su implementación local sigue separada y no desplegada.

No se inició P13/P14, no se promovió producción y no se contrataron recursos. La auditoría **no está concluida**; el inventario muestra el trabajo que falta y los casos inconclusos con sus rutas de investigación.
