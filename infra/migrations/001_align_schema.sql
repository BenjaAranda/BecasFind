-- PostgreSQL 17. Ejecutar con ON_ERROR_STOP y un respaldo restaurado previamente.
-- No modifica filas ni contraseñas. Repetible; cualquier error revierte la transacción.
BEGIN;
SET LOCAL lock_timeout = '5s';
DO $$
DECLARE
    fk RECORD;
    column_type TEXT;
BEGIN
    SELECT data_type INTO column_type FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'password_reset_tokens' AND column_name = 'token';
    IF column_type = 'uuid' THEN
        ALTER TABLE password_reset_tokens ALTER COLUMN token TYPE VARCHAR(36) USING token::text;
    ELSIF column_type <> 'character varying' THEN
        RAISE EXCEPTION 'Tipo de token inesperado: %', column_type;
    END IF;
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public'
        AND ((table_name = 'usuarios' AND column_name = 'creado_en')
          OR (table_name = 'password_reset_tokens' AND column_name = 'fecha_expiracion'))
        AND data_type <> 'timestamp without time zone') THEN
        RAISE EXCEPTION 'Acordar la zona horaria antes de convertir fechas existentes';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM roles WHERE nombre_rol = 'ADMIN')
       OR NOT EXISTS (SELECT 1 FROM roles WHERE nombre_rol = 'STUDENT') THEN
        RAISE EXCEPTION 'Resolver los roles existentes antes de migrar';
    END IF;
    IF EXISTS (SELECT 1 FROM becas GROUP BY nombre, id_institucion HAVING count(*) > 1)
       OR EXISTS (SELECT 1 FROM password_reset_tokens GROUP BY token HAVING count(*) > 1) THEN
        RAISE EXCEPTION 'Resolver duplicados antes de agregar restricciones';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'becas'::regclass
                  AND contype = 'u' AND pg_get_constraintdef(oid) = 'UNIQUE (nombre, id_institucion)') THEN
        ALTER TABLE becas ADD CONSTRAINT uk_beca_nombre_institucion UNIQUE (nombre, id_institucion);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'password_reset_tokens'::regclass
                  AND contype = 'u' AND pg_get_constraintdef(oid) = 'UNIQUE (token)') THEN
        ALTER TABLE password_reset_tokens ADD CONSTRAINT uk_password_reset_token UNIQUE (token);
    END IF;
    FOR fk IN SELECT conname, pg_get_constraintdef(oid) AS definition FROM pg_constraint
              WHERE conrelid = 'becas_regiones'::regclass AND contype = 'f' AND confdeltype <> 'c'
    LOOP
        IF fk.definition LIKE '% ON DELETE %' THEN
            RAISE EXCEPTION 'Revisar manualmente la política existente de %', fk.conname;
        END IF;
        EXECUTE format('ALTER TABLE becas_regiones DROP CONSTRAINT %I', fk.conname);
        EXECUTE format('ALTER TABLE becas_regiones ADD CONSTRAINT %I %s ON DELETE CASCADE', fk.conname, fk.definition);
    END LOOP;
END $$;
COMMIT;
