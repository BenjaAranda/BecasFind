-- PostgreSQL 17: preserva IDs internos, relaciones y UUID ya asignados.
BEGIN;
ALTER TABLE becas ADD COLUMN IF NOT EXISTS public_id UUID NOT NULL DEFAULT gen_random_uuid();
CREATE UNIQUE INDEX IF NOT EXISTS uk_beca_public_id ON becas(public_id);
COMMIT;
