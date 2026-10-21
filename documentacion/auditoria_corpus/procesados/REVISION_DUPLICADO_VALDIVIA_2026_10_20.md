# Duplicidad documental en candidatas de Valdivia — 20 de octubre de 2026

## Decisión

Se excluye del conteo editorial únicamente la identidad repetida `35f9a8955aef575df868a6d378cbd6bc7ba653a0bdd2a242aedfc9d46fe5b313` como duplicado de la candidata canónica `dbcdf820447cc2d3a206a3db3a4943a999a500d92860f58843dd045b194c6e18`. La beca genérica que alegan ambas fichas sigue sin confirmación oficial; esta deduplicación no confirma ni niega que exista.

## Evidencia comparada en los originales preservados

Las dos filas proceden de archivos originales distintos del corpus: `bloque5_muni.csv` (registro 3) y `bloque12_muni.csv` (registro 5). Coinciden en:

- Institución: Municipalidad de Valdivia.
- Modalidad alegada: beca municipal DIDECO de mantención/libre disposición para educación superior.
- Monto: subsidio municipal de mantención de libre disposición.
- Inicio: 1 de marzo de 2026.
- Umbral alegado: RSH 60% y NEM 5,0; la ficha canónica también conserva la variación de 5,0/5,5 que la misma descripción atribuye a las bases del año.
- Región XIV, misma URL municipal raíz y misma población implícita de estudiantes de educación superior.

Las diferencias —cierre 31 de marzo frente a 31 de mayo, listas documentales y pequeñas variaciones de redacción— no nombran otra beca, modalidad, población o convocatoria. Ambas filas describen la misma ficha genérica, repetida en bloques del data lake. Se conserva como canónica la primera entrada del corpus (`bloque5_muni.csv`); no se combinan sus campos ni se selecciona una fecha oficial.

## Alcance y trazabilidad

Se retira solo la copia de la cola de revisión y se registra `DUPLICADO_IDENTIDAD`. Los dos CSV originales y sus filas no se modifican. La candidata canónica permanece en `pendientes_esenciales_actuales.csv` hasta que una fuente oficial específica identifique el programa y sus requisitos. No usar esta deduplicación para afirmar vigencia ni para publicar los valores alegados.
