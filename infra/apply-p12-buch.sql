BEGIN;
SET LOCAL lock_timeout = '5s';
DO $guard$
BEGIN
    IF CURRENT_TIMESTAMP NOT BETWEEN TIMESTAMPTZ '2026-09-21 00:00:00 America/Santiago'
        AND TIMESTAMPTZ '2026-10-30 11:59:59 America/Santiago' THEN
        RAISE EXCEPTION 'La ampliación BUCH requiere nueva revisión';
    END IF;
    PERFORM id_beca FROM becas WHERE public_id='c8d21ab3-66b0-45ad-8d2b-17c764918549' FOR UPDATE;
    IF (SELECT count(*) FROM becas WHERE public_id='c8d21ab3-66b0-45ad-8d2b-17c764918549'
        AND version=0 AND estado_activa=false AND fecha_cierre_postulacion=DATE '2026-10-19'
        AND url_oficial='https://uchile.cl/dbe/buch'
        AND position('371af7982aa3b8152cd1d362a873b11e7744674163eef5d869aba7c715a031fe' IN descripcion_larga)>0) <> 1
    THEN RAISE EXCEPTION 'BUCH cambió: volver a conciliar antes de modificar'; END IF;
END;
$guard$;
UPDATE becas SET fecha_cierre_postulacion=DATE '2026-10-30', estado_activa=true,
    descripcion_corta='BUCH admisión 2027: 100 cupos con matrícula y arancel completos. Postula hasta el 30 de octubre de 2026 a las 12:00; revisa los requisitos.',
    descripcion_larga=replace(descripcion_larga,
        'Postulación digital 21 septiembre–19 octubre 2026 al mediodía; la fecha almacenada no representa la hora y el registro sigue inactivo.',
        'Postulación digital del 21 de septiembre al 30 de octubre de 2026 hasta las 12:00 (America/Santiago). Ampliación publicada en la convocatoria oficial; el cierre al mediodía se aplica con un temporizador operativo específico.'),
    version=version+1
WHERE public_id='c8d21ab3-66b0-45ad-8d2b-17c764918549';
COMMIT;
