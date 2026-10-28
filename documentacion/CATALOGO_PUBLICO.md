# Catálogo público de becas

Decisión autorizada el 28 de octubre de 2026: mantener visibles las becas confirmadas aunque no haya calendario actual acreditado. La visibilidad no modifica `estado_activa`, fechas, UUID ni originales.

## Comportamiento

- `/explorar` muestra el catálogo completo por defecto, con filtros y paginación.
- `vista=abiertas` conserva la búsqueda vigente anterior. Recomendaciones mantiene su regla de vigencia.
- Lectura de catálogo y detalle sin sesión. Favoritos requiere sesión.
- «Postulación abierta»: estado activo y cierre no vencido; «Próxima convocatoria»: apertura futura identificada; «Convocatoria cerrada»: cierre registrado vencido.
- «Fechas por confirmar»: no se acredita apertura actual. «Información en revisión»: expediente de la auditoría inconcluso. Ambos siguen visibles.

## Alcance y mantenimiento

La lista de UUID públicos contiene las 528 fichas de la selección editorial de P12. No expone automáticamente archivos administrativos ni las 40 exclusiones editoriales. Nuevas becas activas con cierre vigente mantienen su acceso público. La lista de revisión contiene 199 UUID del inventario de auditoría al corte de implementación; al resolver un expediente, se debe actualizar también esta lista y comprobar listado, detalle y favoritos.

Las etiquetas se derivan del estado registrado y del corte de revisión. No convierten automáticamente los 62 cierres documentales de la auditoría en fechas de base de datos: esas correcciones siguen requiriendo conciliación individual. No se afirma que las 528 acepten solicitudes hoy.

## Verificación local

Compilación de frontend y lint aprobados. Suite Maven existente aprobada; nueva prueba `PublicCatalogTest` comprueba visibilidad anónima de una ficha confirmada sin cierre, rechazo de una ficha administrativa inactiva fuera de catálogo y conservación del rechazo en la búsqueda vigente. Recorridos de navegador comprueban catálogo por defecto, cambio a abiertas, detalle, navegación, filtros y pantallas de 360 y 1280 píxeles.

El auditor genérico de interfaz detecta deuda previa del conjunto de la aplicación y contratos de controles nativos no formalizados. No equivale a un fallo de compilación ni se declara conformidad integral con esa guía. La verificación de esta entrega se limita al comportamiento ejecutado.

Esta implementación local no acredita despliegue remoto. No se ejecutan importaciones masivas ni P13/P14 por este cambio.
