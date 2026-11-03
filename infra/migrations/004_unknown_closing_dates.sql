-- Las fechas sin fuente se conservan desconocidas. No modificar fechas históricas sin evidencia.
BEGIN;
ALTER TABLE becas ALTER COLUMN fecha_cierre_postulacion DROP NOT NULL;
COMMIT;
