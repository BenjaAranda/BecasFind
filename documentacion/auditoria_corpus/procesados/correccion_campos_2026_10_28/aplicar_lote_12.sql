BEGIN;
SET LOCAL lock_timeout='5s';
CREATE TEMP TABLE correcciones(id bigint,uuid uuid,version bigint,tipo_anterior bigint,tipo_nuevo bigint) ON COMMIT DROP;
INSERT INTO correcciones VALUES
(1,'fc65e10e-f9ad-4698-a261-1d03b1212a14'::uuid,0,9,9),
(23,'69d26871-62e4-435a-a231-35e4d0474262'::uuid,0,9,9),
(37,'e549c7af-aa24-4d4e-b4db-420943a15850'::uuid,0,9,9),
(68,'b57476f8-6347-4d22-bfb9-86691e11c7ef'::uuid,0,9,9),
(193,'8eceb9d6-8ca6-4634-8a13-ebd93bcafb11'::uuid,0,9,4),
(251,'c88b5fa2-cc4a-410b-8d69-8d5975d01409'::uuid,0,9,9),
(270,'e026234b-3a85-430b-999f-02706662528a'::uuid,0,9,4),
(312,'dc45574b-ef2c-42e6-919f-bc0bf6f308fb'::uuid,0,9,9),
(362,'31ad2b50-30ec-4150-aeed-37ce79d5db6a'::uuid,0,9,9),
(393,'e7671aaf-f602-4cf2-bed6-6c0fe63e6165'::uuid,0,9,9),
(402,'0346c14d-e1f7-479e-8d9a-9d4ff17a6d16'::uuid,0,9,9),
(405,'50d864aa-269c-4ee6-a1eb-b685a8841caf'::uuid,0,9,9),
(412,'f5e0d1a7-69fb-4a5f-8078-b29d69157669'::uuid,0,9,9),
(426,'f91de4a7-3178-4533-a21c-e8f1ea113fc4'::uuid,0,9,9),
(500,'a9fc3ffc-dfee-405c-8334-806d65e7c499'::uuid,0,9,9),
(506,'24dbac8b-a756-4f08-a99e-0e0daa6e382a'::uuid,0,9,9),
(510,'c60f68ff-7c99-464e-9179-c7708d743f65'::uuid,0,9,9),
(513,'78861a79-69c6-4e9f-9045-fcdfc4f40039'::uuid,0,9,9),
(514,'03dc06f6-31bc-4f7c-aacb-ba3f09f1eccf'::uuid,0,9,9),
(528,'75c283b9-ad88-47c7-9e36-2a52051dcd98'::uuid,0,9,9);
DO $guard$
BEGIN
 IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario diferente'; END IF;
 PERFORM id_beca FROM becas WHERE id_beca IN (SELECT id FROM correcciones) FOR UPDATE;
 IF EXISTS (SELECT 1 FROM correcciones c LEFT JOIN becas b ON b.id_beca=c.id WHERE b.id_beca IS NULL OR b.public_id<>c.uuid OR b.version<>c.version OR b.id_tipo_beca<>c.tipo_anterior) THEN RAISE EXCEPTION 'Estado previo diferente; conciliar antes de aplicar'; END IF;
 IF EXISTS (SELECT 1 FROM correcciones c LEFT JOIN tipos_beca t ON t.id_tipo_beca=c.tipo_nuevo WHERE t.id_tipo_beca IS NULL) THEN RAISE EXCEPTION 'Tipo inexistente'; END IF;
END;
$guard$;
UPDATE becas b SET id_tipo_beca=c.tipo_nuevo,version=b.version+1 FROM correcciones c WHERE b.id_beca=c.id;
UPDATE becas SET descripcion_corta='Programa histórico de Papudo para estudiantes de educación superior. Cobertura individual y convocatoria actual por confirmar.' WHERE id_beca=1;
UPDATE becas SET descripcion_corta='Beca municipal de María Elena para educación superior. La modalidad de cobertura y el importe no están especificados.' WHERE id_beca=23;
UPDATE becas SET descripcion_corta='Convenio histórico de Hualpén con el IP Diego Portales: 20 becas de estudio en 2022. Cobertura individual no publicada.' WHERE id_beca=37;
UPDATE becas SET descripcion_corta='Programa histórico de Cholchol para educación superior, documentado en 2019–2020. Beneficio individual actual por confirmar.' WHERE id_beca=68;
UPDATE becas SET descripcion_corta='Beca de Natales para jóvenes de educación superior con buen rendimiento académico. Importe y convocatoria actual por confirmar.' WHERE id_beca=193;
UPDATE becas SET descripcion_corta='Beca municipal de Peumo documentada en 2025 para educación superior. Cobertura individual y convocatoria actual por confirmar.' WHERE id_beca=251;
UPDATE becas SET descripcion_corta='Apoyo histórico de San Javier para egresados del Liceo Manuel Montt con mérito académico. Importe individual no publicado.' WHERE id_beca=270;
UPDATE becas SET descripcion_corta='Beca estudiantil municipal de Toltén documentada históricamente. Importe, modalidad de pago y convocatoria actual por confirmar.' WHERE id_beca=312;
UPDATE becas SET descripcion_corta='Beca municipal de Hualañé documentada en 2019 mediante una adjudicación. Cobertura y condiciones actuales no publicadas.' WHERE id_beca=362;
UPDATE becas SET descripcion_corta='Beca de La Florida para educación superior recogida en la Ordenanza 127/2020. Cobertura individual por confirmar.' WHERE id_beca=393;
UPDATE becas SET descripcion_corta='Beca municipal para educación superior prevista en el presupuesto 2025 de Villa Alemana. Cobertura y ejecución posterior por confirmar.' WHERE id_beca=402;
UPDATE becas SET descripcion_corta='Maipú Te Reconoce: modalidad de educación superior 2026. Incluye evaluación social y académica; importe no publicado en el instructivo.' WHERE id_beca=405;
UPDATE becas SET descripcion_corta='Resultados de becas estudiantiles de Pencahue 2026. La publicación no especifica nivel educativo ni beneficio individual.' WHERE id_beca=412;
UPDATE becas SET descripcion_corta='Beca de educación superior de Viña del Mar documentada en 2022–2023. Los totales presupuestarios no indican el importe individual.' WHERE id_beca=426;
UPDATE becas SET descripcion_corta='Programa municipal 100 por 100 de Coronel: entrega de becas universitarias documentada en 2019. Cobertura actual por confirmar.' WHERE id_beca=500;
UPDATE becas SET descripcion_corta='Maipú Te Reconoce: modalidad de educación superior 2026. Incluye evaluación social y académica; importe no publicado en el instructivo.' WHERE id_beca=506;
UPDATE becas SET descripcion_corta='Beca municipal para estudiantes de educación superior de Calera de Tango, sujeta a evaluación social. Cobertura no especificada.' WHERE id_beca=510;
UPDATE becas SET descripcion_corta='Beca estudiantil de Cochamó mencionada en la gestión 2025. Nivel educativo y cobertura individual por confirmar.' WHERE id_beca=513;
UPDATE becas SET descripcion_corta='Beca de Cerrillos para estudiantes de educación superior de escasos recursos. La modificación de 2018 no publica el importe.' WHERE id_beca=514;
UPDATE becas SET descripcion_corta='Beca de educación superior de Viña del Mar documentada en 2022–2023. Los totales presupuestarios no indican el importe individual.' WHERE id_beca=528;
UPDATE becas SET url_oficial='https://imsanjavier.cl/wp-content/uploads/2026/06/CUENTA-PUBLICA-2023.pdf' WHERE id_beca=270;
COMMIT;
