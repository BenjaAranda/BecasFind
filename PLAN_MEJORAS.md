# Plan vigente de BecasFind

Actualizado el 19 de octubre de 2026. Este es el único listado de trabajo. El contexto para retomar está en [tasks/contexto.md](tasks/contexto.md) y el método de revisión en [tasks/plan.md](tasks/plan.md).

## Prioridad actual: P04, confirmación de becas

Estado reproducible: **568 candidatas; 516 confirmaciones esenciales; 2 completas; 11 descartes ratificados; 39 pendientes**. Las pendientes incluyen 28 aclaraciones y 11 exclusiones históricas sin ratificar. Las cifras de 132, 157 o 291 pertenecen a cortes anteriores. Último avance: confirmación histórica de Beca Convenio ENAC y corrección de Excelencia Académica ENAC a su modalidad interna; no se certifica vigencia 2026.

- [ ] Resolver las [39 candidatas de la cola única](documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv) con fuentes oficiales específicas. Leer sus carencias e informes existentes antes de consultar de nuevo.
- [ ] Registrar campos publicados; conservar «No especificado» cuando el expediente oficial no los publique. La identidad del programa sí requiere evidencia positiva.
- [ ] Resolver equivalencias y variantes por programa, modalidad y año; consultar sus decisiones actuales antes de declarar el cierre global. No convertir referencias repetidas en duplicados sin prueba.
- [ ] Comprobar coherencia documental y subir decisiones nuevas a GitHub con mensajes en español.

Originales, trazas e inactividad administrativa se conservan. No descartar por falta de datos, acceso fallido o búsquedas sin resultado. Confirmación histórica no equivale a vigencia. Las búsquedas o aclaraciones repetidas no cuentan como cierres.

Los conteos vigentes se consultan en [avance/resumen.json](documentacion/auditoria_corpus/procesados/avance/resumen.json); el detalle está en [avance por archivo](documentacion/auditoria_corpus/procesados/avance/por_archivo.csv). Los informes anteriores se leen solo cuando sean pertinentes al hash revisado.

## Estado de las fases

| Fase | Estado y alcance restante |
|---|---|
| P01 | Completada: esquema y cobertura monetaria estructurada; conservar texto original y desconocidos. |
| P02 | Completada: filtros y orden monetario por moneda/periodicidad, sin conversiones implícitas. |
| P03 | Completada: UUID públicos de becas; números en administración y catálogos. |
| P04 | Implementación cerrada; revisión editorial pendiente de los casos indicados arriba. |
| P05 | Completada: concurrencia administrativa/importación, atomicidad y batch PostgreSQL. |
| P06 | Completada: trazabilidad de requisitos y cobertura funcional acordada. |
| P07 | Completada: accesibilidad y compatibilidad con el alcance registrado. |
| P08 | Completada: rendimiento local/sintético; no garantiza rendimiento en producción. |
| P09 | Completada localmente: recuperación por Gmail SMTP probada con correo real; activación externa pendiente del despliegue. Secretos externos. |
| P10 | Pipeline Quality implementado y validado en entregas anteriores. No afirmar estado actual de CI sin consultarlo. |
| P11 | Completada localmente: PostgreSQL 17, migraciones 001–005, respaldo/restauración y validación del esquema. El destino externo sigue pendiente. |
| P12 | No autorizada: preparar vista previa Vercel + Oracle Always Free, capacidad real, arquitectura Docker, producción/secretos, BD privada, Nginx/HTTPS, CORS y rutas SPA. |
| P13 | No autorizada: operación en destino, copias/restauración, reinicio y rollback. Depende de P12. |
| P14 | No autorizada: publicación y comprobación pública de HTTPS, rutas, API y roles. Depende de P12/P13. |

## Decisiones que se conservan

Costo mensual objetivo $0; no contratar planes ni comprar dominios. Frontend previsto en Vercel y backend/PostgreSQL en Oracle Always Free; recursos y límites deben verificarse antes de desplegar. La aplicación no tiene publicación validada.

Mantener azul y blanco institucional, tipografía sans-serif, accesibilidad y acceso público a búsqueda/detalle. Sesión para perfil, favoritos, recomendaciones guardadas y administración. Desarrollo con perfil `dev`; producción con `prod`, secretos externos y `ddl-auto: validate`.

Prioridad de esta entrega: revisión de becas. Backend/frontend, sus pruebas, importaciones, activación y despliegue permanecen aplazados. No reabrir tareas completadas sin una regresión concreta.

## Historial y evidencias

Los planes acumulativos anteriores se preservan en [plan histórico al consolidar](documentacion/historial/PLAN_MEJORAS_ANTES_CONSOLIDACION_2026_10_19.md) y [método anterior](documentacion/historial/PLAN_REVISION_ANTES_CONSOLIDACION_2026_10_19.md). El [historial previo](documentacion/PLAN_MEJORAS_HISTORICO.md) y los informes individuales conservan los resultados, comandos y límites de entregas anteriores; no constituyen otro listado vigente.
