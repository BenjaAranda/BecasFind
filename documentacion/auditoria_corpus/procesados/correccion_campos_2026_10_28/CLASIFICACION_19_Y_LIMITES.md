# Clasificación descriptiva de las 19 fichas — 29/10/2026

Las 19 fichas recibieron una clasificación explícita según el nivel de evidencia disponible. **Este lote no confirmó ninguna cobertura específica ni resolvió identidades.** La investigación sigue abierta; las carencias están registradas con el documento necesario para continuarlas.

## Decisiones

**17 apoyos municipales de cobertura por confirmar**: Papudo (1), María Elena (23), Cholchol (68), Peumo (251), Toltén (312), Hualañé (362), La Florida (393), Villa Alemana (402), Maipú (405/506), Pencahue (412), Viña del Mar (426/528), Coronel (500), Calera de Tango (510), Cochamó (513) y Cerrillos (514). Los expedientes existentes identifican programas o antecedentes municipales, con distintos alcances históricos y límites. La categoría general no acredita arancel, mantención, monto, periodicidad, nivel educativo no publicado ni apertura actual. Se conservan las advertencias de cada detalle.

**Dos registros con identidad del programa por confirmar**: Rauco (261) y San Pedro de la Paz (490). Sus títulos ahora dicen «Antecedente de beca municipal … · identidad por confirmar». Se conservan UUID, institución original y advertencia de la fuente cruzada retirada. No se afirman falsedad ni existencia confirmada del beneficio específico.

Son categorías editoriales, no denominaciones oficiales nuevas. No usar el contador de etiquetas «No especificado» como número de investigaciones concluidas. La etiqueta anterior ya no aparece en estas fichas, pero siguen existiendo **19 pendientes documentales: 17 coberturas y dos identidades**.

## Investigación y decisión de alcance

Se consultaron los portales actuales de Maipú, Cerrillos y Cholchol y el listado de ordenanzas de Cerrillos. Maipú exige ejecución de JavaScript para su portal principal; Cerrillos publica la ordenanza deportiva/cultural 21, que no reemplaza la ordenanza superior 20. La modificación publicada por BCN/Diario Oficial en 2018 remite al texto anterior sin reproducir toda la prestación. Los resultados de Rauco y San Pedro no acreditan los programas independientes de las candidatas originales. No se trasladaron ayudas de otras comunas ni de otros niveles educativos.

La categorización general usa únicamente la identidad y alcance ya registrados; no representa una nueva lectura de todas las convocatorias. Su propósito es que la web muestre una descripción honesta del dato disponible. La investigación restante está en `pendientes_documentales_actuales.csv`; `pendientes_tipo.csv` conserva una copia compatible para las referencias anteriores. Cada fila indica el documento concreto necesario.

## Aplicación verificada

Se realizó respaldo y restauración aislada de las 14 tablas. SQL transaccional con controles de inventario, UUID, versión y taxonomía previa; bloqueo del catálogo de tipos y sincronización de su secuencia. Se añadieron dos tipos descriptivos. La comparación privada de 528 filas confirmó solo 19 cambios de categoría y versión, además de los dos títulos de antecedentes.

Se comprobaron las 528 entradas públicas, los 19 detalles, ambos filtros nuevos y el catálogo de 14 tipos. Se mantienen siete abiertas, 58 cerradas, 264 con fechas por confirmar y 199 en revisión. Ningún cambio de fechas, requisitos, importes, activación ni instituciones. Permanecen 523 fichas distintas modificadas frente a la instantánea inicial; estas 19 ya habían sido corregidas en otros campos.

Los SQL están aplicados: no repetir. La numeración «lote 14» corresponde a datos; no se iniciaron P13/P14 de desarrollo ni se declara cerrada la auditoría de vigencia.
