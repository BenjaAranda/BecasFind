# Vigencia: dos fechas no vencidas en Oracle

Revisión del 26 de octubre de 2026. Estado: decisión preparada; modificación en Oracle pendiente de ejecución y comprobación. Mantiene las 526 confirmaciones esenciales y dos completas.

## Verificación técnica recibida

La consulta bytea y sus cinco casos de regresión terminaron correctamente en Oracle: 528 fichas; 0 activas; 468 sin cierre; 58 con cierre pasado; 2 con fechas no vencidas sin revalidar. Cero coincidencias de patrones de doble codificación. La alerta anterior fue un falso positivo del patrón hexadecimal sin límites de bytes.

## Alumni UDD

Candidata `92e4ad7a0560c3a831af47c3412ee193c26746839a7b4fbc7e949183226b0c26`; ID administrativo 310.

La [ficha oficial del curso](https://postgrados.udd.cl/programas/curso-gestion-de-compensaciones-240050/) distingue las fechas de clases, del 2 al 25 de noviembre de 2026, de la inscripción abierta. No publica un cierre de inscripción. Se deben retirar esas dos fechas de los campos de postulación y mantener la ficha inactiva. La confirmación esencial del descuento para ese curso se conserva. El CSV importado y su trazabilidad permanecen como instantánea previa; no regenerarlo sobre esos archivos para ocultar la corrección.

## Hijos de funcionarios UChile

Candidata `a7add480ae1c014fbf47d21eeffd015842829399ea2988e2d743f41393504c11`; ID administrativo 356.

La [convocatoria oficial](https://uchile.cl/convocatorias/7790/descuento-de-arancel-para-hijos-de-funcionarios-o-academicos) acredita el calendario 2026 de la ficha y admite solicitudes posteriores a matrícula. Decisión: habilitarla para su público específico y sustituir las notas internas por contenido público.

## Aplicación preparada

`infra/apply-p12-vigencia.ps1` transfiere los archivos necesarios y ejecuta un respaldo privado con restauración aislada antes del SQL. El SQL comprueba identidad, fuente, fechas e inactividad, conserva UUID y aumenta la versión de las dos filas. Si otro agente modificó los registros, se detiene. La activación UChile caduca por guardia de fecha y por la regla de búsqueda; no ejecutar fuera del calendario sin nueva revisión.

No se ha aplicado todavía. La salida esperada tras ejecutar y verificar es 528 fichas; 1 activa; 469 sin cierre; 58 cerradas y 1 con cierre no vencido. Las demás fichas requieren comprobación propia, no activación masiva.
