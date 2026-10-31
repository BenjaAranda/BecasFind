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

## Preview desplegada el 28/10/2026

Frontend `719646b` en [preview del catálogo](https://becasfind-pf8timp72-benjatlou13-1274.vercel.app/explorar); backend `37ae1a1` en Oracle. Se verificaron las 528 fichas sin sesión y todas las instituciones de sus filtros: 323. La búsqueda «Funcionarios» devuelve dos fichas en catálogo y una en abiertas; una ficha sin fechas abre su detalle sin pedir sesión. El error durante el reinicio se recuperó con Reintentar.

La conciliación de los 528 registros y todos sus campos contra el corte anterior no detectó cambios. Antes de cada sustitución se comprobó respaldo y restauración aislada de 14 tablas. Orígenes anteriores, destino de correo y contenedores previos conservados; protección Vercel vigente. Evidencia en `P12_CATALOGO_PREVIEW_2026_10_28.json` y recibo remoto en `P12_CATALOGO_APLICACION_2026_10_28.json`. No se ejecutaron importaciones masivas ni P13/P14.
