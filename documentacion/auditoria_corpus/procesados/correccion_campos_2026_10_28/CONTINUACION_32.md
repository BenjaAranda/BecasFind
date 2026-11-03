# Continuación de los 32 casos — 29/10/2026

Aplicadas correcciones en 11 fichas: diez categorías y una fuente cruzada. Se incorporaron tres categorías porque la taxonomía anterior no representaba estos beneficios. Son clasificación editorial, no nombres oficiales ni acreditación de vigencia.

- **Apoyo mixto o varias modalidades**: Colina (52/282), Curarrehue (229), Chonchi (265), PAI UAH (274), Santa María (336) y Coquimbo (432). Se conservan los siete UUID. La categoría no permite sumar prestaciones ni postular simultáneamente a modalidades excluyentes. Chonchi exige elegir solo una.
- **Articulación académica sin aporte monetario**: INACAP (123), reconocimiento de asignaturas. Se corrigió el título para no anunciar una beca en dinero.
- **Admisión especial sin beca acreditada**: UDD (468), vía para hijos/as de funcionarios de Medicina. Se corrigió el título; no se promete descuento ni obtención de cupo.
- **Contingencia UBO** (59): clasificada como arancel por el contexto y la regla publicada de aplicación al saldo de arancel después de beneficios externos. El importe sigue desconocido.
- **Rauco** (261): el portal anterior identifica a Arauco mediante dominio y contacto. Se retiró el enlace y se publicó advertencia; no se cambió el municipio ni se afirmó que la beca fuera falsa.

## Fuentes y límites

Se reconsultaron las fichas oficiales de [UBO](https://dae.ubo.cl/becas/becas-ubo/), [Chonchi](https://municipalidadchonchi.cl/web/beca-de-educacion-superior-municipal-2026/), [INACAP](https://portal.inacap.cl/admision/articulacion/articulacion-directa), [Medicina UDD](https://medicina.udd.cl/medicina-santiago/admision/admision-directa/) y el [portal de Arauco](https://beca.muniarauco.cl/login/). Las otras modalidades mixtas se clasificaron por el alcance de los expedientes ya confirmados, sin simular una nueva investigación de convocatoria.

También se releyeron la ficha del Departamento Social de Calera de Tango, el instructivo municipal Maipú 2026, la noticia de Coronel de 2019 y la modificación de Ordenanza 20 de Cerrillos de 2018: no publican un destino individual suficientemente específico para asignar categoría en estas fichas. La página específica de Natales no respondió; eso no demuestra inexistencia. La lista actual de programas de Papudo no permite sustituir automáticamente su beca histórica por residencia familiar. No se utilizaron resultados periodísticos ni redes sociales como confirmación oficial.

## Verificación

Respaldo y restauración de 14 tablas comprobados. SQL transaccional con bloqueo del catálogo de tipos y controles de versiones, UUID, inventario y taxonomía previa. Se sincronizó la secuencia de tipos para evitar colisiones futuras. Tres tipos añadidos; ninguna modificación de esquema.

Comparación privada de 528 filas: 11 cambios, exclusivamente en categoría, nombre de dos beneficios, versión y advertencia de Rauco. Fechas, activación e instituciones permanecen iguales. Se verificaron las 528 entradas, los 11 detalles, los tres filtros nuevos y el catálogo de 12 tipos. No se modificó código de backend/frontend ni se iniciaron P13/P14.

**Quedan 22 categorías sin determinar**. La cola conserva las dos identidades contradictorias (Rauco y San Pedro de la Paz). No se vacía ni se presenta como investigación concluida.

El conteo acumulado fue recalculado comparando todos los UUID con la instantánea pública inicial: **503 fichas distintas modificadas y 501 categorías corregidas**. Corrige el sobreconteo previo de una ficha ya modificada en otro lote; sumar tamaños de lotes no equivale a contar becas distintas.
