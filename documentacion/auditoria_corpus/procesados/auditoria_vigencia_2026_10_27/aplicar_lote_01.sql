BEGIN;
SET LOCAL lock_timeout='5s';
SET LOCAL TIME ZONE 'America/Santiago';
DO $guard$
BEGIN
    IF CURRENT_DATE NOT BETWEEN DATE '2026-09-01' AND DATE '2027-01-31' THEN
        RAISE EXCEPTION 'La convocatoria deportiva necesita nueva comprobación temporal';
    END IF;
    PERFORM id_beca FROM becas WHERE id_beca IN (314,518) FOR UPDATE;
    IF (SELECT count(*) FROM becas WHERE
        ((id_beca=314 AND public_id='a721fbc7-5b58-46db-ac88-5999638e9c38') OR
         (id_beca=518 AND public_id='f763f289-b70d-472a-bedd-141f216e0ed1'))
        AND version=0 AND NOT estado_activa
        AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL)<>2 THEN
        RAISE EXCEPTION 'Identidad o estado previo diferentes: detener y conciliar';
    END IF;
    IF (SELECT count(*) FROM becas)<>528 OR
       (SELECT count(*) FROM tipos_beca WHERE nombre='Beca de Arancel')<>1 THEN
        RAISE EXCEPTION 'El inventario o los catálogos cambiaron';
    END IF;
END;
$guard$;

UPDATE becas SET estado_activa=true, version=version+1,
    fecha_inicio_postulacion=DATE '2026-09-01', fecha_cierre_postulacion=DATE '2027-01-31',
    url_oficial='https://explora.unab.cl/deportes-unab-formacion-apoyo-y-oportunidades-para-compatibilizar-los-estudios-con-el-alto-rendimiento/',
    id_tipo_beca=(SELECT id_tipo_beca FROM tipos_beca WHERE nombre='Beca de Arancel'),
    descripcion_corta='Beca Deportiva UNAB: descuento del 10% al 100% del arancel según evaluación deportiva. Postulación del 1 de septiembre de 2026 al 31 de enero de 2027.',
    descripcion_larga=$d$Beca Deportiva de la Universidad Andrés Bello para deportistas destacados; seleccionados nacionales; deportistas federados y personas con trayectoria de alta competencia. El descuento puede ser del 10% al 100% del arancel anual según la evaluación de antecedentes. No representa un porcentaje garantizado ni se convierte en un importe fijo.
La convocatoria publicada por UNAB el 8 de septiembre de 2026 recibe postulaciones desde el 1 de septiembre de 2026 hasta el 31 de enero de 2027. Presentar antecedentes al encargado de Deportes de Santiago; Viña del Mar o Concepción conforme a la fuente oficial. No es el plazo FUAS ni el de una beca estatal.
La admisión y asignación dependen de la evaluación de antecedentes; los requisitos académicos de cada carrera y las vacantes. Consultar la fuente oficial para las condiciones específicas y la renovación académica; deportiva y disciplinaria. La postulación no garantiza ingreso ni adjudicación.
DOCUMENTOS REQUERIDOS: [OBLIGATORIO] Antecedentes que acrediten la trayectoria deportiva; por ejemplo currículum y certificados de asociaciones; clubes o federaciones según el caso. La fuente no publica una nómina exhaustiva única para todos los postulantes.$d$
WHERE id_beca=314;

UPDATE becas SET version=version+1,
    fecha_inicio_postulacion=DATE '2026-09-04', fecha_cierre_postulacion=DATE '2026-09-25',
    descripcion_corta='UAlumni: becas del 50% o 100% del arancel de programas seleccionados. Segunda convocatoria 2026 cerrada el 25 de septiembre; no incluye matrícula.'
WHERE id_beca=518;
COMMIT;
