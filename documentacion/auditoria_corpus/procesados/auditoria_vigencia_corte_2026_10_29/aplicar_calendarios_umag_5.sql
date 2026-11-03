\set ON_ERROR_STOP on
BEGIN;
SET LOCAL lock_timeout='5s';
DO $g$ BEGIN
IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario diferente'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=12 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=12 AND public_id='98c9d555-3d2d-4934-b772-de3c7829fc89'::uuid AND version=1 AND NOT estado_activa AND fecha_cierre_postulacion IS NULL AND fecha_inicio_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado diferente 12'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=211 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=211 AND public_id='3112dffa-bfb6-4917-884b-1bc63e2fe7c6'::uuid AND version=1 AND NOT estado_activa AND fecha_cierre_postulacion IS NULL AND fecha_inicio_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado diferente 211'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=461 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=461 AND public_id='a0830043-203b-4bbf-8c1d-c3cdeaa28293'::uuid AND version=1 AND NOT estado_activa AND fecha_cierre_postulacion IS NULL AND fecha_inicio_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado diferente 461'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=464 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=464 AND public_id='29e88760-f0c1-427d-a27c-8a6496624a5a'::uuid AND version=1 AND NOT estado_activa AND fecha_cierre_postulacion IS NULL AND fecha_inicio_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado diferente 464'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=489 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=489 AND public_id='c8982c95-c281-4d09-9cf7-317a8de7b21a'::uuid AND version=1 AND NOT estado_activa AND fecha_cierre_postulacion IS NULL AND fecha_inicio_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado diferente 489'; END IF;
END $g$;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-02',fecha_cierre_postulacion=DATE '2026-04-30',descripcion_larga='CALENDARIO VERIFICADO: UMAG 2026. Primera recepción del 12 al 23 de enero; segunda recepción del 2 de marzo al 30 de abril. El campo de fechas representa esta segunda ventana, ya cerrada. La resolución enumera expresamente esta modalidad entre las becas internas. No acredita convocatoria 2027 ni apertura permanente.
FUENTE: https://umag.cl/wp-content/uploads/2026/05/CalendarioAcademico2026.pdf ; Resolución 117/VRAC/2026, páginas 2 y 4.
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por esta nota):
' || descripcion_larga,version=version+1 WHERE id_beca=12;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-02',fecha_cierre_postulacion=DATE '2026-04-30',descripcion_larga='CALENDARIO VERIFICADO: UMAG 2026. Primera recepción del 12 al 23 de enero; segunda recepción del 2 de marzo al 30 de abril. El campo de fechas representa esta segunda ventana, ya cerrada. La resolución enumera expresamente esta modalidad entre las becas internas. No acredita convocatoria 2027 ni apertura permanente.
FUENTE: https://umag.cl/wp-content/uploads/2026/05/CalendarioAcademico2026.pdf ; Resolución 117/VRAC/2026, páginas 2 y 4.
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por esta nota):
' || descripcion_larga,version=version+1 WHERE id_beca=211;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-02',fecha_cierre_postulacion=DATE '2026-04-30',descripcion_larga='CALENDARIO VERIFICADO: UMAG 2026. Primera recepción del 12 al 23 de enero; segunda recepción del 2 de marzo al 30 de abril. El campo de fechas representa esta segunda ventana, ya cerrada. La resolución enumera expresamente esta modalidad entre las becas internas. No acredita convocatoria 2027 ni apertura permanente.
FUENTE: https://umag.cl/wp-content/uploads/2026/05/CalendarioAcademico2026.pdf ; Resolución 117/VRAC/2026, páginas 2 y 4.
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por esta nota):
' || descripcion_larga,version=version+1 WHERE id_beca=461;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-02',fecha_cierre_postulacion=DATE '2026-04-30',descripcion_larga='CALENDARIO VERIFICADO: UMAG 2026. Primera recepción del 12 al 23 de enero; segunda recepción del 2 de marzo al 30 de abril. El campo de fechas representa esta segunda ventana, ya cerrada. La resolución enumera expresamente esta modalidad entre las becas internas. No acredita convocatoria 2027 ni apertura permanente.
FUENTE: https://umag.cl/wp-content/uploads/2026/05/CalendarioAcademico2026.pdf ; Resolución 117/VRAC/2026, páginas 2 y 4.
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por esta nota):
' || descripcion_larga,version=version+1 WHERE id_beca=464;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-02',fecha_cierre_postulacion=DATE '2026-04-30',descripcion_larga='CALENDARIO VERIFICADO: UMAG 2026. Primera recepción del 12 al 23 de enero; segunda recepción del 2 de marzo al 30 de abril. El campo de fechas representa esta segunda ventana, ya cerrada. La resolución enumera expresamente esta modalidad entre las becas internas. No acredita convocatoria 2027 ni apertura permanente.
FUENTE: https://umag.cl/wp-content/uploads/2026/05/CalendarioAcademico2026.pdf ; Resolución 117/VRAC/2026, páginas 2 y 4.
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por esta nota):
' || descripcion_larga,version=version+1 WHERE id_beca=489;
COMMIT;
