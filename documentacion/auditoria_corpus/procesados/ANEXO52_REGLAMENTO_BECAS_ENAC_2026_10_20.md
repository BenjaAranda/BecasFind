# Localización del Reglamento de Becas ENAC, anexo 52

**Consulta:** 20 de octubre de 2026. **Alcance:** cuatro candidatas ENAC que siguen en la cola esencial: Apoyo Familiar, Deportiva, Titulado y Vocación de Servicio.

## Evidencia institucional localizada

La página institucional archivada de documentación de Aseguramiento de la Calidad ENAC incluye una sección «Reglamentos» y enlaza el documento **«52. Cap 13, Reglamento de becas»**. La página recuperada corresponde a la captura del 15 de junio de 2017:

- Página oficial archivada: <https://web.archive.org/web/20170615143728id_/http://aseguramientocalidad.enac.cl/index.php/ac-docs>
- Enlace exacto publicado por esa página: <http://aseguramientocalidad.enac.cl/images/acredita/acc-documentos/reglamentos/52-Cap-13-Reglamento-de-becas.pdf>
- SHA-256 de la copia HTML consultada: `09677FD3428EF86C1AD8BB9BEC6035A0B220B16CC9C5FB4A1C112290EAB14676`.

Esto acredita que el índice institucional listaba un reglamento de becas, pero no permite atribuir a ese reglamento las cuatro modalidades ni sus porcentajes o condiciones: el PDF no se pudo recuperar. Los intentos de lectura del enlace archivado devolvieron HTTP 503 con la página «Temporarily Offline» de Internet Archive; el dominio antiguo ya no resuelve directamente. La consulta de historial a Arquivo.pt para la URL exacta respondió `estimated_nr_results: 0`. La búsqueda pública por nombre exacto del archivo no halló una copia oficial indexada. El 20 de octubre se consultó además la API pública de disponibilidad de Internet Archive, que devolvió `archived_snapshots: {}` para la URL exacta; el índice CDX respondió HTTP 503. Esto solo confirma que no se pudo recuperar otra copia desde esos servicios; no prueba que el reglamento no exista ni invalida la lista institucional archivada. No se toma ninguna de estas fallas como prueba de inexistencia.

## Contraste con el acta oficial CNA N.º 1004

En una consulta posterior se revisó el [acta CNA N.º 1004](https://www.cnachile.cl/Actas%20de%20Sesiones/ACTAN1004.pdf), cuyo texto y anexo corresponden al proceso de acreditación institucional de ENAC de 2016. El expediente describe servicios y beneficios estudiantiles en términos generales, pero no identifica Apoyo Familiar, Deportiva, Titulado ni Vocación de Servicio. Por su objeto y alcance, no confirma ni contradice la identidad de esas cuatro modalidades y no sustituye el Reglamento de Becas del anexo 52. Se descarta como evidencia resolutiva para las cuatro candidatas; no como documento válido de acreditación institucional.

## Decisión editorial

Las cuatro candidatas continúan pendientes. El documento índice no confirma identidad, beneficio ni requisitos de ninguna. No se cambia ningún campo de beca ni se descarta un registro. El paso concreto es recuperar el PDF desde una copia institucional o una captura archivada accesible, o encontrar un acto o reglamento institucional que identifique individualmente cada modalidad. Los enlaces de evidencia previa y las diferencias entre los beneficios están en `CONFIRMACION_ESENCIAL_BECAS_INTERNAS_ENAC_2013_2015_2026_10_19.md` y `CONTRASTE_ARCHIVOS_ESPECIFICOS_2026_10_19.md`.

## Contraste institucional público adicional (21 de octubre de 2026)

Se revisaron las páginas institucionales actuales de [Admisión ENAC](https://enac.cl/admision/), [Atención Estudiantil y Permanencia](https://enac.cl/estudiantes/atencion-estudiantil/), [portal de estudiantes](https://enac.cl/estudiantes/) y [sitio principal](https://enac.cl/). ENAC declara su adscripción a beneficios Mineduc/JUNAEB y mantiene una coordinación de Orientación y Participación Social para orientar sobre beneficios internos o externos; el área no publica en esas páginas reglas que individualicen Apoyo Familiar, Deportiva, Titulado o Vocación de Servicio ni los porcentajes y destinatarios del CSV. El sitio principal presenta beneficios de admisión 2027, pero no se considera un inventario histórico exhaustivo.

Las páginas oficiales acreditan que ENAC ofrece orientación sobre beneficios estudiantiles y que existen beneficios internos en general; no demuestran por sí mismas que las cuatro candidatas sean modalidades con esos nombres ni refutan una convocatoria anterior. La ausencia de las denominaciones en páginas actuales no se usa como prueba negativa. Se conserva `REQUIERE_ACLARACION` para las cuatro, sin trasladar requisitos de otras becas ni corregir el CSV defectuoso.

## Incidencia de integridad del CSV de origen (20 de octubre de 2026)

Al contrastar `originales.jsonl` con `ScrapperBecasFind/data_lake_becas/03_procesados/becas_cftenac.csv`, la candidata «Beca Vocación de Servicio ENAC» (`1e99953c14c855e25d0c8dc49e63a2b99a3957f9459258142435bfe2bf1a5656`) aparece con `COLUMNAS_AUSENTES`. La descripción larga de la fila física de Vocación contiene comas no entrecomilladas y, a continuación, incorpora el texto de la fila «Beca Titulado ENAC». El CSV leído como texto sí enumera Vocación y Titulado en filas distintas; por eso la concatenación es una anomalía de parseo/estructura, no evidencia positiva de que las becas sean una misma modalidad, un duplicado o programas falsos.

No se modifica ni se reescribe el CSV original y no se corrige ningún dato de las candidatas a partir de este archivo defectuoso. Las cuatro candidatas ENAC siguen pendientes porque aún falta una fuente institucional específica recuperable que confirme identidad, beneficio y requisitos principales de cada modalidad. La lista institucional archivada del Reglamento (anexo 52) no basta para resolverlo; véase el análisis de recuperación en este informe.

## Verificación final del archivo exacto en Internet Archive (22 de octubre de 2026)

Se consultaron directamente los endpoints públicos CDX y TimeMap de Internet Archive para la URL exacta del PDF enlazado por el índice institucional. Ambos respondieron HTTP 200 con `[]`; el índice consultado no registra una captura de esa URL. Repetir la descarga o la consulta de disponibilidad de esa misma URL no es una vía útil con el estado actual del archivo. Esto no demuestra que el reglamento no exista ni cambia la decisión sobre las cuatro candidatas.

## Ruta institucional adicional — consulta 23 de octubre de 2026

Se revisaron de nuevo, con búsquedas acotadas a subdominios y documentos ENAC, el portal institucional de matrícula 2026, el apartado institucional de documentos y los servicios para estudiantes. El portal de matrícula presenta el campo “Monto Arancel (Incluye beca Enac)”, pero no nombra el beneficio ni publica sus condiciones en el contenido recuperable. El portal estudiantil dirige las consultas de becas internas y estatales a Permanencia Estudiantil/DIPE; la página de Admisión consultada describe gratuidad, CAE y becas Mineduc/JUNAEB. Ninguna de estas páginas identifica Apoyo Familiar, Deportiva, Titulado o Vocación de Servicio ni permite atribuirles porcentajes o requisitos.

La página institucional de documentos enlaza reglamentos académicos y políticas generales, pero en la ruta consultada no expone el Reglamento de Becas del anexo 52. Las búsquedas oficiales acotadas por nombre y por ubicación de PDF no localizaron una copia pública adicional. El expediente y el índice de 2017 muestran que ENAC tuvo y publicó información sobre becas internas, por lo que el fracaso de recuperación del reglamento no es evidencia de inexistencia de las modalidades.

Fuentes oficiales revisadas: [matrícula ENAC 2026](https://sistemas.enac.cl/pages/matriculas/newSolicitud.php), [documentos institucionales](https://enac.cl/institucion/), [servicios para estudiantes](https://enac.cl/estudiantes/) y [Admisión](https://enac.cl/admision/).

**Decisión:** las cuatro candidatas permanecen `EXCLUSION_HISTORICA_SIN_RATIFICAR`. No se modifica el CSV original, no se traslada el beneficio genérico del portal de matrícula y no se ratifica descarte. La fuente resolutiva que falta continúa siendo el Reglamento de Becas o una publicación institucional que identifique individualmente las modalidades y su periodo. No repetir la búsqueda del anexo 52 en Internet Archive ni los catálogos generales ya revisados; solo reabrir esta ruta si aparece un enlace o documento institucional nuevo.
