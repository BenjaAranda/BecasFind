BEGIN;
SET LOCAL lock_timeout = '5s';
SET LOCAL TIME ZONE 'America/Santiago';

DO $guard$
BEGIN
    IF CURRENT_TIMESTAMP NOT BETWEEN TIMESTAMPTZ '2026-10-01 00:00 America/Santiago'
                                AND TIMESTAMPTZ '2026-11-05 14:00 America/Santiago' THEN
        RAISE EXCEPTION 'El plazo FUAS revisado requiere nueva comprobación';
    END IF;
    PERFORM id_beca FROM becas WHERE id_beca IN (253,272,320) FOR UPDATE;
    IF (SELECT count(*) FROM becas WHERE id_beca IN (253,272,320)
        AND version=0 AND NOT estado_activa
        AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) <> 3 THEN
        RAISE EXCEPTION 'Las fichas ya cambiaron; no repetir';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM becas WHERE id_beca=253
        AND public_id='bc2eb567-a143-4bf6-9fdb-ef1e722e9df1'
        AND url_oficial='https://admision.uandes.cl/becas/beca-uandes-economica')
    OR NOT EXISTS (SELECT 1 FROM becas WHERE id_beca=272
        AND public_id='b5866285-b077-4806-b0cb-2d8f277956f6'
        AND url_oficial='https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-nuevo-milenio-bnm')
    OR NOT EXISTS (SELECT 1 FROM becas WHERE id_beca=320
        AND public_id='1178ad3c-4894-4f76-a060-e0d75cacfa1e'
        AND url_oficial='https://portal.beneficiosestudiantiles.cl/gratuidad') THEN
        RAISE EXCEPTION 'Identidad o fuente diferentes';
    END IF;
END;
$guard$;

UPDATE becas SET estado_activa=true, version=version+1,
    fecha_inicio_postulacion=DATE '2026-10-19', fecha_cierre_postulacion=DATE '2027-01-28',
    descripcion_corta='Admisión 2027: descuento de 15–70% en matrícula y arancel según evaluación económica. Postulación hasta el 28 de enero de 2027.',
    descripcion_larga=$d$Beca UANDES Económica para ingreso 2027 por admisión directa o PAES a pregrado o bachillerato. Descuento de 15–70% en matrícula y arancel anual según evaluación económica familiar.
Postulación del 19 de octubre de 2026 al 28 de enero de 2027. Completar el formulario y adjuntar los antecedentes dentro del plazo. La cobertura en línea es referencial y puede ajustarse tras revisar la documentación. La renovación exige acreditar anualmente la situación económica. No aplica a ingreso de mitad de año ni se acumula con otras becas UANDES; sí puede complementarse con ayudas estatales.
DOCUMENTOS REQUERIDOS: [OBLIGATORIO] Formulario de acreditación económica completo. [OBLIGATORIO] Antecedentes familiares de ingresos y gastos requeridos en el formulario; hasta diez archivos PDF. Consultar la nómina oficial aplicable al caso.
TRAZABILIDAD EDITORIAL: 7ae777fdde7894ecc523a0a19f243e12a089b2d8707b56301ccf515ce9ddabd9; actualización de convocatoria verificada el 27/10/2026.$d$
WHERE id_beca=253;

UPDATE becas SET estado_activa=true, version=version+1,
    fecha_inicio_postulacion=DATE '2026-10-01', fecha_cierre_postulacion=DATE '2026-11-05',
    descripcion_corta='Nuevo Milenio I: hasta $600.000 del arancel anual técnico profesional. FUAS 2027 abierto hasta el 5 de noviembre de 2026 a las 14:00.',
    descripcion_larga=$d$Nuevo Milenio I financia hasta $600.000 del arancel anual. Para formación técnica superior o carrera profesional en instituto profesional; modalidad presencial; nacionalidad chilena; NEM mínimo 5,0 y pertenencia al 70% de menores ingresos evaluada por MINEDUC mediante FUAS. Esa evaluación no equivale automáticamente al porcentaje RSH.
La institución debe estar acreditada al 31/12/2026 o eximida para 2027 conforme al listado ministerial. Estudiantes antiguos deben cumplir avance académico. Se aplican restricciones por títulos y becas previas; consultar la ficha oficial. No se confunde con Nuevo Milenio II.
Primera postulación FUAS para beneficios 2027: del 1 de octubre al 5 de noviembre de 2026; cierre a las 14:00 de Chile continental. Completar FUAS no garantiza asignación: se requieren matrícula elegible y validación socioeconómica. Calendario contrastado con portal MINEDUC y https://www.ucentral.cl/postulacion-fuas-2027/.
DOCUMENTOS REQUERIDOS: No especificados exhaustivamente en la ficha consultada. La institución puede solicitar acreditación socioeconómica.
TRAZABILIDAD EDITORIAL: 833ac94e0448048a743d3eb07059c99cd9c3a38228f0966d98e5e34fdc2fbf54; calendario revisado el 27/10/2026.$d$
WHERE id_beca=272;
UPDATE requisitos_perfil SET nem_minimo=5.0 WHERE id_beca=272;

UPDATE becas SET estado_activa=true, version=version+1,
    fecha_inicio_postulacion=DATE '2026-10-01', fecha_cierre_postulacion=DATE '2026-11-05',
    descripcion_corta='Gratuidad 2027: matrícula y arancel durante la duración nominal. Completa FUAS hasta el 5 de noviembre de 2026 a las 14:00; asignación sujeta a requisitos.',
    descripcion_larga=$d$Gratuidad cubre matrícula y arancel durante la duración nominal de una carrera presencial de pregrado en una institución adscrita. Pueden postular estudiantes nuevos y antiguos del 60% de menores ingresos; MINEDUC evalúa mediante FUAS y bases estatales; no equivale automáticamente al porcentaje RSH.
Debe cumplirse la condición de nacionalidad o residencia. Existen restricciones por títulos previos y duración; las excepciones para formación pedagógica y articulación técnica están en la ficha oficial. El listado institucional visible consultado corresponde a 2026; comprobar la elegibilidad definitiva de la matrícula 2027 en MINEDUC. La postulación no garantiza asignación.
Primera postulación FUAS 2027: del 1 de octubre al 5 de noviembre de 2026; cierre a las 14:00 de Chile continental. Calendario contrastado con portal MINEDUC y https://www.ucentral.cl/postulacion-fuas-2027/. Quienes renuevan y cumplen requisitos no deben completar un nuevo FUAS solo por renovar.
DOCUMENTOS REQUERIDOS: No especificados exhaustivamente en la ficha consultada. Si hay antecedentes incompletos o inconsistentes; acreditar la situación socioeconómica en la institución.
TRAZABILIDAD EDITORIAL: 96f76b70a68a1fad5f60009a09c9ed4bedcb7f1cae9bb4476eb92014ccca609c; calendario revisado el 27/10/2026.$d$
WHERE id_beca=320;

COMMIT;
SELECT count(*) AS total, count(*) FILTER (WHERE estado_activa) AS activas FROM becas;
