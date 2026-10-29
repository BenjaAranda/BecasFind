BEGIN;
SET LOCAL lock_timeout='5s';
CREATE TEMP TABLE correcciones(id bigint,uuid uuid,version bigint,tipo_anterior bigint,tipo_nuevo bigint) ON COMMIT DROP;
INSERT INTO correcciones VALUES
(52,'d717e436-d0e3-4c58-92d8-bb338f3b0222'::uuid,0,9,10),
(229,'af9ca817-b275-4731-9980-4fe8e515d7f8'::uuid,0,9,10),
(265,'eda80e69-7f17-4c52-9e7c-6535c915376d'::uuid,0,9,10),
(274,'e03e7695-ec19-494d-9062-9298222a564d'::uuid,1,9,10),
(282,'cffd021b-f721-4d79-9fa9-32bb12028090'::uuid,0,9,10),
(336,'3bb27b3c-bca1-48d3-b322-dfa8c6e15d11'::uuid,0,9,10),
(432,'27af4caf-be79-4d74-8327-31f118eaf49e'::uuid,0,9,10),
(123,'3a29abc6-6e21-4163-8685-ec15dbd96e4f'::uuid,0,9,11),
(468,'0db85f64-d53b-4dff-a8d1-a18392827cc8'::uuid,0,9,12),
(59,'dea68947-564e-46b2-83ca-c086208efdff'::uuid,0,9,5),
(261,'bbf5e9c1-7545-40a9-800b-4973dd056260'::uuid,0,9,9);
LOCK TABLE tipos_beca IN SHARE ROW EXCLUSIVE MODE;
DO $$ BEGIN IF (SELECT count(*) FROM tipos_beca)<>9 OR EXISTS(SELECT 1 FROM tipos_beca WHERE id_tipo_beca>=10) THEN RAISE EXCEPTION 'Taxonomía cambió; conciliar antes de aplicar'; END IF; END $$;
INSERT INTO tipos_beca(id_tipo_beca,nombre) VALUES (10,'Apoyo mixto o varias modalidades'),(11,'Articulación académica sin aporte monetario'),(12,'Admisión especial sin beca acreditada');
DO $guard$
BEGIN
 IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario diferente'; END IF;
 PERFORM id_beca FROM becas WHERE id_beca IN (SELECT id FROM correcciones) FOR UPDATE;
 IF EXISTS (SELECT 1 FROM correcciones c LEFT JOIN becas b ON b.id_beca=c.id WHERE b.id_beca IS NULL OR b.public_id<>c.uuid OR b.version<>c.version OR b.id_tipo_beca<>c.tipo_anterior) THEN RAISE EXCEPTION 'Estado previo diferente; conciliar antes de aplicar'; END IF;
 IF EXISTS (SELECT 1 FROM correcciones c LEFT JOIN tipos_beca t ON t.id_tipo_beca=c.tipo_nuevo WHERE t.id_tipo_beca IS NULL) THEN RAISE EXCEPTION 'Tipo inexistente'; END IF;
END;
$guard$;
UPDATE becas b SET id_tipo_beca=c.tipo_nuevo,version=b.version+1 FROM correcciones c WHERE b.id_beca=c.id;
UPDATE becas SET nombre='Articulación Directa EMTP INACAP (convalidación académica)' WHERE id_beca=123;
UPDATE becas SET nombre='Admisión directa Medicina UDD: hijos/as de funcionarios (sin beca acreditada)' WHERE id_beca=468;
UPDATE becas SET url_oficial='',descripcion_corta='Identidad en revisión: el enlace anterior era de Arauco y no acredita la candidata de Rauco.',monto_cobertura='La fuente incorporada correspondía a Arauco. El beneficio específico de la candidata original de Rauco permanece sin confirmar.',descripcion_larga='El original corresponde a la Municipalidad de Rauco. El portal anteriormente enlazado identifica a la Municipalidad de Arauco. No trasladar condiciones entre ambas comunas. La falta de evidencia no demuestra inexistencia. Se conserva el registro y su UUID. DOCUMENTOS REQUERIDOS: No especificado para la candidata de Rauco.' WHERE id_beca=261;
SELECT setval(pg_get_serial_sequence('tipos_beca','id_tipo_beca'),(SELECT max(id_tipo_beca) FROM tipos_beca),true);
COMMIT;
