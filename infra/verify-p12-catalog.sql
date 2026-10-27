\set ON_ERROR_STOP on
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY;
SET LOCAL TIME ZONE 'America/Santiago';

DO $check$
DECLARE
    sample RECORD;
    detected BOOLEAN;
BEGIN
    FOR sample IN
        SELECT * FROM (VALUES
            ('5,8, concordante'::TEXT, FALSE),
            ('NEM 5,8, 30%'::TEXT, FALSE),
            (convert_from(decode('c383c2b3','hex'),'UTF8'), TRUE),
            (convert_from(decode('c383e28098','hex'),'UTF8'), TRUE),
            (convert_from(decode('c382c2a1','hex'),'UTF8'), TRUE)
        ) AS samples(value, expected)
    LOOP
        SELECT bool_or(position(decode(pattern, 'hex') IN convert_to(sample.value, 'UTF8')) > 0)
          INTO detected
          FROM unnest(ARRAY['c383c2', 'c383e2', 'c382c2']) AS patterns(pattern);
        IF detected IS DISTINCT FROM sample.expected THEN
            RAISE EXCEPTION 'Encoding regression check failed';
        END IF;
    END LOOP;
END;
$check$;

SELECT count(*) AS total,
       count(*) FILTER (WHERE estado_activa) AS activas,
       count(*) FILTER (WHERE estado_activa AND fecha_cierre_postulacion >= CURRENT_DATE) AS visibles_por_regla,
       count(*) FILTER (WHERE fecha_cierre_postulacion IS NULL) AS cierre_desconocido,
       count(*) FILTER (WHERE fecha_cierre_postulacion < CURRENT_DATE) AS fecha_cerrada,
       count(*) FILTER (WHERE fecha_cierre_postulacion >= CURRENT_DATE) AS fecha_no_vencida
FROM public.becas;

WITH texts AS (
    SELECT id_beca, nombre,
           convert_to(concat_ws(E'\n', nombre, descripcion_corta, descripcion_larga), 'UTF8') AS bytes
    FROM public.becas
)
SELECT count(*) AS posibles_textos_corruptos
FROM texts
WHERE position(decode('c383c2', 'hex') IN bytes) > 0
   OR position(decode('c383e2', 'hex') IN bytes) > 0
   OR position(decode('c382c2', 'hex') IN bytes) > 0;

WITH texts AS (
    SELECT id_beca, nombre,
           convert_to(concat_ws(E'\n', nombre, descripcion_corta, descripcion_larga), 'UTF8') AS bytes
    FROM public.becas
)
SELECT id_beca, nombre
FROM texts
WHERE position(decode('c383c2', 'hex') IN bytes) > 0
   OR position(decode('c383e2', 'hex') IN bytes) > 0
   OR position(decode('c382c2', 'hex') IN bytes) > 0;

SELECT id_beca, nombre, fecha_inicio_postulacion, fecha_cierre_postulacion, url_oficial
FROM public.becas
WHERE fecha_cierre_postulacion >= CURRENT_DATE
ORDER BY fecha_cierre_postulacion, id_beca;
ROLLBACK;
