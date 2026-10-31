# Plan vigente de BecasFind

Actualizado el 30 de octubre de 2026. Este es el listado único de trabajo. El contexto de retoma está en [`tasks/contexto.md`](tasks/contexto.md); el método de revisión en [`tasks/plan.md`](tasks/plan.md).

## Auditoría de vigencia: corte final 30/10/2026

Auditoría de vigencia cerrada al corte documental del 30/10 con resultados inconclusos conservados: 466 dictámenes; 4 con cierre no vencido, 68 cierres de convocatorias identificadas (incluidas históricas), 88 calendarios por modalidad, 119 sin calendario publicado en el expediente y 187 inconclusas. No equivale a investigación exhaustiva de todas las fuentes ni a 466 confirmaciones actuales. Fuente vigente: documentacion/auditoria_corpus/procesados/auditoria_vigencia_corte_2026_10_29/INFORME_CIERRE.md, inventario.json y avance.json. Aplicados y conciliados 56 cambios (54 calendarios cerrados y dos activaciones: 255/327); no repetir los SQL. Todos los UUID conservados. Web verificada: 528 fichas; 8 abiertas, 112 cierres vencidos, 221 fechas por confirmar y 187 en revisión. BUCH cerró por su temporizador el 30/10 a las 12:00. Backend con recurso de 187 UUID actualizado; frontend 719646b conservado. No iniciar P13/P14.

[Informe completo](documentacion/auditoria_corpus/procesados/auditoria_vigencia_corte_2026_10_29/INFORME_CIERRE.md).

## Dictamen final de las 19 — 29/10/2026

Tanda completada con 19 inconclusas (17 coberturas y dos identidades), cero confirmaciones nuevas y cero sin dictamen. [Resultado y evidencia individual](documentacion/auditoria_corpus/procesados/correccion_campos_2026_10_28/RESULTADO_FINAL_19.md). Los datos desconocidos se conservan; la investigación de vigencia de 466 mantiene su propio alcance. No iniciar P13/P14. Las menciones posteriores a colas de 19 son antecedentes previos a este dictamen.

## P04: revisión editorial cerrada

Conteo reconstruido el 24/10/2026: 568 candidatas únicas en 93 fuentes y 647 referencias; **526 confirmadas esenciales, 2 completas, 40 descartadas editorialmente y 0 pendientes**. No quedan exclusiones históricas sin ratificar. La cola [`pendientes_esenciales_actuales.csv`](documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv) está vacía y el [`resumen.json`](documentacion/auditoria_corpus/procesados/avance/resumen.json) prevalece sobre cifras de cortes históricos.

- [x] Resolver las últimas 23 candidatas conforme a la autorización del 24/10/2026: exclusión editorial por insuficiencia de evidencia específica; no implica falsedad ni inexistencia.
- [x] Conservar las 526 confirmaciones esenciales y 2 completas, sus desconocidos y límites de año/modalidad; preservar originales y trazas de los 40 descartes.
- [x] Regenerar el avance y ejecutar `python infra/audit-editorial-evidence.py` sin errores. Esta auditoría comprueba integridad documental; no certifica vigencia ni sustituye la revisión de fuentes.
- [x] Registrar las resoluciones individuales en el [informe de cierre](documentacion/auditoria_corpus/procesados/CIERRE_CANDIDATAS_PENDIENTES_2026_10_24.md), versionado en `cdbf84c`.

El cierre de P04 es editorial y no libera automáticamente el catálogo para publicación. No importar ni activar becas ni ejecutar pruebas de aplicación en este cierre documental. Reabrir casos solo con evidencia oficial nueva y específica; no reconstruir pendientes desde informes históricos.

## Trabajo restante, en orden

- [x] Emitir y comprobar los dictámenes de vigencia de las 466 al corte del 30/10, conservando 187 resultados inconclusos y sus límites. No confundir cierre del corte con certeza de vigencia en esos casos.

- [x] Conciliar plan, contexto y método con el cierre editorial; comprobar integridad de índices y `git diff --check`.
- [x] P12: infraestructura, selección de 528 fichas, cinco convocatorias activas, correo real y recorridos comprobados. Control final de GitHub de esta entrega; evidencia en [P12_DESPLIEGUE.md](infra/P12_DESPLIEGUE.md).
- [ ] P13, después de P12 y con autorización: completar operación y rollback del destino real, aprovechando las comprobaciones de respaldo/restauración y reinicio ya realizadas; repetirlas solo cuando un cambio o fallo lo justifique.
- [ ] P14, después de P12/P13 y con autorización: promover/publicar el destino final y comprobar sus rutas, API y recorridos públicos/autenticados.

P01–P11 quedan cerradas dentro de sus alcances registrados. El usuario autorizó explícitamente iniciar P12 el 24/10/2026. No contratar planes ni comprar dominio. P13/P14 se ejecutan después de P12 conforme al protocolo por fases.

## Checklist vigente de P12

- [x] Oracle ARM64, Docker y PostgreSQL 17.11; esquema prod validado y secretos externos.
- [x] API HTTPS, redirección 301, renovación Certbot y firewall persistente comprobados.
- [x] Preview Vercel READY, build y ruta directa SPA; preflight CORS con origen exacto.
- [x] Registro/login de cuenta propia y rol ADMIN confirmados por el usuario.
- [x] Reinicio real con regreso de servicios y conservación del clúster PostgreSQL.
- [x] Respaldo privado y restauración aislada de las 14 tablas antes de la carga.
- [x] Importación: 528 creadas; cero errores; encoding correcto en Oracle.
- [x] Conciliación inicial compartida: 528 fichas idénticas al CSV, 528 UUID únicos y cero diferencias. No acredita vigencia actual.
- [x] Aplicar corrección UDD y activación UChile con respaldo/restauración previos; no repetir el script.
- [x] Corregir y activar BUCH con cierre oficial 30/10/2026 al mediodía y temporizador específico.
- [x] Conciliación final: mismos 528 UUID; seis fichas con cambios justificados; nueve comprobaciones de API aprobadas.
- [x] Resolver selección individual de las 528, en nueve lotes de 50 y uno de 78: cinco activas, 57 cerradas y 466 inactivas por calendario desconocido o vigencia no acreditada. Mantener originales y no certificar las inactivas.
- [x] Habilitar Gmail SMTP privado en Oracle y comprobar entrega, enlace HTTPS, cambio de clave, reutilización rechazada y sesiones invalidadas.
- [x] Comprobar en navegador búsqueda/filtros, detalle y recarga, ADMIN/STUDENT, perfil, recomendaciones y favoritos; sin errores de consola capturados.
- [x] Compilar las mismas fuentes backend en Oracle y pasar auditoría editorial y controles del importador. Incorporar estos últimos a Quality.
- [x] Versionar scripts y evidencias e integrar sus controles en Quality. El estado de la entrega se verifica en las [ejecuciones de la rama](https://github.com/BenjaAranda/BecasFind/actions?query=branch%3Abugfix%2Fsecurity-and-recovery).

La selección se cerró con límites explícitos: 466 fichas requieren nueva evidencia para activarse; no son descartes ni convocatorias vigentes. No se declara lectura íntegra de 379 documentos. El cierre de entrega exige Quality aprobado en GitHub; no se omiten sus controles. P13/P14 no se iniciaron. No repetir los scripts ya aplicados.

## Fases de producto

| Fase | Estado |
|---|---|
| P01 | Completada: cobertura monetaria estructurada; se conserva el texto original y los desconocidos. |
| P02 | Completada: filtros y orden monetario por moneda/periodicidad, sin conversiones implícitas. |
| P03 | Completada: UUID públicos; IDs numéricos en administración y catálogos. |
| P04 | Cerrada editorialmente: 526 esenciales, 2 completas, 40 descartadas y 0 pendientes; vigencia/publicación son controles separados. |
| P05 | Completada: concurrencia administrativa/importación, atomicidad y batch PostgreSQL. |
| P06–P08 | Completadas según alcance registrado. |
| P09 | Completa localmente: recuperación Gmail SMTP probada con correo real; configuración externa de producción queda para despliegue. |
| P10 | Pipeline de calidad implementado y validado en entregas previas; no representa estado actual de CI. |
| P11 | Completa en su alcance local; esquema y comprobaciones externas posteriores registrados en P12. |
| P12 | Catálogo de 528 fichas en preview; siete abiertas y estados separados. Auditoría de vigencia y revisión de campos en curso; correcciones verificadas en 523 fichas. Evidencias y pendientes actuales en `tasks/contexto.md`. |
| P13–P14 | Pendientes: operación y publicación después de P12 y su autorización por fase. |

## Decisiones vigentes

- Objetivo de costo mensual: $0. No contratar servicios ni comprar dominio sin nueva autorización. La arquitectura prevista es Vercel para frontend y Oracle Cloud Always Free para backend/PostgreSQL; verificar límites antes de iniciar el despliegue.
- Mantener diseño azul y blanco institucional, accesibilidad y búsqueda/detalle públicos. Sesión solo para perfil, favoritos, recomendaciones guardadas y administración.
- Desarrollo con perfil `dev`; producción con `prod`, secretos externos y `ddl-auto: validate`.
- P04 cerrada; P12 ejecutada en preview. No reabrir fases completadas sin una regresión concreta.

## Evidencias anteriores

Los planes previos consolidados se conservan en [`PLAN_MEJORAS_ANTES_CONSOLIDACION_2026_10_19.md`](documentacion/historial/PLAN_MEJORAS_ANTES_CONSOLIDACION_2026_10_19.md) y [`PLAN_REVISION_ANTES_CONSOLIDACION_2026_10_19.md`](documentacion/historial/PLAN_REVISION_ANTES_CONSOLIDACION_2026_10_19.md). El [`historial de planes`](documentacion/PLAN_MEJORAS_HISTORICO.md) y los informes por caso son evidencia, no colas de trabajo vigentes.

Las 19 revisiones recibieron dictamen individual INCONCLUSA el 29/10. Los motivos pendientes de evidencia se conservan en `casos_inconclusos_actuales.csv`; la cola para dictaminar esta tanda está vacía. No equivale a cierre de vigencia ni autoriza P13/P14.
