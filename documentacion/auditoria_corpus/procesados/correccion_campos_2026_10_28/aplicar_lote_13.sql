BEGIN;
SET LOCAL lock_timeout='5s';
CREATE TEMP TABLE correcciones(id bigint,uuid uuid,version bigint,tipo_anterior bigint,tipo_nuevo bigint) ON COMMIT DROP;
INSERT INTO correcciones VALUES
(37,'e549c7af-aa24-4d4e-b4db-420943a15850'::uuid,1,9,5),
(405,'50d864aa-269c-4ee6-a1eb-b685a8841caf'::uuid,1,9,9),
(506,'24dbac8b-a756-4f08-a99e-0e0daa6e382a'::uuid,1,9,9);
DO $guard$
BEGIN
 IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario diferente'; END IF;
 PERFORM id_beca FROM becas WHERE id_beca IN (SELECT id FROM correcciones) FOR UPDATE;
 IF EXISTS (SELECT 1 FROM correcciones c LEFT JOIN becas b ON b.id_beca=c.id WHERE b.id_beca IS NULL OR b.public_id<>c.uuid OR b.version<>c.version OR b.id_tipo_beca<>c.tipo_anterior) THEN RAISE EXCEPTION 'Estado previo diferente; conciliar antes de aplicar'; END IF;
 IF EXISTS (SELECT 1 FROM correcciones c LEFT JOIN tipos_beca t ON t.id_tipo_beca=c.tipo_nuevo WHERE t.id_tipo_beca IS NULL) THEN RAISE EXCEPTION 'Tipo inexistente'; END IF;
END;
$guard$;
UPDATE becas b SET id_tipo_beca=c.tipo_nuevo,version=b.version+1 FROM correcciones c WHERE b.id_beca=c.id;
DO $$ BEGIN IF (SELECT count(*) FROM requisitos_perfil WHERE id_beca IN(405,506) AND rsh_maximo_porcentaje IS NULL AND nem_minimo IS NULL AND paes_minimo IS NULL AND NOT es_para_primer_anio AND NOT es_para_curso_superior)<>2 THEN RAISE EXCEPTION 'Perfil previo diferente; conciliar'; END IF; END $$;
UPDATE becas SET nombre='Convenio de becas IP Diego Portales–Hualpén (antecedentes 2022–2024)',descripcion_corta='Convenio histórico de becas de arancel para residentes de Hualpén que estudian en el IP Diego Portales. Condiciones actuales por confirmar.',descripcion_larga='Convenio IP Diego Portales–Municipalidad de Hualpén: antecedente municipal 2022 y catastro UdeC 2024.
BENEFICIO: El catastro de 2024 describe 20 becas anuales de 50% de arancel: diez presenciales y diez online, durante los estudios. No acredita porcentaje aplicable actualmente ni a la convocatoria de 2022. La tabla general de convenios del instituto enumera otro porcentaje: no se trasladan reglas entre instrumentos.
REQUISITOS PRINCIPALES: Residencia en Hualpén; RSH; matrícula en carrera del instituto en modalidad elegible.
DOCUMENTOS REQUERIDOS:
[OBLIGATORIO] Certificado de residencia de junta de vecinos.
[OBLIGATORIO] Identificación por ambos lados; cartola RSH.
LÍMITES: Sin calendario actual acreditado. La cobertura estructurada permanece desconocida para evitar presentar un porcentaje histórico como vigente.',monto_cobertura='Catastro UdeC 2024: 20 becas anuales de 50% del arancel (diez presenciales y diez online). No acredita porcentaje actual ni de la edición 2022.',url_oficial='https://cade.udec.cl/wp-content/uploads/2024/10/Catastro-Beneficios-Municipales-2.pdf#page=33' WHERE id_beca=37;
UPDATE becas SET descripcion_larga='Maipú Te Reconoce: educación superior 2026. Convocatoria cerrada. Importe no publicado en el instructivo.
REQUISITOS PRINCIPALES: Residencia en Maipú; RSH hasta 90%; alumno regular en institución reconocida; ingreso familiar por persona hasta $904.199. Primer año: promedio de cuarto medio desde 6,5; continuidad: promedio anual de pregrado desde 5,5. No equivalen a un NEM común a todos. Excluye título superior previo, gratuidad y cobertura externa de todo el arancel. Modalidades de jefa de hogar y cuidadora tienen requisitos adicionales.
DOCUMENTOS REQUERIDOS:
[OBLIGATORIO] Identificación del postulante y grupo familiar.
[OBLIGATORIO] RSH actualizado; notas anuales; alumno regular 2026.
[OBLIGATORIO] Antecedentes de ingresos según situación laboral.
[OBLIGATORIO] Certificados médicos, de familiares estudiantes, licencia media para jefa de hogar o credencial de cuidadora cuando correspondan.
FUENTE: Instructivo oficial municipal de educación superior 2026. Se conserva el importe desconocido.' WHERE id_beca IN(405,506);
UPDATE requisitos_perfil SET rsh_maximo_porcentaje=90,es_para_primer_anio=true,es_para_curso_superior=true WHERE id_beca IN(405,506);
COMMIT;
