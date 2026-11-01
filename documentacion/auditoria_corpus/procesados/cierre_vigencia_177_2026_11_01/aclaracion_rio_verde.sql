\set ON_ERROR_STOP on
BEGIN;
SET LOCAL lock_timeout='5s';
DO $guardas$ BEGIN
PERFORM id_beca FROM becas WHERE id_beca=374 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=374 AND public_id='3465cdb7-f393-4de2-b9e5-cf8fc70c8465'::uuid AND version=2 AND md5(descripcion_larga)='a9f6850b0d6a9798d7f92c490149fd45' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha 374 modificada'; END IF;
END $guardas$;
UPDATE becas SET descripcion_larga='ACLARACIÓN INDIVIDUAL RÍO VERDE · 01/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
El afiche oficial «Último llamado», enlazado desde la noticia municipal del 25/03/2026, fija entrega de documentos hasta el 31 de marzo de 2026. El afiche informativo del mismo proceso indica recepción del 1 al 31 de marzo. La continuación del segundo semestre requiere certificado en agosto conforme a la ficha de requisitos; no constituye una nueva postulación general. Esta evidencia sustituye la anterior falta de día de cierre; no acredita una nueva convocatoria abierta ni modifica la cobertura en UTM.
FUENTES: https://www.rioverde.cl/noticias/392-proceso-de-beca-municipalidad-de-rio-verde-2026-2 ; https://www.rioverde.cl/images/Beca2026/Ultimo%20llamado%20a%20la%20beca%202026%20web.jpg ; https://www.rioverde.cl/images/BENEFICIOS/BECA/Afiche%20informativo%20de%20becas%202026%20V2.jpg
ANTECEDENTES CONSERVADOS:
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-03-01',fecha_cierre_postulacion=DATE '2026-03-31' WHERE id_beca=374;
COMMIT;
