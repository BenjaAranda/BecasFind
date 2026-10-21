# Localización del Reglamento de Becas ENAC, anexo 52

**Consulta:** 20 de octubre de 2026. **Alcance:** cuatro candidatas ENAC que siguen en la cola esencial: Apoyo Familiar, Deportiva, Titulado y Vocación de Servicio.

## Evidencia institucional localizada

La página institucional archivada de documentación de Aseguramiento de la Calidad ENAC incluye una sección «Reglamentos» y enlaza el documento **«52. Cap 13, Reglamento de becas»**. La página recuperada corresponde a la captura del 15 de junio de 2017:

- Página oficial archivada: <https://web.archive.org/web/20170615143728id_/http://aseguramientocalidad.enac.cl/index.php/ac-docs>
- Enlace exacto publicado por esa página: <http://aseguramientocalidad.enac.cl/images/acredita/acc-documentos/reglamentos/52-Cap-13-Reglamento-de-becas.pdf>
- SHA-256 de la copia HTML consultada: `09677FD3428EF86C1AD8BB9BEC6035A0B220B16CC9C5FB4A1C112290EAB14676`.

Esto acredita que el índice institucional listaba un reglamento de becas, pero no permite atribuir a ese reglamento las cuatro modalidades ni sus porcentajes o condiciones: el PDF no se pudo recuperar. Los intentos de lectura del enlace archivado devolvieron HTTP 503 con la página «Temporarily Offline» de Internet Archive; el dominio antiguo ya no resuelve directamente. La consulta de historial a Arquivo.pt para la URL exacta respondió `estimated_nr_results: 0`. La búsqueda pública por nombre exacto del archivo no halló una copia oficial indexada. El 20 de octubre se consultó además la API pública de disponibilidad de Internet Archive, que devolvió `archived_snapshots: {}` para la URL exacta; el índice CDX respondió HTTP 503. Esto solo confirma que no se pudo recuperar otra copia desde esos servicios; no prueba que el reglamento no exista ni invalida la lista institucional archivada. No se toma ninguna de estas fallas como prueba de inexistencia.

## Decisión editorial

Las cuatro candidatas continúan pendientes. El documento índice no confirma identidad, beneficio ni requisitos de ninguna. No se cambia ningún campo de beca ni se descarta un registro. El paso concreto es recuperar el PDF desde una copia institucional o una captura archivada accesible, o encontrar un acto o reglamento institucional que identifique individualmente cada modalidad. Los enlaces de evidencia previa y las diferencias entre los beneficios están en `CONFIRMACION_ESENCIAL_BECAS_INTERNAS_ENAC_2013_2015_2026_10_19.md` y `CONTRASTE_ARCHIVOS_ESPECIFICOS_2026_10_19.md`.

## Incidencia de integridad del CSV de origen (20 de octubre de 2026)

Al contrastar `originales.jsonl` con `ScrapperBecasFind/data_lake_becas/03_procesados/becas_cftenac.csv`, la candidata «Beca Vocación de Servicio ENAC» (`1e99953c14c855e25d0c8dc49e63a2b99a3957f9459258142435bfe2bf1a5656`) aparece con `COLUMNAS_AUSENTES`. La descripción larga de la fila física de Vocación contiene comas no entrecomilladas y, a continuación, incorpora el texto de la fila «Beca Titulado ENAC». El CSV leído como texto sí enumera Vocación y Titulado en filas distintas; por eso la concatenación es una anomalía de parseo/estructura, no evidencia positiva de que las becas sean una misma modalidad, un duplicado o programas falsos.

No se modifica ni se reescribe el CSV original y no se corrige ningún dato de las candidatas a partir de este archivo defectuoso. Las cuatro candidatas ENAC siguen pendientes porque aún falta una fuente institucional específica recuperable que confirme identidad, beneficio y requisitos principales de cada modalidad. La lista institucional archivada del Reglamento (anexo 52) no basta para resolverlo; véase el análisis de recuperación en este informe.
