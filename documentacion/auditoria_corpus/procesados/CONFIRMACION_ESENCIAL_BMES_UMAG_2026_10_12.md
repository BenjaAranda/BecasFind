# Corrección y confirmación esencial de BMES en UMAG — 12 de octubre de 2026

## Candidata

- Hash: `ec336267e6863dc06ee5e692b4fba940673ba7c826abf8eb150a800d87e0940c`
- Registro original: `ScrapperBecasFind/data_lake_becas/03_procesados/bloque8_docs.csv#10`
- Nombre original: «Beca de Mantención UMAG».

## Identidad y fuentes

La página oficial de Admisión UMAG enumera la **Beca de Mantención para la Educación Superior (BMES)** dentro de las becas JUNAEB disponibles para su comunidad. La ficha oficial de ChileAtiende, cuya información atribuye a JUNAEB, identifica a BMES como un beneficio monetario de libre disposición de **$207.950 anuales referenciales**, pagado en hasta diez cuotas. La ficha de Ayuda Mineduc publicada para BMES establece los requisitos vigentes.

Fuentes oficiales:

- [UMAG — Becas y beneficios](https://admision.umag.cl/?page_id=634)
- [ChileAtiende / JUNAEB — ficha BMES](https://www.chileatiende.gob.cl/fichas/10453/1/pdf)
- [Ayuda Mineduc — BMES y requisitos](https://www.ayudamineduc.cl/ficha/beca-de-mantencion-educacion-superior-bmes)

## Correcciones frente al original

La candidata sí corresponde a una beca de mantención identificable, pero la información del registro mezcla datos no respaldados con la BMES. La cobertura no es alojamiento y alimentación: es un aporte monetario de libre disposición. No se confirman para BMES el tope RSH de 60%, las fechas 1 de enero–31 de diciembre ni los documentos enumerados en el original; se guardan como desconocidos y no se migran al contenido corregido. La unidad responsable es JUNAEB; UMAG la lista como beneficio externo para sus estudiantes.

## Alcance esencial confirmado

- **Identidad:** BMES, beneficio JUNAEB listado también por UMAG.
- **Beneficio:** $207.950 anuales referenciales en hasta diez cuotas; la cifra es referencial y no se convierte en garantía de adjudicación.
- **Requisitos principales:** integrar la última resolución de asignación de JUNAEB; estar matriculado en una institución de educación superior reconocida por el Estado; y contar con un beneficio de arancel entregado por Mineduc o Comisión Ingresa.
- **Estado de convocatoria:** no postulable; solo permite continuidad de beneficiarios previos. No se confirma una fecha de cierre de convocatoria vigente. Mantener inactiva y fuera de búsqueda vigente hasta contar con un proceso publicable con fechas confirmadas.
- **Documentos:** desconocidos en las fuentes citadas; no inferirlos.

Esta corrección confirma la identidad y los datos esenciales del programa BMES; no confirma que el apoyo original de alojamiento/alimentación exista como beneficio interno UMAG. El original permanece íntegro en `originales.jsonl`.
