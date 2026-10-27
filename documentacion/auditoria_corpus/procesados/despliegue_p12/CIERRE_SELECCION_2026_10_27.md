# Selección publicable de P12 — 27 de octubre de 2026

Se resolvió la selección de las 528 fichas importadas. Esto no vuelve a certificar exhaustivamente sus 379 documentos ni convierte el archivo histórico en oferta vigente. Cada candidata conserva identidad, modalidad, alcance editorial, beneficio, requisitos, fuentes, desconocidos, UUID y una decisión individual en `seleccion_publicacion_2026_10_27.json`.

| Decisión | Fichas |
|---|---:|
| Activas con cierre vigente acreditado | 5 |
| Inactivas con convocatoria documentada cerrada | 57 |
| Inactivas por calendario desconocido o vigencia sin acreditar | 466 |
| Total conservado en Oracle | 528 |

La decisión de publicación está resuelta para todas; las 466 inactivas requieren nueva evidencia antes de poder activarse. No son 466 becas falsas ni nuevos descartes. Las 40 exclusiones editoriales anteriores no se importaron ni se modificaron. Se mantiene el total editorial de 526 esenciales y dos completas.

## Convocatorias habilitadas

| Programa | Postulación comprobada | Fuente |
|---|---|---|
| BUCH, ingreso 2027 | 21/09–30/10/2026; cierre 12:00 de Santiago | [Convocatoria UChile](https://uchile.cl/dbe/buch) |
| Hijos de Funcionarios UChile | 13/01–31/12/2026 | [Convocatoria específica](https://uchile.cl/convocatorias/7790/descuento-de-arancel-para-hijos-de-funcionarios-o-academicos) |
| UANDES Económica, ingreso 2027 | 19/10/2026–28/01/2027 | [Ficha UANDES](https://admision.uandes.cl/becas/beca-uandes-economica) |
| Nuevo Milenio I, FUAS 2027 | 01/10–05/11/2026; cierre 14:00 | [Modalidades MINEDUC](https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-nuevo-milenio-bnm) |
| Gratuidad, FUAS 2027 | 01/10–05/11/2026; cierre 14:00 | [Requisitos 2027 MINEDUC](https://portal.beneficiosestudiantiles.cl/gratuidad) |

El anuncio vigente del [portal ministerial](https://portal.beneficiosestudiantiles.cl/?id_portal=74) acredita la ampliación FUAS al 5 de noviembre. La [Universidad Central](https://www.ucentral.cl/postulacion-fuas-2027/) precisa las 14:00 para el proceso 2027. Se instalaron y comprobaron temporizadores específicos BUCH y FUAS; no se modificó la regla general de búsqueda por fecha. Completar FUAS no garantiza adjudicación. Gratuidad advierte que el listado institucional visible consultado es 2026 y que la matrícula 2027 debe ser elegible. No se equipara la evaluación económica FUAS a un porcentaje RSH.

## Contradicciones y límites resueltos para esta selección

- Alumni UDD: noviembre 2–25 corresponde a clases; se retiraron ambas fechas de postulación y se conservó inactiva.
- Alimentación UANDES: calendario/asignación 2027 pero pie de condiciones aún 2026; se conserva inactiva. Económica sí presenta condiciones de ingreso 2027 coherentes.
- Nuevo Milenio II: la ficha mantiene una fecha de acreditación anterior; no se trasladaron automáticamente las reglas ni la activación de modalidad I.
- Juan Gómez Millas y Bicentenario: referencias de acreditación de distintos años; no se actualizó el año por suposición ni se activaron por el anuncio FUAS general.
- BAE UChile: el encabezado corresponde a actualización FOCES; no acredita un cierre uniforme de solicitudes. Andrés Bello es un proceso futuro de enero 2027. Residencias mezcla años; permanecen inactivas.
- UAI: el cierre de diciembre pertenece a María Isabel Sprenger, no a las candidatas Total, Mantención o Puntaje.
- Petorca: el 21 de octubre cierra la solicitud; las validaciones hasta el 28 y los depósitos de noviembre no amplían ese cierre. Diego de Almagro cerró el segundo llamado el 23 de octubre.
- Cunco, Dalcahue, Rengo, Frutillar y otros: rendiciones, pagos, resultados y noticias laterales no se usan como fechas de postulación.
- Los calendarios semestrales sin anualidad concreta, beneficios automáticos y solicitudes sin cierre no reciben una fecha por defecto.

Se trabajó con expedientes previos y lotes de selección de nueve grupos de 50 y uno de 78. Las consultas adicionales intentaron 379 fuentes: 320 produjeron texto y 59 no pudieron recuperarse. La revisión limitada de pasajes de calendario no se presenta como lectura íntegra; un documento recuperado, un resultado de búsqueda o HTTP 200 por sí solos no confirman vigencia. Las barreras de acceso y las contradicciones quedan en cada registro; resuelven su selección como inactiva, sin eliminarla.

## Integridad y operación

La conciliación inicial encontró 528 fichas idénticas al CSV. La final conserva los 528 UUID y registra diferencias únicamente en seis fichas: UDD y las cinco activas. Se ajustaron tipo de beca y nivel de ingreso de las activas; NEM 5,0 de Nuevo Milenio I quedó estructurado. Se retiraron notas de trabajo y hashes de sus descripciones públicas; sus trazas siguen en los expedientes y mapas UUID/candidata. La comprobación PostgreSQL por límites de bytes devuelve cero patrones de mojibake.

El CSV inicial y su manifiesto permanecen inmutables. SHA-256 del CSV: `757cec62e2dcb3ac980c65bc4a33c2ea204b6c2eba1b9d536188108400732d16`. No se repitió la importación ni se modificó la base local.

Antes de las modificaciones se conservaron respaldos privados y se comprobaron restauraciones aisladas de las 14 tablas. Últimos respaldos: `pre-catalogo-20261027T193952Z-73dfb13a.dump`, `pre-catalogo-20261027T194246Z-b621413b.dump` y `pre-catalogo-20261027T194742Z-2d8075e8.dump`, dentro del directorio privado de Oracle. No se publican sus contenidos.

Evidencia: `conciliacion_oracle_2026_10_27.json`, `pruebas_api_2026_10_27.json`, `prueba_recuperacion_2026_10_27.json` y `recorridos_web_2026_10_27.json`. El cierre de selección no autoriza promover Vercel a producción ni iniciar P13/P14.
