\set ON_ERROR_STOP on
BEGIN;
SET LOCAL lock_timeout='5s';
DO $guardas$ BEGIN
IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario diferente'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=53 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=53 AND public_id='d80f5bb9-1beb-436d-aa41-b722f6d6364f'::uuid AND version=1 AND md5(descripcion_larga)='8084085d163ae85cd409fef23da91d3a' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 53'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=74 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=74 AND public_id='b5ab1857-8377-4c27-8f35-ca62aabcce98'::uuid AND version=1 AND md5(descripcion_larga)='74cf040bde1e0a633a9ee9ed6b6707d8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 74'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=84 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=84 AND public_id='914b8c1b-8f90-4c85-bdd1-024cf76b54b7'::uuid AND version=1 AND md5(descripcion_larga)='3fb0fe7dd06673156e9ac7a9e45bbd56' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 84'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=107 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=107 AND public_id='fe455bbb-f320-4d3c-88e9-c23dabbabad6'::uuid AND version=1 AND md5(descripcion_larga)='042ddab4d2711c0d54eb5055f0286e14' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 107'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=123 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=123 AND public_id='3a29abc6-6e21-4163-8685-ec15dbd96e4f'::uuid AND version=1 AND md5(descripcion_larga)='c7613c12a97b3e1de531b443c84aaba8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 123'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=131 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=131 AND public_id='089eced8-f950-45fa-bfeb-74c31952e6d4'::uuid AND version=1 AND md5(descripcion_larga)='57f58ab35202b92b535005998114b708' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 131'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=325 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=325 AND public_id='54d25af0-92b8-4e03-8ec0-5916895c9028'::uuid AND version=1 AND md5(descripcion_larga)='7154f44a8a9d4224c544a55f20704ed2' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 325'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=394 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=394 AND public_id='15a3c480-52af-4a5b-b87d-54ec2d7225df'::uuid AND version=1 AND md5(descripcion_larga)='423187f9526ea32936fdfc2da058c8af' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 394'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=396 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=396 AND public_id='55ed985e-7701-4293-9526-e7ddabfa856b'::uuid AND version=1 AND md5(descripcion_larga)='234fc85128b825fa00df2b1a0ae0fd51' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 396'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=503 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=503 AND public_id='86cad381-f81f-4b75-92f6-e8b5a17ba04e'::uuid AND version=1 AND md5(descripcion_larga)='fc19b9f68a349c1aea15f13547a8c426' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 503'; END IF;
END $guardas$;
UPDATE becas SET descripcion_larga='REVISIÓN DOCUMENTAL DEL 01/11/2026: Total UAI: reglamento de ingreso 2026, artículos 2–7; cubre matrícula y arancel residual. El portal advierte expresamente que las condiciones 2027 están por publicarse. La falta de calendario 2027 queda delimitada; no es una convocatoria abierta.
FUENTES: https://www.uai.cl/admision/becas-y-aranceles/becas ; https://uai.cdn7pm.net/documentos/reglamento-becas-excelencia-academica-pregrado-2026.pdf
No se acredita recepción abierta por esta revisión.
ANTECEDENTES CONSERVADOS (las afirmaciones corregidas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=53;
UPDATE becas SET descripcion_larga='REVISIÓN DOCUMENTAL DEL 01/11/2026: Instructivo completo recuperado: premio anual de $300.000 al mejor promedio por programa/jornada; asignación sin solicitud. Requiere 35 créditos semestrales y ausencia de reprobaciones y sanciones. No publica fecha de asignación ni convocatoria anual actual.
FUENTES: https://www.ucsh.cl/assets/uploads/2022/05/Beca_Merito.pdf
No se acredita recepción abierta por esta revisión.
ANTECEDENTES CONSERVADOS (las afirmaciones corregidas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=74;
UPDATE becas SET descripcion_larga='REVISIÓN DOCUMENTAL DEL 01/11/2026: Mantención Regiones: artículos 14–17 del reglamento 2026; 50 UF anuales en diez cuotas desde marzo y elegibilidad por procedencia. Marzo es inicio del pago, no cierre de solicitud; condiciones 2027 aún anunciadas como pendientes.
FUENTES: https://www.uai.cl/admision/becas-y-aranceles/becas ; https://uai.cdn7pm.net/documentos/reglamento-becas-excelencia-academica-pregrado-2026.pdf
No se acredita recepción abierta por esta revisión.
ANTECEDENTES CONSERVADOS (las afirmaciones corregidas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=84;
UPDATE becas SET descripcion_larga='REVISIÓN DOCUMENTAL DEL 01/11/2026: El apartado específico ya señala ingreso centralizado 2027 y egreso 2026 para la modalidad del 90%, concordantes entre sí. El encabezado general conserva 2026. No publica días de solicitud de esta beca; conservar ese límite y no usar una ventana de otra modalidad.
FUENTES: https://admision.uahurtado.cl/becas-y-beneficios/
No se acredita recepción abierta por esta revisión.
ANTECEDENTES CONSERVADOS (las afirmaciones corregidas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,url_oficial='https://admision.uahurtado.cl/becas-y-beneficios/' WHERE id_beca=107;
UPDATE becas SET descripcion_larga='REVISIÓN DOCUMENTAL DEL 01/11/2026: La sección 2027 identifica convalidación EMTP, no rebaja del arancel: NEM 5,0, egreso 2025/2026 y asignaturas escolares aprobadas. La FAQ duplicada aún menciona 2026. No publica cierre de la articulación 2027 y no corresponde inventar una beca monetaria.
FUENTES: https://portal.inacap.cl/admision/articulacion/articulacion-directa
No se acredita recepción abierta por esta revisión.
ANTECEDENTES CONSERVADOS (las afirmaciones corregidas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=123;
UPDATE becas SET descripcion_larga='REVISIÓN DOCUMENTAL DEL 01/11/2026: La ficha fue corregida editorialmente a Puntaje Ponderado Pedro Luis González. Artículos 8–11 y tablas de ingreso 2026, sin fecha de solicitud utilizable ahora. Coincide en programa con 503; conservar ambos UUID y revisar esa duplicidad separadamente.
FUENTES: https://www.uai.cl/admision/becas-y-aranceles/becas ; https://uai.cdn7pm.net/documentos/reglamento-becas-excelencia-academica-pregrado-2026.pdf
No se acredita recepción abierta por esta revisión.
ANTECEDENTES CONSERVADOS (las afirmaciones corregidas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=131;
UPDATE becas SET descripcion_larga='REVISIÓN DOCUMENTAL DEL 01/11/2026: Continuidad online recuperada: título relacionado de institución acreditada y hasta diez años, con excepción laboral para técnicos; matrícula gratuita y becas hasta 35%, sin porcentaje individual garantizado. No publica ventana de esta ayuda.
FUENTES: https://admision.ipchile.cl/continuidad
No se acredita recepción abierta por esta revisión.
ANTECEDENTES CONSERVADOS (las afirmaciones corregidas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=325;
UPDATE becas SET descripcion_larga='REVISIÓN DOCUMENTAL DEL 01/11/2026: La fila de Alimentación UTA 2026 fija 16–31 de marzo para solicitud; distingue complemento BAES automático. Se acredita el cierre de esa ventana, no que todas las posibles recepciones posteriores estén cerradas. La DAE conserva referencia semestral general.
FUENTES: https://www.uta.cl/transparencia/beneficios/2026/ ; https://www.uta.cl/transparencia/pdf/mn/1/108.2025.pdf ; https://webdae.uta.cl/index.php/beneficios-complementarios/
No se acredita recepción abierta por esta revisión.
ANTECEDENTES CONSERVADOS (las afirmaciones corregidas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-03-16',fecha_cierre_postulacion=DATE '2026-03-31' WHERE id_beca=394;
UPDATE becas SET descripcion_larga='REVISIÓN DOCUMENTAL DEL 01/11/2026: Tabla UTA 2026 y decreto 1190/2024 distinguen PAES de PSU derogada: asignación sin postulación propia. Artículos 1 y 15 incluyen 1.000 puntos en tramo superior. Corregir exclusión editorial previa de ese límite, sin inventar fechas.
FUENTES: https://www.uta.cl/transparencia/beneficios/2026/ ; https://www.uta.cl/transparencia/pdf/mn/1/1190.2024.pdf
No se acredita recepción abierta por esta revisión.
ANTECEDENTES CONSERVADOS (las afirmaciones corregidas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,monto_cobertura='Arancel básico y diferenciado: hasta 100% con PAES 930–1000; básico más 50% del diferenciado con 850–<930; básico más 25% del diferenciado con 795–<850. Asignación automática; decreto 1190/2024.',url_oficial='https://www.uta.cl/transparencia/beneficios/2026/' WHERE id_beca=396;
UPDATE becas SET descripcion_larga='REVISIÓN DOCUMENTAL DEL 01/11/2026: Puntaje Ponderado PLG: mismas tablas del reglamento 2026, con cobertura por campus/carrera/colegio; no porcentaje universal. La universidad anuncia futuras condiciones 2027. Coincidencia con 131 documentada, sin eliminar ninguno.
FUENTES: https://www.uai.cl/admision/becas-y-aranceles/becas ; https://uai.cdn7pm.net/documentos/reglamento-becas-excelencia-academica-pregrado-2026.pdf
No se acredita recepción abierta por esta revisión.
ANTECEDENTES CONSERVADOS (las afirmaciones corregidas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=503;
COMMIT;
