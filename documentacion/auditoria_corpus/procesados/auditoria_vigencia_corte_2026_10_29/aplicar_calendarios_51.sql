\set ON_ERROR_STOP on
BEGIN;
SET LOCAL lock_timeout='5s';
SET LOCAL TIME ZONE 'America/Santiago';
DO $guard$ BEGIN
IF CURRENT_DATE NOT BETWEEN DATE '2026-10-29' AND DATE '2026-11-04' THEN RAISE EXCEPTION 'Revisar calendario y fecha antes de aplicar'; END IF;
IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario distinto'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=11 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=11 AND public_id='da8bdcfe-2746-4a95-92c0-852042f7a903'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 11'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=20 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=20 AND public_id='6ec7f358-681e-43d2-a8cc-5a8d7a27da76'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 20'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=24 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=24 AND public_id='32d2a10c-1c8b-46d9-b461-84b8082d9a6a'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 24'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=35 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=35 AND public_id='0573fb91-8350-4e79-850c-322ffc876913'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 35'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=39 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=39 AND public_id='ee214984-660e-433b-80bd-1a2ccc48e3dd'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 39'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=42 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=42 AND public_id='a1c86c4a-c48e-40e8-b190-a75e6684fb56'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 42'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=76 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=76 AND public_id='6e1979d4-9c61-4b08-a45b-6b6d6e2525ca'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 76'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=80 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=80 AND public_id='6fc9b420-ae9b-4e94-94ed-83b7b2ed7673'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 80'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=113 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=113 AND public_id='996eddb7-7f41-4663-9f39-10b21144d7b3'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 113'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=115 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=115 AND public_id='c7a19c94-6821-43ec-ae63-be7125b86796'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 115'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=116 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=116 AND public_id='a5aeebbd-0be7-48ea-825d-7cbb8099e7fb'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 116'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=128 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=128 AND public_id='9b9a66e2-2676-45ee-9b76-f9032fa0df06'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 128'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=132 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=132 AND public_id='2120c1b4-12d2-48d4-9ae2-460317c24da5'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 132'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=146 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=146 AND public_id='f10dcc10-b985-4bb8-aa58-329d54d8ed60'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 146'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=154 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=154 AND public_id='3fbb74c4-279f-4ecf-8c5e-4b9cbe98c4d3'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 154'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=159 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=159 AND public_id='82238e26-0d6e-456b-92be-b1deef4a2b8b'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 159'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=166 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=166 AND public_id='3e8215fc-2554-465f-bedd-5d8dcf7a5f6a'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 166'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=179 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=179 AND public_id='61343ed1-6067-4ff3-a855-8359299426c4'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 179'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=188 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=188 AND public_id='96a2f04e-fa92-4963-bbca-0820613a6941'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 188'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=200 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=200 AND public_id='c5993f59-b9d2-482f-b670-5f63d97bd9de'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 200'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=207 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=207 AND public_id='4a1e3ab6-2492-4159-8718-cbdd03eae1a9'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 207'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=224 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=224 AND public_id='c40dabd6-af08-4c3d-a6e3-3c320a4c3717'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 224'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=252 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=252 AND public_id='da9f9f5b-9006-466f-824c-08df80484463'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 252'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=258 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=258 AND public_id='ff4ef933-fe40-48f6-a450-ddf0bd6f59a3'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 258'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=269 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=269 AND public_id='d12d90d3-2fdc-4d6b-b0f3-d9d776686d8f'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 269'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=275 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=275 AND public_id='74742803-319e-4295-b5a4-c29eb9f43f8a'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 275'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=283 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=283 AND public_id='87e0f3a8-aac5-4be8-b93f-e922e26819ac'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 283'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=311 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=311 AND public_id='4e6e42c8-9ad5-485a-a37d-631911a93a5c'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 311'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=315 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=315 AND public_id='725bd129-0f0e-4f93-84ae-b2435a4a505a'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 315'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=316 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=316 AND public_id='a9d0f01b-1b36-432b-8f9f-20151ec88fc1'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 316'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=326 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=326 AND public_id='b5a8075b-4929-4962-9250-e02ee9fa6236'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 326'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=330 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=330 AND public_id='d07b4f20-aa32-40bc-b1ab-4a4a651f8e29'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 330'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=339 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=339 AND public_id='84f4de8c-14a6-4f74-979b-4ee171ac3d77'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 339'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=345 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=345 AND public_id='8aadf4e9-53dc-4ebd-a682-3dd906b13c41'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 345'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=348 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=348 AND public_id='9cb796f5-6d14-44ed-a5d4-3f0e0447c2d4'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 348'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=359 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=359 AND public_id='548e96a8-e7d8-4b16-b549-c802242d17a4'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 359'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=361 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=361 AND public_id='bf5876ae-5c03-4e17-956e-befbdf065784'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 361'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=387 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=387 AND public_id='ccffe04f-d144-4837-b452-b7dacf9c6bce'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 387'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=399 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=399 AND public_id='2a43fa46-4a31-4018-9242-9e45bc61e0f1'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 399'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=409 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=409 AND public_id='cc02bb04-7363-4469-bc08-965b3c22b50b'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 409'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=411 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=411 AND public_id='10cdc994-9b07-4f5f-994d-e269c935b2cf'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 411'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=429 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=429 AND public_id='e66bd0e5-eb94-41d4-9dbb-02a5664029d0'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 429'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=448 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=448 AND public_id='c2d34bc4-82a0-44d4-b0b3-f1cd8232c1b6'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 448'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=460 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=460 AND public_id='f34f34e9-bb29-47a7-8dfb-6c1c470da438'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 460'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=470 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=470 AND public_id='846bcf1d-45f4-47e2-ad41-eb2ad963c3db'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 470'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=471 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=471 AND public_id='75e2f5b1-e021-4fe4-8534-fd2b2cf2c085'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 471'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=484 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=484 AND public_id='d2d2f486-7d6e-4ae6-85ff-8f19587f7c65'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 484'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=516 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=516 AND public_id='61fdbc15-b108-4d89-9657-8fdda6b595e1'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 516'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=524 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=524 AND public_id='3d0bbdd0-8d31-497a-969a-2ea6ddbeb029'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 524'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=255 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=255 AND public_id='d4b5e1f3-91b1-4091-834a-2a9f9f05bfed'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 255'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=327 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=327 AND public_id='c6303482-479e-4955-80d0-9827c0f9151e'::uuid AND version=1 AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto en 327'; END IF;
END $guard$;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-05-04', fecha_cierre_postulacion=DATE '2026-05-31', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-05-04 hasta 2026-05-31. La lectura visual de las bases acredita recepción en línea del 4 al 31 de mayo de 2026. Junio corresponde a tramitación y subsanación.
LÍMITES DEL CALENDARIO: La portada web mantiene textos de años anteriores; prevalece el calendario explícito de las bases 2026. No se deduce prórroga de la subsanación. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://becasmunicipales.quilicura.cl/index.aspx ; https://becasmunicipales.quilicura.cl/Doc/BASES_3.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=11;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-30', fecha_cierre_postulacion=DATE '2026-04-14', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-03-30 hasta 2026-04-14 a las 14:00 (America/Santiago). La convocatoria establece recepción del 30 de marzo al 14 de abril de 2026 a las 14:00; exige residencia, RSH y condición estudiantil.
LÍMITES DEL CALENDARIO: La entrega de premios de mayo no amplía la recepción. No se traslada el monto de las bases 2024 sin respaldo de esta edición. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://hijuelas.cl/beca-de-excelencia-municipal/ ; https://hijuelas.cl/wp-content/uploads/BASES-Beca-municipal-2024.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=20;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-23', fecha_cierre_postulacion=DATE '2026-04-12', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-03-23 hasta 2026-04-12. La noticia municipal fija recepción online del 23 de marzo al 12 de abril de 2026; aporte único de $160.000 para estudiantes superiores con RSH comunal.
LÍMITES DEL CALENDARIO: La revisión de abril/mayo y la selección no son extensión de postulaciones. No se accedió con Clave Única ni se enviaron formularios. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.sanantonio.cl/municipalidad/noticias/item/14791-municipio-abre-postulaciones-a-la-beca-imsa-2026.html ; https://transparencia.sanantonio.cl/municipalidad/noticias/item/download/2201_5017f1e6eb156d7396044f78f0e37ad5.html ; https://www.sanantonio.cl/servicios/portal-servicios/tramites-por-unidades/item/8873-beca-municipal.html
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=24;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-10-05', fecha_cierre_postulacion=DATE '2026-10-19', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-10-05 hasta 2026-10-19. La convocatoria específica fija recepción online del 5 al 19 de octubre de 2026 para estudiantes regulares con mérito y necesidad económica.
LÍMITES DEL CALENDARIO: La URL conserva 2025 pero el texto y calendario académico indican 2026; diciembre es resultado, no cierre. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.ucsh.cl/actualidad/ucsh-abre-postulaciones-a-la-beca-don-bosco-2025-2026-conoce-los-requisitos-promedios-y-plazos-del-beneficio/ ; https://academicos.ucsh.cl/calendarioacad.aspx ; https://www.ucsh.cl/assets/uploads/2023/10/info_BDB.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=35;
UPDATE becas SET fecha_inicio_postulacion=NULL, fecha_cierre_postulacion=DATE '2026-03-31', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción hasta 2026-03-31. La municipalidad fija cierre el 31 de marzo de 2026 para el incentivo único de $200.000; exige regularidad 2026 y condiciones académicas y sociales.
LÍMITES DEL CALENDARIO: El día de publicación no acredita apertura; no se inventa fecha inicial. El pago de abril no amplía el cierre. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.munivichuquen.cl/postula-a-la-beca-municipal-de-incentivo-a-la-educacion-superior-2026-no-pierdas-la-oportunidad/
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=39;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-02-01', fecha_cierre_postulacion=DATE '2026-03-31', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-02-01 hasta 2026-03-31. El portal diferencia excelencia académica y estímulo socioeconómico; ambas ventanas publicadas van del 1 de febrero al 31 de marzo de 2026 y figuran cerradas.
LÍMITES DEL CALENDARIO: El calendario coincide pero no prueba que ambas becas sean un mismo programa ni autoriza trasladar coberturas entre ellas. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.municipalidadsanvicente.cl/tramites/postulaciones ; https://convocatorias.municipalidadsanvicente.cl/ ; https://storage.googleapis.com/san-vicente-bucket/archivos_portal/cuentas-publicas/68ea454d-0a0a-41b8-98e1-64b13bbbd818.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=42;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-09', fecha_cierre_postulacion=DATE '2026-03-27', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-03-09 hasta 2026-03-27. La página institucional incluye esta modalidad en la recepción interna del 9 al 27 de marzo de 2026.
LÍMITES DEL CALENDARIO: No trasladar ventana de postgrado del segundo semestre; se acredita solo proceso de pregrado identificado. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://ubiobio.cl/admision/Becas_de_Mantencion_y_Cuota_Basica/ ; https://acceso.mineduc.cl/wp-content/uploads/2025/11/SERV-Y-BENEF-2026-181125.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=76;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-02-16', fecha_cierre_postulacion=DATE '2026-03-13', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-02-16 hasta 2026-03-13 a las 13:00 (America/Santiago). El municipio publica recepción presencial del 16 de febrero al 13 de marzo de 2026 a las 13:00; no acepta solicitudes por correo.
LÍMITES DEL CALENDARIO: El 10 de febrero es publicación de bases y no apertura. Los apoyos de viaje son un componente separado. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.muniprimavera.cl/noticias/proceso-de-becas-municipales-de-primavera-2026/ ; https://drive.google.com/file/d/1-ZIm27npFj8vg26DHj-k57XXbpLZFh_h/view?usp=drive_link ; https://drive.google.com/uc?export=download&id=1-ZIm27npFj8vg26DHj-k57XXbpLZFh_h
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=80;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-02-02', fecha_cierre_postulacion=DATE '2026-03-31', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-02-02 hasta 2026-03-31. La fila 2026 fija 2 febrero–31 marzo; separa evaluación abril/mayo y pagos junio/septiembre.
LÍMITES DEL CALENDARIO: El año del acto 2023 es normativo; no altera la edición 2026. No se halló prórroga en las tablas leídas. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.sanpedrodeatacamatransparente.cl/Uploads/2022/07/09%20Subsidios%20y%20Beneficios%20propios/Beca%20Municipal/BECA%20SOCIAL%20ESTUDIOS%20MARZO%202026.pdf ; https://sanpedrodeatacamatransparente.cl/Uploads/2022/07/09%20Subsidios%20y%20Beneficios%20propios/2026/Beca%20Municipal/BECA%20SOCIAL%20DE%20ESTUDIOS%20ENERO%202026.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=113;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-10-19', fecha_cierre_postulacion=DATE '2026-10-23', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-10-19 hasta 2026-10-23. La página específica fija segundo llamado 19–23 octubre 2026; aporte único 400.000 y orden de recepción completa.
LÍMITES DEL CALENDARIO: El encabezado exige egreso anterior pero FAQ dice sin requisito de año; no corregir elegibilidad masivamente. El ejemplo de certificado agosto no es apertura. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://imda.gob.cl/beca-municipal/
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=115;
UPDATE becas SET fecha_inicio_postulacion=NULL, fecha_cierre_postulacion=DATE '2026-05-25', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción hasta 2026-05-25 a las 17:00 (America/Santiago). El aviso posterior sustituye cierre 20 mayo por lunes 25 mayo; atención final hasta 17:00.
LÍMITES DEL CALENDARIO: Una noticia previa escribe sábado 17 mayo, día incompatible con 2026; el aviso posterior acredita explícitamente año y prórroga coherente. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://munirinconada.cl/municipalidad-amplia-plazo-de-postulacion-a-beca-de-educacion-superior-2026/ ; https://munirinconada.cl/alta-afluencia-marco-inicio-de-postulacion-a-beca-municipal-de-educacion-superior-2026/
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=116;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-02-16', fecha_cierre_postulacion=DATE '2026-04-17', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-02-16 hasta 2026-04-17 a las 14:00 (America/Santiago). La noticia del 13 febrero fija solicitudes 16 febrero–17 abril 2026 de 08:30 a 14:00; hasta 400 aportes de 210.000.
LÍMITES DEL CALENDARIO: La antigua tabla PSU diciembre/enero no sustituye el llamado actual. La adjudicación posterior no amplía recepción. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://chillanviejo.cl/noticia/se-abre-el-proceso-de-postulacion-para-la-beca-municipal-2026-en-chillan-viejo/ ; https://chillanviejo.cl/wp-content/uploads/2024/02/REGLAMENTO-BECA-MUNICIPAL-2024.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=128;
UPDATE becas SET fecha_inicio_postulacion=NULL, fecha_cierre_postulacion=DATE '2026-03-12', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción hasta 2026-03-12 a las 23:59 (America/Santiago). La convocatoria enumera Trayectoria Formativa y fija cierre el 12 de marzo de 2026 a las 23:59.
LÍMITES DEL CALENDARIO: No confundir recepción de becas con FAS abierto hasta abril. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.ulagos.cl/comunicados/becas-internas-2026/ ; https://www.ulagos.cl/portal-del-estudiante/financiamiento-estudiantil/ ; https://acceso.mineduc.cl/wp-content/uploads/2025/11/SERV-Y-BENEF-2026-181125.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=132;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-24', fecha_cierre_postulacion=DATE '2026-04-13', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-03-24 hasta 2026-04-13. La ficha contiene edición 2026 con recepción y acreditación del 24 de marzo al 13 de abril; también conserva una sección 2025 separada.
LÍMITES DEL CALENDARIO: El alcance es Universidad Tecnológica de Chile INACAP; no generalizar a todo IP/CFT. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://portal.inacap.cl/financiamiento-estudiantil/becas/beca-asistencial
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=146;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-02-02', fecha_cierre_postulacion=DATE '2026-02-20', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-02-02 hasta 2026-02-20. La noticia específica del 13 febrero recibe sobres del 2 al 20 febrero; aclara transporte solo jornada vespertina.
LÍMITES DEL CALENDARIO: No extender arancel/transporte diurno ni inferir segundo semestre. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://sanfabian.cl/noticias/?id=1079 ; https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=154;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-06-01', fecha_cierre_postulacion=DATE '2026-06-15', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-06-01 hasta 2026-06-15 a las 17:00 (America/Santiago). El aviso oficial fija solicitudes del 1 al 15 junio 2026; cierre a las 17:00.
LÍMITES DEL CALENDARIO: Los actos de entrega de septiembre no amplían recepción. Se mantienen ambos UUID sin resolver duplicidad por nombre. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.sanbernardo.cl/becas-2026/ ; https://www.sanbernardo.cl/wp-content/uploads/2026/05/REGLAMENTO-BECA-2026.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=159;
UPDATE becas SET fecha_inicio_postulacion=DATE '2025-12-08', fecha_cierre_postulacion=DATE '2026-01-04', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2025-12-08 hasta 2026-01-04. El instructivo del expediente fija cierre el 4 de enero de 2026 para esta modalidad. La contradicción de requisitos no convierte ese plazo vencido en recepción abierta.
LÍMITES DEL CALENDARIO: Se acredita únicamente ese cierre histórico. Se mantienen sin resolver las condiciones 2025/2026 y un llamado posterior; no se actualizan requisitos. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.unab.cl/servicioestudiante/beca-cursos-superiores/ ; https://www.unab.cl/servicioestudiante/wp-content/uploads/2025/12/Instructivo-Becas-Cursos-Superiores-2026.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=166;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-09', fecha_cierre_postulacion=DATE '2026-04-01', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-03-09 hasta 2026-04-01 a las 13:30 (America/Santiago). El texto establece postulación y renovación 9 marzo–1 abril a las 13:30; pagos tienen otro calendario.
LÍMITES DEL CALENDARIO: El apoyo es 50.000 mensual; controles de alumno regular después del día 10 no reabren solicitudes. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://munipuchuncavi.cl/2.0/sitio10/becas2026.php ; https://munipuchuncavi.cl/2.0/sitio10/pdf/becas2026/reglamento.pdf ; https://munipuchuncavi.cl/2.0/sitio10/news-estudiantes-de-puchuncav-2183.html ; https://www.munipuchuncavi.cl/news-concejo-municipal-aprueba-2114.html
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=179;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-08-12', fecha_cierre_postulacion=DATE '2026-08-31', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-08-12 hasta 2026-08-31. El díptico oficial leído fija proceso 12–31 agosto 2026; alumno regular actualizado agosto y notas 2025.
LÍMITES DEL CALENDARIO: El slug 2025 del portal no invalida el cuerpo 2026 del díptico. No crear fecha de otra edición. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://municipalidaddepuyehue.cl/web/wp-content/uploads/2026/08/fffffDIPTICO_2026.pdf.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=188;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-05-22', fecha_cierre_postulacion=DATE '2026-06-05', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-05-22 hasta 2026-06-05. Portal de convocatorias identifica subsidio de arancel superior con apertura 22 mayo y cierre 5 junio 2026; landing dice cerrada.
LÍMITES DEL CALENDARIO: Empleo Juvenil y Escolaridad de agosto son otras líneas y no amplían esta convocatoria. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://subsidios.lascondes.cl/ ; https://landingconvocatorias.lascondes.cl/beneficio/educacion-superior/ ; https://transparencia.lascondes.cl/transparencia/tramites-organismo/direccion_desarrollo_comunitario.html
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=200;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-01', fecha_cierre_postulacion=DATE '2026-03-31', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-03-01 hasta 2026-03-31. Aviso 2 febrero 2026 establece recepción y renovación del 1 al 31 marzo de cada año, sustituyendo decreto 590/2025.
LÍMITES DEL CALENDARIO: Pagos marzo–diciembre no son ventana de postulación; norma solo aplicada a edición acreditada. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://municipalidadquilleco.cl/municipalidad-de-quilleco-aprueba-nueva-ordenanza-de-beca-municipal-para-educacion-superior/
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=207;
UPDATE becas SET fecha_inicio_postulacion=DATE '2025-12-08', fecha_cierre_postulacion=DATE '2026-01-04', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2025-12-08 hasta 2026-01-04. El instructivo del expediente fija cierre el 4 de enero de 2026 para esta modalidad. La contradicción de requisitos no convierte ese plazo vencido en recepción abierta.
LÍMITES DEL CALENDARIO: Se acredita únicamente ese cierre histórico. Se mantienen sin resolver las condiciones 2025/2026 y un llamado posterior; no se actualizan requisitos. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.unab.cl/servicioestudiante/beca-cursos-superiores/ ; https://www.unab.cl/servicioestudiante/wp-content/uploads/2025/12/Instructivo-Becas-Cursos-Superiores-2026.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=224;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-04-13', fecha_cierre_postulacion=DATE '2026-04-20', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-04-13 hasta 2026-04-20. El llamado enumera Dinero, Alimentación, Trabajo y Residencia con recepción del 13 al 20 de abril de 2026.
LÍMITES DEL CALENDARIO: El llamado de postgrado de septiembre/octubre es distinto; falta verificar una edición posterior de pregrado. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://vrae.usach.cl/comenzaron-las-postulaciones-de-becas-internas-para-este-primer-semestre-2026/
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=252;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-01-20', fecha_cierre_postulacion=DATE '2026-01-29', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-01-20 hasta 2026-01-29. La ficha específica liga solicitud de residencia a matrícula 20–29 enero 2026.
LÍMITES DEL CALENDARIO: No transferir fechas de deporte; no acredita edición de ingreso 2027. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://admision.udec.cl/beneficios/
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=258;
UPDATE becas SET fecha_inicio_postulacion=DATE '2025-11-19', fecha_cierre_postulacion=DATE '2026-01-08', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2025-11-19 hasta 2026-01-08. La ficha específica fija recepción 19/11/2025–08/01/2026 y cupos por carrera 2026.
LÍMITES DEL CALENDARIO: El nuevo enlace de navegación 2027 no convierte estos plazos en nueva convocatoria; hay discordancia de número de ley en el texto. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://admision.uandes.cl/becas/beca-ejercito ; https://www.uandes.cl/wp-content/uploads/2023/12/Reglamento-de-Becas-de-Pregrado-diciembre-2019.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=269;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-01-22', fecha_cierre_postulacion=DATE '2026-03-12', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-01-22 hasta 2026-03-12 a las 23:59 (America/Santiago). El llamado enumera Alimentación Interna y fija cierre el 12 de marzo de 2026 a las 23:59.
LÍMITES DEL CALENDARIO: El plazo FAS no extiende solicitudes; BAES es otro beneficio. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.ulagos.cl/comunicados/becas-internas-2026/ ; https://www.ulagos.cl/portal-del-estudiante/financiamiento-estudiantil/
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=275;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-05-22', fecha_cierre_postulacion=DATE '2026-06-05', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-05-22 hasta 2026-06-05. Se coteja esta variante con convocatoria superior22mayo–5junio2026 y landing cerrada.
LÍMITES DEL CALENDARIO: No usar cierre de Escolaridad ni Empleo Juvenil; conservar UUID separado de200. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://subsidios.lascondes.cl/ ; https://landingconvocatorias.lascondes.cl/beneficio/educacion-superior/ ; https://transparencia.lascondes.cl/transparencia/tramites-organismo/direccion_desarrollo_comunitario.html
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=283;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-01-12', fecha_cierre_postulacion=DATE '2026-03-20', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-01-12 hasta 2026-03-20. El artículo transitorio 27 establece para 2026 recepción del 12 de enero al 20 de marzo. Evaluación y transferencias son etapas posteriores.
LÍMITES DEL CALENDARIO: No convertir el periodo de difusión del 5 de enero en apertura ni trasladar el calendario a 2027. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://munimaullin.cl/ordenanzas/ ; https://munimaullin.cl/wp-content/uploads/2025/12/ordenanza-municipal-beca-ensen%CC%83anza-superior.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=311;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-02-16', fecha_cierre_postulacion=DATE '2026-03-31', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-02-16 hasta 2026-03-31. Actividad oficial identifica inicio16febrero y término31marzo2026; noticia distingue beca superior de pasajes.
LÍMITES DEL CALENDARIO: Descripción genérica dice revisión de bases en marzo; para fecha se usa calendario explícito de actividad2026, no el premio deportivo. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.munisanesteban.cl/noticias/municipio-abre-proceso-de-postulacion-online-a-bec-22973 ; https://www.munisanesteban.cl/actividades/beca-ensenanza-superior-san-esteban-2026-162189
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=315;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-09', fecha_cierre_postulacion=DATE '2026-04-17', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-03-09 hasta 2026-04-17. Noticia7marzo2026 fija recepción desde9marzo hasta17abril; formularios2026 distinguen edición del reglamento2025.
LÍMITES DEL CALENDARIO: No se usa el escaneo2025 ilegible como fuente del plazo ni se considera vigente por redacción del anuncio. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://eltabo.cl/municipalidad-de-el-tabo-abre-proceso-de-postulacion-a-becas-para-estudiantes-de-educacion-superior/ ; https://eltabo.cl/wp-content/uploads/2025/03/Reglamento-y-requisitos-Becas-2025.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=316;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-02', fecha_cierre_postulacion=DATE '2026-03-27', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-03-02 hasta 2026-03-27. Se leyeron imágenes del PDF: primer año2026, egreso2023–25, RSH40–70; página4 apartado h fija postulación2–27marzo.
LÍMITES DEL CALENDARIO: Resultados30abril y ceremonia9mayo no son nuevas ventanas; voluntariado es opcional. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://renca.cl/wp-content/uploads/2026/02/DECRETO-496-APRUEBA-BASES-DE-POSTULACION-A-LA-BECA-MUNICIPAL-DE-INCENTIVO-A-LAS-TRAYECTORIAS-EDUCATIVAS-1.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=326;
UPDATE becas SET fecha_inicio_postulacion=NULL, fecha_cierre_postulacion=DATE '2026-03-06', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción hasta 2026-03-06. Noticia5marzo2026 fija último plazo viernes6marzo y enumera U/IP/CFT. Existen bases2026 en biblioteca municipal.
LÍMITES DEL CALENDARIO: No se inventa apertura ni se toma disponibilidad de cupos como extensión posterior. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.losandes.cl/download/2026-bases-beca-educacion-superior/ ; https://www.losandes.cl/ultimos-dias-para-postular-a-la-beca-de-educacion-superior-en-los-andes/ ; https://www.losandes.cl/download/2026_antecedentes_postulacion_beca_superior/ ; https://www.losandes.cl/download/2026_antecedentes_postulacion_beca_superior/?wpdmdl=15723&refresh=6ac5255f9bb091791305055&ind=1770180488141&filename=2026_ANTECEDENTES_POSTULACION_BECA_SUPERIOR.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=330;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-06-01', fecha_cierre_postulacion=DATE '2026-06-15', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-06-01 hasta 2026-06-15 a las 17:00 (America/Santiago). El aviso oficial fija solicitudes del 1 al 15 junio 2026; cierre a las 17:00.
LÍMITES DEL CALENDARIO: Los actos de entrega de septiembre no amplían recepción. Se mantienen ambos UUID sin resolver duplicidad por nombre. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.sanbernardo.cl/becas-2026/ ; https://www.sanbernardo.cl/wp-content/uploads/2026/05/REGLAMENTO-BECA-2026.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=339;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-09', fecha_cierre_postulacion=DATE '2026-03-31', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-03-09 hasta 2026-03-31 a las 13:00:00 (America/Santiago). Recepción de antecedentes del 9 al 31 de marzo de 2026; cierre presencial a las 13:00.
LÍMITES DEL CALENDARIO: La difusión inicia el 2 de marzo; agosto es acreditación para segunda cuota. No extender la recepción hasta esos pagos. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.yungay.cl/wp-content/uploads/2026/03/Reglamento-Beca-Municipal-2026-PDF.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=345;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-05-04', fecha_cierre_postulacion=DATE '2026-05-31', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-05-04 hasta 2026-05-31. Se coteja esta variante con calendario leído visualmente de bases2026:4–31mayo.
LÍMITES DEL CALENDARIO: No usar antiguas anualidades de portadas ni fusionar UUID con11. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://becamunicipal.quilicura.cl/ ; https://becasmunicipales.quilicura.cl/Doc/BASES_3.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=348;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-04-07', fecha_cierre_postulacion=DATE '2026-04-27', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-04-07 hasta 2026-04-27. Bases2026 enumeran recepción y subsanación del7al27abril; fin de rendición11diciembre2026 es separado.
LÍMITES DEL CALENDARIO: El27abril se refiere a solicitudes; no traslada calendario al antiguo traslado del otro UUID229 sin acreditar identidad. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://curarrehue.cl/on/wp-content/uploads/2026/04/bases-incentivo-educacion-superior-2026.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=359;
UPDATE becas SET fecha_inicio_postulacion=NULL, fecha_cierre_postulacion=DATE '2026-03-31', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción hasta 2026-03-31. Noticia23febrero2026, actualizada24febrero, fija fin de documentos y postulación31marzo2026;255cupos y70.000mensuales.
LÍMITES DEL CALENDARIO: No usar hora13:30 de convocatoria2025 para edición2026 sin fuente expresa. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.munilaunioninfo.com/single-post/municipio-inicia-proceso-de-postulaci%C3%B3n-proceso-de-postulaci%C3%B3n-a-beca-de-educaci%C3%B3n-superior-2026 ; https://www.munilaunioninfo.com/single-post/municipio-inicia-proceso-de-postulaci%25C3%25B3n-proceso-de-postulaci%25C3%25B3n-a-beca-de-educaci%25C3%25B3n-superior-2026
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=361;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-09', fecha_cierre_postulacion=DATE '2026-03-27', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-03-09 hasta 2026-03-27. La página institucional incluye esta modalidad en la recepción interna del 9 al 27 de marzo de 2026.
LÍMITES DEL CALENDARIO: No trasladar ventana de postgrado del segundo semestre; se acredita solo proceso de pregrado identificado. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://ubiobio.cl/admision/Becas_de_Mantencion_y_Cuota_Basica/ ; https://dde.ubiobio.cl/bienestar/becas-y-beneficios-ubb/
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=387;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-08-18', fecha_cierre_postulacion=DATE '2026-09-01', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-08-18 hasta 2026-09-01. Las bases identifican recepción del 18 de agosto al 1 de septiembre de 2026 para el aporte superior.
LÍMITES DEL CALENDARIO: La ceremonia del 16 de octubre no es cierre. El horario 08:30–14:00 corresponde a atención presencial y no se impone al canal digital. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://purranque.cl/descargas/BASES-BECA-ED-SUPERIOR.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=399;
UPDATE becas SET fecha_inicio_postulacion=NULL, fecha_cierre_postulacion=DATE '2026-03-31', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción hasta 2026-03-31. El aviso específico para nuevos estudiantes fija acceso al descuento hasta 31 de marzo de 2026.
LÍMITES DEL CALENDARIO: No comprende automáticamente otras jornadas, programas ni semestres del conjunto de convenios. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://portal.inacap.cl/w/descubre-los-descuentos-de-carreras-t%C3%A9cnicas-para-estudiantes-nuevos-de-2026 ; https://portal.inacap.cl/w/descubre-los-convenios-de-financiamiento-para-el-primer-semestre-2025-en-inacap
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=409;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-03-09', fecha_cierre_postulacion=DATE '2026-03-27', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-03-09 hasta 2026-03-27. La página institucional incluye esta modalidad en la recepción interna del 9 al 27 de marzo de 2026.
LÍMITES DEL CALENDARIO: No trasladar ventana de postgrado del segundo semestre; se acredita solo proceso de pregrado identificado. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://ubiobio.cl/admision/Becas_de_Mantencion_y_Cuota_Basica/ ; https://dde.ubiobio.cl/bienestar/becas-y-beneficios-ubb/
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=411;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-04-07', fecha_cierre_postulacion=DATE '2026-05-07', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-04-07 hasta 2026-05-07. Ficha específica fija7abril–7mayo2026;200.000,RSH40 y egresados de cuarto medio de la comuna.
LÍMITES DEL CALENDARIO: Formulario de entrevista disponible no reabre recepción; no inventar hora. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.munirionegro.cl/entrevista-para-beca-municipal/
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=429;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-07-20', fecha_cierre_postulacion=DATE '2026-08-20', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-07-20 hasta 2026-08-20. Recepción del 20 de julio al 20 de agosto de 2026 para Pasajes de Excelencia de educación superior.
LÍMITES DEL CALENDARIO: Los encabezados residuales 2025 no sustituyen la anualidad 2026 expresa del cuerpo y del calendario. No es la beca cultural. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.mpitrufquen.cl/portal/publicaciones/2026/ ; https://www.mpitrufquen.cl/portal/publicaciones/2026/publicaciones/Postulacion_a_Becas_de_Pasajes_para_Estudiantes_de_Educacion_Superior_2026_6a5e6d15e3545/BASES_BECAS_ESTUDIANTES_2026.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=448;
UPDATE becas SET fecha_inicio_postulacion=NULL, fecha_cierre_postulacion=DATE '2026-03-12', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción hasta 2026-03-12 a las 23:59 (America/Santiago). El llamado incluye Delia Domínguez y fija recepción hasta 12 de marzo de 2026 a las 23:59.
LÍMITES DEL CALENDARIO: No ampliar por FAS ni reemplazar por excelencia genérica. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.ulagos.cl/comunicados/becas-internas-2026/ ; https://www.ulagos.cl/portal-del-estudiante/financiamiento-estudiantil/ ; https://acceso.mineduc.cl/wp-content/uploads/2025/11/SERV-Y-BENEF-2026-181125.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=460;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-09-07', fecha_cierre_postulacion=DATE '2026-09-21', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-09-07 hasta 2026-09-21 a las 14:00 (America/Santiago). Calendario enlazado oficialmente fija7–21septiembre2026, cierre14:00; revisión/resultados/pagos posteriores son etapas distintas.
LÍMITES DEL CALENDARIO: Documento se titula referencial; no se halló modificación posterior en página consultada. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.teno.cl/portal2/Depto_Unidades/Dideco/Becas/CALENDARIO%20BECA%20MUNICIPAL%202026.pdf ; https://www.teno.cl/portal2/beca-municipal-2026/
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=470;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-10-14', fecha_cierre_postulacion=DATE '2026-10-21', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-10-14 hasta 2026-10-21. Ficha oficial fija postulación14–21octubre2026, validación22–28octubre, notificación29octubre–2noviembre y depósito3–10noviembre.
LÍMITES DEL CALENDARIO: Solo recepción termina21octubre; no usar pago como cierre. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://munipetorca.cl/docs/becamunicipaleducacionsuperior/
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=471;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-01-20', fecha_cierre_postulacion=DATE '2026-01-29', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-01-20 hasta 2026-01-29. La convocatoria de la beca enumera condiciones y recepción en matrícula del 20 al 29 enero 2026.
LÍMITES DEL CALENDARIO: Es esta modalidad de excelencia, no cualquier beca del sitio ni nueva convocatoria 2027. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://admision.udec.cl/beneficios/
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=484;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-04-06', fecha_cierre_postulacion=DATE '2026-04-17', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-04-06 hasta 2026-04-17. Noticia oficial7abril2026 informa recepción lunes6–viernes17abril en segundo piso municipal.
LÍMITES DEL CALENDARIO: No usar30agosto del reglamento2022: es acreditación para segunda cuota. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://www.mlonquimay.cl/web/departamentos-2/noticias/page/7/?i=71-816-1 ; https://www.mlonquimay.cl/web/wp-content/uploads/2022/07/reglamento-beca-municipal-FINAL-1.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=516;
UPDATE becas SET fecha_inicio_postulacion=DATE '2026-02-01', fecha_cierre_postulacion=DATE '2026-03-31', descripcion_larga='CALENDARIO VERIFICADO: convocatoria 2026 cerrada. Recepción desde 2026-02-01 hasta 2026-03-31. Se coteja con42 y portal oficial: ambas modalidades muestran1febrero–31marzo2026 y estado cerrado.
LÍMITES DEL CALENDARIO: Calendario común no convierte ambas becas en una; no fusionar UUID ni coberturas. Una nueva edición exige nueva evidencia.
FUENTES DE CALENDARIO: https://convocatorias.municipalidadsanvicente.cl/ ; https://storage.googleapis.com/san-vicente-bucket/archivos_portal/cuentas-publicas/68ea454d-0a0a-41b8-98e1-64b13bbbd818.pdf
ANTECEDENTES DEL BENEFICIO (el calendario anterior queda sustituido por la nota anterior):
' || descripcion_larga, version=version+1 WHERE id_beca=524;
UPDATE becas SET estado_activa=true, fecha_inicio_postulacion=DATE '2026-10-01', fecha_cierre_postulacion=DATE '2026-11-05', url_oficial='https://www.ventanillaunicasocial.gob.cl/ficha/255/beca-juan-gomez-millas', descripcion_corta='Beca Juan Gómez Millas: postulación FUAS 2027 hasta el 5 de noviembre de 2026 a las 14:00. Sujeta a requisitos y adjudicación.', descripcion_larga='ALCANCE VERIFICADO: postulación FUAS para asignación 2027 de Beca Juan Gómez Millas. Recepción del 1 de octubre al 5 de noviembre de 2026 a las 14:00 de America/Santiago. Postular no garantiza adjudicación.
BENEFICIO: Financia hasta $1.150.000 del arancel anual.
REQUISITOS PRINCIPALES: nacionalidad chilena; 70% de menores ingresos evaluado mediante FUAS. Ese criterio no se convierte en un porcentaje RSH. Institución de educación superior acreditada; para nuevos y antiguos dentro de la duración formal. PAES promedio de pruebas obligatorias desde 510 puntos; exención PACE para nuevos. Antiguos: escala de ingreso aplicable y avance de 60% al pasar a segundo; 70% desde tercero. Pregrado presencial; restricciones por título y asignaciones previas.
LÍMITES: matrícula, acreditación y demás condiciones de asignación deben cumplirse; completar FUAS es solo postulación. Los calendarios de resultados y apelaciones son procesos distintos.
DOCUMENTOS REQUERIDOS: completar FUAS; acreditar situación socioeconómica en la institución si corresponde.

TRAZABILIDAD EDITORIAL — texto previo conservado (sustituido para convocatoria actual):
' || descripcion_larga, version=version+1 WHERE id_beca=255;
UPDATE requisitos_perfil SET es_para_primer_anio=true, es_para_curso_superior=true WHERE id_beca=255;
UPDATE becas SET estado_activa=true, fecha_inicio_postulacion=DATE '2026-10-01', fecha_cierre_postulacion=DATE '2026-11-05', url_oficial='https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-bicentenario-bb', descripcion_corta='Beca Bicentenario: postulación FUAS 2027 hasta el 5 de noviembre de 2026 a las 14:00. Sujeta a requisitos y adjudicación.', descripcion_larga='ALCANCE VERIFICADO: postulación FUAS para asignación 2027 de Beca Bicentenario. Recepción del 1 de octubre al 5 de noviembre de 2026 a las 14:00 de America/Santiago. Postular no garantiza adjudicación.
BENEFICIO: Financia el arancel de referencia anual; puede quedar una diferencia respecto del arancel real.
REQUISITOS PRINCIPALES: nacionalidad chilena; 70% de menores ingresos evaluado mediante FUAS. Ese criterio no se convierte en un porcentaje RSH. Nuevos: universidad acreditada y elegible. Antiguos: universidad CRUCh; la ficha contempla excepciones para universidades estatales. Verificar elegibilidad de institución y carrera para 2027. PAES promedio de pruebas obligatorias desde 510 puntos; exención PACE para nuevos. Antiguos: escala de ingreso aplicable y avance de 60% al pasar a segundo; 70% desde tercero. Pregrado presencial; restricciones por título y asignaciones previas.
LÍMITES: matrícula, acreditación y demás condiciones de asignación deben cumplirse; completar FUAS es solo postulación. Los calendarios de resultados y apelaciones son procesos distintos.
DOCUMENTOS REQUERIDOS: completar FUAS; acreditar situación socioeconómica en la institución si corresponde.

TRAZABILIDAD EDITORIAL — texto previo conservado (sustituido para convocatoria actual):
' || descripcion_larga, version=version+1 WHERE id_beca=327;
UPDATE requisitos_perfil SET es_para_primer_anio=true, es_para_curso_superior=true WHERE id_beca=327;
COMMIT;
