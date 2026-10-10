-- Detener escrituras y respaldar antes de aplicar. Conserva IDs y avance de secuencias.
BEGIN;
ALTER TABLE becas ADD COLUMN IF NOT EXISTS version BIGINT NOT NULL DEFAULT 0;
DO $$
DECLARE
    target RECORD;
    seq_name TEXT;
    saved_value BIGINT;
    maximum_id BIGINT;
BEGIN
    FOR target IN SELECT * FROM (VALUES ('becas','id_beca'), ('requisitos_perfil','id_requisito'), ('documentos_requeridos','id_documento')) AS targets(table_name,column_name)
    LOOP
        EXECUTE format('LOCK TABLE %I IN ACCESS EXCLUSIVE MODE', target.table_name);
        seq_name := target.table_name || '_' || target.column_name || '_seq';
        IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema=current_schema() AND table_name=target.table_name AND column_name=target.column_name AND is_identity='YES') THEN
            EXECUTE format('SELECT last_value FROM %s', pg_get_serial_sequence(target.table_name,target.column_name)) INTO saved_value;
            EXECUTE format('SELECT COALESCE(MAX(%I),0) FROM %I', target.column_name,target.table_name) INTO maximum_id;
            EXECUTE format('ALTER TABLE %I ALTER COLUMN %I DROP IDENTITY',target.table_name,target.column_name);
            EXECUTE format('CREATE SEQUENCE %I INCREMENT BY 1',seq_name);
            PERFORM setval(seq_name::regclass,GREATEST(saved_value,maximum_id,1),true);
            EXECUTE format('ALTER TABLE %I ALTER COLUMN %I SET DEFAULT nextval(%L)',target.table_name,target.column_name,seq_name);
            EXECUTE format('ALTER SEQUENCE %I OWNED BY %I.%I',seq_name,target.table_name,target.column_name);
        END IF;
    END LOOP;
END $$;
COMMIT;
