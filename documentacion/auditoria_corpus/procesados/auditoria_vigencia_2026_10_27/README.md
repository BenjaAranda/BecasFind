# Auditoría individual de vigencia

Abierta el 27 de octubre de 2026 por petición expresa del usuario. Sustituye el cierre de investigación implícito en la selección anterior: una decisión conservadora de no publicar **no acredita que se haya investigado suficientemente la convocatoria actual**.

Las 466 fichas objetivo están conservadas y confirmadas editorialmente. No son nuevos descartes. El corte inicial se conserva sin sobrescribir; la auditoría mantiene el hash de ese archivo y la correspondencia candidata/ID/UUID. No reabre los 40 descartes anteriores.

- `inventario.json` e `inventario.csv`: todas las fichas, evidencia anterior y hallazgos nuevos cuando existen. `revision_individual_realizada=false` significa que aún no se investigó esa ficha en esta auditoría.
- `hallazgos.json`: decisiones escritas individualmente tras consultar fuentes. El generador no deduce clasificaciones de palabras clave, descargas o estados de la BD.
- `avance.json`: separa fichas investigadas, no investigadas y aplicación. Una revisión inconclusa sigue siendo inconclusa.

Comando de actualización: `python infra/report-vigencia-audit.py`. No importa datos ni modifica Oracle.

## Alcance de aplicación

No modificar la regla de búsqueda vigente. Las becas permanentes, automáticas o ligadas a matrícula no reciben fechas artificiales. El catálogo público con estados fue autorizado por el usuario en este chat; su implementación local quedó en preparación y separada de esta auditoría. No está desplegado ni sustituye las comprobaciones de vigencia. No se inicia P13/P14.

Los cambios locales de backend/frontend del catálogo no se incluyen en los commits documentales de esta auditoría ni constituyen evidencia de cambios remotos.
