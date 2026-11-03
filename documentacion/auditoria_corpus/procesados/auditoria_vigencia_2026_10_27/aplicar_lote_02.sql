BEGIN;
SET LOCAL lock_timeout='5s';
SET LOCAL TIME ZONE 'America/Santiago';
DO $guard$
BEGIN
    IF CURRENT_DATE NOT BETWEEN DATE '2026-10-19' AND DATE '2027-01-28' THEN
        RAISE EXCEPTION 'Revisar nuevamente el calendario antes de aplicar';
    END IF;
    PERFORM id_beca FROM becas WHERE id_beca=445 FOR UPDATE;
    IF NOT EXISTS (SELECT 1 FROM becas WHERE id_beca=445
        AND public_id='929f4d5c-231e-4443-92c9-6ca2cb1cde87' AND version=0
        AND NOT estado_activa AND fecha_inicio_postulacion IS NULL
        AND fecha_cierre_postulacion IS NULL) THEN
        RAISE EXCEPTION 'Estado previo diferente: detener y conciliar';
    END IF;
    IF (SELECT count(*) FROM becas)<>528 THEN
        RAISE EXCEPTION 'Inventario diferente: detener y conciliar';
    END IF;
END;
$guard$;
UPDATE becas SET estado_activa=true, version=version+1,
    fecha_inicio_postulacion=DATE '2026-10-19',
    fecha_cierre_postulacion=DATE '2027-01-28',
    url_oficial='https://admision.uandes.cl/becas/beca-alimentacion-uandes',
    descripcion_corta='Beca de Alimentación UANDES: crédito mensual para consumo en campus. Solicitud de ingreso 2027 junto con Beca Económica; cierre el 28 de enero de 2027.',
    descripcion_larga=$d$ALCANCE VERIFICADO: solicitud de ingreso 2027; recepción del 19 de octubre de 2026 al 28 de enero de 2027. La ficha específica vincula este beneficio al formulario de Beca Económica; esta última identifica expresamente admisión 2027 y el mismo calendario.
BENEFICIO: crédito mensual en campus de marzo a diciembre; $88.000 sin BAES JUNAEB y $44.000 con ella. No es una transferencia bancaria.
REQUISITOS PRINCIPALES: acreditación socioeconómica y solicitud completa con documentos. Nuevos solicitan junto con Económica; estudiantes vigentes utilizan Banner. La recepción de ingreso indicada no certifica el calendario interno de Banner. No se otorga a ingresados a mitad de año; pueden solicitar para el año siguiente. Requiere nueva evaluación anual; mantener la situación económica no garantiza adjudicación.
LÍMITES: no se acredita un RSH máximo ni un NEM mínimo. El pie de Alimentación conserva referencia 2026; sus fechas y resultado marzo 2027 se corroboran con la ficha Económica 2027. No se traslada un cierre de clases o pago. La hora de cierre no está especificada.
DOCUMENTOS REQUERIDOS: antecedentes de acreditación económica solicitados por el formulario; nómina exhaustiva no especificada en la ficha de Alimentación.
TRAZABILIDAD EDITORIAL: d71f011070e0a643659ede1d40035465e6fc14d9cbe28d1a6aa4dc122f2f1bfb1; CONFIRMADA_ESENCIAL. Confirmación editorial separada de vigencia.$d$
WHERE id_beca=445;
COMMIT;
