\set ON_ERROR_STOP on
BEGIN;
SET LOCAL lock_timeout='5s';
DO $guardas$ BEGIN
IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario cambiado'; END IF;
IF CURRENT_TIMESTAMP NOT BETWEEN TIMESTAMPTZ '2026-10-01 00:00 America/Santiago' AND TIMESTAMPTZ '2026-11-05 13:59:59 America/Santiago' THEN RAISE EXCEPTION 'Revisar plazo FUAS antes de aplicar'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=17 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=17 AND public_id='5f919505-ad66-404a-bb3c-33dd6995265d'::uuid AND version=2 AND md5(descripcion_larga)='ce25914d5332831b0ae438b0dc4fdf16' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 17'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=26 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=26 AND public_id='0c372274-cdc0-498c-bf75-13bf07c0c9f2'::uuid AND version=2 AND md5(descripcion_larga)='842bf3b1fa7bd2b3c6dd7a32d0b1e83b' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 26'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=27 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=27 AND public_id='5e68bb01-d118-45b2-8c11-1458b008c03a'::uuid AND version=2 AND md5(descripcion_larga)='8d245ccad41837b56edbd71aa4c25f4b' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 27'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=34 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=34 AND public_id='90707e2d-91e0-4019-a4b4-fe6b2f7e08cc'::uuid AND version=2 AND md5(descripcion_larga)='bc6b9795fabb05665b19e5055c74da65' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 34'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=50 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=50 AND public_id='384afa53-cbcf-4992-a20c-44fc5a01ed44'::uuid AND version=2 AND md5(descripcion_larga)='a73d2c40bba34e8dc4dd410e99567809' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 50'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=51 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=51 AND public_id='c3185637-8e0b-47ff-bd29-c1304407c9ad'::uuid AND version=2 AND md5(descripcion_larga)='e9cd0b9681aeff4291f2c9c00eb3b4e5' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 51'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=60 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=60 AND public_id='01bfbc25-aaac-4c9b-b767-194e4508d3a8'::uuid AND version=2 AND md5(descripcion_larga)='9fe593bdc9bf847275d37fc8e079e5db' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 60'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=63 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=63 AND public_id='94d04245-92e0-4f04-ba1a-ab3271853edd'::uuid AND version=2 AND md5(descripcion_larga)='82dda5ca36f89806b850fecaf687c3a6' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 63'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=83 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=83 AND public_id='a01d0d98-da82-4111-9030-344bedcc65ef'::uuid AND version=2 AND md5(descripcion_larga)='99250f778c606e1fb6efae2c41be1781' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 83'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=110 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=110 AND public_id='1a8ab1b1-7e39-4aa7-8330-1dcd511bd514'::uuid AND version=2 AND md5(descripcion_larga)='7840af04138a7570c996452e70585625' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 110'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=117 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=117 AND public_id='64dd46e4-c0b3-421b-8877-9b90bcbd5e03'::uuid AND version=2 AND md5(descripcion_larga)='87126cab9b1a4c0f4d2490ee34ca5a28' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 117'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=124 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=124 AND public_id='34df6d9a-f687-4609-83ec-2de1a210d257'::uuid AND version=2 AND md5(descripcion_larga)='937e3f2dcb1f7328e6b7b841e49f8314' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 124'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=130 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=130 AND public_id='1b141394-e39a-43b3-905e-d76beccd32e3'::uuid AND version=2 AND md5(descripcion_larga)='ec2c01de40b8fa173de6a6d978d6b257' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 130'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=139 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=139 AND public_id='e19f64bb-5645-41af-8abf-43457e19775f'::uuid AND version=2 AND md5(descripcion_larga)='df13beb274c2022437a0c8de7abbc113' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 139'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=142 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=142 AND public_id='98a63c13-f0fa-4331-844d-362bcabd8347'::uuid AND version=2 AND md5(descripcion_larga)='27958a179715e97180cc048fe0a46956' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 142'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=147 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=147 AND public_id='4d8e556f-9769-4476-a63a-9fe399176c9d'::uuid AND version=2 AND md5(descripcion_larga)='7a2051c453765fce3ea4ed09d4a56316' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 147'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=158 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=158 AND public_id='c6af8cf1-d8ee-4803-8107-9253a30e2903'::uuid AND version=2 AND md5(descripcion_larga)='f562d4de3d1d6693d22bdbea5c1236ef' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 158'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=168 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=168 AND public_id='6de0793f-f3f3-453e-a1db-7b79bd796c88'::uuid AND version=2 AND md5(descripcion_larga)='ad9025c5de76a90bacd07fa9be93e814' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 168'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=174 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=174 AND public_id='419b8f9d-a696-4139-be2d-2e1561801e90'::uuid AND version=2 AND md5(descripcion_larga)='b6c221baea859d444957ab85c31233f8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 174'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=213 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=213 AND public_id='14e5b9a9-abfb-41c0-99ac-2f8f83aa3ace'::uuid AND version=2 AND md5(descripcion_larga)='4202aebbc14c98599f3f37795597221c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 213'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=222 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=222 AND public_id='86b45159-0446-4d4f-8be0-4248f4ed3b76'::uuid AND version=2 AND md5(descripcion_larga)='6d93eb5b3d7a03da5f5d3627433424a4' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 222'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=223 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=223 AND public_id='a1b8507f-d645-42d3-9c5c-8e773e5be571'::uuid AND version=2 AND md5(descripcion_larga)='212b0b4f396ff6fcf621a9bdfbfd36d9' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 223'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=226 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=226 AND public_id='c697c921-e233-4110-8b15-cadd757a3529'::uuid AND version=2 AND md5(descripcion_larga)='776f90dd45dbf10a8230af19734ec5c2' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 226'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=231 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=231 AND public_id='0485398a-a487-4203-9441-724d97d05789'::uuid AND version=2 AND md5(descripcion_larga)='cc7689f2b6c2134642a4d36cf0388816' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 231'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=233 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=233 AND public_id='2c40d3ea-34c8-4687-b02a-fdf3eb26418e'::uuid AND version=2 AND md5(descripcion_larga)='b2d6d776a47165845d1bdae427b33901' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 233'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=236 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=236 AND public_id='16cc9651-6c93-4894-a9f9-6d6b8f7a4a4e'::uuid AND version=2 AND md5(descripcion_larga)='3e33e4499d1e7f5020b3c65da1bb4252' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 236'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=257 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=257 AND public_id='8f8b4b5f-1231-4ae9-9207-c6637a09f4de'::uuid AND version=2 AND md5(descripcion_larga)='74fc08ac7a2123c1c5491f9f9300750a' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 257'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=273 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=273 AND public_id='99323baf-0dcd-4d09-a0ed-0469d52f2aa2'::uuid AND version=2 AND md5(descripcion_larga)='01513ba39dd61b12e05ca467d069bd7d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 273'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=279 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=279 AND public_id='e6ef0e92-595f-4789-b6ee-99a24e8005d6'::uuid AND version=2 AND md5(descripcion_larga)='3b195f3f0ef1bb92f7316202a80a9121' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 279'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=288 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=288 AND public_id='6321fa90-534d-4031-acb2-39e78afb3c6c'::uuid AND version=2 AND md5(descripcion_larga)='a9d2880a59d798f545f27baef9d70139' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 288'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=292 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=292 AND public_id='f191dd70-1764-4fef-9a10-7073a1734980'::uuid AND version=2 AND md5(descripcion_larga)='650e0bedfc4d70722dc2711b4039e302' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 292'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=306 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=306 AND public_id='21bd74a2-b2a0-49b8-944a-266a7718641c'::uuid AND version=2 AND md5(descripcion_larga)='1aca3386566e5f72cf0403d9f7bde8a9' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 306'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=331 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=331 AND public_id='214dac55-77e8-440a-80db-37c3c18e15f5'::uuid AND version=2 AND md5(descripcion_larga)='d9fc23f3bd12183656731c8c723cfee2' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 331'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=333 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=333 AND public_id='f203e82f-69fd-49ad-a55b-594fb8c78124'::uuid AND version=2 AND md5(descripcion_larga)='f5ad690dcda84b980cbc369334e398cc' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 333'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=347 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=347 AND public_id='51454f1c-5ff8-40a4-aacd-cbeff79838db'::uuid AND version=2 AND md5(descripcion_larga)='6e850782ec391436344241b015107562' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 347'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=358 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=358 AND public_id='af05b33d-c588-4d50-a86f-91046ce852f6'::uuid AND version=2 AND md5(descripcion_larga)='f87d5af17879cdd0252bcaa556177e06' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 358'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=373 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=373 AND public_id='e2213b53-51f8-4b59-b02c-f90a5fc88c4b'::uuid AND version=2 AND md5(descripcion_larga)='88ef97641ef564924814e207c411a253' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 373'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=376 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=376 AND public_id='330cbb6d-1567-4336-aaaf-07aa70523abb'::uuid AND version=2 AND md5(descripcion_larga)='67846a8a2a7af556549a0af8b7c6cfc8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 376'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=378 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=378 AND public_id='21b70095-4dfe-46aa-90ad-c3908ed358a0'::uuid AND version=2 AND md5(descripcion_larga)='aa4da964c01f9845f6e0121622e5c9f9' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 378'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=390 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=390 AND public_id='71d385bb-857d-4f10-9856-5156fd6fcdb1'::uuid AND version=2 AND md5(descripcion_larga)='c9dca33452bf3995a234082a28515df3' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 390'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=400 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=400 AND public_id='e2b909f4-393c-4d10-b34e-060ddac7fdc8'::uuid AND version=2 AND md5(descripcion_larga)='ed3916d5443965df4c6f684ccb4785fb' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 400'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=404 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=404 AND public_id='3b92e7cd-b4ac-4627-9ecf-e6b44118acbc'::uuid AND version=2 AND md5(descripcion_larga)='e4eb42d02c5d778de9994d0dcc4c5228' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 404'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=418 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=418 AND public_id='97a71176-c41c-4def-990c-77898a2f23ad'::uuid AND version=2 AND md5(descripcion_larga)='77a96594e16f58b345d28e101289ecfe' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 418'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=433 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=433 AND public_id='2c5426ce-4880-4f95-b5db-22f873d8877f'::uuid AND version=2 AND md5(descripcion_larga)='d1ddd09e3675ffec55495bef09b6a2ff' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 433'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=455 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=455 AND public_id='8ad49966-ad42-437a-9033-686fb2c5eb05'::uuid AND version=2 AND md5(descripcion_larga)='6a8e825261dd1ac28008e79286a71254' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 455'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=457 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=457 AND public_id='a64ab8be-76a1-4f9f-a047-4237671ab53d'::uuid AND version=2 AND md5(descripcion_larga)='7945d86868470ab50d4f84dbb2aa1dfd' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 457'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=474 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=474 AND public_id='5ccc92c6-1cf2-4343-9e30-4b1dbabb7168'::uuid AND version=2 AND md5(descripcion_larga)='e49da6748a08a179ef4b52b091473e7c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 474'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=477 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=477 AND public_id='06e92527-a183-4b37-9481-c88011de170b'::uuid AND version=2 AND md5(descripcion_larga)='465e318054f65b2d26a85702e8f22da9' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 477'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=481 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=481 AND public_id='8595e873-ce70-4269-bf04-2ccaff04662c'::uuid AND version=2 AND md5(descripcion_larga)='5eac1655af18d124a0c2c8d9755f1295' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 481'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=486 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=486 AND public_id='e531d2dc-9bfb-4f55-890e-8da5c0362556'::uuid AND version=2 AND md5(descripcion_larga)='9e34a9c99a4e5ad51bc69e2ef20e9cbc' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 486'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=509 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=509 AND public_id='23daf499-8c7c-4dc7-9a92-3dac13c5a533'::uuid AND version=2 AND md5(descripcion_larga)='96bd95bc72b1b43d9d17dcbb9053b8af' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 509'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=513 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=513 AND public_id='78861a79-69c6-4e9f-9045-fcdfc4f40039'::uuid AND version=4 AND md5(descripcion_larga)='bf5e3ab2c068df7d3a9394f6b84ec1b6' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 513'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=515 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=515 AND public_id='a9b513db-98c2-462b-afe1-02a6c84b24a6'::uuid AND version=2 AND md5(descripcion_larga)='0850f694af0d504f20df19b24708c0ec' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 515'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=520 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=520 AND public_id='c16d155f-4014-4769-b4cc-2a9f1a1052f8'::uuid AND version=2 AND md5(descripcion_larga)='f7e9752b848ce4873390077e7a189eaa' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 520'; END IF;
END $guardas$;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Nuevo Milenio II; inscripción FUAS para beneficios 2027.
DICTAMEN DOCUMENTAL: VIGENTE_CON_CIERRE_CONFIRMADO.
La lectura directa en navegador de la ficha ministerial actual resuelve la diferencia con el índice antiguo: modalidad II exige institución acreditada al 31 de diciembre de 2026 por al menos tres años. Financia hasta 860.000 CLP de arancel anual para nuevos del 50% de menores ingresos; NEM mínimo 5,0; nacionalidad chilena y demás condiciones generales de la ficha. La carrera debe ser presencial y del tipo elegible. La fuente remite expresamente a FUAS y el formulario actual acredita recepción del 1 de octubre al 5 de noviembre de 2026 para beneficios 2027.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: El corte 2025 procedía de la versión indexada antigua; no es el texto visible actual. Se conservan ambas capturas para explicar la rectificación. La lista de instituciones elegibles aún se anuncia por publicar: completar FUAS no garantiza asignación ni certifica una institución específica. Cierre 5 de noviembre a las 14:00 de Santiago, según Comisión Ingresa.
FUENTES: https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-nuevo-milenio-bnm ; https://postulacion.beneficiosestudiantiles.cl/fuas/ ; https://portal.ingresa.cl/extienden-plazo-para-postular-a-los-beneficios-estudiantiles-del-estado-para-el-ano-2027/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-10-01',fecha_cierre_postulacion=DATE '2026-11-05',estado_activa=true,monto_cobertura='Hasta 860.000 CLP del arancel anual; Nuevo Milenio II para nuevos del 50% de menores ingresos. FUAS 2027 hasta el 5 de noviembre de 2026 a las 14:00.',cobertura_tipo='MONETARIA',cobertura_importe=860000.00,cobertura_moneda='CLP',cobertura_periodicidad='ANUAL',cobertura_porcentaje=NULL,descripcion_corta='Nuevo Milenio II: hasta $860.000 del arancel anual. Primer año, NEM 5,0 y 50% de menores ingresos; institución elegible. FUAS hasta el 05/11/2026 a las 14:00.',url_oficial='https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-nuevo-milenio-bnm' WHERE id_beca=17;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Puntaje Promedio PAES Universidad Mayor;2026.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
El reglamento 2026 artículos 10–18 y 38–46 y DEMRE 2026 páginas 354–355 acreditan descuento sobre saldo de arancel por promedio CL/M1; el catálogo indica hasta 25%, no 30% fijo. Primer ingreso, FUAS del proceso 2026 y sin gratuidad. Renovación requiere aprobación de todas las asignaturas. La tabla por carrera define la concesión individual.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: Se delimita al proceso 2026. La renovación 2027 no demuestra recepción de nuevos 2027; porcentaje individual y calendario exacto desconocidos. El máximo 25% es el publicado por el catálogo, sin prometerlo a cada persona.
FUENTES: https://www.admisionmayor.cl/um/bundles/umayor/descargables/um/Reglamento-Sistema-de-Apoyo-y-Becas-2026.pdf ; https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,monto_cobertura='Hasta 25% del saldo de arancel según tabla por carrera y PAES; Universidad Mayor, catálogo de admisión 2026.',cobertura_tipo='PORCENTUAL',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=NULL WHERE id_beca=26;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca municipal Mejillones; fuente primaria recuperada de 2021.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
El mapa público permitió recuperar la noticia del 21/09/2021:beca municipal superior llamada «beca de pasajes»,228 estudiantes, pago agrupado de agosto–noviembre y 40.000–80.000 CLP mensuales según vulnerabilidad/rendimiento. Es una fuente individual de modalidad superior, distinta de cuentas con educación media mezclada.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: La noticia es 2021, aunque las noticias laterales sean 2026. No se acredita valor ni recepción 2026; tampoco se sustituye con Tablet 2026 o Talento BHP. El nuevo antecedente aclara identidad histórica pero no elimina incertidumbre actual.
FUENTES: https://www.mejillones.cl/noticias-comunales/estudiantes-de-educacion-superior-de-mejillones-reciben-beca-municipal/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=27;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beneficio estudiantil Lautaro; programa 2026 y modificación 1061.
DICTAMEN DOCUMENTAL: CERRADA_CONFIRMADA.
La lectura del programa oficial descargado mediante navegador acredita 70 cupos,185.000 CLP en pago único, desde segundo año de carrera técnica o profesional, residencia comunal y RSH hasta 50%. Recepción presencial 16–20 marzo 2026; viernes hasta 16:00. El decreto 1061 de 6/03/2026, leído visualmente en sus dos páginas, rectifica el promedio 2025: donde decía 6,0 debe decir 5,5. Mantiene todo lo no modificado del decreto 796 de 18/02/2026.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: La nota corresponde al año superior anterior, no al NEMde admisión. No usar el texto inicial 6,0 una vez leído el acto modificatorio. La recarga por terminal da 406, pero la página y el programa se recuperaron en navegador; las capturas del decreto y el PDF base se conservan como evidencia. No inferir convocatoria 2027.
FUENTES: https://sitio.munilautaro.cl/programa-de-beneficio-estudiantil-para-alumnos-de-educacion-superior-tecnico-universitarios-de-la-comuna-de-lautaro-2026/ ; https://sitio.munilautaro.cl/wp-content/uploads/2026/02/PROGRAMA-ESTUDIANTIL.pdf ; https://sitio.munilautaro.cl/wp-content/uploads/2026/02/DD_4701654_260316_P.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-03-16',fecha_cierre_postulacion=DATE '2026-03-20',monto_cobertura='185.000 CLP en un pago único; programa estudiantil Lautaro 2026.',cobertura_tipo='MONETARIA',cobertura_importe=185000.00,cobertura_moneda='CLP',cobertura_periodicidad='UNICA',cobertura_porcentaje=NULL,url_oficial='https://sitio.munilautaro.cl/programa-de-beneficio-estudiantil-para-alumnos-de-educacion-superior-tecnico-universitarios-de-la-comuna-de-lautaro-2026/' WHERE id_beca=34;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca superior Limache; antecedente 2023 recuperado.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
La noticia primaria del 20/04/2023 acredita 136 beneficiarios y dos cuotas de 150.000 CLP, una por semestre; renovación con 75% de asignaturas y alumno regular. El título y la fecha interna permiten distinguir esta entrega de la pista periodística 2026 de 180 beneficiarios.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No trasladar las cuotas 2023 a 2026. La fuente recuperada no confirma el llamado 2026; el copyright actual no la actualiza. La pista de 2026 continúa requiriendo documento o noticia primaria equivalente.
FUENTES: https://limache.cl/limache-entrega-beca-de-educacion-superior-y-beneficiara-a-136-alumnos-y-alumnas-recibiran-150-mil-por-semestre/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=50;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Becas de ingreso educación superior Paine;2026.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
La página DIDECO de ingreso pide certificado de notas de cuarto medio 2025 y enlaza un formulario alojado en marzo 2026. El banner oficial expresa Becas Educación Superior 2026: confirma que existe material de esa edición, no solo resultados 2025.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: El banner leído no contiene fechas ni monto; el formulario descargado es una ficha de antecedentes sin calendario. No completar cobertura o plazo 2026 con la entrega 2025 ni con una página personal de autoridad. Hace falta el llamado o bases 2026 de ingreso, no un banner genérico.
FUENTES: https://www.paine.cl/dideco-beca-superior/ ; https://www.paine.cl/wp-content/uploads/2026/03/FORMULARIO-DE-BECA-DE-INGRESO.pdf ; https://www.paine.cl/wp-content/uploads/2026/03/BANNER-WEB-POSTULACIONES-Becas-Educacion-Superior-2026-1-scaled.jpg
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=51;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Incentivo a la enseñanza superior; convocatoria 2026.
DICTAMEN DOCUMENTAL: CERRADA_CONFIRMADA.
El llamado municipal del 16 de marzo fija recepción entre el 16 y el 22 de marzo a las 23:59. La publicación del 30 de abril acredita 200.000 CLP por beneficiario. Se admiten estudios diurnos, vespertinos y en línea; primera carrera superior; RSH de San Joaquín. No hay límite de edad publicado. Se conservan ambos UUID como antecedentes coincidentes del mismo programa.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No se aplica la beca AIEP ni se convierte la fecha de pago en plazo de postulación. La periodicidad del aporte no está expresada en la noticia de resultados.
FUENTES: https://sanjoaquin.cl/2026/03/16/atencion-ya-se-abrieron-las-postulaciones-a-la-beca-de-incentivo-ensenanza-superior-2026/ ; https://sanjoaquin.cl/2026/03/06/conoce-aqui-todo-sobre-las-becas-de-incentivo-a-la-ensenanza-superior-2026/ ; https://sanjoaquin.cl/2026/04/30/revisa-el-listado-de-beneficiarios-de-la-beca-de-incentivo-ensenanza-superior-2026-en-san-joaquin/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-03-16',fecha_cierre_postulacion=DATE '2026-03-22',monto_cobertura='200.000 CLP por beneficiario según resultados del incentivo superior San Joaquín 2026; periodicidad no indicada.',cobertura_tipo='MONETARIA',cobertura_importe=200000.00,cobertura_moneda='CLP',cobertura_periodicidad='DESCONOCIDA',cobertura_porcentaje=NULL,url_oficial='https://sanjoaquin.cl/2026/03/16/atencion-ya-se-abrieron-las-postulaciones-a-la-beca-de-incentivo-ensenanza-superior-2026/' WHERE id_beca=60;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Incentivo a la enseñanza superior; convocatoria 2026.
DICTAMEN DOCUMENTAL: CERRADA_CONFIRMADA.
El llamado municipal del 16 de marzo fija recepción entre el 16 y el 22 de marzo a las 23:59. La publicación del 30 de abril acredita 200.000 CLP por beneficiario. Se admiten estudios diurnos, vespertinos y en línea; primera carrera superior; RSH de San Joaquín. No hay límite de edad publicado. Se conservan ambos UUID como antecedentes coincidentes del mismo programa.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No se aplica la beca AIEP ni se convierte la fecha de pago en plazo de postulación. La periodicidad del aporte no está expresada en la noticia de resultados.
FUENTES: https://sanjoaquin.cl/2026/03/16/atencion-ya-se-abrieron-las-postulaciones-a-la-beca-de-incentivo-ensenanza-superior-2026/ ; https://sanjoaquin.cl/2026/03/06/conoce-aqui-todo-sobre-las-becas-de-incentivo-a-la-ensenanza-superior-2026/ ; https://sanjoaquin.cl/2026/04/30/revisa-el-listado-de-beneficiarios-de-la-beca-de-incentivo-ensenanza-superior-2026-en-san-joaquin/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-03-16',fecha_cierre_postulacion=DATE '2026-03-22',monto_cobertura='200.000 CLP por beneficiario según resultados del incentivo superior San Joaquín 2026; periodicidad no indicada.',cobertura_tipo='MONETARIA',cobertura_importe=200000.00,cobertura_moneda='CLP',cobertura_periodicidad='DESCONOCIDA',cobertura_porcentaje=NULL,url_oficial='https://sanjoaquin.cl/2026/03/16/atencion-ya-se-abrieron-las-postulaciones-a-la-beca-de-incentivo-ensenanza-superior-2026/' WHERE id_beca=63;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: BEAministerial; inscripción FUAS 2027.
DICTAMEN DOCUMENTAL: VIGENTE_CON_CIERRE_CONFIRMADO.
La lectura directa en navegador de la ficha oficial BEA confirma: 10% de mejores egresados del establecimiento el año de inscripción, ingreso superior el año siguiente, nacionalidad chilena, sin título previo y 80% de menores ingresos. Hasta 1.150.000 CLP de arancel anual. Acreditación institucional al 31/12/2026 y Medicina/Pedagogía/Odontología acreditada o en proceso al 31/01/2027. La ficha vincula expresamente FUAS; el portal actual incluye BEA y fija inscripción del 1 de octubre al 5 de noviembre de 2026 por extensión para beneficios 2027.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: El error 404 de la recarga automática no impedía abrir la ficha oficial en navegador: se conserva el texto visible actual, además del índice. No es Complementaria UCSH del 20% ni cupos de acceso Usach. La inscripción no garantiza adjudicación. Cierre a las 14:00 de Santiago acreditado por Comisión Ingresa; agregar estos UUID al temporizador antes de activar.
FUENTES: https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-excelencia-academica-bea ; https://postulacion.beneficiosestudiantiles.cl/fuas/ ; https://portal.ingresa.cl/extienden-plazo-para-postular-a-los-beneficios-estudiantiles-del-estado-para-el-ano-2027/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-10-01',fecha_cierre_postulacion=DATE '2026-11-05',estado_activa=true,monto_cobertura='Hasta 1.150.000 CLP del arancel anual; BEA Mineduc. FUAS 2027 hasta el 5 de noviembre de 2026 a las 14:00 de Santiago.',cobertura_tipo='MONETARIA',cobertura_importe=1150000.00,cobertura_moneda='CLP',cobertura_periodicidad='ANUAL',cobertura_porcentaje=NULL,descripcion_corta='BEA Mineduc: hasta $1.150.000 del arancel anual para el 10% de mejores egresados del colegio y el 80% de menores ingresos. FUAS hasta el 05/11/2026 a las 14:00.',url_oficial='https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-excelencia-academica-bea' WHERE id_beca=83;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Deportivas arancelarias UPLA; admisión 2026.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
El catálogo oficial DEMRE 2026, página 263, identifica Seleccionado Nacional y Excelencia Deportiva: exención parcial del arancel a estudiantes que participan en selecciones universitarias, previa postulación, selección y evaluación por especialistas. La publicación 2026 corrige el alcance exclusivamente histórico del dictamen anterior.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: El porcentaje y las fechas no están publicados en ese apartado. La alimentación para deportistas es una prestación diferente; no se utiliza para completar la ficha alimenticia general 214. No certifica reglas 2027 ni recepción abierta.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=110;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca Anselmo «Profe Chemo» Osorio; antes Centenario; 2026.
DICTAMEN DOCUMENTAL: CERRADA_CONFIRMADA.
La noticia municipal del 19 de mayo acredita explícitamente el cambio de nombre del programa y la ampliación hasta el 30 de mayo de 2026. Exige matrícula, alumno regular, RSH hasta 60%, identidad, cuenta bancaria e informe social presencial posterior a la solicitud.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: La apertura y el importe no se publican en este aviso. No trasladar importes de 2023 ni la convocatoria deportiva de agosto.
FUENTES: https://municipiocabildo.cl/cabildo/hasta-el-30-de-mayo-se-extendio-el-plazo-de-postulacion-a-la-beca-anselmo-profe-chemo-osorio/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=NULL,fecha_cierre_postulacion=DATE '2026-05-30',nombre='Beca Anselmo «Profe Chemo» Osorio (antes Centenario)',monto_cobertura='Aporte económico de la beca Anselmo «Profe Chemo» Osorio 2026; importe y periodicidad no publicados en el aviso de ampliación.',cobertura_tipo='MONETARIA',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad='DESCONOCIDA',cobertura_porcentaje=NULL,url_oficial='https://municipiocabildo.cl/cabildo/hasta-el-30-de-mayo-se-extendio-el-plazo-de-postulacion-a-la-beca-anselmo-profe-chemo-osorio/' WHERE id_beca=117;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beneficio matrícula UVM; admisión 2026.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
DEMRE 2026, página 399, acredita 100% del valor de matrícula para primer año de programas regulares diurnos presenciales, por admisión centralizada o vía especial; válido solo por el año de admisión. Se sostiene la corrección del antiguo rango 50–100% sin exigir una edición 2027 para reconocer la 2026.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No se publica un cierre propio del beneficio ni se extiende a matrícula de cursos superiores. La fecha de admisión general no se introduce como plazo sin vínculo expreso.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,monto_cobertura='100% de matrícula de primer año; programas regulares diurnos presenciales de ingreso centralizado o especial. UVM 2026.',cobertura_tipo='PORCENTUAL',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=100.00 WHERE id_beca=124;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Residencia interna UCT; diferencia respecto de JUNAEB.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
La oferta DGE de beneficios internos y mantención identifica alimentación propia y becas de residencia indígena JUNAEB. El catálogo DEMRE 2026 páginas 127–129 no añade un llamado específico de residencia interna. No hay equivalencia documental entre la beca indígena externa y el antecedente interno de esta ficha.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: La ausencia en esos apartados no prueba supresión del programa interno. Para resolverlo falta regla o convocatoria de residencia UCT; no se adoptan montos JUNAEB ni requisitos de ascendencia como si fueran universales.
FUENTES: https://dge.uct.cl/beneficios-internos/ ; https://dge.uct.cl/mantencion/ ; https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=130;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Apoyo al Estudiante de Nivel Técnico Profesional y Superior Mulchén;2026.
DICTAMEN DOCUMENTAL: CERRADA_CONFIRMADA.
La página municipal Becas Estudiantiles 2026 enlaza las bases específicas de Apoyo 2026 y un afiche de ambos beneficios que publica recepción 9–31 de marzo en DIDECO. El afiche confirma el calendario escrito en la sección VI del DOCX, por lo que la frase residual «fecha a definir» deja de ser el único antecedente. Apoyo es 100.000 CLP únicos, RSH hasta 60%, NEM 5,5 o notas superiores 5,0; Fray Alejandro Manera es otra prestación.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: La fecha deriva del afiche municipal publicado en la página 2026 y del calendario del documento 2026, no de un archivo histórico. No transferir a Apoyo el 1,5 UTM mensual de Fray. Hora 14:00 solo según sección VI del documento; el afiche no agrega otra hora.
FUENTES: https://www.munimulchen.cl/becas-estudiantiles-2026/ ; https://www.munimulchen.cl/wp-content/uploads/2026/03/Fray-Alejandro-Manera-Beca-de-Apoyo-al-Estudiante-de-Nivel-Tecnico-Profesional-y-Ensenanza-Superior.png ; https://www.munimulchen.cl/wp-content/uploads/2026/03/06.-BECA-DE-APOYO-PARA-EL-ESTUDIANTE-NIVEL-TECNICO-Y-SUPERIOR-2026.docx
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-03-09',fecha_cierre_postulacion=DATE '2026-03-31',monto_cobertura='100.000 CLP en un aporte único; Beca de Apoyo al Estudiante técnico y superior Mulchén 2026.',cobertura_tipo='MONETARIA',cobertura_importe=100000.00,cobertura_moneda='CLP',cobertura_periodicidad='UNICA',cobertura_porcentaje=NULL,url_oficial='https://www.munimulchen.cl/becas-estudiantiles-2026/' WHERE id_beca=139;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: PRFE educación superior; renovación 2026.
DICTAMEN DOCUMENTAL: CALENDARIO_POR_MODALIDAD.
Chile Atiende identifica expresamente que en educación superior el PRFE no admite nuevas postulaciones; solo renovación del beneficio ya asignado. La ficha ministerial específica de educación superior publica inicio 1 de diciembre de 2025 y cierre 4 de febrero de 2026, con trámite cerrado. La ejecución en Arica de abril no corresponde a recepción de estudiantes nuevos ni al reclutamiento de familias tutoras.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: La ficha Ventanilla mezcla en su sección de requisitos referencias a educación media: no trasladarlas como elegibilidad superior. El calendario se informa para renovación 2026; resultados de octubre, noviembre y diciembre no abren postulaciones.
FUENTES: https://www.chileatiende.gob.cl/fichas/4600-programa-residencia-familiar-estudiantil-prfe ; https://www.ventanillaunicasocial.gob.cl/ficha/125/programa-residencia-familiar-estudiantil-educacion-superior
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2025-12-01',fecha_cierre_postulacion=DATE '2026-02-04' WHERE id_beca=142;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca municipal de educación superior Saavedra 2026.
DICTAMEN DOCUMENTAL: CERRADA_CONFIRMADA.
Las bases 2026, aprobadas por decreto firmado electrónicamente, fijan recepción del 30 de abril al 15 de mayo. Aporte único: 150.000 CLP; 180.000 CLP acreditando voluntariado comunal. Primera carrera, residencia comunal y RSH de 40% a 60%. Notas: 5,0 de enseñanza media o 4,5 del último período superior. Evaluación del 18 al 22 de mayo y pago del 29 de mayo son etapas diferentes.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: Conservar la condición literal RSH «40% al 60%», que no se representa íntegramente mediante un solo máximo. No generalizar el monto aumentado sin voluntariado ni la excepción de funcionarios sin sus condiciones.
FUENTES: https://munisaavedra.cl/wp-content/uploads/2026/05/BASES-BECA-MUNICIPAL-2026.pdf ; https://munisaavedra.cl/wp-content/uploads/2026/05/DECRETO-BECA-MUNICIPAL-2026.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-04-30',fecha_cierre_postulacion=DATE '2026-05-15',monto_cobertura='150.000 CLP en un pago único; 180.000 CLP con voluntariado comunal acreditado. Bases Saavedra 2026.',cobertura_tipo='MONETARIA',cobertura_importe=NULL,cobertura_moneda='CLP',cobertura_periodicidad='UNICA',cobertura_porcentaje=NULL,url_oficial='https://munisaavedra.cl/wp-content/uploads/2026/05/BASES-BECA-MUNICIPAL-2026.pdf' WHERE id_beca=147;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca NEM UDD; admisión directa y condiciones por sede/carrera.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
La ficha particular 172769 declara admisión 2027 y describe alumnos nuevos admitidos por vía NEM, cuarto medio egresado y prueba válida. Renovación requiere promedio anual igual o superior al de la promoción en carrera y sede, por duración formal. Se distingue de las reglas generales del acceso centralizado y de Puntaje Ponderado; la propia página anuncia que la tabla 2027 de Santiago se publicará próximamente.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No confirmar 30% ni otro porcentaje 2027 antes de la tabla aplicable. La edición 2026 del antecedente se mantiene delimitada; calendario de admisión general no es cierre acreditado de la beca. La ausencia de tabla es un dato pendiente específico, no prueba de desaparición del programa.
FUENTES: https://www.udd.cl/admision-pregrado/becas/?udd_beca=172769
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca NEM UDD' WHERE id_beca=158;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca municipal general Teodoro Schmidt 2026.
DICTAMEN DOCUMENTAL: CERRADA_CONFIRMADA.
La convocatoria municipal del 12 de mayo fija cierre al 31 de mayo de 2026. Aporte único de 150.000 CLP o 200.000 CLP para promedio igual o superior a 6,5. Matrícula superior 2026 reconocida; NEM 5,5 o promedio superior 5,0 del año 2025 o último cursado. Los resultados se publicaron el 24 de julio.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: La publicación dice que comenzó la recepción pero no acredita día exacto de apertura. No confundir con residencia de agosto. Importe variable según rendimiento; no asignar el máximo a todas las personas.
FUENTES: https://muniteodoro.cl/portal/2026/05/12/%f0%9f%8e%93%f0%9f%93%a2-proceso-postulacion-beca-municipal-educacion-superior/ ; https://muniteodoro.cl/portal/2026/07/24/%f0%9f%8e%93%f0%9f%93%a2-resultados-becas-municipales-2026/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=NULL,fecha_cierre_postulacion=DATE '2026-05-31',monto_cobertura='150.000 CLP en un pago único; 200.000 CLP con promedio igual o superior a 6,5. Beca municipal general Teodoro Schmidt 2026.',cobertura_tipo='MONETARIA',cobertura_importe=NULL,cobertura_moneda='CLP',cobertura_periodicidad='UNICA',cobertura_porcentaje=NULL,url_oficial='https://muniteodoro.cl/portal/2026/05/12/%f0%9f%8e%93%f0%9f%93%a2-proceso-postulacion-beca-municipal-educacion-superior/' WHERE id_beca=168;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca USS; primer semestre 2026.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
El catálogo oficial DEMRE 2026, página 370, identifica expresamente la Beca USS para primer año diurno del primer semestre 2026, con cobertura hasta 100% del arancel durante los años del plan. El cuerpo de la página actual coincide con esta edición; el encabezado 2027 no sustituye el año del beneficio.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: Importe individual sujeto a simulador y certificado; sin cierre propio publicado. Se confirma alcance 2026, no una nueva asignación 2027. No confundir con Excelencia Académica USS del 20%.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf ; https://admision.uss.cl/becas-y-financiamiento
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=174;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca municipal Traiguén; noticia primaria 18/05/2021.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
La noticia específica recuperada en el sitio municipal acredita ejecución del programa 2021, entonces en evaluación, y explica selección por antecedentes socioeconómicos. Los 20 millones citados son presupuesto agregado, no importe individual. Es distinta de la referencia 2023 del PLADECO.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: La publicación no es 2026. No dividir presupuesto por estudiantes ni usar próximos meses de 2021 como calendario actual. Falta fuente primaria del llamado o entrega 2026 anunciado por prensa.
FUENTES: https://mtraiguen.cl/municipalidad/fortaleciendo-la-educacion-superior-becas-municipales/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=213;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Copago técnico UCentral 2019 frente a oferta actual 2026.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
La página actual y DEMRE 2026 página 163 describen Complementaria para nuevos de pregrado diurno con CAE 100% referencial, hasta 100% de diferencia, excluida Medicina. No identifican la modalidad técnica 2016–2018 del informativo 2019 de esta ficha. La plataforma DAVE actual sí incluye técnicos en general, sin demostrar equivalencia entre becas.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No reemplazar la identidad técnica histórica por Complementaria pregrado ni trasladar 45/35% a 2026. El calendario de otro beneficio no resuelve esta modalidad; conservar porcentaje y año históricos delimitados.
FUENTES: https://admision.ucentral.cl/becas-y-financiamiento/becas-ucen-aplicables-desde-primer-ano/ ; https://www.ucentral.cl/postulacion-becas/ ; https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=222;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Copago 0 DTE Universidad Mayor;2026.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
DEMRE 2026 página 355 y reglamento 2026 artículos 55–60 identifican complemento de la Beca Distinción a las Trayectorias Educativas ministerial hasta copago cero del arancel. Ingreso inmediatamente posterior a enseñanza media y FUAS del primer período; mantener requisitos ministeriales para renovar, sin gratuidad.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No es complemento automático de cualquier beca. El requisito FUAS de esta edición no acredita recepción nueva 2027 ni un cierre propio del beneficio interno. Se mantiene el año 2026 y se corrige la conclusión de que faltaban reglas de esa edición.
FUENTES: https://www.admisionmayor.cl/um/bundles/umayor/descargables/um/Reglamento-Sistema-de-Apoyo-y-Becas-2026.pdf ; https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=223;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca municipal general Teodoro Schmidt 2026.
DICTAMEN DOCUMENTAL: CERRADA_CONFIRMADA.
La convocatoria municipal del 12 de mayo fija cierre al 31 de mayo de 2026. Aporte único de 150.000 CLP o 200.000 CLP para promedio igual o superior a 6,5. Matrícula superior 2026 reconocida; NEM 5,5 o promedio superior 5,0 del año 2025 o último cursado. Los resultados se publicaron el 24 de julio.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: La publicación dice que comenzó la recepción pero no acredita día exacto de apertura. No confundir con residencia de agosto. Importe variable según rendimiento; no asignar el máximo a todas las personas.
FUENTES: https://muniteodoro.cl/portal/2026/05/12/%f0%9f%8e%93%f0%9f%93%a2-proceso-postulacion-beca-municipal-educacion-superior/ ; https://muniteodoro.cl/portal/2026/07/24/%f0%9f%8e%93%f0%9f%93%a2-resultados-becas-municipales-2026/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=NULL,fecha_cierre_postulacion=DATE '2026-05-31',monto_cobertura='150.000 CLP en un pago único; 200.000 CLP con promedio igual o superior a 6,5. Beca municipal general Teodoro Schmidt 2026.',cobertura_tipo='MONETARIA',cobertura_importe=NULL,cobertura_moneda='CLP',cobertura_periodicidad='UNICA',cobertura_porcentaje=NULL,url_oficial='https://muniteodoro.cl/portal/2026/05/12/%f0%9f%8e%93%f0%9f%93%a2-proceso-postulacion-beca-municipal-educacion-superior/' WHERE id_beca=226;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca Deportiva PUCV; separación de acceso y financiación.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
La lectura de la sección PUCV delcatálogo DEMRE 2026 identifica premios PAES y becas de apoyo, pero no determina condiciones de la beca financiera deportiva. Una vía de acceso deportivo por sí sola no acredita una exención de arancel.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No trasladar automáticamente plazos de postulación a carreras a la beca. Falta convocatoria o reglamento de beca deportiva PUCV específico; el texto sobre actividades deportivas no sustituye ese documento.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf ; https://www.pucv.cl/pucv/futuros-estudiantes/becas-y-beneficios
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=231;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Red de residencias UACh, incluidos Hogar Leiva Mella y Fundación; nuevos 2026.
DICTAMEN DOCUMENTAL: CERRADA_CONFIRMADA.
La página específica DAE publica recepción de nuevos estudiantes del 24 al 26 de enero de 2026 mediante Info Alumnos y matrícula vigente. Identifica expresamente residencia Leiva Mella masculina, costo mensual de 94.000 CLP, y otras residencias con valores propios. Hasta sexto decil, rendimiento satisfactorio y entrevista psicosocial; cupos limitados. El reglamento enlazado se aplica desde noviembre de 2023 y declara modificación diciembre de 2024.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: Los valores publicados son costos del alojamiento, no dinero entregado al estudiante. La beca de residencia Puerto Montt, con RSH 40%, es otra modalidad. El desacuerdo 20/22 enero de 2023 no define esta edición 2026.
FUENTES: https://dae.uach.cl/residencias-estudiantiles/ ; https://dae.uach.cl/wp-content/uploads/2025/12/REGLAMENTO-RESIDENCIAS-ESTUDIANTILES-UACh-2024.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-01-24',fecha_cierre_postulacion=DATE '2026-01-26',monto_cobertura='Cupo residencial UACh con costo por hogar; Leiva Mella masculino: 94.000 CLP mensuales a cargo del estudiante. No es aporte monetario ni alojamiento gratuito.',cobertura_tipo='NO_MONETARIA',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=NULL,url_oficial='https://dae.uach.cl/residencias-estudiantiles/' WHERE id_beca=233;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Distinción a las Trayectorias Educativas UDP;2026.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
La ficha específica UDP y DEMRE 2026 página 333 acreditan 100% del arancel y matrícula por primer año; recién egresados con puntaje máximo PAES o beneficiarios de DTE ministerial, para pruebas efectivamente rendidas para admisión 2026. La página institucional identifica correctamente DTE ministerial frente a la referencia genérica «Puntaje PAES» del catálogo.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: Sin cierre propio publicado; no aplicar plazos generales de ingreso especial ni extender las condiciones al 2027. No se adopta el 40% del archivo histórico.
FUENTES: https://admision.udp.cl/becas-y-beneficios/becas-y-beneficios-udp/ ; https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,monto_cobertura='100% de matrícula y arancel del primer año; DTE UDP para pruebas de admisión 2026.',cobertura_tipo='PORCENTUAL',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=100.00 WHERE id_beca=236;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca estudiantil familiar UTA;2026.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
DEMRE 2026, página 286, identifica Beca Estudiantil para hermanos o matrimonio: rebaja 5% sobre arancel diferenciado a pagar, en Casa Central y sede Iquique. Es la modalidad familiar de esta ficha, distinta de Ayuda Solidaria. La existencia de reglas 2026 queda acreditada.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: El apartado no fija fechas ni permite trasladar los plazos semestrales de alimentación o fotocopias. No se atribuye cobertura monetaria ni cupos 2027.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca Estudiantil UTA (hermanos o matrimonio)',monto_cobertura='5% de rebaja sobre arancel diferenciado para hermanos o matrimonio; Casa Central e Iquique. Beca Estudiantil UTA 2026.',cobertura_tipo='PORCENTUAL',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=5.00,url_oficial='https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf' WHERE id_beca=257;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Copago Cero Autónoma; admisión 2026.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
DEMRE 2026, página 94, identifica CAE y promedio PAES 2024/2025 según carrera: cobertura 100% de la diferencia entre arancel de referencia y real anual, conservable durante duración formal. El mínimo varía según tabla institucional: no existe puntaje universal respaldado por este apartado.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: El calendario y la tabla completa por carrera siguen sin publicarse en este expediente. Reconocer edición 2026 no confirma recepción 2027 ni permite completar los mínimos desconocidos.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=273;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Convenios institucionales UBO publicados por DAE.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
La página específica DAE enumera entidades con convenio, población vinculada, documentos de afiliación con antigüedad máxima de treinta días, descuentos propios por entidad y renovación sujeta a aprobación académica y documentación. El beneficio depende de la entidad: por ejemplo AFUBACH 10%, CAPREDENA 15%, FAMAE 20%. No existe un porcentaje empresarial único aplicable a todos los empleadores.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: El catálogo de convenios no publica cierre anual ni prueba que una empresa no listada tenga convenio. Conservar porcentaje estructurado desconocido y condiciones específicas; no extrapolar a la beca de copago o excelencia UBO.
FUENTES: https://dae.ubo.cl/convenios/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=279;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Residencias y BRI Universidad de Chile; proceso 2027.
DICTAMEN DOCUMENTAL: CALENDARIO_POR_MODALIDAD.
La página específica DIRBDE publica nuevos prioritarios SIPEE/PACE: FOCES del 20 al 22 de enero 2027, acreditación del 21 al 27. Cursos superiores y renovantes: inicio 13 de octubre 2026 y cierre según Unidad de Bienestar. Primera etapa es vacante con copago; desde cuarto año BRI mensual base 160.000 CLP inicial o 120.000 CLP egreso, limitada por arriendo real. La fuente identifica recursos estimados 2027.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No imponer el 22 de enero al conjunto de modalidades ni el cierre de BUCH. La instrucción documental conserva una referencia 2026: se señala como texto no actualizado y no se cambia el calendario 2027 que está expresamente titulado. Nuevos 2027 aún no están en recepción; antiguos no tienen cierre único acreditado. No activar la ficha genérica.
FUENTES: https://uchile.cl/dbe/residencias
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=288;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Premio al Ingreso Destacado PUCV;2026.
DICTAMEN DOCUMENTAL: CALENDARIO_POR_MODALIDAD.
DEMRE 2026 página 20 identifica asignación automática por promedio PAES:100% de arancel desde 890 puntos;50% entre 850 y 889. Si hay beca ministerial complementa hasta el porcentaje. Renovación exige 100% de asignaturas aprobadas y matrícula en la misma carrera. Incluye alimentación PUCV incompatible con BAES. La edición 2026 queda acreditada mediante publicación oficial legible.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: El rótulo original «Excelencia» no se considera alias oficial. No consta fecha de corte de asignación ni condiciones 2027. No inventar postulación independiente para un premio automático ni NEM 5,8 del archivo original.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Premio al Ingreso Destacado PUCV',url_oficial='https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf' WHERE id_beca=292;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Excelencia Académica interna UST;2026.
DICTAMEN DOCUMENTAL: CALENDARIO_POR_MODALIDAD.
DEMRE 2026, página 377, acredita mejor promedio ponderado de carrera por sede superior a 5,5; desde segundo año, asignación sin postulación y descuento 35–50% sobre saldo después de beneficios externos. Su mecanismo es asignación académica interna, no una ventana de ingreso PAES.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No consta día de corte de selección ni tabla que asigne porcentajes a cada promedio. No inventar fecha de cierre para una ayuda sin postulación. Distinguir Universidad Santo Tomás de IP/CFT y de BEAministerial.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=306;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Hijo de funcionario UANDES; oferta pública 2026 contrastada.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
La sección UANDES delcatálogo DEMRE 2026, páginas 236–239, describe becas académicas y económicas, pero no fija condiciones de la ayuda para hijos de funcionarios. El beneficio de personal requiere norma propia; no se sustituye por descuentos PAES.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No se prueba inexistencia por omisión del catálogo. Falta convenio o resolución de personal aplicable, con porcentaje y destinatarios. Las fuentes de Los Andes Colombia siguen excluidas.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf ; https://admision.uandes.cl/becas/beca-hijo-funcionario
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=331;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca Familiar IPCHILE; comparación con oferta interna publicada 2026.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
La página específica de becas internas publica transporte, fallecimiento de tutor, deporte, rendimiento, mantención y conectividad; varias instrucciones aluden expresamente al proceso 2026. Ningún apartado leído sustenta el descuento familiar del antecedente ni lo identifica como un convenio empresarial.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No se infiere eliminación por ausencia de la lista. El protocolo 2026 de transporte/mantención no es norma familiar y el convenio Gardilcic tiene otros destinatarios. Falta regla específica de familia vigente; porcentaje y calendario no confirmados.
FUENTES: https://www.ipchile.cl/becas-y-financiamiento/becas-ipchile/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=333;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca Universidad Finis Terrae por puntaje ponderado; edición 2026.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
DEMRE 2026, páginas 343–344, y ficha específica de admisión que exige FUAS 2026 identifican 20% del arancel anual por ingreso centralizado y mínimo ponderado de carrera. La ficha actual publica mínimos por carrera: Medicina 950; Derecho y varias de salud 800; otras 750 o 700, según lista. No se requiere que el reglamento marco enumere nuevamente cada tabla anual para sostener esta edición.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No certificar rótulo histórico «Excelencia» ni 30–100%. La lista actual y el catálogo difieren en tratamiento del arancel regulado: conservar ambas condiciones con su fuente, sin prometer aplicación universal. Sin cierre propio ni confirmación 2027.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf ; https://admision.finis.cl/becas-y-beneficios/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca Universidad Finis Terrae',monto_cobertura='20% del arancel anual; Beca Universidad Finis Terrae por puntaje ponderado de ingreso. Aplicación de arancel regulado en revisión.',cobertura_tipo='PORCENTUAL',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=20.00,url_oficial='https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf' WHERE id_beca=347;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca matrícula familiar UCSC; ficha financiera específica.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
La ficha del Sistema Universitario de Becas identifica más de dos hermanos matriculados, exención del 100% del derecho básico de matrícula de menor valor para uno, pregrado diurno de primer año, documentación de parentesco y no contar con beneficios de arancel Mineduc. Renovación con condición de alumno regular y duración formal. Se adopta este alcance preciso, sin generalizar las reglas de otras modalidades familiares.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No publica plazo anual de la beca. No reducir «más de dos hermanos» a dos ni aplicar descuento al arancel. La ficha anterior de admisión menciona otra modalidad compatible con Mineduc: se conservan ambos antecedentes, con prioridad a la modalidad expresamente descrita por la unidad financiera, sin afirmar derogación de las demás.
FUENTES: https://sube.ucsc.cl/becas-y-financiamiento/beca-matricula-familiar/ ; https://sube.ucsc.cl/manual-de-postulacion-y-renovacion-de-beneficios-de-arancel-ucsc/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca Matrícula Familiar UCSC',monto_cobertura='100% del Derecho Básico de Matrícula de menor valor para un hermano; más de dos hermanos matriculados. UCSC; no es rebaja del arancel.',cobertura_tipo='PORCENTUAL',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=100.00,url_oficial='https://sube.ucsc.cl/becas-y-financiamiento/beca-matricula-familiar/' WHERE id_beca=358;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: BEAministerial; inscripción FUAS 2027.
DICTAMEN DOCUMENTAL: VIGENTE_CON_CIERRE_CONFIRMADO.
La lectura directa en navegador de la ficha oficial BEA confirma: 10% de mejores egresados del establecimiento el año de inscripción, ingreso superior el año siguiente, nacionalidad chilena, sin título previo y 80% de menores ingresos. Hasta 1.150.000 CLP de arancel anual. Acreditación institucional al 31/12/2026 y Medicina/Pedagogía/Odontología acreditada o en proceso al 31/01/2027. La ficha vincula expresamente FUAS; el portal actual incluye BEA y fija inscripción del 1 de octubre al 5 de noviembre de 2026 por extensión para beneficios 2027.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: El error 404 de la recarga automática no impedía abrir la ficha oficial en navegador: se conserva el texto visible actual, además del índice. No es Complementaria UCSH del 20% ni cupos de acceso Usach. La inscripción no garantiza adjudicación. Cierre a las 14:00 de Santiago acreditado por Comisión Ingresa; agregar estos UUID al temporizador antes de activar.
FUENTES: https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-excelencia-academica-bea ; https://postulacion.beneficiosestudiantiles.cl/fuas/ ; https://portal.ingresa.cl/extienden-plazo-para-postular-a-los-beneficios-estudiantiles-del-estado-para-el-ano-2027/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-10-01',fecha_cierre_postulacion=DATE '2026-11-05',estado_activa=true,monto_cobertura='Hasta 1.150.000 CLP del arancel anual; BEA Mineduc. FUAS 2027 hasta el 5 de noviembre de 2026 a las 14:00 de Santiago.',cobertura_tipo='MONETARIA',cobertura_importe=1150000.00,cobertura_moneda='CLP',cobertura_periodicidad='ANUAL',cobertura_porcentaje=NULL,descripcion_corta='BEA Mineduc: hasta $1.150.000 del arancel anual para el 10% de mejores egresados del colegio y el 80% de menores ingresos. FUAS hasta el 05/11/2026 a las 14:00.',url_oficial='https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-excelencia-academica-bea' WHERE id_beca=373;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Armada de Chile UANDES; existencia 2026 expresamente citada.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
DEMRE 2026 página 237 menciona explícitamente Beca Armada de Chile entre las ayudas disponibles y remite a admisión para cupos y mantención. Corrige el carácter exclusivamente histórico de la existencia del programa, sin extender las reglas de PAES a Armada.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: El catálogo no especifica porcentaje, beneficiarios cubiertos por parentesco ni plazo del convenio. Falta ficha o acuerdo particular para confirmar esos campos. No afirmar que el beneficio esté abierto o cerrado por el calendario de otra ayuda.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf ; https://admision.uandes.cl/becas/beca-armada-de-chile
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=376;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Becas de ingreso educación superior Paine;2026.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
La página DIDECO de ingreso pide certificado de notas de cuarto medio 2025 y enlaza un formulario alojado en marzo 2026. El banner oficial expresa Becas Educación Superior 2026: confirma que existe material de esa edición, no solo resultados 2025.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: El banner leído no contiene fechas ni monto; el formulario descargado es una ficha de antecedentes sin calendario. No completar cobertura o plazo 2026 con la entrega 2025 ni con una página personal de autoridad. Hace falta el llamado o bases 2026 de ingreso, no un banner genérico.
FUENTES: https://www.paine.cl/dideco-beca-superior/ ; https://www.paine.cl/wp-content/uploads/2026/03/FORMULARIO-DE-BECA-DE-INGRESO.pdf ; https://www.paine.cl/wp-content/uploads/2026/03/BANNER-WEB-POSTULACIONES-Becas-Educacion-Superior-2026-1-scaled.jpg
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=378;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Copago Cero UBO histórico 2021 frente a oferta 2026.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
DEMRE 2026 páginas 100–102 publica becas PAES, matrícula, mujeres Ingeniería, trabajador y convenios: los porcentajes de algunas se aplican al saldo luego de ayudasestatales. No identifica el Copago Cero histórico que exigía CAE y BEAo Juan Gómez Millas del ingreso 2021.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: Aplicar una beca al saldo no demuestra que sea el mismo Copago Cero. No adoptar renovaciones de otra modalidad ni extender el requisito 2021 a 2026. Hace falta norma o ficha específica actual; no se declara eliminación por ausencia del catálogo.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf ; https://dae.ubo.cl/becas-alumnos-nuevos/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=390;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Integración Transfronteriza UTA–AGCID;2026.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
DEMRE 2026, página 293, identifica nacionales de Perú y Bolivia egresados de media el año anterior al ingreso:100% de arancel básico y diferenciado por duración de carrera y 300.000 CLP mensuales marzo–diciembre aportados por AGCID. Se sostiene esa edición 2026 con fuente oficial legible.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No consta recepción actual ni selección adicional completa. La próxima convocatoria 2027 no se presume; tampoco se aplican fechas de CRISCOS o intercambios. La beca combina exención y aporte: no reducir la cobertura total a 300.000 CLP.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=400;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Puntaje PAES UDP;2026.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
La tabla particular UDP 2026 acredita 25% del arancel de primer año para recién egresados de media por ingreso regular-centralizado. Promedio 50% CL+50% M1: Medicina 935; grupo Arquitectura/Derecho/Salud/Ingeniería Comercial 910; las demás carreras listadas 810. La beca Ingeniería Civil está en otra tabla y no se incorpora a esta modalidad.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: Se reconoce el proceso 2026 y se conserva el cierre desconocido. No afirmar 35% ni trasladar tabla Ingeniería Civil 2025 a PAES 2026. La falta de una tabla 2027 no invalida la 2026 comprobada.
FUENTES: https://admision.udp.cl/becas-y-beneficios/becas-y-beneficios-udp/ ; https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,monto_cobertura='25% del arancel de primer año; promedio PAES mínimo 935, 910 u 810 según carrera. Tabla UDP 2026; Ingeniería Civil en otra modalidad.',cobertura_tipo='PORCENTUAL',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=25.00 WHERE id_beca=404;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Convenio Empresas ENAC; nueva lectura DIPE.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
La página actual de Permanencia Estudiantil identifica orientación en beneficios internos y externos y enlaza el Manual de Trayectoria; no publica en el cuerpo condiciones del convenio empresarial histórico. Los formularios de orientación psicológica y ayudas de acceso no constituyen tabla empresarial.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No generalizar matrícula promocional 2027 al convenio. Falta documento que identifique empresas adheridas, población, porcentaje y edición de esta modalidad. Conservar el antecedente histórico sin afirmar eliminación.
FUENTES: https://enac.cl/estudiantes/atencion-estudiantil/ ; https://enac.cl/admision/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=418;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca Puntaje PAES UBO;2026.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
DEMRE 2026, página 100, confirma la identificación ya corregida de esta ficha: nuevos sin gratuidad, FUAS, convocados DEMRE con PAES vigente; hasta 80% sobre arancel según promedio CL/M1 y carrera, excluye Medicina. Si hay becas o CAE se aplica al saldo; renovación exige 100% de asignaturas de los dos últimos semestres y duración formal. Compatible exclusivamente con Matrícula UBO.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No se verifica porcentaje individual ni cierre propio. El rótulo histórico «Excelencia» no se adopta como alias oficial ni se certifica nueva tabla 2027.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca Puntaje PAES UBO',monto_cobertura='Hasta 80% del arancel o saldo después de ayudas estatales, según carrera y PAES; excluye Medicina. UBO 2026.',cobertura_tipo='PORCENTUAL',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=NULL,url_oficial='https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf' WHERE id_beca=433;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca Municipal de Transporte Bulnes; modalidades 2026.
DICTAMEN DOCUMENTAL: CALENDARIO_POR_MODALIDAD.
La publicación municipal del 31 de marzo 2026 acredita entrega a 351 estudiantes:23.000 CLP mensuales para 264 universitarios y 18.000 CLP mensuales para 87 técnicos, marzo–diciembre. La noticia y afiches oficiales de Estudios 2026 fijan inscripción 9–13 febrero, NEM 5,5 para primer año y 5,0 para cursos superiores; documentos de matrícula, notas, RSH e ingresos; recepción presencial en Biblioteca Municipal 9:00–13:30.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No se confirma que la convocatoria general de Estudios y la modalidad nocturna tengan el mismo plazo: el nombre de la ficha agrupa ambas. No aplicar un importe único ni cargar 9–13 febrero como cierre de todas las modalidades. Las bases Simple con encabezado Los Lagos siguen sin usarse.
FUENTES: https://www.imb.cl/noticias/beca-municipal-de-estudios-2026/ ; https://www.imb.cl/noticias/municipalidad-de-bulnes-entrega-beca-de-transporte-a-351-estudiantes-de-educacion-superior/ ; https://www.imb.cl/wp-content/uploads/2026/02/WhatsApp-Image-2026-02-02-at-08.55.57-2.jpeg ; https://www.imb.cl/wp-content/uploads/2026/02/WhatsApp-Image-2026-02-02-at-08.55.57-3.jpeg
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,monto_cobertura='23.000 CLP mensuales para universitarios y 18.000 CLP mensuales para técnicos; marzo a diciembre. Beca de transporte Bulnes 2026.',cobertura_tipo='MONETARIA',cobertura_importe=NULL,cobertura_moneda='CLP',cobertura_periodicidad='MENSUAL',cobertura_porcentaje=NULL,url_oficial='https://www.imb.cl/noticias/beca-municipal-de-estudios-2026/' WHERE id_beca=455;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca municipal Penco 2026; bases firmadas y proceso adjudicado.
DICTAMEN DOCUMENTAL: CERRADA_CONFIRMADA.
La lectura visual de las bases firmadas, páginas 2 y 3, acredita NEM 5,5 para primer año, notas 5,0 para continuidad, RSH y matrícula superior; aporte único 100.000 CLP y adicional 200.000 CLP por puntaje nacional PAES. Las bases fijan 9 de febrero a 6 de marzo; el formulario indica 9 de marzo. Los resultados del 30 de abril y la entrega de mayo acreditan cierre y adjudicación del proceso.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: La convocatoria está cerrada por evidencia positiva, aunque subsiste discrepancia del día final entre bases y formulario. No escoger 6 o 9 de marzo como fecha definitiva sin un acto aclaratorio. Se conserva cierre estructurado desconocido y ambas fechas documentadas; esta limitación no equivale a recepción abierta.
FUENTES: https://penco.cl/wp-content/uploads/2026/02/BASES-BECA-MUNICIPAL-2026.pdf ; https://penco.cl/resultados-beca-municipal-2026/ ; https://penco.cl/municipio-de-penco-entrega-mas-de-mil-becas-de-educacion-superior-con-inversion-historica-de-109-millones/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=457;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Arancel ajustado UCT; mecanismo distinto de beca concursable.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
El portal FUAS 2027 indica que quienes no califiquen a gratuidad por situación económica pueden solicitar arancel reajustado ante instituciones adscritas, presentando RSH. DGEUCT confirma participación en gratuidad y financiación estatal, pero su apartadoarancel no publica procedimiento local del ajuste; DCR mantiene error DNS.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: La posibilidad general del mecanismo queda acreditada; no su porcentaje, documentos adicionales o calendario administrativo UCT. No imponer cierre FUAS a un trámite local no descrito ni inventar una beca monetaria. Hace falta instructivo público de DCRUCT.
FUENTES: https://postulacion.beneficiosestudiantiles.cl/fuas/ ; https://dge.uct.cl/arancel/ ; https://dcr.uct.cl/preguntas-frecuentes/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=474;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Excelencia Académica ENAC; nueva lectura DIPE.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
La página DIPE actual explica apoyo al acceso y renovación de beneficios, pero no enumera una regla específica de excelencia. El apartado de Coordinación de Orientación y Participación Social no asigna porcentajes o notas mínimas a esta beca.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No confundir orientación general, promoción de matrícula o beneficios estatales con excelencia interna ENAC. Falta la norma específica aplicable; no se actualizan por suposición los porcentajes históricos.
FUENTES: https://enac.cl/estudiantes/atencion-estudiantil/ ; https://enac.cl/admision/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=477;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca municipal general Quellón; ejecución 2026.
DICTAMEN DOCUMENTAL: SIN_CALENDARIO_PUBLICADO.
La publicación municipal del 17 de agosto distingue explícitamente la Beca Municipal de Hijos de Pescadores, CEA y Mujer Trabajadora. Para la general informa 82 estudiantes y aporte individual de 400.000 CLP distribuido en dos cuotas semestrales. Ya no depende de extrapolar las bases de Hijos de Pescadores.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No acredita fechas de recepción ni requisitos completos de la convocatoria general. El total de personas del título y la suma de modalidades difieren: no utilizar el agregado para deducir importes ni alterar el dato individual explícito. No se declara abierta ni permanente.
FUENTES: https://muniquellon.cl/municipalidad-de-quellon-entrega-40-millones-en-becas-y-beneficia-a-100-estudiantes-de-la-comuna/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,monto_cobertura='400.000 CLP por beneficiario en dos cuotas semestrales; Beca Municipal general Quellón 2026.',cobertura_tipo='MONETARIA',cobertura_importe=400000.00,cobertura_moneda='CLP',cobertura_periodicidad='DESCONOCIDA',cobertura_porcentaje=NULL WHERE id_beca=481;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca municipal Paillaco; nueva lectura de fuentes 2021.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
Dos noticias oficiales del 1 de abril y 4 de mayo 2021 distinguen la beca de apoyo superior del bono matrícula. Informan 13 cupos y ayuda mensual durante diez meses, con aprobación para 2021–2024; el segundo aviso amplía la recepción hasta 14 de mayo 2021. Confirma que el plazo de abril del bono no es el de esta modalidad.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: La edición 2021 no prueba renovación de la autorización 2021–2024 para 2026. El acta 2025 identifica 2 UFmensuales pero falta llamado o regla de acceso de esa edición actual. Conservar la separación de programas y el cierre 2026 desconocido.
FUENTES: https://www.munipaillaco.cl/municipalidad-de-paillaco-invita-a-postular-a-beca-de-apoyo-a-la-educacion-superior-2/ ; https://www.munipaillaco.cl/beca-municipal-de-apoyo-a-la-educacion-superior-extiende-plazo-de-postulacion-hasta-el-14-de-mayo-2/
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=486;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Beca superior San Gregorio 2026; postulación y renovación.
DICTAMEN DOCUMENTAL: CALENDARIO_POR_MODALIDAD.
El llamado municipal del 19 de marzo fija postulación 19–27 marzo 2026. El de 7 de agosto fija renovación superior 10–21 agosto 2026 a 17:00, con notas del primer semestre y alumno regular del segundo. La ordenanza 0113 de 17/03/2026, páginas 1–5 leídas visualmente, establece 110.000 CLP mensuales para técnico superior o 140.000 CLPpara profesional, durante diez meses; matrícula 2026, RSHcomunal 40–80%, edad máxima 25 y sin título superior previo. Obligaciones académicas incluyen promedio 4,7 y revisión por comisión si hay asignaturas reprobadas.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: No unir marzo y agosto en una ventana continua ni aplicar requisitos de enseñanza media. El artículo 2 contiene la referencia residual «estudios medios», pero el decreto, título, artículo 5 y formulario distinguen expresamente técnico superior/profesional. El monto depende del nivel: no asignar 140.000 a todos. Ambos períodos 2026 ya vencieron.
FUENTES: https://sangregorio.cl/2026/03/19/beca-municipal-conoce-el-cronograma-de-recepcion-de-antecedentes/ ; https://sangregorio.cl/2026/08/07/municipalidad-de-san-gregorio-inicia-proceso-de-renovacion-de-becas-municipales-para-estudiantes-de-ensenanza-media-y-educacion-superior/ ; https://sangregorio.cl/wp-content/uploads/2026/03/ORDENANZA-BECA-MUNICIPAL-ESTUDIANTES-EDUCACION-SUPERIOR.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,monto_cobertura='110.000 CLP mensuales para técnico superior o 140.000 CLP para profesional; diez meses y renovación en agosto. Ordenanza 0113/2026 San Gregorio.',cobertura_tipo='MONETARIA',cobertura_importe=NULL,cobertura_moneda='CLP',cobertura_periodicidad='MENSUAL',cobertura_porcentaje=NULL,url_oficial='https://sangregorio.cl/2026/03/19/beca-municipal-conoce-el-cronograma-de-recepcion-de-antecedentes/' WHERE id_beca=509;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Cochamó; nueva consulta directa al portal municipal.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
El sitio municipal actual y su buscador se abrieron en navegador pese a 406 en la descarga automática. La búsqueda «beca» devuelve una cápsula de 3/05/2017 sobre Fundación Desarrollo Cochamó, distinta de la ayuda municipal de esta ficha. No se usa esa coincidencia para reemplazar el programa ni fecharlo en 2026.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: El buscador no prueba ausencia de convocatoria. La pista periodística 2026 y la cuenta pública 2025 no quedan sustituidas por la fundación. Sigue faltando el acto primario específico del aporte municipal superior 2026; no se modifica cobertura por esta consulta.
FUENTES: https://municochamo.cl/ ; https://municochamo.cl/?s=beca ; https://municochamo.cl/transparencia/cuentapublica/cuentapublica2025.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=513;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Carahue; consulta directa al sitio público.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
El buscador del sitio/webabrió en navegador; devuelve una página de ejemplo y comentarios ajenos a la convocatoria. Esos comentarios incluyen publicidad de apuestas y no se consideran información emitida por el municipio. No se abrieron sus enlaces ni se usaron sus fechas como evidencia de beca.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: La consulta no produjo un llamado oficial 2026 utilizable. El reglamento del expediente corresponde a 2025 y no se actualiza por el copyright. Falta publicación de convocatoria superior 2026 o acto que acredite condiciones aplicables; no se usa la plataforma Simple de pruebas.
FUENTES: https://carahue.cl/web/?s=beca ; https://carahue.cl/web/wp-content/uploads/2025/03/REQUISITOS-Y-REGLAMENTO.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=515;
UPDATE becas SET descripcion_larga='REVISIÓN DE INCERTIDUMBRES · 02/11/2026
ALCANCE: Excelencia Puntaje Trayectoria Educativa 2 UCSC;2026.
DICTAMEN DOCUMENTAL: REVISION_INCONCLUSA.
DEMRE 2026 página 108 y ficha específica SUBE confirman 50% sobre arancel a pagar y promedio 950 CL/M1 o 1000 en obligatoria exigible. El Manual de Becas Internas 2026, páginas 4 y 6, identifica asignación automática y mantiene requisitos generales sobre saldo, exclusión Medicina y beneficios Mineduc.
LÍMITES Y DATOS QUE SIGUEN SIN CONFIRMACIÓN: Persiste discordancia de compatibilidad: catálogo y ficha descuentan previamente becas ministeriales, pero el manual y el apartado compatibilidad las excluyen. El beneficio y porcentaje están acreditados; la coexistencia con becas ministeriales sigue inconclusa. No eliminar esa incertidumbre por el acuerdo entre las fuentes sobre el 50% ni cambiarla a «No publicado».
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf ; https://sube.ucsc.cl/becas-y-financiamiento/beca-excelencia-puntaje-trayectoria-educativa/ ; https://direcciones.ucsc.cl/content/uploads/sites/66/2026/08/Manual-becas-internas-1.pdf
La fecha de esta revisión no convierte el año del antecedente en una convocatoria nueva.
ANTECEDENTES CONSERVADOS (prevalecen las correcciones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca Excelencia Puntaje Trayectoria Educativa 2 UCSC',monto_cobertura='50% del arancel a pagar; Excelencia Trayectoria Educativa 2 UCSC. Compatibilidad con becas ministeriales en revisión.',cobertura_tipo='PORCENTUAL',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=50.00 WHERE id_beca=520;
COMMIT;
