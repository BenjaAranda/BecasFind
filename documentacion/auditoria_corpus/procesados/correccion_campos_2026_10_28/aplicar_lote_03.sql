BEGIN;
SET LOCAL lock_timeout='5s';
CREATE TEMP TABLE correcciones(id bigint,uuid uuid,version bigint,tipo bigint,beneficio text) ON COMMIT DROP;
INSERT INTO correcciones VALUES
(27,'5e68bb01-d118-45b2-8c11-1458b008c03a'::uuid,0,7,'Apoyo económico municipal para educación superior acreditado históricamente; monto individual y periodicidad no publicados. La inversión agregada de enseñanza media y superior no corresponde a una beca individual.'),
(28,'245e6918-ab24-47e1-b9b3-589f068d919e'::uuid,0,9,'Apoyo para jóvenes de Copiapó con mérito académico y recursos insuficientes que estudian Medicina u Odontología en Argentina (Carmen Vilches). Monto y periodicidad no publicados en la fuente de 2026.'),
(45,'7197d2ad-6e5a-410a-b2d4-80df47863d32'::uuid,0,7,'Edición 2024: aporte único por transferencia para matrícula, arancel, materiales y pasajes, con rendición de gastos. Importe individual no publicado; dirigido a 20 estudiantes de primer ingreso.');
DO $guard$
BEGIN
 IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario diferente'; END IF;
 PERFORM id_beca FROM becas WHERE id_beca IN (SELECT id FROM correcciones) FOR UPDATE;
 IF EXISTS (SELECT 1 FROM correcciones c LEFT JOIN becas b ON b.id_beca=c.id WHERE b.id_beca IS NULL OR b.public_id<>c.uuid OR b.version<>c.version OR b.id_tipo_beca<>9 OR coalesce(b.monto_cobertura,'')<>'') THEN RAISE EXCEPTION 'Estado previo diferente'; END IF;
END;
$guard$;
UPDATE becas b SET monto_cobertura=c.beneficio,id_tipo_beca=c.tipo,version=b.version+1 FROM correcciones c WHERE b.id_beca=c.id;
COMMIT;
