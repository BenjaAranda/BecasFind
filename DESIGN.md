# Diseño de BecasFind

Portal público de becas para estudiantes en Chile. La identidad autorizada es institucional: azul y blanco, tipografía sans-serif, bordes discretos y controles sobrios. No se presenta como un organismo gubernamental.

## Continuidad visual

Los componentes existentes de `frontend/src/components` y las utilidades Tailwind de `frontend/src/index.css` son la referencia de ejecución. Azul principal #0b3c75, secundario #375b80, bordes #dbe3ed y fondos blancos o #f8fafc. No se modifican los valores por esta entrega. Las etiquetas comparten un único componente `EstadoPostulacion` para tarjetas, detalle y favoritos.

## Catálogo público

`/explorar` abre el catálogo completo. `vista=abiertas` limita los resultados a la regla de vigencia existente. Filtros, página y vista quedan en la URL; volver desde detalle conserva la búsqueda. La lectura no requiere sesión; guardar favoritos sí.

Fechas por confirmar significa calendario no acreditado; Información en revisión señala investigación inconclusa. Ninguna significa descarte. La apertura no se deduce de la probabilidad ni se inventan fechas. Convocatoria cerrada muestra sus fechas para identificar su alcance histórico.

## Interacción

Se conservan paginación, cancelación de consultas anteriores, espera de búsqueda y mensajes de carga, error con reintento y ausencia de resultados. La navegación de tarjeta usa su botón de título; los favoritos son un control separado. Mantener foco visible, contraste y contenido legible en pantallas estrechas.
