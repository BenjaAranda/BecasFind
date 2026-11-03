# Revisión de las 177 fichas restantes — 1 de noviembre de 2026

Se completó el recorrido de las 177 fichas de esta tanda con dictamen individual y nota pública: **27 dictámenes precisados y 150 inconclusos**. No quedan fichas de esta tanda sin dictamen. Las 150 incógnitas no se han convertido en confirmaciones: el CSV explica por beca qué falta y qué evidencia permitiría reabrirla. No se declara una investigación exhaustiva de todas las fuentes posibles.

La cohorte general conserva sus 466 UUID. El catálogo completo conserva sus 528 fichas: **8 abiertas, 121 cerradas, 249 con fechas por confirmar y 150 en revisión**. Cero activaciones y cero eliminaciones en esta entrega. Confirmación editorial, visibilidad y recepción de solicitudes siguen siendo controles separados.

## Resultado de esta tanda

| Dictamen | Fichas |
|---|---:|
| Cerrada con calendario identificado | 7 |
| Calendario por modalidad o cohorte | 9 |
| Fuente específica sin calendario publicado | 11 |
| Inconclusa sobre el campo investigado | 150 |
| Total | 177 |

Los siete calendarios incorporados son Cisnes, Melipilla, Curarrehue, Quinchao, Providencia, Contulmo y Río Verde. En Cisnes se separan los semestres y las apelaciones; en Quinchao los canales presencial y por correo; en Curarrehue la ampliación del primer llamado, el segundo llamado, la subsanación y la rendición. Río Verde se precisó al final con lectura visual del afiche de último llamado de marzo de 2026.

Se actualizaron ocho textos de cobertura: Cisnes, Melipilla, Los Álamos, mérito deportivo UNAP, alimentación UNAP, residencia UNAP, segunda carrera AIEP y Tirúa. El decreto UNAP de marzo de 2026 permite distinguir cinco beneficios actuales y las reglas conservadas para renovantes. No acredita Primera Preferencia; esa ficha continúa inconclusa. Lebu y Curarrehue reciben nombres acordes al programa identificado.

## Contradicciones y límites conservados

- Melipeuco: bases 2026 con «viernes 15 de julio» discordante con el día de la semana; pago el imposible «31 de noviembre». No se corrigen por conjetura ni se activa noviembre sin plazo preciso.
- Penco: noticia con 6 de marzo y formulario con 9 de marzo. Las dos ventanas son pasadas, pero no se certifica un cierre único sin acto de ampliación.
- Mulchén: el documento confirma requisitos e importe de Apoyo 2026, pero mantiene «con fecha a definir» junto a 9–31 de marzo. No se mezcla con Fray Alejandro Manera.
- Alhué y Los Muermos: referencias incompatibles de meses o requisitos. USS y otras universitarias: encabezados de 2027 junto a condiciones de 2026 o reglamentos históricos. Se delimitan las cohortes.
- Rauco y San Pedro de la Paz: los antecedentes de otras comunas no sustituyen la identidad pendiente ni justifican eliminar sus UUID.
- Empleos, fondos para organizaciones, preparación PAES, pagos, matrícula general, becas deportivas y municipios de otros países se descartan como evidencia de la convocatoria investigada; no se descartan las fichas por esos hallazgos.

No se acreditó una nueva modalidad permanentemente abierta. Los nueve calendarios por modalidad siguen descritos individualmente y sin fecha artificial de cierre; no se altera BR-VIGENCIA. Las once fichas sin calendario muestran «Fechas por confirmar». Las 150 inconclusas conservan «Información en revisión».

## Evidencia y comprobación

- `dictamenes_177.csv` y `dictamenes_177.json`: una fila por UUID con conclusión, límites, fuentes, año, fechas acreditadas, aplicación y siguiente evidencia necesaria.
- `inventario_466.json`: consolidación actual; el seguimiento previo de 62 y el corte original siguen intactos.
- `inconclusas_150.csv`: incertidumbres específicas, sin recategorizarlas como becas falsas o descartadas.
- `fuentes.json` y `fuentes_conservadas/`: rutas, fechas de consulta, barreras y huellas de capturas primarias. Se conserva el SHA del original cuando no se copia un archivo grande. Una captura o una búsqueda no se cuenta como confirmación.
- `conciliacion_variantes.json`: coincidencias 131/503 (Puntaje Ponderado PLG UAI 2026) y 175/508 (Honor UPLA 2025) documentadas; originales, UUID y favoritos conservados. No hay fusiones o bajas.
- `recibo_aplicacion.json`: respaldo privado y restauración aislada previa de 14 tablas; transacción con guardas; 177 notas, ocho coberturas y seis calendarios iniciales; 351 fichas idénticas y 13 tablas ajenas idénticas.
- `aclaracion_rio_verde.sql` y su recibo: segundo respaldo/restauración y transacción para el séptimo calendario; 527 fichas idénticas. Son **177 fichas distintas y 178 operaciones de actualización**, porque Río Verde recibió una aclaración posterior.
- `verificacion_publica.json`: 177 detalles comprobados sin sesión, texto previo conservado, 528 UUID conciliados, búsqueda por texto y filtro de institución, CORS de la preview y ocho resultados abiertos de la búsqueda estricta. Ninguna ficha de esta tanda fue activada.

El primer intento de la transacción de 177 se revirtió íntegro por una periodicidad monetaria incompatible con el tipo porcentual. Se corrigió ese formato y se verificó otro respaldo antes de aplicar; no se cambió la restricción de calidad ni quedó aplicación parcial.

## Alcance técnico

Backend compilado al empaquetar el recurso de clasificación de 150 UUID. No hay cambios de lógica de aplicación ni de frontend. Imagen de la preview: `sha256:93c82c8c205cebf7991365ee28c02758e064b097e8bb59f273181295b45f9ff8`. Configuración y frontend conservados; contenedor anterior disponible para reversión. No se ejecutó una batería nueva de pruebas funcionales, no se inició P13/P14 y no se promovió producción.

## Qué permanece desconocido

Las 150 conclusiones limitadas están detalladas en `inconclusas_150.csv`. Requieren una fuente pública oficial específica nueva, acceso a un documento concreto o un acto que resuelva la contradicción indicada. No se exige contactar instituciones y no se usó Firecrawl. Mantener una incertidumbre documentada es el resultado de la revisión, no una autorización para anunciar solicitudes abiertas.
