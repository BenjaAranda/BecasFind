# Plan vigente de BecasFind

Actualizado el 23 de octubre de 2026. Este es el listado único de trabajo. El contexto de retoma está en [`tasks/contexto.md`](tasks/contexto.md); el método de revisión en [`tasks/plan.md`](tasks/plan.md).

## Prioridad: P04, revisión esencial de becas

Conteo reproducible: 568 candidatas únicas; **526 confirmadas esenciales, 2 completas, 17 descartadas y 23 pendientes** (18 `REQUIERE_ACLARACION`, 5 `EXCLUSION_HISTORICA_SIN_RATIFICAR`). La cola única está en [`pendientes_esenciales_actuales.csv`](documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv) y el resumen generado en [`resumen.json`](documentacion/auditoria_corpus/procesados/avance/resumen.json). El conteo prevalece sobre cifras de cortes históricos.

- [ ] Resolver las 23 candidatas con fuentes públicas oficiales específicas; leer la carencia y la próxima acción de cada fila antes de consultar.
- [ ] Registrar solo campos respaldados. Mantener «No especificado» cuando la fuente oficial no publique el dato dentro del alcance consultado.
- [ ] Resolver variantes por institución, modalidad y año. Exigir evidencia positiva individual para duplicidad, falsedad o descarte.
- [ ] Regenerar y auditar los índices tras cambios probatorios; subir cambios sustantivos a GitHub con mensajes en español.

No contactar instituciones ni usar Firecrawl. Conservar originales y trazas. No importar ni activar becas, probar backend/frontend ni iniciar despliegue durante esta prioridad. No hay cierre global mientras queden candidatas sin resolución respaldada.

## Fases de producto

| Fase | Estado |
|---|---|
| P01 | Completada: cobertura monetaria estructurada; se conserva el texto original y los desconocidos. |
| P02 | Completada: filtros y orden monetario por moneda/periodicidad, sin conversiones implícitas. |
| P03 | Completada: UUID públicos; IDs numéricos en administración y catálogos. |
| P04 | Revisión editorial en curso; 23 candidatas en la cola actual. |
| P05 | Completada: concurrencia administrativa/importación, atomicidad y batch PostgreSQL. |
| P06–P08 | Completadas según alcance registrado. |
| P09 | Completa localmente: recuperación Gmail SMTP probada con correo real; configuración externa de producción queda para despliegue. |
| P10 | Pipeline de calidad implementado y validado en entregas previas; no representa estado actual de CI. |
| P11 | Completa localmente: PostgreSQL 17, migraciones 001–005, respaldo/restauración y validación de esquema. Destino externo no configurado. |
| P12–P14 | No autorizadas: preparación, operación y publicación del despliegue. |

## Decisiones vigentes

- Objetivo de costo mensual: $0. No contratar servicios ni comprar dominio sin nueva autorización. La arquitectura prevista es Vercel para frontend y Oracle Cloud Always Free para backend/PostgreSQL; verificar límites antes de iniciar el despliegue.
- Mantener diseño azul y blanco institucional, accesibilidad y búsqueda/detalle públicos. Sesión solo para perfil, favoritos, recomendaciones guardadas y administración.
- Desarrollo con perfil `dev`; producción con `prod`, secretos externos y `ddl-auto: validate`.
- Prioridad actual: terminar P04. No reabrir fases completadas sin una regresión concreta.

## Evidencias anteriores

Los planes previos consolidados se conservan en [`PLAN_MEJORAS_ANTES_CONSOLIDACION_2026_10_19.md`](documentacion/historial/PLAN_MEJORAS_ANTES_CONSOLIDACION_2026_10_19.md) y [`PLAN_REVISION_ANTES_CONSOLIDACION_2026_10_19.md`](documentacion/historial/PLAN_REVISION_ANTES_CONSOLIDACION_2026_10_19.md). El [`historial de planes`](documentacion/PLAN_MEJORAS_HISTORICO.md) y los informes por caso son evidencia, no colas de trabajo vigentes.
