BEGIN;
SET LOCAL lock_timeout='5s';
CREATE TEMP TABLE correcciones(id bigint,uuid uuid,version bigint,tipo_anterior bigint,tipo_nuevo bigint) ON COMMIT DROP;
INSERT INTO correcciones VALUES
(14,'66adbcf6-f39b-4356-b404-21c6579f2bf3'::uuid,0,9,7),
(28,'245e6918-ab24-47e1-b9b3-589f068d919e'::uuid,1,9,3),
(86,'b3d099dd-c18b-4ec2-8f5e-5d3aae1a7fd2'::uuid,0,9,7),
(90,'524d17dd-63f5-4a06-a779-e6fae7eaed90'::uuid,0,9,4),
(102,'ecb2bda1-fffc-4c4a-a1ef-d3682dece301'::uuid,0,9,4),
(141,'7ec2669e-fa97-4c01-ae14-a8b8d5edf19a'::uuid,0,9,7),
(158,'c6af8cf1-d8ee-4803-8107-9253a30e2903'::uuid,0,9,4),
(167,'14fac1a4-44e1-40c1-b927-2b071b584fab'::uuid,0,9,5),
(181,'1a803d53-3830-4aad-aad7-529208c2b6c4'::uuid,0,9,5),
(182,'6638adb2-8ea1-40fc-82b6-2c9b2da608fc'::uuid,0,9,2),
(183,'56c64afc-2bed-48b1-8354-d536bcbeef39'::uuid,0,9,4),
(186,'917f5bbf-97ca-47ab-9992-3148b8a88f4e'::uuid,0,9,7),
(196,'93ebee9a-8f5e-4c87-bf62-a5c4b924afaf'::uuid,0,9,5),
(197,'23818e4d-dc3f-43bb-8b0e-5a3fbd600f38'::uuid,0,9,4),
(228,'5bf4c919-bd7a-4b12-a579-d22ff74eae35'::uuid,0,9,7),
(242,'f1e55afd-d717-4159-9654-bdb358271f32'::uuid,0,9,7),
(274,'e03e7695-ec19-494d-9062-9298222a564d'::uuid,0,9,9),
(285,'d0ee5abe-9edb-4bef-86ea-6fc8d56440ab'::uuid,0,9,7),
(353,'1eafa257-d986-4f40-a58c-3eb65dea1575'::uuid,0,9,7),
(375,'829317a0-4751-427c-86c2-238e992d6b61'::uuid,0,9,5),
(400,'e2b909f4-393c-4d10-b34e-060ddac7fdc8'::uuid,0,9,3),
(410,'44168295-0fb6-447c-a943-55cc2b33b918'::uuid,0,9,5),
(419,'de87f683-7d4e-4dba-86ee-eedf62f0ae21'::uuid,0,9,7),
(490,'fa4f6465-132e-4722-aede-f9dd25d63cd7'::uuid,0,9,9),
(521,'2b60e99f-ae81-45a0-b110-2884a70e4a30'::uuid,0,9,7);
DO $guard$
BEGIN
 IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario diferente'; END IF;
 PERFORM id_beca FROM becas WHERE id_beca IN (SELECT id FROM correcciones) FOR UPDATE;
 IF EXISTS (SELECT 1 FROM correcciones c LEFT JOIN becas b ON b.id_beca=c.id WHERE b.id_beca IS NULL OR b.public_id<>c.uuid OR b.version<>c.version OR b.id_tipo_beca<>c.tipo_anterior) THEN RAISE EXCEPTION 'Estado previo diferente; conciliar antes de aplicar'; END IF;
 IF EXISTS (SELECT 1 FROM correcciones c LEFT JOIN tipos_beca t ON t.id_tipo_beca=c.tipo_nuevo WHERE t.id_tipo_beca IS NULL) THEN RAISE EXCEPTION 'Tipo inexistente'; END IF;
END;
$guard$;
UPDATE becas b SET id_tipo_beca=c.tipo_nuevo,version=b.version+1 FROM correcciones c WHERE b.id_beca=c.id;
UPDATE becas SET monto_cobertura='Beca al Mérito Deportivo de Punitaqui 2026: hasta 5 UTM anuales para transporte deportivo, inscripciones, hospedaje y equipamiento; sujeto a presupuesto. Excluye matrícula y arancel.' WHERE id_beca=182;
UPDATE becas SET monto_cobertura='Apoyo económico municipal a estudiantes de educación superior en Los Vilos (2025). Importe individual no publicado; no trasladar montos de residencia, deporte ni movilización.' WHERE id_beca=186;
UPDATE becas SET monto_cobertura='PAI UAH 2024: financiamiento parcial o total de arancel según necesidad, asignaciones mensuales, apoyo para titulación y acompañamiento integral. Monto y porcentaje individuales no publicados.' WHERE id_beca=274;
UPDATE becas SET monto_cobertura='Coltauco: aporte anual en una cuota para gastos educativos. Importe fijado por presupuesto; ciertos beneficiarios estatales reciben 50% del monto municipal (ordenanza 2021).' WHERE id_beca=419;
UPDATE becas SET monto_cobertura='Cunco 2026: aporte directo para gastos educativos con rendición; importe y periodicidad no publicados. No corresponde al pago de $100.000 de Villa Alegre.' WHERE id_beca=14;
UPDATE becas SET monto_cobertura='La fuente incorporada era de San Pedro de Melipilla y no acredita esta ficha de San Pedro de la Paz. Beneficio específico: no confirmado.' WHERE id_beca=490;
UPDATE becas SET descripcion_corta='Aporte municipal de Cunco para gastos de educación superior. Convocatoria 2026 cerrada.',descripcion_larga='Cunco: convocatoria de educación superior 2026. Solicitudes del 6 al 30 de abril; pagos desde julio. Aporte para gastos educativos con rendición hasta el 18 de diciembre. Importe no publicado.
REQUISITOS PRINCIPALES: Residencia comunal acreditada por RSH; matrícula superior reconocida; ingreso familiar por persona hasta $500.000. Ingreso: promedio de cuarto medio 5,5; continuidad: promedio 5,0 y máximo una asignatura reprobada. Evaluación especial: 5,0 y 4,5 respectivamente. No convertir promedio de cuarto medio en NEM completo. Excluye segunda carrera con título, continuidad técnica-profesional, postulantes a beca deportiva municipal y contrato municipal a plazo fijo. Rendición previa exigible cuando corresponda.
DOCUMENTOS REQUERIDOS:
[OBLIGATORIO] Identificación; cuenta RUT; matrícula o alumno regular; notas; RSH; declaración municipal; acreditación de ingresos según situación laboral.
[OBLIGATORIO] Antecedentes de discapacidad o enfermedad cuando corresponda.
FUENTE: Folleto municipal de Cunco 2026, páginas 1–2. Corrección del 29/10/2026: se retiraron condiciones de Villa Alegre. Convocatoria cerrada; sin activación.',url_oficial='https://www.municunco.cl/comunitarias/beca-municipal-educacion-superior-2026/',fecha_inicio_postulacion='2026-04-06',fecha_cierre_postulacion='2026-04-30' WHERE id_beca=14;
UPDATE becas SET descripcion_corta='Identidad en revisión: la fuente anterior corresponde a otra comuna.',descripcion_larga='La candidata original corresponde a San Pedro de la Paz. Las fuentes incorporadas en la revisión anterior son de San Pedro de Melipilla y no acreditan este registro. No trasladar sus requisitos ni calendario. Se retiró el enlace incorrecto. No se afirma que el programa sea falso. DOCUMENTOS REQUERIDOS: No especificado para esta candidata.',url_oficial='' WHERE id_beca=490;
COMMIT;
