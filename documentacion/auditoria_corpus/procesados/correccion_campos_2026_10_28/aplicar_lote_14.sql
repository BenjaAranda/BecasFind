BEGIN;
SET LOCAL lock_timeout='5s';
CREATE TEMP TABLE correcciones(id bigint,uuid uuid,version bigint,tipo_anterior bigint,tipo_nuevo bigint) ON COMMIT DROP;
INSERT INTO correcciones VALUES
(1,'fc65e10e-f9ad-4698-a261-1d03b1212a14'::uuid,1,9,13),
(23,'69d26871-62e4-435a-a231-35e4d0474262'::uuid,1,9,13),
(68,'b57476f8-6347-4d22-bfb9-86691e11c7ef'::uuid,1,9,13),
(251,'c88b5fa2-cc4a-410b-8d69-8d5975d01409'::uuid,1,9,13),
(261,'bbf5e9c1-7545-40a9-800b-4973dd056260'::uuid,1,9,14),
(312,'dc45574b-ef2c-42e6-919f-bc0bf6f308fb'::uuid,1,9,13),
(362,'31ad2b50-30ec-4150-aeed-37ce79d5db6a'::uuid,1,9,13),
(393,'e7671aaf-f602-4cf2-bed6-6c0fe63e6165'::uuid,1,9,13),
(402,'0346c14d-e1f7-479e-8d9a-9d4ff17a6d16'::uuid,1,9,13),
(405,'50d864aa-269c-4ee6-a1eb-b685a8841caf'::uuid,2,9,13),
(412,'f5e0d1a7-69fb-4a5f-8078-b29d69157669'::uuid,1,9,13),
(426,'f91de4a7-3178-4533-a21c-e8f1ea113fc4'::uuid,1,9,13),
(490,'fa4f6465-132e-4722-aede-f9dd25d63cd7'::uuid,1,9,14),
(500,'a9fc3ffc-dfee-405c-8334-806d65e7c499'::uuid,1,9,13),
(506,'24dbac8b-a756-4f08-a99e-0e0daa6e382a'::uuid,2,9,13),
(510,'c60f68ff-7c99-464e-9179-c7708d743f65'::uuid,1,9,13),
(513,'78861a79-69c6-4e9f-9045-fcdfc4f40039'::uuid,1,9,13),
(514,'03dc06f6-31bc-4f7c-aacb-ba3f09f1eccf'::uuid,1,9,13),
(528,'75c283b9-ad88-47c7-9e36-2a52051dcd98'::uuid,1,9,13);
LOCK TABLE tipos_beca IN SHARE ROW EXCLUSIVE MODE;
DO $$ BEGIN IF (SELECT count(*) FROM tipos_beca)<>12 OR EXISTS(SELECT 1 FROM tipos_beca WHERE id_tipo_beca>=13) THEN RAISE EXCEPTION 'Taxonomía diferente; conciliar'; END IF; END $$;
INSERT INTO tipos_beca(id_tipo_beca,nombre) VALUES (13,'Apoyo municipal · cobertura por confirmar'),(14,'Identidad del programa por confirmar');
DO $guard$
BEGIN
 IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario diferente'; END IF;
 PERFORM id_beca FROM becas WHERE id_beca IN (SELECT id FROM correcciones) FOR UPDATE;
 IF EXISTS (SELECT 1 FROM correcciones c LEFT JOIN becas b ON b.id_beca=c.id WHERE b.id_beca IS NULL OR b.public_id<>c.uuid OR b.version<>c.version OR b.id_tipo_beca<>c.tipo_anterior) THEN RAISE EXCEPTION 'Estado previo diferente; conciliar antes de aplicar'; END IF;
 IF EXISTS (SELECT 1 FROM correcciones c LEFT JOIN tipos_beca t ON t.id_tipo_beca=c.tipo_nuevo WHERE t.id_tipo_beca IS NULL) THEN RAISE EXCEPTION 'Tipo inexistente'; END IF;
END;
$guard$;
UPDATE becas b SET id_tipo_beca=c.tipo_nuevo,version=b.version+1 FROM correcciones c WHERE b.id_beca=c.id;
UPDATE becas SET nombre='Antecedente de beca municipal de Rauco · identidad por confirmar' WHERE id_beca=261;
UPDATE becas SET nombre='Antecedente de beca municipal de San Pedro de la Paz · identidad por confirmar' WHERE id_beca=490;
SELECT setval(pg_get_serial_sequence('tipos_beca','id_tipo_beca'),(SELECT max(id_tipo_beca) FROM tipos_beca),true);
COMMIT;
