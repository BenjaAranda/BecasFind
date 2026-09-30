-- Solo ejecutar en una base temporal del verificador.
CREATE SCHEMA coverage_migration_verify;
SET search_path TO coverage_migration_verify;
CREATE TABLE becas (id_beca BIGINT PRIMARY KEY, nombre TEXT, monto_cobertura VARCHAR(255));
INSERT INTO becas VALUES (1,'Beca de Ñuble','$600.000 anual'), (2,'Cobertura parcial','75% del arancel'), (3,'Apoyo','Alimentación'), (4,'Sin información',NULL);
CREATE TABLE before_migration AS SELECT md5(json_agg(b ORDER BY id_beca)::text) fingerprint FROM becas b;
\ir migrations/002_structured_coverage.sql
\ir migrations/002_structured_coverage.sql
DO $$ BEGIN
    IF (SELECT md5(json_agg(b ORDER BY id_beca)::text) FROM (SELECT id_beca,nombre,monto_cobertura FROM becas) b)
       <> (SELECT fingerprint FROM before_migration) THEN RAISE EXCEPTION 'La migración alteró los datos originales'; END IF;
    IF EXISTS (SELECT 1 FROM becas WHERE cobertura_tipo <> 'DESCONOCIDA' OR cobertura_importe IS NOT NULL OR cobertura_moneda IS NOT NULL)
       THEN RAISE EXCEPTION 'La migración inventó metadata'; END IF;
END $$;
UPDATE becas SET cobertura_tipo='MONETARIA', cobertura_importe=1234.56, cobertura_moneda='USD', cobertura_periodicidad='UNICA' WHERE id_beca=1;
\ir migrations/002_structured_coverage.sql
DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM becas WHERE id_beca=1 AND cobertura_importe=1234.56 AND cobertura_moneda='USD')
       THEN RAISE EXCEPTION 'Reaplicar borró metadata'; END IF;
    BEGIN
        UPDATE becas SET cobertura_importe=-1 WHERE id_beca=1;
        RAISE EXCEPTION 'Importe negativo aceptado';
    EXCEPTION WHEN check_violation THEN NULL; END;
    BEGIN
        UPDATE becas SET cobertura_tipo='PORCENTUAL', cobertura_porcentaje=75 WHERE id_beca=1;
        RAISE EXCEPTION 'Porcentaje con importe aceptado';
    EXCEPTION WHEN check_violation THEN NULL; END;
    BEGIN
        UPDATE becas SET cobertura_tipo='PORCENTUAL', cobertura_porcentaje=101 WHERE id_beca=2;
        RAISE EXCEPTION 'Porcentaje fuera de rango aceptado';
    EXCEPTION WHEN check_violation THEN NULL; END;
    BEGIN
        UPDATE becas SET cobertura_moneda=NULL WHERE id_beca=1;
        RAISE EXCEPTION 'Importe sin moneda aceptado';
    EXCEPTION WHEN check_violation THEN NULL; END;
END $$;
\ir migrations/003_public_scholarship_ids.sql
CREATE TABLE public_ids_before AS SELECT id_beca, public_id FROM becas;
\ir migrations/003_public_scholarship_ids.sql
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM becas b JOIN public_ids_before p USING(id_beca) WHERE b.public_id <> p.public_id)
       OR (SELECT count(DISTINCT public_id) FROM becas) <> 4 THEN RAISE EXCEPTION 'UUID públicos no estables o repetidos'; END IF;
END $$;
RESET search_path;
DROP SCHEMA coverage_migration_verify CASCADE;
