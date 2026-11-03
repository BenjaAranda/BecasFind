BEGIN;
SET LOCAL lock_timeout = '5s';

DO $guard$
BEGIN
    IF CURRENT_DATE NOT BETWEEN DATE '2026-01-13' AND DATE '2026-12-31' THEN
        RAISE EXCEPTION 'La convocatoria 2026 requiere nueva revisión';
    END IF;
    PERFORM id_beca FROM becas WHERE id_beca IN (310,356) FOR UPDATE;
    IF (SELECT count(*) FROM becas WHERE id_beca=310
        AND nombre='Beca Alumni UDD' AND estado_activa=false
        AND fecha_inicio_postulacion=DATE '2026-11-02' AND fecha_cierre_postulacion=DATE '2026-11-25'
        AND url_oficial='https://postgrados.udd.cl/programas/curso-gestion-de-compensaciones-240050/'
        AND position('92e4ad7a0560c3a831af47c3412ee193c26746839a7b4fbc7e949183226b0c26' IN descripcion_larga)>0) <> 1
    THEN RAISE EXCEPTION 'La ficha UDD cambio; revisar antes de modificar'; END IF;
    IF (SELECT count(*) FROM becas WHERE id_beca=356
        AND nombre='Beca Hijos de Funcionarios' AND estado_activa=false
        AND fecha_inicio_postulacion=DATE '2026-01-13' AND fecha_cierre_postulacion=DATE '2026-12-31'
        AND url_oficial='https://uchile.cl/convocatorias/7790/descuento-de-arancel-para-hijos-de-funcionarios-o-academicos'
        AND position('a7add480ae1c014fbf47d21eeffd015842829399ea2988e2d743f41393504c11' IN descripcion_larga)>0) <> 1
    THEN RAISE EXCEPTION 'La ficha UChile cambio; revisar antes de modificar'; END IF;
END;
$guard$;

UPDATE becas SET fecha_inicio_postulacion=NULL, fecha_cierre_postulacion=NULL,
    descripcion_larga=descripcion_larga || E'\nACLARACIÓN DEL CALENDARIO: del 2 al 25 de noviembre de 2026 son fechas de clases. La fuente anuncia inscripción abierta sin publicar su fecha límite. Calendario de postulación no especificado; ficha inactiva.',
    version=version+1
WHERE id_beca=310;

UPDATE becas SET estado_activa=true,
    descripcion_corta='Rebaja del arancel de pregrado UChile para hijos de funcionarios o académicos. Cobertura según situación de ingreso; vínculo; jornada y renta.',
    descripcion_larga=$description$Convocatoria 2026: del 13 de enero al 31 de diciembre. Beneficio para estudiantes de pregrado UChile hijos de funcionarios o académicos.
Primer ingreso y primera carrera: 100% del arancel para hijos de personal vigente. En otras situaciones se aplican descuentos de 25%; 50% o 100% según vínculo; jornada y renta. Jubilados de jornada completa: 25%.
Ingresar el RUN del progenitor durante la matrícula. Si no se registra el beneficio; solicitar revisión a postulacionbhf@uchile.cl. Las solicitudes posteriores a matrícula no son retroactivas. La renovación exige conservar condiciones y pagos al día. Fallecimiento y beneficio Margarita Ancacoy tienen condiciones particulares; consultar la fuente.
DOCUMENTOS REQUERIDOS: [OBLIGATORIO] Para solicitudes como hijo de jubilado: certificado AFP o resolución de pensión IPS.$description$,
    version=version+1
WHERE id_beca=356;

COMMIT;

SELECT id_beca, public_id, nombre, estado_activa, fecha_inicio_postulacion, fecha_cierre_postulacion
FROM becas WHERE id_beca IN (310,356) ORDER BY id_beca;
SELECT count(*) AS total, count(*) FILTER (WHERE estado_activa) AS activas,
       count(*) FILTER (WHERE fecha_cierre_postulacion IS NULL) AS cierre_desconocido
FROM becas;
