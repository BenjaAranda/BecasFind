-- PostgreSQL 17. Respaldo obligatorio antes de aplicar a una base existente.
-- Conserva texto histórico; no infiere moneda, importe ni periodicidad.
BEGIN;
ALTER TABLE becas ADD COLUMN IF NOT EXISTS cobertura_tipo VARCHAR(20) NOT NULL DEFAULT 'DESCONOCIDA';
ALTER TABLE becas ADD COLUMN IF NOT EXISTS cobertura_importe NUMERIC(18,2);
ALTER TABLE becas ADD COLUMN IF NOT EXISTS cobertura_moneda VARCHAR(3);
ALTER TABLE becas ADD COLUMN IF NOT EXISTS cobertura_periodicidad VARCHAR(20);
ALTER TABLE becas ADD COLUMN IF NOT EXISTS cobertura_porcentaje NUMERIC(5,2);
ALTER TABLE becas DROP CONSTRAINT IF EXISTS ck_beca_cobertura;
ALTER TABLE becas ADD CONSTRAINT ck_beca_cobertura CHECK (
    cobertura_tipo IN ('MONETARIA','PORCENTUAL','NO_MONETARIA','DESCONOCIDA')
    AND (cobertura_importe IS NULL OR cobertura_importe >= 0)
    AND (cobertura_porcentaje IS NULL OR cobertura_porcentaje BETWEEN 0 AND 100)
    AND (cobertura_moneda IS NULL OR cobertura_moneda ~ '^[A-Z]{3}$')
    AND (cobertura_periodicidad IS NULL OR cobertura_periodicidad IN ('UNICA','MENSUAL','SEMESTRAL','ANUAL','DESCONOCIDA'))
    AND (
        (cobertura_tipo = 'MONETARIA' AND cobertura_porcentaje IS NULL AND (cobertura_importe IS NULL OR cobertura_moneda IS NOT NULL))
        OR (cobertura_tipo = 'PORCENTUAL' AND cobertura_importe IS NULL AND cobertura_moneda IS NULL AND cobertura_periodicidad IS NULL)
        OR (cobertura_tipo IN ('NO_MONETARIA','DESCONOCIDA') AND cobertura_importe IS NULL AND cobertura_moneda IS NULL AND cobertura_periodicidad IS NULL AND cobertura_porcentaje IS NULL)
    )
);
COMMIT;
