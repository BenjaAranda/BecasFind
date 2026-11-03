\set ON_ERROR_STOP on
BEGIN;
SET LOCAL lock_timeout='5s';
DO $guardas$ BEGIN
IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario distinto de 528'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=1 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=1 AND public_id='fc65e10e-f9ad-4698-a261-1d03b1212a14'::uuid AND version=3 AND md5(descripcion_larga)='acebcafe0e057c1ec2f20a47569ecbf2' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 1'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=2 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=2 AND public_id='7698fdfa-3610-4c10-b74d-84be1d424eb7'::uuid AND version=1 AND md5(descripcion_larga)='2ef6a12e98069aec638c491ffb53db69' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 2'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=3 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=3 AND public_id='935bf4e5-e962-4c04-8a08-4033f94f23eb'::uuid AND version=1 AND md5(descripcion_larga)='3c0ed33e0b0a1310c3471f27f0863033' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 3'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=17 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=17 AND public_id='5f919505-ad66-404a-bb3c-33dd6995265d'::uuid AND version=1 AND md5(descripcion_larga)='46f4b04657a9e15bf909e77fde5d8baf' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 17'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=19 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=19 AND public_id='89aa67b1-a632-4585-b51b-60ce5d4c75cc'::uuid AND version=1 AND md5(descripcion_larga)='277a7bdc03917745d044e0e07be22777' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 19'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=21 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=21 AND public_id='e2114db0-b245-4950-a2bb-2660f007e342'::uuid AND version=1 AND md5(descripcion_larga)='5baf70da129b8db77904f3cadb3e287d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 21'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=26 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=26 AND public_id='0c372274-cdc0-498c-bf75-13bf07c0c9f2'::uuid AND version=1 AND md5(descripcion_larga)='1840efb27b8e9296e3d1f283ab7a6563' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 26'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=27 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=27 AND public_id='5e68bb01-d118-45b2-8c11-1458b008c03a'::uuid AND version=1 AND md5(descripcion_larga)='48db9a1e40101816c25435384d6e867b' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 27'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=33 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=33 AND public_id='b9d08a38-8d37-432f-b637-82ca917311b4'::uuid AND version=1 AND md5(descripcion_larga)='81a39471cfd8ceb1521db88828941631' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 33'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=34 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=34 AND public_id='90707e2d-91e0-4019-a4b4-fe6b2f7e08cc'::uuid AND version=1 AND md5(descripcion_larga)='3c74f0ff11aa167913709ef1471a2a29' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 34'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=37 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=37 AND public_id='e549c7af-aa24-4d4e-b4db-420943a15850'::uuid AND version=2 AND md5(descripcion_larga)='1c62ed98be7bf9893cef4c0cf4e1ae57' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 37'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=44 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=44 AND public_id='e624598d-0746-4369-b52b-65cc668c40ae'::uuid AND version=1 AND md5(descripcion_larga)='148b204820027f582ac1bcc156f2290d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 44'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=47 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=47 AND public_id='e44d35f2-542a-491c-ae56-80883bf89e0d'::uuid AND version=1 AND md5(descripcion_larga)='5b64cea2e070a6a564fb2127c23143ea' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 47'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=49 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=49 AND public_id='c1c28f20-cb82-42d2-ba12-f1f8079ee3e0'::uuid AND version=1 AND md5(descripcion_larga)='70707774413c06270d504532d34d828f' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 49'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=50 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=50 AND public_id='384afa53-cbcf-4992-a20c-44fc5a01ed44'::uuid AND version=1 AND md5(descripcion_larga)='29a98ed02636bf17f6e8ee570cebb6f5' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 50'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=51 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=51 AND public_id='c3185637-8e0b-47ff-bd29-c1304407c9ad'::uuid AND version=1 AND md5(descripcion_larga)='0d01bb84f6596ab9581af1222ef7fff8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 51'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=52 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=52 AND public_id='d717e436-d0e3-4c58-92d8-bb338f3b0222'::uuid AND version=1 AND md5(descripcion_larga)='b8c2f0496901deb39efa7ea4ac582b6c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 52'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=55 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=55 AND public_id='c9da3b0c-a207-41e4-98fd-06ae7623f75b'::uuid AND version=1 AND md5(descripcion_larga)='9943a6b01f7a5de654ff39c3131ded5c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 55'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=57 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=57 AND public_id='f393ea3c-a42b-49cb-b18d-f5ac6cf22f18'::uuid AND version=1 AND md5(descripcion_larga)='21b0121467e4f1ed06ad68a260f97cb8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 57'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=60 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=60 AND public_id='01bfbc25-aaac-4c9b-b767-194e4508d3a8'::uuid AND version=1 AND md5(descripcion_larga)='1ea9ab7817ceacbcf39a4815b2387c89' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 60'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=63 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=63 AND public_id='94d04245-92e0-4f04-ba1a-ab3271853edd'::uuid AND version=1 AND md5(descripcion_larga)='179115cb49b1e3a14f82a8b1d12cbf36' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 63'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=64 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=64 AND public_id='1c16f749-45f2-4b85-8838-50d1928758bc'::uuid AND version=1 AND md5(descripcion_larga)='c5e0314a913ebf80f7d62a716946d693' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 64'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=68 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=68 AND public_id='b57476f8-6347-4d22-bfb9-86691e11c7ef'::uuid AND version=3 AND md5(descripcion_larga)='cb43456c6b2f163cc33556abf14e5afc' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 68'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=79 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=79 AND public_id='848def6c-70a5-4a0d-825c-12bef34e5387'::uuid AND version=1 AND md5(descripcion_larga)='01d2c1dcc8eeb1f02dda8d59bd9e69af' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 79'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=83 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=83 AND public_id='a01d0d98-da82-4111-9030-344bedcc65ef'::uuid AND version=1 AND md5(descripcion_larga)='8e3661c277ff39316b745ced011ee7e8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 83'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=90 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=90 AND public_id='524d17dd-63f5-4a06-a779-e6fae7eaed90'::uuid AND version=1 AND md5(descripcion_larga)='dee4d2d38f96aa43ac875ef5b08fb78d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 90'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=91 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=91 AND public_id='39dbabc3-52ea-4f92-9620-ddcf530a7642'::uuid AND version=1 AND md5(descripcion_larga)='1cde945bc1c682f5961a85b0e973c4e1' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 91'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=92 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=92 AND public_id='8dd7e072-983a-4b33-9c1f-caeb7d3b2f7d'::uuid AND version=1 AND md5(descripcion_larga)='1d890100d1a27309c9f884b075940fa7' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 92'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=93 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=93 AND public_id='0f07eea8-ea42-451b-8b49-cdf6e72e29f4'::uuid AND version=1 AND md5(descripcion_larga)='0a7fcdd0e2f39a01f729df613722ace3' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 93'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=96 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=96 AND public_id='ad08ea6a-8ebb-4c3f-8383-05afea9ea271'::uuid AND version=1 AND md5(descripcion_larga)='6e328489cf41aab1f83a8c3b99917fdf' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 96'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=100 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=100 AND public_id='96648d83-e8a5-4849-bc16-7fbd134fc9c4'::uuid AND version=1 AND md5(descripcion_larga)='8fd2f4012ed7c4ea10277c8e3eb578e7' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 100'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=101 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=101 AND public_id='e50604ba-024c-46a2-a1a6-1e940d86ea7a'::uuid AND version=1 AND md5(descripcion_larga)='33f7f683e726181c0e4e05c509b7a235' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 101'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=102 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=102 AND public_id='ecb2bda1-fffc-4c4a-a1ef-d3682dece301'::uuid AND version=1 AND md5(descripcion_larga)='4978af3d1cce8e9fd66f3c88cf124d7a' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 102'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=105 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=105 AND public_id='d4bfeb79-7b05-45ad-9915-f0bfd75940bc'::uuid AND version=1 AND md5(descripcion_larga)='59d26bc51671cff7db60d03c5a134122' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 105'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=110 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=110 AND public_id='1a8ab1b1-7e39-4aa7-8330-1dcd511bd514'::uuid AND version=1 AND md5(descripcion_larga)='e7d8c117deb9d72fce865f498434d93f' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 110'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=117 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=117 AND public_id='64dd46e4-c0b3-421b-8877-9b90bcbd5e03'::uuid AND version=1 AND md5(descripcion_larga)='353f44e2e54f854a0b9ff92542ca4000' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 117'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=121 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=121 AND public_id='99fd11bf-6953-4d10-a099-4b51b2de5468'::uuid AND version=1 AND md5(descripcion_larga)='76b0b52b7f490bef78c21bc53f4ee04d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 121'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=124 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=124 AND public_id='34df6d9a-f687-4609-83ec-2de1a210d257'::uuid AND version=1 AND md5(descripcion_larga)='23de1d365cb51f3df8822291dfc18e50' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 124'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=125 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=125 AND public_id='33d96d0d-f819-4949-ab85-a6ca61b73bcb'::uuid AND version=1 AND md5(descripcion_larga)='9484b8c11152bdc7f218da16cc2ce300' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 125'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=126 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=126 AND public_id='ac0a9ea4-cb5c-4df2-b260-651ef3dc5a89'::uuid AND version=1 AND md5(descripcion_larga)='cde4f63e578acbb4e7430a7376425804' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 126'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=127 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=127 AND public_id='dadba91f-f202-44bb-b81a-d20c8ffc224d'::uuid AND version=1 AND md5(descripcion_larga)='7bcc45da9a24a80c2b2245a4c9333b78' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 127'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=129 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=129 AND public_id='7c6bc61b-739a-4360-91c8-f9840922bb00'::uuid AND version=1 AND md5(descripcion_larga)='2c94d4b4c96ef765de66619a312c1a9c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 129'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=130 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=130 AND public_id='1b141394-e39a-43b3-905e-d76beccd32e3'::uuid AND version=1 AND md5(descripcion_larga)='ce75fa6099e1183aaaaaa2d2aec1f048' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 130'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=134 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=134 AND public_id='3adc76b0-5f00-4243-ac2b-20d9547ced3a'::uuid AND version=1 AND md5(descripcion_larga)='9c519ebb11965b63d50b9f4a133f6349' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 134'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=139 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=139 AND public_id='e19f64bb-5645-41af-8abf-43457e19775f'::uuid AND version=1 AND md5(descripcion_larga)='84dac5459a79af5ac16c2ab1c72fdbdd' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 139'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=141 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=141 AND public_id='7ec2669e-fa97-4c01-ae14-a8b8d5edf19a'::uuid AND version=1 AND md5(descripcion_larga)='06f49f698569563cb636825b08ec9e2f' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 141'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=142 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=142 AND public_id='98a63c13-f0fa-4331-844d-362bcabd8347'::uuid AND version=1 AND md5(descripcion_larga)='2b9749d2103da6ab22d1c5eaa8135b41' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 142'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=147 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=147 AND public_id='4d8e556f-9769-4476-a63a-9fe399176c9d'::uuid AND version=1 AND md5(descripcion_larga)='ceea3c1aa85bc460679d9ba7e17bdd06' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 147'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=148 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=148 AND public_id='7280e8f4-42b4-47f1-b842-fba32f0ba92d'::uuid AND version=1 AND md5(descripcion_larga)='f7065f695596ec5585bf1c53ab5672c7' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 148'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=149 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=149 AND public_id='a9c5e0e4-524f-4f4e-b8ea-5ecd7fc15ad3'::uuid AND version=1 AND md5(descripcion_larga)='0a1a2856e1122a0076263a86e4877936' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 149'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=157 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=157 AND public_id='a5192944-d1bc-45c8-9ffa-f7557a0b0c4d'::uuid AND version=1 AND md5(descripcion_larga)='70ec522874f4865576b8bef815e2219e' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 157'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=158 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=158 AND public_id='c6af8cf1-d8ee-4803-8107-9253a30e2903'::uuid AND version=1 AND md5(descripcion_larga)='f7b36eaa94231a441512918127a01594' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 158'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=164 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=164 AND public_id='2d68ba2f-e660-4f8f-8816-95a725271b2b'::uuid AND version=1 AND md5(descripcion_larga)='bbe16c6b6834deb82ee2f73ce5371959' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 164'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=165 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=165 AND public_id='07ea6341-bf45-4a3d-b0dd-7335383d4ab0'::uuid AND version=1 AND md5(descripcion_larga)='fd577923169b1211ddece96e8c2cf99a' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 165'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=168 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=168 AND public_id='6de0793f-f3f3-453e-a1db-7b79bd796c88'::uuid AND version=1 AND md5(descripcion_larga)='34b2d03436edd4a2e5dacf2344c57ec0' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 168'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=172 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=172 AND public_id='2f5f3383-e3df-42ea-9705-757b0c56a15f'::uuid AND version=1 AND md5(descripcion_larga)='62ab21fbd35eb22a432defc181a6bb93' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 172'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=173 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=173 AND public_id='5c0aba1f-d33b-49c0-8ae9-e84f4d7611a3'::uuid AND version=1 AND md5(descripcion_larga)='c81b48c7e3c3442720622a6c270ef0aa' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 173'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=174 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=174 AND public_id='419b8f9d-a696-4139-be2d-2e1561801e90'::uuid AND version=1 AND md5(descripcion_larga)='a07057dff61f6eabb4b75c9184b76c13' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 174'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=175 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=175 AND public_id='af85d9b4-2afa-46b3-a8ac-1abfa270ffc1'::uuid AND version=1 AND md5(descripcion_larga)='5ae791acbc79e0f291ffa2e46551c1b6' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 175'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=177 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=177 AND public_id='7249b8b3-e648-422c-870c-60c54181690f'::uuid AND version=1 AND md5(descripcion_larga)='1ec8c6cd570370dd790eb9787ea7e12b' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 177'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=193 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=193 AND public_id='8eceb9d6-8ca6-4634-8a13-ebd93bcafb11'::uuid AND version=1 AND md5(descripcion_larga)='e684a8c84ce3174bb8ffdd55e016fb0a' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 193'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=198 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=198 AND public_id='c6bd8e78-ca84-4014-a494-63e1202013b0'::uuid AND version=1 AND md5(descripcion_larga)='f905f03c8b02bb506a834e51955340ae' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 198'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=202 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=202 AND public_id='30184ba7-876c-499e-b992-de4bbbe871b9'::uuid AND version=1 AND md5(descripcion_larga)='b57ff56b4b13f133a3eb278c4a185936' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 202'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=209 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=209 AND public_id='3bd84a69-9adf-438a-b3da-9e7108a4ae4b'::uuid AND version=1 AND md5(descripcion_larga)='95c061020445f3c6132f888a59f75a7d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 209'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=212 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=212 AND public_id='c5c15edc-fe9e-42a9-b262-e88b3070eb4e'::uuid AND version=1 AND md5(descripcion_larga)='01dbad11c0fdaab4dcd86ad6bf0b8729' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 212'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=213 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=213 AND public_id='14e5b9a9-abfb-41c0-99ac-2f8f83aa3ace'::uuid AND version=1 AND md5(descripcion_larga)='fee28a712791ae13ff434b8d349f906b' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 213'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=214 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=214 AND public_id='eec985a2-f75c-4c54-b8ba-e3f883f21aaf'::uuid AND version=1 AND md5(descripcion_larga)='601bd60de1d6a16f23744d378d9c6ce5' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 214'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=216 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=216 AND public_id='7551ac2e-dc59-4df5-8acc-ca7b1958473e'::uuid AND version=1 AND md5(descripcion_larga)='294d5df58c4f8b595ba48b3972f34f0a' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 216'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=217 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=217 AND public_id='645f5e78-a187-4198-8b94-568b9973f208'::uuid AND version=1 AND md5(descripcion_larga)='0d5d2153149966780164449554b5602c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 217'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=218 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=218 AND public_id='34d248ee-0cf8-40b3-bbe1-7aa7ebe5ea47'::uuid AND version=1 AND md5(descripcion_larga)='b9f31ded25170dec994b9df299c77b5c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 218'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=219 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=219 AND public_id='94c3abb1-c020-48e2-b8bd-ad8f8e589fb7'::uuid AND version=1 AND md5(descripcion_larga)='28337716256437cef828537cb4b9913c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 219'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=221 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=221 AND public_id='62cf00eb-ceeb-4832-b9d6-802526fc9f24'::uuid AND version=1 AND md5(descripcion_larga)='d5037db22e65e79f40629873a6db528d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 221'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=222 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=222 AND public_id='86b45159-0446-4d4f-8be0-4248f4ed3b76'::uuid AND version=1 AND md5(descripcion_larga)='58049361a192679bf4a556cf88f8c76b' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 222'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=223 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=223 AND public_id='a1b8507f-d645-42d3-9c5c-8e773e5be571'::uuid AND version=1 AND md5(descripcion_larga)='88dc3bdff899ec0c7d5410409997ed83' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 223'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=226 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=226 AND public_id='c697c921-e233-4110-8b15-cadd757a3529'::uuid AND version=1 AND md5(descripcion_larga)='8dae1fb5943357d84f21774185ee16f7' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 226'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=229 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=229 AND public_id='af9ca817-b275-4731-9980-4fe8e515d7f8'::uuid AND version=1 AND md5(descripcion_larga)='3dcff489cb4cd36e0c2c12366f5ac1c1' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 229'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=231 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=231 AND public_id='0485398a-a487-4203-9441-724d97d05789'::uuid AND version=1 AND md5(descripcion_larga)='6b96aaf102062336bed6455622ae27b8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 231'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=233 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=233 AND public_id='2c40d3ea-34c8-4687-b02a-fdf3eb26418e'::uuid AND version=1 AND md5(descripcion_larga)='6ea0dc7ad2f112c6eb5876e183d4db50' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 233'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=234 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=234 AND public_id='eda4c362-f3a8-41df-a241-254c9746293f'::uuid AND version=1 AND md5(descripcion_larga)='0d4c0bd4ad917b0d1e98de2b771c9bf8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 234'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=236 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=236 AND public_id='16cc9651-6c93-4894-a9f9-6d6b8f7a4a4e'::uuid AND version=1 AND md5(descripcion_larga)='0ac71e95b8781ddba9161dd2c6a4b319' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 236'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=240 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=240 AND public_id='825e30aa-51eb-4d0a-aba5-7a25a3ea508e'::uuid AND version=1 AND md5(descripcion_larga)='2f89575b6c126f61d9084d11fc39ee30' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 240'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=243 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=243 AND public_id='cb00dd91-75c2-4d16-9a34-0e2456c81e20'::uuid AND version=1 AND md5(descripcion_larga)='cb9a9b3825e7e642115c8fd23c7d0628' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 243'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=248 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=248 AND public_id='d451029f-468b-4e34-b758-aebe08749491'::uuid AND version=1 AND md5(descripcion_larga)='b605756a6fb1bc4a6d960d4abb9ec663' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 248'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=251 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=251 AND public_id='c88b5fa2-cc4a-410b-8d69-8d5975d01409'::uuid AND version=3 AND md5(descripcion_larga)='f803865fd42fc1fd9748e71ed8326c0b' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 251'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=257 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=257 AND public_id='8f8b4b5f-1231-4ae9-9207-c6637a09f4de'::uuid AND version=1 AND md5(descripcion_larga)='2c0c93824957d9268b31b2f11fdc520f' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 257'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=260 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=260 AND public_id='b00bde27-8092-4216-9774-8745ec78d9a4'::uuid AND version=1 AND md5(descripcion_larga)='dcbbdddf35a1d43b38cee07c6f9d7797' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 260'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=261 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=261 AND public_id='bbf5e9c1-7545-40a9-800b-4973dd056260'::uuid AND version=3 AND md5(descripcion_larga)='25dd994413fd863a294995fa7e45cdfc' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 261'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=262 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=262 AND public_id='b9768b49-2abf-47b8-9c5b-bd7c9ccd27f0'::uuid AND version=1 AND md5(descripcion_larga)='23efb68b60d309e2a10c8f3d2b20408b' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 262'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=263 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=263 AND public_id='ab08a79f-417d-426b-b966-9a561ad7a1dc'::uuid AND version=1 AND md5(descripcion_larga)='4b8f870d98881e6f428268de057666c9' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 263'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=267 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=267 AND public_id='3d270aac-ca38-4f1a-b69c-dcfa1eecf09b'::uuid AND version=1 AND md5(descripcion_larga)='8c715d96618a8050d90fc5d3aad8d1cf' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 267'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=273 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=273 AND public_id='99323baf-0dcd-4d09-a0ed-0469d52f2aa2'::uuid AND version=1 AND md5(descripcion_larga)='02f52a6564cbb85fa0a5b5c889667dd2' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 273'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=276 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=276 AND public_id='6911b56a-30e5-4638-b9de-388952541ac7'::uuid AND version=1 AND md5(descripcion_larga)='cee50c7cc2ba95b6f6ab7270c25ea7c4' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 276'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=279 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=279 AND public_id='e6ef0e92-595f-4789-b6ee-99a24e8005d6'::uuid AND version=1 AND md5(descripcion_larga)='2bdb0d2efa771dbc2fc30c0be69ba556' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 279'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=280 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=280 AND public_id='6df00ebf-d945-4d8d-8281-c5ce0c8d4e72'::uuid AND version=1 AND md5(descripcion_larga)='92022194dd4b9341de45b0459d6b613f' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 280'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=288 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=288 AND public_id='6321fa90-534d-4031-acb2-39e78afb3c6c'::uuid AND version=1 AND md5(descripcion_larga)='78ff2fb55610afc166c725cf082f1ec1' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 288'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=292 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=292 AND public_id='f191dd70-1764-4fef-9a10-7073a1734980'::uuid AND version=1 AND md5(descripcion_larga)='9da347898d02838fb9066aa4d7a7415a' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 292'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=293 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=293 AND public_id='b92f2e33-8568-4c55-bd95-2b0b3506e2b9'::uuid AND version=1 AND md5(descripcion_larga)='75418b0e304fc87bb4fa7d77f0ea1fb6' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 293'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=297 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=297 AND public_id='cace1550-37d2-4d96-9324-8ade2478852b'::uuid AND version=1 AND md5(descripcion_larga)='cf8aef216761743751fdb08774cdeca6' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 297'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=299 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=299 AND public_id='7f94eb9a-3add-4d6e-b7c9-69eb9fe1cdc8'::uuid AND version=1 AND md5(descripcion_larga)='fbff5eecea43d0fb20484469dda93676' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 299'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=300 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=300 AND public_id='e4d1e6ae-c939-4f0d-9592-8ec6558b1e45'::uuid AND version=1 AND md5(descripcion_larga)='7418ff949beed9daf359b59f6bd5b865' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 300'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=301 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=301 AND public_id='521ecc43-cd7d-41b7-9268-01e834c4fa44'::uuid AND version=1 AND md5(descripcion_larga)='f8b41af51fb7736ad30a6cd7563bde3d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 301'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=302 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=302 AND public_id='318445bc-34e8-4ca9-a865-afd9424f3378'::uuid AND version=1 AND md5(descripcion_larga)='df86fe95fa823740ddd64a4231530bfb' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 302'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=306 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=306 AND public_id='21bd74a2-b2a0-49b8-944a-266a7718641c'::uuid AND version=1 AND md5(descripcion_larga)='74333a0efa9c4de3fa7b5d9e26abf64d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 306'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=312 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=312 AND public_id='dc45574b-ef2c-42e6-919f-bc0bf6f308fb'::uuid AND version=3 AND md5(descripcion_larga)='4b34a4f52c1f9589bd568342b5da3fe4' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 312'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=318 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=318 AND public_id='5b96c1f3-2d86-4332-b736-db7700914247'::uuid AND version=1 AND md5(descripcion_larga)='c75c6cec4d48a67750a8e5fa0ccf920d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 318'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=321 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=321 AND public_id='cfa2072d-c1f2-4bf8-b31f-3effb792c63b'::uuid AND version=1 AND md5(descripcion_larga)='1c5ad9e55bdd520e15d306951f639341' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 321'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=329 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=329 AND public_id='3200e60d-476e-4822-94b8-94aff8b6c9c3'::uuid AND version=1 AND md5(descripcion_larga)='e36449187ded3c55764d34766070f315' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 329'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=331 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=331 AND public_id='214dac55-77e8-440a-80db-37c3c18e15f5'::uuid AND version=1 AND md5(descripcion_larga)='5b8f356d4c43bbdb4c6ccbe514e9cd72' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 331'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=333 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=333 AND public_id='f203e82f-69fd-49ad-a55b-594fb8c78124'::uuid AND version=1 AND md5(descripcion_larga)='5b296fbcbd9cfc7abe1c12bfbb1b58a8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 333'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=336 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=336 AND public_id='3bb27b3c-bca1-48d3-b322-dfa8c6e15d11'::uuid AND version=1 AND md5(descripcion_larga)='f42522fb14ecbb9eaa597d6b7f352d84' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 336'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=338 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=338 AND public_id='b67f77b3-3d34-4bdd-b777-8e1c248a16dc'::uuid AND version=1 AND md5(descripcion_larga)='cecdf0aa78f310ec11fa1c42c2f6cf85' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 338'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=340 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=340 AND public_id='735a2b59-21f1-4101-9d1b-a59a815a798d'::uuid AND version=1 AND md5(descripcion_larga)='f51547dbcea43ece9f82c2d938504d04' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 340'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=343 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=343 AND public_id='267502a0-fee7-49a1-8b2f-49d8e0ad3cd9'::uuid AND version=1 AND md5(descripcion_larga)='b019f750450e2b62466f50384664d528' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 343'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=347 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=347 AND public_id='51454f1c-5ff8-40a4-aacd-cbeff79838db'::uuid AND version=1 AND md5(descripcion_larga)='decfe69b6efe8c01fe1eaa2f73912e0f' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 347'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=353 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=353 AND public_id='1eafa257-d986-4f40-a58c-3eb65dea1575'::uuid AND version=1 AND md5(descripcion_larga)='15200695c891c0872235b6677d49b9a5' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 353'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=354 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=354 AND public_id='4d26d644-2873-4438-bda7-51b05e6e4f09'::uuid AND version=1 AND md5(descripcion_larga)='ef7beb4517b12ab0af97f51f16d07e79' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 354'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=357 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=357 AND public_id='c8e8679f-0be1-47c4-a548-f9acfb77ad78'::uuid AND version=1 AND md5(descripcion_larga)='c8e28b221279e92267f828b1ed1fd117' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 357'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=358 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=358 AND public_id='af05b33d-c588-4d50-a86f-91046ce852f6'::uuid AND version=1 AND md5(descripcion_larga)='cf314b71bf24570ea19630edeb14a4a4' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 358'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=360 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=360 AND public_id='78771074-0289-4b91-8623-07a7640c145a'::uuid AND version=1 AND md5(descripcion_larga)='73b22c071bb9a960d4d705f5fd48ece8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 360'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=362 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=362 AND public_id='31ad2b50-30ec-4150-aeed-37ce79d5db6a'::uuid AND version=3 AND md5(descripcion_larga)='2c617b0ea94fa69d6c2bcda9fec799f9' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 362'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=365 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=365 AND public_id='d4e9691e-bef1-478e-af0e-2a5e8f01012e'::uuid AND version=1 AND md5(descripcion_larga)='424987a4ef1fb357e0d10496d5bb1be2' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 365'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=367 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=367 AND public_id='3b91c020-b195-4128-89eb-affe6c9e5523'::uuid AND version=1 AND md5(descripcion_larga)='440e02d9f129c75df94e8e68c6b9ed37' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 367'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=368 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=368 AND public_id='141e3bc2-0962-4b38-8346-f90376d92bef'::uuid AND version=1 AND md5(descripcion_larga)='0c0e6181b58b1e4672fe72c9245b3040' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 368'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=369 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=369 AND public_id='c889de93-82ea-49c6-8744-4673f20071e8'::uuid AND version=1 AND md5(descripcion_larga)='ec4c8e5f855fe2e6003663bf1684522f' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 369'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=373 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=373 AND public_id='e2213b53-51f8-4b59-b02c-f90a5fc88c4b'::uuid AND version=1 AND md5(descripcion_larga)='e03ff72e40150c7319589d227fd96ede' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 373'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=374 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=374 AND public_id='3465cdb7-f393-4de2-b9e5-cf8fc70c8465'::uuid AND version=1 AND md5(descripcion_larga)='b583ba6dd6cc4ff9579d228027aa5a40' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 374'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=376 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=376 AND public_id='330cbb6d-1567-4336-aaaf-07aa70523abb'::uuid AND version=1 AND md5(descripcion_larga)='5ba3134908eb674debc7065e49502f75' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 376'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=378 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=378 AND public_id='21b70095-4dfe-46aa-90ad-c3908ed358a0'::uuid AND version=1 AND md5(descripcion_larga)='e6ec734cb0f0e0524aa99a5eb0cd606b' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 378'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=381 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=381 AND public_id='93a1499e-6648-4815-ad49-7c3b5446670b'::uuid AND version=1 AND md5(descripcion_larga)='b26003ebf90af2180374c0b057cbe523' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 381'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=385 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=385 AND public_id='3ddcf8c8-2a70-40ca-9632-45e470c8385e'::uuid AND version=1 AND md5(descripcion_larga)='4037ec06dde3dd3c382a4b38329ef0ee' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 385'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=388 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=388 AND public_id='0f7fa1b8-a97b-4d3a-bdcb-e5453dd75eb2'::uuid AND version=1 AND md5(descripcion_larga)='cfa912454278e2695fe021b59b2eb345' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 388'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=390 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=390 AND public_id='71d385bb-857d-4f10-9856-5156fd6fcdb1'::uuid AND version=1 AND md5(descripcion_larga)='e0eed24bdf33becb156b4e0ad36e5ad6' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 390'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=391 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=391 AND public_id='76dd2495-a281-43f2-a696-aa0353e9501e'::uuid AND version=1 AND md5(descripcion_larga)='574d2dd20ca1e994bc1cb18852e1fd0b' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 391'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=393 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=393 AND public_id='e7671aaf-f602-4cf2-bed6-6c0fe63e6165'::uuid AND version=3 AND md5(descripcion_larga)='1e5ca7c0a6018345cfc378ef7113b1cf' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 393'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=395 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=395 AND public_id='2a2b3a7d-68cf-41d6-b672-de395587005e'::uuid AND version=1 AND md5(descripcion_larga)='7da96df763e676733914837bbe572950' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 395'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=400 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=400 AND public_id='e2b909f4-393c-4d10-b34e-060ddac7fdc8'::uuid AND version=1 AND md5(descripcion_larga)='5e875855ac7bc33e2e6f37f050a4409f' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 400'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=402 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=402 AND public_id='0346c14d-e1f7-479e-8d9a-9d4ff17a6d16'::uuid AND version=3 AND md5(descripcion_larga)='1a578ee6ee7473ff9b6ad5fe76d57afa' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 402'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=403 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=403 AND public_id='2e77097d-1a77-46ff-b96a-9ebfa81e5036'::uuid AND version=1 AND md5(descripcion_larga)='5d87ee93d868f77ac0e24cd19f0fde4d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 403'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=404 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=404 AND public_id='3b92e7cd-b4ac-4627-9ecf-e6b44118acbc'::uuid AND version=1 AND md5(descripcion_larga)='4d3e51297ca99afdea9fde61635e10c5' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 404'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=406 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=406 AND public_id='78affd44-3860-4b8c-8e16-d2df7729bbd4'::uuid AND version=1 AND md5(descripcion_larga)='0a07134db20838994e3b67e117417cb8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 406'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=408 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=408 AND public_id='c98615bb-8a9f-4124-b8aa-96d6e451c581'::uuid AND version=1 AND md5(descripcion_larga)='5944cd2ffeca6eb6cbeda4cbc4efef96' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 408'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=412 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=412 AND public_id='f5e0d1a7-69fb-4a5f-8078-b29d69157669'::uuid AND version=3 AND md5(descripcion_larga)='757ed863a14d84e9ee47248433e9c113' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 412'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=418 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=418 AND public_id='97a71176-c41c-4def-990c-77898a2f23ad'::uuid AND version=1 AND md5(descripcion_larga)='4d27e0df384e2841e0013717efa82578' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 418'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=421 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=421 AND public_id='e0c5f05d-f641-4bcc-8b11-930f6f21b12f'::uuid AND version=1 AND md5(descripcion_larga)='b2d8abda879562797b9f1e6e7fce0915' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 421'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=424 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=424 AND public_id='bd16eeb2-e333-48c3-931f-d63e4aee44b9'::uuid AND version=1 AND md5(descripcion_larga)='29077fb0cd079e09aafde1e1562a331c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 424'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=425 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=425 AND public_id='86a972ff-4d96-4866-8e70-af58d0271f31'::uuid AND version=1 AND md5(descripcion_larga)='49d849fde94ecc062c6901a43f7fefbd' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 425'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=426 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=426 AND public_id='f91de4a7-3178-4533-a21c-e8f1ea113fc4'::uuid AND version=3 AND md5(descripcion_larga)='169720bc9193072d99c72b43842a0905' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 426'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=432 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=432 AND public_id='27af4caf-be79-4d74-8327-31f118eaf49e'::uuid AND version=1 AND md5(descripcion_larga)='24eba4915f9aa2cd21f62f4c5e103207' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 432'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=433 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=433 AND public_id='2c5426ce-4880-4f95-b5db-22f873d8877f'::uuid AND version=1 AND md5(descripcion_larga)='63969fbc8a11fd1d5a0f0f51ed71c624' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 433'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=438 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=438 AND public_id='70532341-595c-417b-bd04-226946138bcb'::uuid AND version=1 AND md5(descripcion_larga)='40b64b4ac77bdf68bd709b7bbd2469c6' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 438'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=440 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=440 AND public_id='82ef63fe-7a67-4c02-9145-dea0daf8fcf8'::uuid AND version=1 AND md5(descripcion_larga)='8a60efbcf37bff1f82d2067722310790' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 440'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=451 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=451 AND public_id='fb4e9d28-1652-477e-b905-42972ef6c0a5'::uuid AND version=1 AND md5(descripcion_larga)='86a6c43783040057e5540fb1f9e65180' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 451'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=455 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=455 AND public_id='8ad49966-ad42-437a-9033-686fb2c5eb05'::uuid AND version=1 AND md5(descripcion_larga)='1526cce8b6006b4326311f7d0fe5081e' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 455'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=456 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=456 AND public_id='93008537-4ee1-48d7-83d4-93c47f3095da'::uuid AND version=1 AND md5(descripcion_larga)='b312b68b48f57bc52c9ef596acc46a5a' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 456'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=457 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=457 AND public_id='a64ab8be-76a1-4f9f-a047-4237671ab53d'::uuid AND version=1 AND md5(descripcion_larga)='c424a4c1a48aa1a7c2d07f34861dde1c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 457'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=463 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=463 AND public_id='6f635e53-4633-4fe0-831b-0b5d3ce1da7b'::uuid AND version=1 AND md5(descripcion_larga)='3c03eeca1c56917af37afb0d83c521d5' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 463'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=467 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=467 AND public_id='cb393d0a-2749-4839-85ad-ff617b2ac5f1'::uuid AND version=1 AND md5(descripcion_larga)='06825638161021b20b095204469561e7' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 467'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=474 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=474 AND public_id='5ccc92c6-1cf2-4343-9e30-4b1dbabb7168'::uuid AND version=1 AND md5(descripcion_larga)='ae0a2c06bc89e99a43511f29fcc38682' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 474'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=477 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=477 AND public_id='06e92527-a183-4b37-9481-c88011de170b'::uuid AND version=1 AND md5(descripcion_larga)='2ff74543b2f99338e3cb1dc947468f6a' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 477'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=481 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=481 AND public_id='8595e873-ce70-4269-bf04-2ccaff04662c'::uuid AND version=1 AND md5(descripcion_larga)='81547ef088ea18b02ca641f6661e6358' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 481'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=486 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=486 AND public_id='e531d2dc-9bfb-4f55-890e-8da5c0362556'::uuid AND version=1 AND md5(descripcion_larga)='afb8463a8060690acee1a925c0918f48' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 486'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=490 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=490 AND public_id='fa4f6465-132e-4722-aede-f9dd25d63cd7'::uuid AND version=3 AND md5(descripcion_larga)='b94edc8dc59e67e1681fa03eaeb38cc9' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 490'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=494 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=494 AND public_id='963b7c61-9e4b-46f5-8bc4-379299acfc03'::uuid AND version=1 AND md5(descripcion_larga)='840e3f6e00a0357270860a1b330e8573' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 494'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=497 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=497 AND public_id='63070a6e-b29d-47f6-b9c4-9c82cee9c72d'::uuid AND version=1 AND md5(descripcion_larga)='511a1a89c12fd0ca214bf39efa857976' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 497'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=500 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=500 AND public_id='a9fc3ffc-dfee-405c-8334-806d65e7c499'::uuid AND version=3 AND md5(descripcion_larga)='2180f12fa017ea7cc269591a041aa391' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 500'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=501 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=501 AND public_id='29c288d8-3e4b-48d8-aa66-da6bcffd0a32'::uuid AND version=1 AND md5(descripcion_larga)='47a5b37ed90d243f876b4ddb60bcc9f1' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 501'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=504 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=504 AND public_id='b220d9ed-b064-4f12-8553-fc079bd85f53'::uuid AND version=1 AND md5(descripcion_larga)='36bde6c7886fbd12199c353bfa6e1f68' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 504'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=505 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=505 AND public_id='51d66b19-417a-4121-9791-ae9548f60718'::uuid AND version=1 AND md5(descripcion_larga)='cbabb4290082cc4d925a29541cddfcd3' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 505'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=507 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=507 AND public_id='75e41376-08d6-4002-8ca2-605a95225b2c'::uuid AND version=1 AND md5(descripcion_larga)='973f17669f34ae6a15a40db9655a4e81' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 507'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=508 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=508 AND public_id='3bf8f23b-f3d9-460e-9698-2e11e06653fc'::uuid AND version=1 AND md5(descripcion_larga)='7993e65771a35a821962e67b951c0484' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 508'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=509 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=509 AND public_id='23daf499-8c7c-4dc7-9a92-3dac13c5a533'::uuid AND version=1 AND md5(descripcion_larga)='f117a8060da3efc6e1fa8b948ce6d102' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 509'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=513 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=513 AND public_id='78861a79-69c6-4e9f-9045-fcdfc4f40039'::uuid AND version=3 AND md5(descripcion_larga)='95c89bce9d1e0df81c4c99f1070a300e' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 513'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=515 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=515 AND public_id='a9b513db-98c2-462b-afe1-02a6c84b24a6'::uuid AND version=1 AND md5(descripcion_larga)='b0b7d65a896874fec12b8855e0239217' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 515'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=520 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=520 AND public_id='c16d155f-4014-4769-b4cc-2a9f1a1052f8'::uuid AND version=1 AND md5(descripcion_larga)='6442f1617dc56143da5b4d88dedf1dc9' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 520'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=523 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=523 AND public_id='ba95a166-513e-4aac-999b-edf175edac44'::uuid AND version=1 AND md5(descripcion_larga)='78896e0c456d7b836dc0caef4802e0ac' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 523'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=525 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=525 AND public_id='2b63ca1f-90f6-4a5f-8776-f27a951295c0'::uuid AND version=1 AND md5(descripcion_larga)='103ae664574911a53eaa6f34dbfbb756' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 525'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=528 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=528 AND public_id='75c283b9-ad88-47c7-9e36-2a52051dcd98'::uuid AND version=3 AND md5(descripcion_larga)='98ecc00cc5c78321cf8d604c287de898' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Ficha modificada 528'; END IF;
END $guardas$;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El PLADECO 2023–2026 y los antecedentes 2015/2017 identifican apoyo superior; no acreditan importe ni recepción de una convocatoria actual. El portal nuevo devuelve 406 y el dominio antiguo tiene certificado incompatible. No se reemplaza por ayudas escolares.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://munipapudo.cl/beneficios-y-tramites/beneficios-y-programas ; https://munipapudo.cl/images/PLADECO/Plan%20Desarrollo%20Comunal.pdf ; https://www.municipalidadpapudo.cl/Archivos/cuenta_publica/cuenta_publica_2017.pdf ; https://www.municipalidadpapudo.cl/portal/planes/plan_de_salud_2015.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=1;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La cuenta 2021 acredita ejecución histórica y gasto agregado; no publica condiciones de recepción 2026. Se rechazan resultados de Pudahuel por contener una dirección llamada La Estrella.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munilaestrella.cl/Documentos/CUENTA_PUBLICA_LA_ESTRELLA_2021.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=2;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
El catastro oficial UCSC 2026, página 13, identifica aporte económico para continuidad superior en Lebu. No especifica importe ni calendario; no equivale a la exención nacional de inscripción PAES.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://direcciones.ucsc.cl/content/uploads/sites/35/2026/01/Becas-Municipales-2026.pdf ; https://lebu.cl/municipalidad/ ; https://www.ventanillaunicasocial.gob.cl/ficha/260/beca-prueba-admision-educacion-superior
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,nombre='Beca municipal de educación superior de Lebu' WHERE id_beca=3;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La búsqueda de Nuevo Milenio II para admisión 2027 no recuperó bases específicas adicionales. No trasladar condiciones de otras modalidades Nuevo Milenio ni considerar el calendario general FUAS prueba suficiente de sus condiciones particulares.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-nuevo-milenio-bnm
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=17;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La cuenta pública y DIDECO permiten distinguir apoyo mensual superior y premio PAES. Los fondos para organizaciones de 2026 no son convocatoria estudiantil; no se confirma calendario nuevo ni se suman prestaciones distintas.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.municombarbala.cl/departamento-desarrollo-comunitario-dideco/ ; https://www.municombarbala.cl/wp-content/uploads/2025/04/eSdcvc_dfer989dfXXs02.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=19;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El decreto 494/2023 se recuperó como escaneo; no hay calendario actual legible en el expediente. El portal ofrece llamados laborales, que no sustentan apertura de esta beca.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://imcolchane.cl/web/ ; https://www.imcolchane.cl/documentos/inde/DECRETO%20494%202023.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=21;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se conserva alcance PAES del reglamento 2026. La página nueva de renovantes y la matrícula de 2027 no bastan para certificar una nueva asignación PAES ni trasladar puntajes de otra cohorte.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.admisionmayor.cl/becas-y-creditos ; https://www.umayor.cl/um/bundles/umayor/descargables/um/Reglamento-Sistema-de-Apoyo-y-Becas-2026.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=26;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La cuenta 2024 reúne estudiantes medios y superiores y gasto global. Talento para el Futuro vinculado a BHP/Spence es una pista diferente; no se equipara a la beca municipal ni se divide el presupuesto entre beneficiarios.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://mejillones.cl/wp-content/uploads/2025/05/CUENTA-MEJILLONES-WEB.pdf ; https://www.mejillones.cl/wp-content/uploads/2010/09/Cuenta-P%C3%BAblica-2009.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=27;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El acta 898 de marzo de 2013 documenta convenio SIPEE con la Universidad de Chile. La orientación FUAS 2026 no demuestra convocatoria vigente del convenio ni autoriza generalizarlo a cualquier institución.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://transparencia.laserena.cl/documentos/898_06-03-2013_11-25-56_O.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=33;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Los dos documentos municipales 2026 devuelven 406. La búsqueda actual no recupera bases estudiantiles equivalentes. Se conserva incertidumbre; no se declara inexistente el programa.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://sitio.munilautaro.cl/wp-content/uploads/2026/02/PROGRAMA-ESTUDIANTIL.pdf ; https://sitio.munilautaro.cl/wp-content/uploads/2026/02/DD_4701654_260316_P.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=34;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El convenio IP Diego Portales del catastro Ude C 2024 es distinto de una mantención general. Se mantienen alcance histórico y modalidad; no se prueba renovación de cupos 2026.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.hualpenciudad.cl/wp-content/uploads/2023/04/Cuenta-Publica-de-la-Gestion-del-ano-2022-Alcalde-y-marcha-Municipalidad-de-Hualpen-Reducido_compressed.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=37;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
Bases 2026 enlazadas por el portal municipal: primer semestre 16/02–16/03; segundo 13/07–13/08. La apelación anunciada el 01/09 exige documentos antes del lunes 7 de septiembre; no es reapertura general. Aporte $78.000 mensuales hasta diez meses; ambos períodos ordinarios concluidos.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://drive.google.com/uc?export=download&id=1gMYtnnvvlLhGqRSaG16j6f--wdidTeVe ; https://drive.google.com/uc?export=download&id=1js1ESDS7oum2CAKJsNv3QWRY1klxyJas ; https://municipalidadcisnes.cl/ ; https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-07-13',fecha_cierre_postulacion=DATE '2026-08-13',monto_cobertura='78.000 CLP mensuales, hasta diez meses; bases municipales 2026.',cobertura_tipo='MONETARIA',cobertura_importe=78000.00,cobertura_moneda='CLP',cobertura_periodicidad='MENSUAL',cobertura_porcentaje=NULL,url_oficial='https://sites.google.com/municipalidadcisnes.cl/becasmunicipales/inicio' WHERE id_beca=44;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
La noticia municipal del 18/02/2026 y su afiche acreditan mantención para residentes de básica, media, especial y superior con vulnerabilidad. El afiche revisado no contiene cierre. La entrega de julio no fija plazo de postulación ni importe individual.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://municipalidadpanguipulli.cl/wp-content/uploads/2026/02/beca-estudiantes.jpg ; https://municipalidadpanguipulli.cl/archivos/45837 ; https://municipalidadpanguipulli.cl/archivos/48401
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=47;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El PDF municipal de becas de estudio y la corporación presentan barreras de certificado. La referencia CFT Massachusetts no prueba convocatoria actual; se rechaza Villa Alegre aunque pertenezca a provincia de Linares.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.corporacionlinares.cl/utilidad/becas_estudios.pdf ; https://www.corporacionlinares.cl/index.php/ver_noticia/810
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=49;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La cuenta 2023 describe aporte semestral y egreso de escuelas municipales. La noticia periodística de 2026 no sustituye bases oficiales; calendario y condiciones actuales siguen sin acreditarse.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://limache.cl/wp-content/uploads/2024/04/cuenta_publica_gestion_2023.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=50;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Los resultados municipales corresponden a 2025 y a ingreso superior de esa edición. El sitio personal de una autoridad sobre entrega 2026 no se utiliza como bases municipales ni se interpreta adjudicación como recepción abierta.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.paine.cl/resultados-becas-educacion-superior-2025/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=51;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La rectificación presupuestaria 2024 y el formulario 2025 distinguen arancel y transporte. No acreditan calendario 2026; una fecha presupuestaria no es cierre de solicitudes.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.colina.cl/beneficiarios-proceso-de-becas-educacion-superior-2025/ ; https://transparencia.colina.cl/archivos/cf73484-0779.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=52;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El boletín agosto 2024 indica retiro de pagos del 06/08 al 04/09, no postulaciones. El portal con RUT no se consulta con datos personales; no se traslada una beca deportiva a mantención superior.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://media.mpudahuel.cl/web/media/boletines/2024/08/la-estrella-de-pudahuel-ed-17-agosto-2024.pdf ; https://dideco.mpudahuel.cl/app/tramites/home.asp
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=55;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El manual histórico no se recuperó. Beca TIC y Beca Dorada INACAP para mayores tienen destinatarios distintos; no confirman la ayuda municipal superior genérica.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://web.sanmiguel.cl/category/educacion/ ; https://web.sanmiguel.cl/Manual-Ayudas-Sociales-2019.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=57;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La guía 2024–2025 de Banco Pyme corresponde a emprendimiento, no al incentivo superior histórico. El llamado de Radio San Joaquín de marzo 2026 se conserva como pista sin equivalencia oficial verificada.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://sanjoaquin.cl/wp-content/uploads/2025/01/GUIA-SERVICIOS_2024-2025.pdf ; https://www.uahurtado.cl/wp-images/uploads/2022/03/BENEFICIOS-ESTUDIANTILES-ADMISION-2022.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=60;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La guía 2024–2025 de Banco Pyme corresponde a emprendimiento, no al incentivo superior histórico. El llamado de Radio San Joaquín de marzo 2026 se conserva como pista sin equivalencia oficial verificada.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://sanjoaquin.cl/wp-content/uploads/2025/01/GUIA-SERVICIOS_2024-2025.pdf ; https://www.uahurtado.cl/wp-images/uploads/2022/03/BENEFICIOS-ESTUDIANTILES-ADMISION-2022.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=63;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El documento 2025 de transporte de $100.000 y 60 cupos no identifica necesariamente esta ayuda superior general. No se trasladan sus meses de gestión a una convocatoria 2026.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://munitiltil.cl/wp-content/uploads/2025/04/BECA-MUNICIPAL-DE-TRANSPORTE-2025-PROGRAMA-PRESENTACION.pdf ; https://munitiltil.cl/wp-content/uploads/2023/04/CUENTA-PUBLICA-2022-21.04.23.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=64;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Las contrataciones PAES de Mercado Público son compras de preparación académica. Su cierre de ofertas no constituye plazo para estudiantes ni acredita un aporte monetario municipal superior.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.mercadopublico.cl/Procurement/Modules/RFB/DetailsAcquisition.aspx?idlicitacion=4993-32-LE25 ; https://legalpython.com/municipalidades/cholchol/padems/PADEM_2021.pdf ; https://surinformado.cl/entrega-becas-cholchol-2025/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=68;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CALENDARIO_POR_MODALIDAD.
Reglamento municipal 2026, secciones V y VIII: las fechas semestrales/anuales se comunicarán por circular; postulación anual en enero y seguimiento en julio/agosto. La noticia de mayo acredita $20.000 mensuales marzo–diciembre. No hay día de cierre acreditado; premio PAES y deportiva son modalidades separadas.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://transparencia.tome.cl/8/1386.pdf ; https://www.tome.cl/transparencia/reglamentos ; https://www.tome.cl/noticias/municipalidad-entrego-becas-de-educacion-superior-a-400-estudiantes-
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=79;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La ficha corresponde a BEA de Mineduc, no a la Complementaria UCSH del 20%. El instructivo UCSH de 2014 no acredita por sí solo la convocatoria ministerial actual; no se sustituye la identidad.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://zonaestudiantes.ucsh.cl/documentos/Instructivo_GraL_Ayudas_Estudiantiles_UCSH.pdf ; https://admisionucsh.cl/becas-y-beneficios/ ; https://www.ucsh.cl/becas-y-beneficios/ ; https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-excelencia-academica-bea ; https://portal.beneficiosestudiantiles.cl/sites/default/files/20250909_38501_decreto-97_09-oct-2013_actualizacion_2025.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=83;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La ordenanza histórica conserva PAA y varias modalidades. Las entregas municipales no publican recepción anual actual; no se traducen puntajes PAA a PAES ni se convierten meses de pago en cierres.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.chiguayante.cl/transparencia/2017/7_ACTOS%20Y%20RESOLUCIONES%20CON%20EFECTOS%20SOBRE%20TERCEROS/ORDENANZAS/19%20Para_otorgamiento_de_Becas_a_estudiantes_destacados.pdf ; https://chiguayante.cl/Chgte/?page_id=161
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=90;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CALENDARIO_POR_MODALIDAD.
Bases Melipeuco 2026: nuevos y renovantes en junio/julio; segunda cuota de renovantes en noviembre. La página 7 dice viernes 15 de julio aunque ese día de 2026 fue miércoles. Además aparece pago el imposible 31 de noviembre. Se documentan ambas anomalías y no se fabrican fechas correctoras ni se activa noviembre sin plazo preciso.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://municipalidadmelipeuco.cl/wp-content/uploads/2026/06/DECRETO-Y-BASES-BECA-MUNICIPAL.pdf ; https://municipalidadmelipeuco.cl/category/comunidad/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=91;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La referencia de residencia UPLA es histórica y no acredita cupos ni calendario actual. La publicación futura de servicios y beneficios 2027 anunciada para noviembre no constituye convocatoria de residencia ya publicada.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://upla.cl/vinculacion/wp-content/uploads/2018/12/Informe-AUI-Institucional-UPLA-2016-29-02-2016.pdf ; https://www.upla.cl/transparencia/wp-content/uploads/2016/12/2016_1210_beneficiarios_nov-2016__dto_exto_1426-2016.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=92;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
Bases BIES marzo 2026, apartados de beneficio y calendario: $200.000 en pago único del primer semestre; recepción del 16/03 a las 08: 30 al 17/04 a las 11: 59. RSH 40–80%; ingreso desde media 5, 5 y continuidad 5, 0. No se utiliza FOCMU, que es otro fondo.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://melipilla.cl//wp-content/archivos/2026/03/BASES-FINALES-BIES-MARZO-2026.pdf ; https://becas.melipilla.cl/ ; https://melipilla.cl/beca-de-incentivo-escolar-2026/ ; https://melipilla.cl/alcaldesa-paula-garate-llama-a-estudiantes-melipillanos-a-postular-a-beca-de-incentivo-a-la-educacion-superior/ ; https://melipilla.cl/municipio-de-melipilla-entrego-beca-de-incentivo-a-la-educacion-superior-a-mas-de-2-mil-estudiantes-de-la-comuna/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-03-16',fecha_cierre_postulacion=DATE '2026-04-17',monto_cobertura='200.000 CLP en un pago único del primer semestre; bases BIES marzo 2026.',cobertura_tipo='MONETARIA',cobertura_importe=200000.00,cobertura_moneda='CLP',cobertura_periodicidad='UNICA',cobertura_porcentaje=NULL,url_oficial='https://melipilla.cl//wp-content/archivos/2026/03/BASES-FINALES-BIES-MARZO-2026.pdf' WHERE id_beca=93;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CALENDARIO_POR_MODALIDAD.
Reglamento municipal 2026, secciones V y VIII: las fechas semestrales/anuales se comunicarán por circular; postulación anual en enero y seguimiento en julio/agosto. La noticia de mayo acredita $20.000 mensuales marzo–diciembre. No hay día de cierre acreditado; premio PAES y deportiva son modalidades separadas.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://transparencia.tome.cl/8/1386.pdf ; https://www.tome.cl/transparencia/reglamentos ; https://www.tome.cl/noticias/municipalidad-entrego-becas-de-educacion-superior-a-400-estudiantes-
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=96;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La cuenta 2023 describe 135 aportes de $80.000; la pista 2024 informa otro monto agregado. Ninguna acredita recepción 2026; no se usa una cuenta pública como llamado nuevo.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.municipalidadgorbea.cl/transparencia/images/ArchivosHOME/Cuenta%20Publica/Cuenta%20p%C3%BAblica%202023.pdf ; https://www.municipalidadgorbea.cl/transparencia/images/pdf/cp2016.pdf ; https://www.municipalidadgorbea.cl/transparencia/images/acta_17.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=100;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CALENDARIO_POR_MODALIDAD.
Decreto UNAP 10-0329-26 de 11/03/2026, arts. 4, 6, 8 y 10–14: mérito 40/60/100% por tramos 750–800/801–850/851+. Asignación y renovación anual tienen calendarios DGAE; artículo transitorio conserva reglas de renovantes anteriores. No se acredita cierre 2027.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://transparencia.unap.cl/activa/web/index.php?a=2026&action=plantillas_generar_archivo&ia=9448&ig=97&m=3 ; https://www.unap.cl/mk/prontus_unap/vice_academica/de_1312_aprueba_texto_refundo_reglamento_becas_deja_sin_efecto_de_510_2014.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=101;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La ordenanza histórica conserva PAA y varias modalidades. Las entregas municipales no publican recepción anual actual; no se traducen puntajes PAA a PAES ni se convierten meses de pago en cierres.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.chiguayante.cl/transparencia/2017/7_ACTOS%20Y%20RESOLUCIONES%20CON%20EFECTOS%20SOBRE%20TERCEROS/ORDENANZAS/19%20Para_otorgamiento_de_Becas_a_estudiantes_destacados.pdf ; https://chiguayante.cl/Chgte/?page_id=161
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=102;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La cuenta 2024 y la de 2020 se distinguen de la tabla histórica de beneficiarios de 2014. El portal actual de concursos contiene empleos; no confirma una convocatoria estudiantil 2026.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://muniolivar.cl/wp-content/uploads/2026/04/CUENTA-PUBLICA-2024-OLIVAR.pdf ; https://muniolivar.cl/wp-content/uploads/2024/02/CUENTA-PUBLICA-2020-OLIVAR.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=105;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El beneficio deportivo UPLA publicado históricamente no se actualiza con el calendario general de admisión 2027. No hay convocatoria deportiva nueva específica recuperada.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.upla.cl/admision/2025/01/21/preguntas-frecuentes-sobre-el-proceso-de-admision-y-matricula-2025/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=110;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El aviso de Beca Centenario es de abril de 2023, con errata 20203 y renovación de 2022. La beca deportiva de agosto 2026 es otro programa; no autoriza actualizar el año del incentivo superior.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://municipiocabildo.cl/noticias/hasta-el-11-de-mayo-tienen-plazo-los-estudiantes-cabildanos-para-postular-a-la-beca-centenario-para-la-educacion-superior/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=117;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El catastro UCSC anterior identifica expresamente presupuesto 2025 y recepción marzo–abril. El compilado 2026 no incluye Alto Biobío en el apartado localizado; no se extrapola el calendario histórico ni se usa prensa como confirmación.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf ; https://direcciones.ucsc.cl/content/uploads/sites/35/2026/01/Becas-Municipales-2026.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=121;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El documento Mineduc de matrícula 2026 y el de servicios separan matrícula de mantenimiento. El encabezado de admisión 2027 no fija por sí solo condiciones ni cierre de la beca de matrícula individual.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.uvm.cl/wp-content/archivos/politica-financiamiento-estudiantil.pdf?v=3801236 ; https://acceso.mineduc.cl/wp-content/uploads/2025/11/SERV-Y-BENEF-2026-181125.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=124;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
El catastro UCSC 2026, página 3, confirma aporte de libre disposición para residentes matriculados en carreras profesionales y técnicas. No publica importe ni plazo. Los $500.000 y las incompatibilidades del antecedente 2020 no se presentan como reglas 2026.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://direcciones.ucsc.cl/content/uploads/sites/35/2026/01/Becas-Municipales-2026.pdf ; https://munilosalamos.cl/noticias/partio-la-postulacion-la-beca-municipal/ ; https://munilosalamos.cl/noticias/18322llm1/ ; https://munilosalamos.cl/noticias/18-02-2020-1/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,monto_cobertura='Aporte económico de libre disposición para estudiantes superiores residentes. Catastro UCSC 2026: importe y periodicidad no especificados; los montos de 2020 son históricos.',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad='DESCONOCIDA',cobertura_porcentaje=NULL,cobertura_tipo='MONETARIA' WHERE id_beca=125;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La subvención municipal 2026 es para organizaciones y la cuenta 2011 tiene alcance histórico. Los concursos INDAP son laborales; no se usan sus plazos como beca superior.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://imputre.cl/subvencion-2026/ ; https://imputre.cl/transparencia/archivos_muni/CUENTA%20PUBLICA%202011.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=126;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La tabla de trámites señala NEM 5, 3 y requisitos desde febrero; el reglamento modificado 2021 indica 5, 5. No hay cierre anual ni acto nuevo que resuelva esa diferencia; se conserva expresamente la contradicción.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.muermos.cl/transparencia2.0/images/A._Transparencia_2021/Modificaciones/salud/Reglamento_de_Subsidio_Municipal_2021_MODIFICADO.pdf ; https://transparencia.muermos.cl/index.php?Itemid=101&id=1701%3Atramites-ante-la-municipalidad-de-los-muermos&option=com_phocadownload&view=category
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=127;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El portal Peñaflor conserva categoría de becas y errores de aplicación; el llamado deportivo 2026 es distinto. No se acredita recepción del incentivo superior ni continuidad del monto histórico.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://penaflor.cl/tramites/ ; https://penaflor.cl/postulacion-becas-deportivas-2026/ ; https://penaflor.cl/wp-content/uploads/2022/04/CTAPCA-2021_ABR2022-C.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=129;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La residencia JUNAEB y el ingreso especial 2027 son distintos de residencia interna UCT. La página de DCR no se recupera; no hay calendario o cupos propios confirmados.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://admision.uct.cl/becas-y-creditos/ ; https://dge.uct.cl/beneficios-internos/ ; https://acreditacion.uct.cl/wp-content/uploads/Informe-Autoevaluacion-2024.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=130;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CALENDARIO_POR_MODALIDAD.
UNAP 10-0329-26, arts. 27–33: mérito deportivo 60/80/100% según nivel evaluado; al menos tres competencias, buena conducta, representación exclusiva y evaluación institucional. Nuevos y renovantes se rigen por sus normas; fechas anuales DGAE sin cierre preciso publicado en este decreto.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://transparencia.unap.cl/activa/web/index.php?a=2026&action=plantillas_generar_archivo&ia=9448&ig=97&m=3 ; https://www.unap.cl/mk/prontus_unap/vice_academica/de_1312_aprueba_texto_refundo_reglamento_becas_deja_sin_efecto_de_510_2014.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,monto_cobertura='60%, 80% o 100% del arancel según nivel deportivo evaluado; decreto UNAP 10-0329-26, art. 30. Renovantes anteriores conservan sus reglas.',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=NULL,cobertura_tipo='PORCENTUAL' WHERE id_beca=134;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El DOCX Apoyo 2026 confirma $100.000 únicos, RSH hasta 60%, NEM 5, 5 o notas superiores 5, 0; distinto de Fray 1, 5 UTM mensuales. La sección VI escribe 09–31 marzo 14: 00 y a la vez con fecha a definir. Se completan requisitos, pero se conserva calendario inconcluso por la redacción contradictoria.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munimulchen.cl/wp-content/uploads/2026/03/06.-BECA-DE-APOYO-PARA-EL-ESTUDIANTE-NIVEL-TECNICO-Y-SUPERIOR-2026.docx ; https://www.munimulchen.cl/becas-estudiantiles-2026/ ; https://www.munimulchen.cl/wp-content/uploads/2026/03/04-BECA-FRAY-PADRE-MANERA.docx
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=139;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página de vinculación municipal no se recuperó. Una beca del Colegio Talcahuano para 2027 no es la beca municipal superior; no se reemplazan sus destinatarios.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://web2026.talcahuano.cl/centro-de-servicios/jovenes/vinculacion-con-el-medio ; https://www.talcahuano.cl/adm/imagenes/ckfinder/files/06%20PLADECO%202024-2027%20%20I_MUNICIPALIDAD%20DE%20TALCAHUANO.pdf ; https://www.talcahuano.cl/adm/imagenes/ckfinder/files/CP%202024%20MUNICIPALIDAD%20DE%20TALCAHUANO.pdf ; https://www.talcahuano.cl/adm/imagenes/ckfinder/files/07%20-%20Convenios%20Celebrados.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=141;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El aviso Arica de abril 2026 documenta ejecución PRFE y familias tutoras, no un cierre para estudiantes nuevos. No se usa convocatoria de tutores ni reglamento de Polimetales como calendario de este beneficio.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.ventanillaunicasocial.gob.cl/ficha/125/programa-residencia-familiar-estudiantil-educacion-superior ; https://www.muniarica.cl/noticias/publicacion/municipalidad-lanza-programa-de-residencia-familiar-estudiantil-que-beneficiara-a-jovenes-vulnerables-de-zonas-alejadas-con-apoyo-integral
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=142;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se recuperaron bases específicas de Saavedra 2025; el año y la población quedan delimitados. La guía 2022 y resultados de Saavedra Argentina no acreditan convocatoria 2026 en Chile.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://munisaavedra.cl/wp-content/uploads/2025/05/BASES-BECA-MUNICIPAL-ANO-2025.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=147;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página actual INACAP distingue becas internas y promociones de matrícula. No se equipara BECH ni articulación con la modalidad escolar Mérito del antecedente 2020, seleccionada por establecimiento.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://portal.inacap.cl/financiamiento-estudiantil/becas ; https://portal.inacap.cl/w/inacap-osorno-reconoci%C3%B3-a-titulados-destacados-por-su-excelencia-acad%C3%A9mica-en-ceremonia-de-m%C3%A9rito-acad%C3%A9mico-2025 ; https://portales.inacap.cl/noticias/noticias-inacap/2020/nunoa-20/becas-al-merito-inacap-2020-beneficia-a-alumno-del-liceo-industrial-chileno-aleman-de-nunoa-?page=390
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=148;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El portal enumera procedimiento y ordenanza de marzo 2023 actualizada 2026; no aporta en el texto leído convocatoria con fecha anual. El listado de procedimientos no equivale a apertura de solicitudes.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://serviciosantuco.cl/procedimientos_administrativos.php ; https://serviciosantuco.cl/transparencia_detalle.php?id=35 ; https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=149;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El conjunto de datos de Puente Alto contiene años cursados y adjudicaciones. La instancia beneficios-develop no tiene procedencia pública enlazada verificada; no se usa como llamado oficial ni se ingresan datos personales.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://datos.mpuentealto.cl/datasets/197869/beca-municipal-de-educacion-superior-ano-a-cursar/ ; https://datos.mpuentealto.cl/search/?account=&category=Becas+Municipales&q=%25&resource=db ; https://www.mpuentealto.cl/estudiantes-de-puente-alto-reciben-beca-municipal-de-educacion-superior/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=157;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La ficha particular de ingreso NEM y las reglas generales de admisión mantienen alcance distinto. El reglamento 2025–2026 localizado devuelve 404; no se declara resuelta la elegibilidad 2027 con un encabezado publicitario.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.udd.cl/admision-pregrado/becas/?udd_beca=193551 ; https://www.udd.cl/admision-pregrado/becas/?udd_beca=172769 ; https://acceso.mineduc.cl/wp-content/uploads/2025/11/SERV-Y-BENEF-2026-181125.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=158;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El acta 2023 documenta ejecución del aporte municipal; transporte TER y becas deportivas 2026 son programas diferentes. No hay bases actuales de la misma modalidad acreditadas.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://municipalidadsantacruz.cl/transparencia/DirectorioConsejo/Actas%20Sesion%20Ordinaria/2023/Acta%20Sesion%2069.pdf ; https://www.transparenciasantacruz.cl/potestades-marco-normativo/marco-normativo ; https://drive.google.com/file/d/1VgqB3r8QExCgL2zlmeO4fYzebWJ22yyp/view
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=164;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CALENDARIO_POR_MODALIDAD.
Decreto UNAP marzo 2026 reemplaza art.38 y suprime 39 bis: tarjeta electrónica alimenticia mensual para quienes no reciben BAES; monto sujeto al acto anual. No se confunde con complemento monetario de arts.40–41 para beneficiarios BAES. Renovantes previos mantienen sus reglas según transitorio; fechas exactas no publicadas.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://transparencia.unap.cl/activa/web/index.php?a=2026&action=plantillas_generar_archivo&ia=9448&ig=97&m=3 ; https://www.unap.cl/prontus_unap/site/docs/20210304/20210304163151/instructivo_de_beneficios_externos_e_internos_2024.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,monto_cobertura='Tarjeta electrónica personalizada para alimentos, con crédito mensual; importe anual por definir. Sin BAES; decreto UNAP 10-0329-26, arts. 38–39.',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad='MENSUAL',cobertura_porcentaje=NULL,cobertura_tipo='MONETARIA' WHERE id_beca=165;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La convocatoria de residencia 2026 del 10–23 agosto y $200.000 tiene objeto específico; no se traslada a la beca municipal general 2025 de estas fichas. El decreto de entrega 2025 es escaneado y no acredita una nueva recepción general.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://muniteodoro.cl/portal/2026/08/06/%F0%9F%8E%93%F0%9F%8F%A0-postula-a-la-beca-de-residencia-estudiantil-educacion-superior-2026/ ; https://muniteodoro.cl/portal/wp-content/uploads/2025/07/DAE-1015-APRUEBA-ACTA-Y-ENTREGA-BECA-MUNICIPAL-2025.pdf ; https://muniteodoro.cl/portal/wp-content/uploads/2025/04/REQUISITOS-BECA-MUNICIPAL-EDUCACION-SUPERIOR.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=168;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El enlace de descarga mantiene barrera; organigrama y prensa 2020 no proporcionan bases específicas actuales. Se conserva la beca histórica con calendario desconocido.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.comunaparedones.cl/index.php/descargas/transparencia-historica/category/59-beca-ensenanza-superior?download=1791:benca-ensenanza
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=172;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
La página actual AIEP de financiamiento confirma segunda carrera para titulados AIEP nuevos: matrícula sin costo y 10% del arancel del primer año; certificado de título y cupos limitados. No publica apertura/cierre específicos para este apoyo. No trasladar apertura pendiente de AIEP Mayor o Mujer STEM.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.aiep.cl/admision/becas-y-financiamiento/ ; https://www.aiep.cl/noticias/conoce-a-que-becas-puedes-optar-para-estudiar-en-aiep/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,monto_cobertura='Matrícula sin costo y 10% de descuento en el arancel del primer año de una segunda carrera para titulados AIEP nuevos; certificado de título y cupos limitados.',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=10.00,cobertura_tipo='PORCENTUAL' WHERE id_beca=173;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página USS tiene título 2027 y texto de la Beca USS que dice primer semestre 2026. No se elige una cohorte por el encabezado ni se confunde con Excelencia 20%; permanece contradicción temporal.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://admision.uss.cl/becas-y-financiamiento
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=174;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Ambas fichas remiten al mismo FAQ UPLA 2025 para Beca de Honor. Se registra coincidencia de programa sin borrar UUID; no se acredita reglamento o asignación 2027 con el anuncio general futuro.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.upla.cl/admision/2025/01/21/preguntas-frecuentes-sobre-el-proceso-de-admision-y-matricula-2025/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=175;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El instructivo UCSH recuperado sigue fechado 24/06/2014 y remite a resolución 2013/056 para personal, cónyuges e hijos. No publica porcentaje o calendario 2026; recuperación del PDF cifrado no actualiza su año.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://zonaestudiantes.ucsh.cl/documentos/Instructivo_GraL_Ayudas_Estudiantiles_UCSH.pdf ; https://admisionucsh.cl/becas-y-beneficios/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=177;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
Se recuperó ficha oficial Beca Excelencia Municipal de Natales: fondos municipales para jóvenes superiores con rendimiento académico; trámite presencial en marzo. No especifica año, día de cierre ni monto; no se anuncia como abierta.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://portal.muninatales.cl/social/beca-excelencia-municipal/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=193;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se recuperaron noticias municipales históricas de 601 y 80 beneficiarios. La noticia 2017 no acredita calendario 2026; la pista de acuerdo 2026 en Monitor Municipios no se usa sin el acto primario correspondiente.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.perquenco.cl/perquenco-ha-beneficiado-a-601-alumnos-con-beca-municipal-para-la-educacion-superior/ ; https://www.perquenco.cl/80-becas-por-rendimiento-academico-fueron-entregadas-a-estudiantes-de-nuestra-comuna/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=198;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La contratación de preuniversitario de Llay Llay no acredita la beca superior individual. Se conserva el antecedente municipal sin asumir que la fecha de licitación sea para estudiantes.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.mercadopublico.cl/Procurement/Modules/RFB/DetailsAcquisition.aspx?qs=kGDvPC8G0Hqw%2B3YyfIoLpQ%3D%3D
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=202;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se recuperaron PADEM 2007 y decreto de pago 2024 escaneado. Son antecedentes de ejecución; los fondos comunitarios 2026 no prueban convocatoria superior ni permiten actualizar su importe.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://muniriobueno.cl/uptransparencia/pdf/01_PDF_23/BECA%20MUNICIPAL%202024_C.pdf ; https://transparencia.muniriobueno.cl/index.php?d=EDUCACION&f=PADEM+2007.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=209;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La resolución 162/2023 recuperada identifica beca municipal y rendición de segunda cuota superior. No se actualiza a 2026 por compras de tarjetas escolares ni por un archivo Cloud sin procedencia municipal comprobada.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.recoletatransparente.cl/archivos_2023/programas_sociales/RES%20162_OCR.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=212;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
PLADECO 2025 acredita pagos y criterios 2023. La pista periodística de agosto 2026 no sustituyó bases oficiales; BCN no entregó texto legible. Convocatoria actual inconclusa.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://mtraiguen.cl/wp-content/uploads/2025/11/PLADECO-TRAIGUEN-2025-2025.pdf ; https://www.bcn.cl/leychile/navegar?idNorma=211823
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=213;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La ayuda alimenticia interna UPLA no se equipara con BAES. La documentación de admisión 2025 y el futuro catálogo 2027 no aportan cierre específico del beneficio interno.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://upla.cl/noticias/2011/06/22/respuestas-a-demandas-estudiantiles/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=214;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia OMAJ describe 19 aportes de$500.000 sin año inequívoco; la ficha DIDECO 2025 pp 18–20 es Beca Vocación de Profesor, y el aviso 2026 es artístico. Ninguno sustituye calendario de la beca superior original.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.municipalidadchillan.cl/sitio/descargas/DIDECO/FICHAS-SERVICIOS-DIDECO-2025.pdf ; https://www.municipalidadchillan.cl/sitio/index.php?not=5010 ; https://www.municipalidadchillan.cl/sitio/noticia.php?id=3147 ; https://pace.ubiobio.cl/wp-content/uploads/2024/07/Becas-Municipales-Nuble-Diguillin.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=216;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La reglamentación histórica Padre Hurtado de pregrado usa PAA y delega calendario anual. Premios UC de investigación homónimos no son esta beca; no se certifica postulación actual ni permanencia por nombre.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://registrosacademicos.uc.cl/wp-content/uploads/2021/11/padreHurtado.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=217;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El programa es reembolso municipal de matrícula; el beneficio BPR y concursos de funcionarios/deportistas tienen otro alcance. La cuenta 2023 presenta certificado no verificable; no se extrapolan plazos.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.mlicanten.cl/laip/Transparencia%20Municipalidad/Cuentas%20Publicas%20de%20Gestion/2023/Cuenta%20P%C3%BAblica%202023.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=218;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El portal actual Tucapel separa Profesionales del Futuro de Bono Movilización y Deportiva. El llamado de septiembre 2026 es movilización; no acredita recepción del aporte profesional ni su importe anual.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.municipalidadtucapel.cl/becas ; https://www.municipalidadtucapel.cl/news/article/id/2768 ; https://www.munitucapel.cl/admin/archivos/1764346563.pdf ; https://www.munitucapel.cl/filesglob/1773648567.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=219;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Nueva Ciudad se conserva como programa histórico de Graneros. Las becas estatales y servicios escolares DAEM no acreditan una convocatoria municipal superior de la misma modalidad.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.daemgraneros.cl/file/padem2019.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=221;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página actual UCentral exige inscripción y documentos 2026, pero no identifica por sí sola las reglas de copago técnico para cohortes 2016–2018 del informativo 2019. El reglamento enlazado no produjo texto utilizable; no se generalizan sus porcentajes a todo pregrado.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.ucentral.cl/postulacion-becas/ ; https://www.ucentral.cl/wp-content/uploads/2026/01/listado-de-documentos-postulacion-becas-2026.pdf ; https://www.ucentral.cl/ucentral/site/docs/20191218/20191218100048/informativo.pdf ; https://admision.ucentral.cl/becas-y-financiamiento/becas-ucen-aplicables-desde-primer-ano/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=222;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página UMayor de renovantes incluye revisión académica 2027, pero no demuestra una nueva convocatoria de copago ni modifica automáticamente las condiciones de admisión 2026. Se conserva alcance y diferencia nuevo/renovante.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.admisionmayor.cl/becas-y-creditos ; https://www.admisionmayor.cl/um/bundles/umayor/descargables/um/Reglamento-Sistema-de-Apoyo-y-Becas-2026.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=223;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La convocatoria de residencia 2026 del 10–23 agosto y $200.000 tiene objeto específico; no se traslada a la beca municipal general 2025 de estas fichas. El decreto de entrega 2025 es escaneado y no acredita una nueva recepción general.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://muniteodoro.cl/portal/2026/08/06/%F0%9F%8E%93%F0%9F%8F%A0-postula-a-la-beca-de-residencia-estudiantil-educacion-superior-2026/ ; https://muniteodoro.cl/portal/wp-content/uploads/2025/04/REQUISITOS-BECA-MUNICIPAL-EDUCACION-SUPERIOR.pdf ; https://muniteodoro.cl/portal/wp-content/uploads/2025/07/DAE-1015-APRUEBA-ACTA-Y-ENTREGA-BECA-MUNICIPAL-2025.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=226;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
Se verificaron decreto 617 de ampliación al 30/04/2026 y decreto 1013 del segundo llamado. Sus bases pp 2 y 4 fijan recepción 16–26/06/2026 hasta 14: 00; subsanación hasta 03/07 y rendición 11/12 no son nuevas postulaciones. Transporte es gasto admisible del incentivo, no una beca independiente.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://curarrehue.cl/on/wp-content/uploads/2026/06/Bases-para-segundo-llamado-Incentivo-a-la-Educacion-Superior-2026.pdf ; https://curarrehue.cl/on/wp-content/uploads/2026/06/Decreto-Exento-1013.pdf ; https://curarrehue.cl/on/wp-content/uploads/2026/04/Decreto-Exento-617.pdf ; https://curarrehue.cl/on/wp-content/uploads/2026/04/bases-incentivo-educacion-superior-2026.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-06-16',fecha_cierre_postulacion=DATE '2026-06-26',nombre='Beca Incentivo a la Educación Superior de Curarrehue',url_oficial='https://curarrehue.cl/on/bases-segundo-llamado-incentivo-a-laeducacion-superior-comuna-de-curarrehue/' WHERE id_beca=229;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La vía de ingreso deportivo PUCV y la beca deportiva financiera son controles diferentes. La página específica mantiene 403; no se trasladan plazos generales 2027 a la beca.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.pucv.cl/pucv/noticias/alumni/sin-miedo-a-los-peligros-del-deporte-extremo-de-alto-rendimiento ; https://movilmail.pucv.cl/pucv/noticias/destacadas/universidad-ofrecio-amplia-informacion-sobre-programas-formativos-en
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=231;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Las fuentes de Hogar Leiva Mella conservan diferencia 20/22 enero en antecedentes 2023. El calendario de admisión 2027 no es convocatoria de residencia; no se resuelve escogiendo arbitrariamente una fecha.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://dae.uach.cl/comienza-proceso-de-postulacion-a-residencias-estudiantiles-para-nuevos-as-estudiantes/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=233;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El decreto del expediente identifica Proceso 2014 pese al 2026 del nombre. La normativa de subvenciones 2025 es para organizaciones; no confirma condiciones actuales de Dr.Joaquín Contreras Silva.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.transparenciarequinoa.cl/nueweb/tact/requinoa/2014/secretaria%20municipal/7.-%20JULIO2014/DA1815.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=234;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La tabla UDP de DTE publica alcance 2026, sin reglas específicas 2027. No se usa la admisión especial general como plazo de esta beca; condiciones actuales de nueva cohorte por acreditar.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://admision.udp.cl/becas-y-beneficios/becas-y-beneficios-udp/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=236;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El reglamento interno enumera encargatura de San Juan y Educación Superior; el PDFsocial mantiene barrera DNS. No hay convocatoria individual 2026 acreditada por la mera existencia de la unidad.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.transparenciavicuna.cl/wp-content/uploads/2023/09/SOCIAL.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=240;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia recuperada del expediente es 27/05/2016 y cierra 31/05/2016. La búsqueda actual no aporta bases equivalentes; el pie del sitio 2026 no actualiza la noticia.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://portal.mph.cl/?p=11935
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=243;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El programa en transparencia presenta barrera DNS. La noticia Calle Larga de 2010 sigue siendo histórica aunque muestre noticias laterales 2026; FONDECO no es la misma beca.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.transparencia.callelarga.cl/Archivos/DeptoSocial/6.-Becas/Beca%20Pedro%20Aguirre%20Cerda/programa%20BECA%20PEDRO%20AGUIRRE%20CERDA.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=248;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El portal Peumo publica beneficiarios y afiche 2025; la noticia radial 2026 no se usa como bases primarias. No se confunde la fecha del archivo original con una convocatoria nueva.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://mpeumo.cl/page/2/?paged=2 ; https://mpeumo.cl/wp-content/uploads/2025/03/481277172_933850362293800_8297977883969411565_n.jpg
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=251;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La ficha corresponde al apoyo familiar UTA 5%, no a Ayuda Solidaria. El índice de transparencia recuperado no aporta norma familiar actual utilizable; no se sustituye beneficio por semejanza de nombre.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.uta.cl/transparencia/beneficios/ ; https://webdae.uta.cl/index.php/becas/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=257;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Copago Santo Tomás debe distinguir UST de IP/CFT y sus años. La admisión 2027 general y páginas de Colombia no certifican las condiciones de esta beca chilena.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.ipsantotomas.cl/estudiantes/financiamiento/beneficios-internos/becas-internas/ ; https://www.tupuedes.cl/becas-beneficios/ ; https://acceso.mineduc.cl/wp-content/uploads/2021/11/Pub-ServiciosyBeneficios-2022-11-25.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=260;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El enlace original de Rauco pertenecía a Arauco y ya fue retirado. La búsqueda municipal actual no identifica una beca equivalente; no se cambia comuna, no se borra UUID y no se afirma falsedad.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munirauco.cl/ ; https://beca.muniarauco.cl/login/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=261;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
La ficha oficial 2026 confirma aporte único$400.000; RSH 70%; cuarto medio 6, 0 o continuidad 5, 5; carreras de al menos cuatro semestres. Describe trámite digital, pero no fija fechas en el texto consultado; el enlace de formulario no acredita recepción abierta.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.municipalidadelbosque.cl/noticias-elbosque/el-bosque-inicia-las-postulaciones-a-la-beca-municipal-de-educacion-superior-2026/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=262;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El texto refundido UNAP 2026 enumera mérito, funcionario, rectoría, deporte, convenios y asistencia; no identifica la antigua Primera Preferencia del artículo 14/2014. No se considera esa ausencia prueba de eliminación, pero su aplicación actual no queda acreditada.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://transparencia.unap.cl/activa/web/index.php?a=2026&action=plantillas_generar_archivo&ia=9448&ig=97&m=3 ; https://www.unap.cl/mk/prontus_unap/vice_academica/de_1312_aprueba_texto_refundo_reglamento_becas_deja_sin_efecto_de_510_2014.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=263;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Residencia Estudia Tranquilo 2026 en Temuco tiene plazo 16–18 febrero y RSH 40%; no es la beca municipal monetaria general de 2025. Se mantienen separados beneficio y calendario.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munilossauces.cl/noticias/postulacion-a-residencia-estudiantil-2026-estudia--22964 ; https://www.munilossauces.cl/noticias/20479 ; https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=267;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El reglamento 208/2023 aplica a nuevos desde 2024 y conserva condiciones de antiguos; porcentajes se fijan anualmente. No basta la norma marco o la matrícula 2027 para certificar tabla de copago de una nueva edición.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.uautonoma.cl/content/uploads/2024/01/Reglamento-de-Becas-y-Creditos.pdf ; https://admision.uautonoma.cl/becas-y-creditos/becas-internas/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=273;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
La página oficial USM identifica expresamente Premio Puntaje Máximo PAES 2026, egreso 2025 e ingreso centralizado 2026; tabla y renovación verificables. No publica plazo específico nuevo 2027. Se conserva como referencia 2026 con fechas por confirmar, sin activación.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://usm.cl/admision/becas/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=276;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página actual de financiamiento UBO recuperada desarrolla ayudas estatales, no convenio empresarial individual. La existencia de convenios no prueba cupos, entidad ni calendario de este beneficio.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.ubo.cl/financiamiento-estudiantil/ ; https://admision.ubo.cl/financiamiento/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=279;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CALENDARIO_POR_MODALIDAD.
UNAP 2026 art.44 regula Subsidio Apoyo Residencia de$60.000 mensuales por semestre/año, con contrato de arriendo y requisitos generales. Art.43 Hogar Universitario es distinto. Arts.6, 8 ytransitorio separan nuevos y renovantes; cierre no publicado.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://transparencia.unap.cl/activa/web/index.php?a=2026&action=plantillas_generar_archivo&ia=9448&ig=97&m=3 ; https://www.unap.cl/prontus_unap/site/docs/20210304/20210304163151/instructivo_de_beneficios_externos_e_internos_2024.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,monto_cobertura='60.000 CLP mensuales para subsidiar arriendo; decreto UNAP 10-0329-26, art. 44. Reglas de renovantes anteriores conservadas.',cobertura_tipo='MONETARIA',cobertura_importe=60000.00,cobertura_moneda='CLP',cobertura_periodicidad='MENSUAL',cobertura_porcentaje=NULL WHERE id_beca=280;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La búsqueda devuelve BUCH 2027 y admisión universitaria, distintos de residencia. No trasladar su cierre 30 octubre a hogares universitarios; el expediente de residencia no acredita convocatoria actual.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://uchile.cl/dbe/residencias
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=288;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página de becas PUCV mantiene barrera y el antecedente de excelencia delimita puntaje/admisión 2026. No se equipara financiamiento con acceso especial 2027 sin tabla de la beca.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.daepucv.cl/becas-de-apoyo-pucv ; https://www.pucv.cl/pucv/futuros-estudiantes/becas-y-beneficios
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=292;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El catálogo 2025 identifica$50.000 mensuales y 22 enero–28 marzo; el 2026 recuperado no incluye Curanilahue. La noticia de entrega 166 becas de junio 2026 mantiene 406. No se trasladan fechas 2025 a 2026.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf ; https://direcciones.ucsc.cl/content/uploads/sites/35/2026/01/Becas-Municipales-2026.pdf ; https://munichue.com/wp/municipalidad-de-curanilahue-entrego-166-becas-a-estudiantes-que-cursan-su-educacion-superior/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=293;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El acta 898 de marzo de 2013 documenta convenio SIPEE con la Universidad de Chile. La orientación FUAS 2026 no demuestra convocatoria vigente del convenio ni autoriza generalizarlo a cualquier institución.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://transparencia.laserena.cl/documentos/898_06-03-2013_11-25-56_O.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=297;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La cuenta pública de Fresia supera el límite de tamaño; la prensa describe beca superior y movilización 2026, dos modalidades. No se usa la fecha de entrega de renovantes como cierre ni se confirman requisitos sin fuente municipal equivalente.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munifresia.cl/transparencia/descargas/MecanismoParticipacionCiudadana/CuentaPublica/2024/CuentaPublica2024-Gestion2023.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=299;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Las bases 2025 devuelven 404. El catastro institucional anterior identifica aporte superior fuera de la comuna; no acredita convocatoria 2026 ni justifica inferir el calendario por repetición anual.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf ; https://cobquecura.cl/wp-content/uploads/BASES-APORTE-EDUCACION-SUPERIOR-ANO-2025.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=300;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se recuperan avisos municipales 2023 y 2024, con recepción semestral histórica. El copyright 2026 del portal no acredita edición actual ni permite mover 31 marzo al año 2026.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.municipalidadchaiten.cl/abierto-se-encuentra-el-proceso-de-postulacion-a-beca-municipal/ ; https://www.municipalidadchaiten.cl/se-encuentra-abierto-el-proceso-de-postulacion-a-la-beca-municipal-2024/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=301;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
Reglamento Quinchao 07/07/2026, art.9 ycuadroart.18: presencial 08–31/07 hasta 13: 00; correo 08/07–02/08 hasta 23: 59. Complemento 05/08, reclamación 19–21/08 y pago 24–28/08 son etapas distintas. Ambos canales cerrados; el último cierre ordinario fue 02/08/2026.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.municipalidadquinchao.cl/cquinchao/reglamento-beca-municipal/ ; https://www.municipalidadquinchao.cl/cquinchao/wp-content/uploads/2026/07/reglamento_beca_municipal.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-07-08',fecha_cierre_postulacion=DATE '2026-08-02' WHERE id_beca=302;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La beca UST corresponde a excelencia desde segundo año; IP/CFT por NEM y PAES de ingreso son otras modalidades. No se utilizan convocatorias colombianas ni admisión 2027 como calendario de su asignación interna.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.tupuedes.cl/becas-y-beneficios/becas-internas/beca-paes/ ; https://acceso.mineduc.cl/wp-content/uploads/2025/11/SERV-Y-BENEF-2026-181125.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=306;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Los antecedentes Toltén están en archivos históricos 2013/2020; la búsqueda dirigida actual solo aporta empleos/otros fondos. No se considera la ausencia de resultados prueba de fin del programa.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://web.archive.org/web/20130627091130id_/http://www.tolten.cl/muni/index.php/noticias/destacados/171-beca-municipal-2013 ; https://web.archive.org/web/20200929235222id_/http://www.tolten.cl/web/index.php/noticias/98-becas-municipales ; https://web.archive.org/web/20200929232349id_/http://www.tolten.cl/web/images/becas/REQUISITOS_POSTULACIONES_BECA_MUNICIPAL_AO_2020.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=312;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia PAC 2026 fija 23 febrero–02 marzo; el decreto 2912 cita modificación 2606 del 17 abril. No se recuperó texto específico suficiente para resolver el alcance de la modificación; no se certifica fecha única por escoger el aviso inicial.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.pedroaguirrecerda.cl/arn/postula-a-la-nueva-beca-municipal-de-educacion-superior-2026/ ; https://www.pedroaguirrecerda.cl/app/uploads/2026/05/2912-5.pdf ; https://www.pedroaguirrecerda.cl/app/uploads/2026/02/Bases-de-Becas-Decretadas.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=318;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
La noticia municipal 12/01/2026 separa niveles: Educación Superior online 26/01–13/02/2026 hasta 24: 00; resultados 03/03. Enero 13–30 corresponde a otras becas y la recepción anual para discapacidad es distinta. La fecha civil de cierre superior es 13/02, no 14/02 por normalizar 24: 00.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://providencia.cl/provi/explora/noticias/municipalidad/becas-de-apoyo-a-la-educacion-2026 ; https://providencia.cl/provi/site/docs/20260112/20260112113918/beca_educacion_superior_online.pdf ; https://transparencia.providencia.cl/Carpeta/VerTabla/24175 ; https://transparencia.providencia.cl/Carpeta/VerTablaV/413476
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-01-26',fecha_cierre_postulacion=DATE '2026-02-13',url_oficial='https://providencia.cl/provi/explora/noticias/municipalidad/becas-de-apoyo-a-la-educacion-2026' WHERE id_beca=321;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El sitio Santa Juana conserva bases 2024 de devolución de matrícula. La noticia 2026 corresponde a FUAS 2027 estatal, no a la devolución municipal; no extrapolar fecha ni presupuesto.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://santajuana.cl/wp-content/uploads/2024/01/aprueba-bases-beca-devolucion-de-matricula-para-estudiantes-de-primer-ano-educacion-superior.pdf ; https://santajuana.cl/beca-devolucion-de-matricula/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=329;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página UANDES de créditos no prueba el beneficio interno de hijo de funcionario ni sus condiciones anuales. Se rechazan fuentes de Universidad de los Andes Colombia; no se generaliza PAES a personal.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.uandes.cl/estudiantes/becas-y-creditos/ ; https://admision.uandes.cl/becas/beca-hijo-funcionario
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=331;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El convenio Gardilcic es empresarial, no prueba la Beca Familiar IPCHILE de esta ficha. La página Mineduc contiene además referencias 2023; no sirve como calendario de una ayuda familiar interna.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.ipchile.cl/becas-y-financiamiento/becas-mineduc/ ; https://www.ipchile.cl/noticias/campus-a-distancia-firma-convenio-con-constructora-gardilcic/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=333;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La guía Santa María 2016 acredita ayudas universitarias recibidas dos veces por año, sin convocatoria 2026. Los cronogramas de Santa María Argentina no pertenecen a este municipio chileno.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.santamariatransparente.cl/web/images/stories/Contenido/Tramites/Tramites_SOCIAL2016.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=336;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El catastro Ude C 2024 indica 01–31 marzo y reevaluación 01–31 agosto; el UCSC anterior 06–24 marzo. No hay acto municipal actual que resuelva la divergencia; no se inventa calendario 2026.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf ; https://cade.udec.cl/wp-content/uploads/2024/10/Catastro-Beneficios-Municipales-2.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=338;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Las compras 2026 de buses/pasajes de Caldera acreditan objeto contractual de movilización, no requisitos o plazos para estudiantes. La licitación no se transforma en convocatoria individual.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.mercadopublico.cl/Procurement/Modules/RFB/DetailsAcquisition.aspx?qs=RrIdIuqVe8AGCxHRVJoIIg%3D%3D
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=340;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
USM publica Premio Excelencia Primer Año 2026 con escala según puntaje ponderado, diferente de Puntaje Máximo y limitado al primer año. No hay cierre de beca 2027 publicado en esta página; se mantiene alcance 2026 y fechas por confirmar.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://usm.cl/admision/becas/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=343;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El reglamento Finis Terrae recuperado es versión 06/05/2025 y delega tabla de admisión a publicación anual. No se confunde Beca Universidad del art.16 con excelencia interna; no acredita por sí mismo nueva cohorte 2027.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://finis.cl/images/descargables/reglamentos/reglamento-de-becas-y-ayudas-asistenciales-finis-terrae.pdf ; https://admision.finis.cl/becas-y-beneficios/ ; https://finis.cl/wp-content/uploads/2026/01/RBB-2025-pre-y-posgrado-FINAL.pdf ; https://acceso.mineduc.cl/wp-content/uploads/2025/11/SERV-Y-BENEF-2026-181125.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=347;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La función de DIDECO incluye becas, pero no publica convocatoria estudiantil actual. Subvenciones 2026–2027 y concursos laborales no equivalen a ayuda superior individual; cuenta de gran tamaño sin lectura suficiente.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://imtocopilla.cl/direccion-de-desarrollo-comunitario/ ; https://imtocopilla.cl/download/22874/?tmstv=1746030338
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=353;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La tabla DIDECO contiene subvenciones y empleo, sin identificación suficiente de convocatoria superior actual. El convenio Salud Municipal-UFRO es otra población; no se reemplaza beca genérica por él.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://transparencia.temuco.cl/h_tramites/dideco/index.htm
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=354;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Las bases oficiales 2026 y el decreto 2025 localizado devuelven 404. Los extractos de búsqueda ayudan a identificar el programa, pero no permiten afirmar lectura ni resolver calendario actual completo.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.constitucion.cl/wp-content/uploads/2026/04/D.-EXENTO-1086-ORDENANZA-BECA-MUNICIPAL-Y-REQUISITOS.pdf ; https://www.constitucion.cl/wp-content/uploads/2025/04/DECRETO-EXENTO-1120C-BECAS-MUNICIPALES.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=357;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página UCSC describe más de dos hermanos y menciona modalidad 1 compatible con Mineduc mientras otras reglas excluyen beneficios. Sin reglamento específico de modalidades y plazos no se fuerza una regla única ni se anuncia asignación 2027.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://admision.ucsc.cl/becas-y-financiamiento/becas-y-beneficios/ ; https://sube.ucsc.cl/contenido/beca-matricula-familiar/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=358;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El Programa Generación Empleo para estudiantes 2026 realiza encuestas y difiere de vivienda universitaria 2024. El 30 enero anual de la vivienda no se traslada a empleo ni a una ayuda monetaria genérica.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.santabarbara.cl/santa-barbara-programa-pge-estudiantes/ ; https://historico.santabarbara.cl/noticias-de-la-comuna-historico/educacion/item/1924-estudiantes-de-educacion-superior-reciben-beneficio-municipal-unico-en-su-tipo-en-la-region
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=360;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El listado de decretos diciembre 2019 actualizado 2026 no es un calendario nuevo. El decreto 3574 se recuperó como escaneo; trámites 2025/2026 recuperados no identifican convocatoria de la misma beca.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.hualane.cl/TA_IGTA/Transparencia_Proactiva/Decretos_Alcaldicios/Exentos/2019/12_Diciembre/3574.pdf ; https://transparencia.hualane.cl/index.php?a=2019&action=plantillas_generar_plantilla&ia=12189&ig=411&m=12
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=362;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La propia ficha Alhué dice primera cuotaabril/mayo, segunda septiembre/octubre y mes de postulaciónjunio. No se escoge una de las tres referencias sin acto aclaratorio; se conservan requisitos respaldados y fechas desconocidas.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://municipalidadalhue.cl/portal/beca-municipal/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=365;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Huasco separa Juanita González Toro y Hogar Estudiantil. Bases 2023 de residencia y cuentas 2023/2024 no se convierten en convocatoria 2026 del aporte; documento 2026 en Scribd no sustituye original oficial.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://imhuasco.cl/Transparenciamunicipal/Documentos/BECAS/2023/BECA%20RESIDENCIA%20ESTUDIANTIL.pdf ; https://imhuasco.cl/Transparenciamunicipal/Documentos/cuentas_publicas/Cuenta_Publica_2024.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=367;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El conjunto de datos de Puente Alto contiene años cursados y adjudicaciones. La instancia beneficios-develop no tiene procedencia pública enlazada verificada; no se usa como llamado oficial ni se ingresan datos personales.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://datos.mpuentealto.cl/datasets/197869/beca-municipal-de-educacion-superior-ano-a-cursar/ ; https://www.mpuentealto.cl/estudiantes-de-puente-alto-reciben-beca-municipal-de-educacion-superior/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=368;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CALENDARIO_POR_MODALIDAD.
Bases Melipeuco 2026: nuevos y renovantes en junio/julio; segunda cuota de renovantes en noviembre. La página 7 dice viernes 15 de julio aunque ese día de 2026 fue miércoles. Además aparece pago el imposible 31 de noviembre. Se documentan ambas anomalías y no se fabrican fechas correctoras ni se activa noviembre sin plazo preciso.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://municipalidadmelipeuco.cl/wp-content/uploads/2026/06/DECRETO-Y-BASES-BECA-MUNICIPAL.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=369;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
BEAMineduc se distingue de cupos de trayectoria Usach y del llamado FUASgeneral. Los requisitos ministeriales de la nueva edición no quedan confirmados por una página de acceso especial universitaria.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://admision.usach.cl/cupos-acceso-directos ; https://www.admision.usach.cl/trayectoria-educativa ; https://www.ucentral.cl/postulacion-fuas-2027/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=373;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CALENDARIO_POR_MODALIDAD.
La página de noticias 25/03/2026 acredita proceso Río Verde; requisitos oficiales describen dos etapas de recepción y montos en UTMsegún avance. No se obtiene cierre anual inequívoco; no usar fechas de 2023 como 2026 ni convertir UTMsinfecha.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.rioverde.cl/noticias?start=30 ; https://www.rioverde.cl/component/phocadownload/category/8-noticias?Itemid=101&download=90%3ARequisitos+Beca.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=374;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La beca Armada UANDES requiere convenio propio; el catálogo general de becas/créditos no fija cupos ni calendario. Se mantienen términos históricos y no se aplica la tabla PAES a este convenio.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.uandes.cl/estudiantes/becas-y-creditos/ ; https://admision.uandes.cl/becas/beca-armada-de-chile
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=376;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Los resultados municipales corresponden a 2025 y a ingreso superior de esa edición. El sitio personal de una autoridad sobre entrega 2026 no se utiliza como bases municipales ni se interpreta adjudicación como recepción abierta.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.paine.cl/resultados-becas-educacion-superior-2025/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=378;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Cuentas 2014/2015 identifican apoyos municipales y Beca 25 Mdistintos. El llamado reciente de Diego De Almagro no pertenece a Chañaral; concursos actuales del municipio son laborales.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munichanaral.cl/pdf/Cuenta%20Publica%202014.pdf ; https://www.munichanaral.cl/pdf/Cuenta%20Publica%202015.pdf ; https://www.munichanaral.cl/pdf/Cuenta%20Publica%202013.pdf ; https://www.munichanaral.cl/new_graduacion_liceo_24.html ; https://www.munichanaral.cl/pdf/Cuenta_Publica_2024.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=381;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El decreto 5852/2022 es manual escaneado de ayudas sociales de 25 páginas, no convocatoria 2026 acreditada. No se infiere permanencia por tratarse de ayudas de pasajes.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munivina.cl/wp-content/uploads/2022/04/D.A-5852.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=385;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se recupera ficha de 2025 con primera etapa 01–18 abril; el portal 2026 solo ofrece acceso Clave Única sin fechas públicas. No se ingresa con identidad personal ni se extiende el calendario 2025 a 2026.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://agendabecas.santodomingo.cl/ ; https://tramites.santodomingo.cl/beca-educacion-superior
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=388;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página actual UBOde financiamiento describe principalmente beneficios estatales. No recupera condiciones específicas actuales de copago institucional ni un cierre; no se copia la tabla de otra universidad.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.ubo.cl/financiamiento-estudiantil/ ; https://admision.ubo.cl/financiamiento/ ; https://dae.ubo.cl/becas-alumnos-nuevos/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=390;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La cuenta 2021 y las referencias 2018/2019 son antecedentes históricos. No se aplica fecha de contratación PAES 2026 a estudiantes; no hay llamado actual de la beca propia DAEM/DIDECO.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.municipalidaddecodegua.cl/municipalidad/transparencia/cuentapublica2021.pdf ; https://www.municipalidaddecodegua.cl/municipalidad/transparencia/archivos/particip/CUENTA%20PUBLICA%20DEFINITIVO%202018.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=391;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La plataforma escolar 2026 se limita a kínder–cuartomedio; el PLADECO enumera apoyosestatales. Ninguno acredita convocatoria municipal superior de esta ficha; conservar advertencia de alcance.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://appx.laflorida.cl/beca_escolar/ ; https://appx.laflorida.cl/transparencia/documentacion/VERSION_FINAL_PLADECO_LA_FLORIDA_2024_2029.pdf ; https://pladeco.laflorida.cl/v3/main.php
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=393;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
La ruta oficial /becas ahora publica resultados de Educación Superior 2026: pago en dos períodos, rendiciones y voluntariado. Consultas 06–10 julio no son postulaciones. Identidad/ejecución 2026 confirmadas; cierre de recepción original no publicado en esta vista.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.quillota.cl/becas ; https://quillota.cl/municipalidad/beca-municipal/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=395;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La ficha/formulario BIT de Perú/Bolivia delimita 2026; no hay convocatoria 2027 específica recuperada. No se transfieren plazos CRISCOS, PAESo movilidad de otros convenios.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.uta.cl/index.php/direccion-de-internacionalizacion-documentos/ ; https://acceso.mineduc.cl/wp-content/uploads/2025/11/SERV-Y-BENEF-2026-181125.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=400;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia presupuestaria 2025 anuncia creación de beca superior, pero no proporciona bases individuales 2026. La postulación deportiva 2024 y fondoscomunitarios 2026 son programas distintos.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://munivillalemana.gob.cl/2024/11/con-un-historico-aumento-de-casi-mil-millones-en-salud-concejo-municipal-de-villa-alemana-aprueba-presupuesto-2025/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=402;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Los enlaces de cuenta 2024 y deportiva 2026 de Máfil devuelven 404. Los concursos 2026 actuales son laborales; no se presume que sus condiciones correspondan a beca superior.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munimafil.cl/wp-content/uploads/2026/01/Becas-Deportivas-2026.pdf ; https://www.munimafil.cl/wp-content/uploads/2025/05/PUBLICA-2024.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=403;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página UDP conserva tabla PAES 2026 y el nuevo calendario de admisión no publica condiciones particulares 2027. Se conserva año de referencia y no se certifica la siguiente convocatoria.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://admision.udp.cl/becas-y-beneficios/becas-y-beneficios-udp/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=404;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Quinta Normal 2026 publica útiles para escolares y becas culturales, no la ayuda superior histórica. La cuenta 2006 y su asistencia escolar no acreditan recepción 2026 para estudios superiores.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.quintanormal.cl/actividades/postula-becas-culturales-2026-161187 ; https://www.quintanormal.cl/actividades/beca-de-utiles-escolares-2026-161179 ; https://ligup-v2.s3.amazonaws.com/quintanormal/multimedia/19430_cuenta_publica_2006.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=406;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Las bases sin año citan viernes 22 abril y prestación mensual; la ordenanza 2023 indica aporte único. Sin llamado 2026 vinculado no se armonizan importes o fechas de instrumentos distintos.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munitorresdelpaine.cl/Portal%20TA/Efecto%20Terceros/Ordenanzas/2023/Ordenanza2.pdf ; https://www.munitorresdelpaine.cl/Portal%20TA/Otros%20Antecedentes/CUENTA%20P%C3%BAblica%202025.pdf ; https://www.munitorresdelpaine.cl/VARIOS/bases_beca.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=408;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Los resultados Pencahue 2026 mantienen 403 y el texto previo no determina nivel o prestación. La oficina virtual general no acredita una beca superior ni autoriza inferir requisitos.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://mpencahue.cl/index.php/resultados-becas-2026/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=412;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La admisión ENAC 2027 publica promociones generales; las referencias de convenio empresarial son históricas. La matrícula gratuita temprana no se usa como cierre o porcentaje de este convenio.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://enac.cl/admision/ ; https://web.archive.org/web/20130611194042id_/http://www.enac.cl:80/becas/becas-enac ; https://web.archive.org/web/20150614042632id_/http://enac.cl:80/becas/beca-enac
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=418;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El acta Osornoenero 2024 mezcla becas deportivas y programas municipales. BEMARTy subvenciones 2026 tienen otro alcance; no se acredita convocatoria superior individual equivalente.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.imo.cl/sistemas/sitioweb/actas/1161_478.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=421;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El llamado 26/10/2026 es Beca Deportiva; el archivo de transparencia es informe 2009. La plataforma Simplede capacitación no constituye trámite real de beca superior.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.municoelemu.cl/beca-deportiva-coelemu-2026/ ; https://transparencia.municoelemu.cl/index.php?a=2010&action=plantillas_generar_archivo&ia=778&ig=207&m=3
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=424;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
Catastro oficial UCSC 2026, página 8, distingue incentivo de excelencia NEM>6, 0 e incentivo superior NEM 5, 5/RSH<60%. Corrobora existencia 2026 sin importe ni fechas; las entregas 2024/2025 no se usan como cierre 2026.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://direcciones.ucsc.cl/content/uploads/sites/35/2026/01/Becas-Municipales-2026.pdf ; https://munitirua.gob.cl/noticias/?cst=&query-14-page=5 ; https://munitirua.gob.cl/alcalde-jose-linco-encabezo-entrega-de-becas-para-la-educacion-superior-a-17-estudiantes-de-tirua/ ; https://munitirua.gob.cl/alcalde-jose-linco-encabezo-ceremonia-de-entrega-de-becas-municipales-a-nuestros-estudiantes/ ; https://munitirua.gob.cl/apoyo-a-los-estudiantes-de-tirua-entrega-de-la-beca-de-excelencia-academica-y-beca-de-incentivo-a-la-ensenanza-superior/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,monto_cobertura='Aporte económico municipal para continuidad superior; modalidad Incentivo con NEM 5,5 y RSH menor al 60% según catastro UCSC 2026. Importe y calendario no publicados.',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad='DESCONOCIDA',cobertura_porcentaje=NULL,cobertura_tipo='MONETARIA' WHERE id_beca=425;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Ambas fichas Viña remiten a las mismas cuentas 2022/2023 y secciónsocial. Coincidencia de antecedentes, sin nuevo calendario 2026; no se usan fondos para organizaciones ni ofertaslaborales como convocatoria superior.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munivina.cl/desarrollo-comunitario/desarrollo-social/seccion-servicio-social/ ; https://www.munivina.cl/wp-content/uploads/2023/04/Cuenta-Publica-2022-Municipio-de-Cuidados_.pdf ; https://www.munivina.cl/wp-content/uploads/2024/04/CPVina-2023_c.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=426;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se recuperó la noticia Coquimbo con fecha 08/01/2019 y cierre 28 febrero 2019. Distingue aportes arancelarios y residencia; las noticias lateralesoctubre 2026 no actualizan la convocatoria histórica.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.municoquimbo.cl/index.php/noticias/4834-invitan-a-jovenes-de-coquimbo-a-postular-a-aportes-municipales-para-la-educacion-superior
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=432;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La tabla UBOde excelencia del catálogo 2026 no acredita condiciones 2027. La página actual recuperada es de financiamiento estatal; no confirma nueva recepción de excelencia interna.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.ubo.cl/financiamiento-estudiantil/ ; https://admision.ubo.cl/financiamiento/ ; https://acceso.mineduc.cl/wp-content/uploads/2025/11/SERV-Y-BENEF-2026-181125.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=433;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El reglamento UAI 2024 identifica rebaja para hijos/cónyuges de funcionarios, sin porcentaje corroborado. La norma de excelencia 2026 y su próxima actualización 2027 son beneficios diferentes; no se extrapola.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://delta.uaidev.cl/admision/becas-y-aranceles/becas ; https://alumno.uai.cl/assets/uploads/2024/04/reglamentos-uai-2024.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=438;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
PLADECO 2026–2032 presenta barrera de acceso y antecedentes de orientación FUAS/JUNAEB. El convenio Diego Portales de Hualpén no prueba una mantención general; no se traslada su 50% de arancel.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.hualpenciudad.cl/wp-content/uploads/2025/12/Pladeco-2026-2032-2-reducido.pdf ; https://legalpython.com/municipalidades/hualpen/padems/PADEM_2023.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=440;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Las bases leídas son 2018 y recepciónmarzo–abril 2018; los concursosmunicipales 2026 actuales son otros fondos. No hay prueba de convocatoria anual actual de esfuerzo/mérito superior.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munimontepatria.cl/transparencia/index.php?a=2018&action=plantillas_generar_archivo&ia=49110&ig=404&m=12
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=451;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El catastro UBB 2024 corrobora transporte/ayudaeconómica y el decreto 2024 es nómina escaneada. La ficha Simple 2026 confunde título Los Lagos con cuerpo Bulnes; no se adopta esa contradicción como convocatoria válida ni se declara permanente por interfaz.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://pace.ubiobio.cl/wp-content/uploads/2024/07/Becas-Municipales-Nuble-Diguillin.pdf ; https://www.imb.cl/wp-content/uploads/2024/04/DECRETO-NOMINA-BECAS-TRANSPORTE-2024-BULNES.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=455;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Residencia Estudia Tranquilo 2026 en Temuco tiene plazo 16–18 febrero y RSH 40%; no es la beca municipal monetaria general de 2025. Se mantienen separados beneficio y calendario.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munilossauces.cl/noticias/postulacion-a-residencia-estudiantil-2026-estudia--22964 ; https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=456;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El formulario 2026 indica 09 febrero–09 marzo 13: 30, mientras la noticia señala 06 marzo. Ambas ventanas son pasadas; se acredita programa y aporte$100.000 pero no un único cierre final sin acto de ampliación. Se publica la discrepancia y no se activa.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://penco.cl/wp-content/uploads/2026/02/ANEXO-1-BECA-MUNICIPAL.pdf ; https://penco.cl/penco-abre-postulacion-a-mil-becas-para-la-educacion-superior-con-una-inversion-de-100-millones-de-pesos/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=457;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Las contrataciones PAES de Mercado Público son compras de preparación académica. Su cierre de ofertas no constituye plazo para estudiantes ni acredita un aporte monetario municipal superior.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.mercadopublico.cl/Procurement/Modules/RFB/DetailsAcquisition.aspx?idlicitacion=4993-32-LE25 ; https://www.mercadopublico.cl/Procurement/Modules/RFB/DetailsAcquisition.aspx?idlicitacion=4993-30-LE26
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=463;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El formulario 2024 remite a decreto 865/2021; el servicio anterior remite a norma 2010 con otros montos. La prensa 2026 de entrega no resuelve bases actuales; no se combinan instrumentos como una sola convocatoria.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://municipalidadchimbarongo.cl/wp-content/uploads/FORMULARIO-DE-POSTULACION-BECA-CAPITAL-DEL-MIMBRE-SUPERIOR.pdf ; https://www.municipalidadchimbarongo.com/becas.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=467;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El arancel ajustado UCTes mecanismo legal/financiero diferente de una beca con recepción anual. La página DCRno se recupera y el ingreso 2027 no establece por sí mismo el trámite de ajuste; no inventar cierre.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://admision.uct.cl/becas-y-creditos/ ; https://dge.uct.cl/beneficios-internos/ ; https://dcr.uct.cl/preguntas-frecuentes/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=474;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La beca de excelencia ENACdebe sostenerse con reglas particulares; la promoción de matrícula temprana 2027 hasta 31 octubre no acredita asignación de excelencia. Se conserva antecedente histórico sin trasladar el plazo.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://enac.cl/admision/ ; https://web.archive.org/web/20130611194042id_/http://www.enac.cl:80/becas/becas-enac ; https://web.archive.org/web/20150614042632id_/http://enac.cl:80/becas/beca-enac
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=477;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Las bases Hijosde Pescadores 2026 excluyen expresamente otras becas municipales. Su$400.000 y sus fechas no se aplican a la Beca Municipal general; el PDFgeneral 2025 sigue 404.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://muniquellon.cl/wp-content/uploads/2026/04/Bases-Beca-HP-2026.pdf ; https://muniquellon.cl/wp-content/uploads/2025/03/Bases-Beca-Municipal-2025.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=481;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El acta 10/2025 separa Bono Incentivo devoluciónmatrícula de Beca Municipal 2 UFmensuales. El 17 marzo–17 abril corresponde al bono; transporte Valdivia 2026 es otro beneficio. No trasladar fechas entre ellos.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munipaillaco.cl/wp-content/uploads/2025/03/Acta-N%C2%B010.pdf ; https://www.munipaillaco.cl/wp-content/uploads/2021/04/BECA-MUNICIPAL-PAILLACO-2021-1.pdf ; https://www.munipaillaco.cl/wp-content/uploads/2023/05/Cuenta-Publica-Paillaco-2022.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=486;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Los documentos originales pertenecen a San Pedro de Melipilla, no San Pedro dela Paz. El preuniversitario y convenio IPDPde la Paz son otros programas; no reemplazan retroactivamente la identidad ni justifican eliminar el UUID.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munisanpedro.gob.cl/wp-content/uploads/2026/04/Becas-2026-ok.pdf ; https://www.munisanpedro.gob.cl/wp-content/uploads/2026/03/DECRETO-N%C2%B0406-APRUEBA-NUEVO-REGLAMENTO-DE-BECA-MUNICIPAL-DE-EDUCACION-SUPERIO-Y-BECA-PAES.pdf ; https://www.munisanpedro.gob.cl/noticias/becas-municipales-de-educacion-superior-y-beca-paes/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=490;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
Se recupera noticia municipal La Cruz 31/07/2026 en nueva ruta: acredita beca superior y ejecución, con prestaciones según evaluación. No publica calendario de recepción; el plazo 22 enero–15 febrero de prensa no se carga como oficial.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.lacruz.cl/Municipalidad/noticia.php?id=61 ; https://lacruz.cl/a94a8fe5/noticias/beca-municipal-si-se-puede/ ; https://lacruz.cl/a94a8fe5/wp-content/uploads/2026/04/CUENTA-PUBLICA-2025.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,url_oficial='https://www.lacruz.cl/Municipalidad/noticia.php?id=61' WHERE id_beca=494;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El reglamento 562/2005 es convenio CFTSan Agustíncon plazo 3–15 abril de cada año, no prueba convocatoria 2026 de ayuda superior general. PADEM 2025 describe becasestatales; no se equiparan programas.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://cauquenes.cl/ordenanzas/pdf/562.pdf ; https://www.cauquenes.cl/transparencia_activa/Cuenta_Publica_2020.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=497;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se recupera noticia de 96 universitarios con fecha 01/04/2019 y programa 100 por 100. El subsidio de pasajes 2026 y deportiva son modalidades distintas; Coronel Suárez Argentina no pertenece a esta ficha.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.coronel.cl/noticias/entrega-de-96-becas-a-alumnos-y-alumnas-universitarias-de-nuestra-comuna/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=500;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CALENDARIO_POR_MODALIDAD.
El decreto UNAP 2026 art.26 identifica Beca Rectoría excepcional anual/semestral de arancel, con NEM 6, 0 para nuevos y 100% asignaturas para antiguos. La decisión individual fija porcentaje/período; el transitorio conserva renovantes anteriores. No se inventan cupos, monto ni cierre 2027.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://transparencia.unap.cl/activa/web/index.php?a=2026&action=plantillas_generar_archivo&ia=9448&ig=97&m=3 ; https://www.unap.cl/mk/prontus_unap/vice_academica/de_1312_aprueba_texto_refundo_reglamento_becas_deja_sin_efecto_de_510_2014.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=501;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página municipal de actas no aporta bases actuales de la beca. La noticia radial de traslado/conectividadagosto 2026 es pista; no se usa Studylibni un proyecto de rediseño como convocatoria oficial.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.mpinto.cl/actas-de-consejo/ ; https://studylib.es/doc/7986385/acta-47---transparencia-municipal ; https://ensanpedro.cl/2022/08/12/invitan-a-estudiantes-universitarios-de-maria-pinto-a-renovar-la-beca-de-conectividad-de-educacion-superior/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=504;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El portal Peñaflor conserva categoría de becas y errores de aplicación; el llamado deportivo 2026 es distinto. No se acredita recepción del incentivo superior ni continuidad del monto histórico.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://penaflor.cl/tramites/ ; https://penaflor.cl/wp-content/uploads/2021/03/CUENTA-PUBLICA-2020_web.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=505;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El catastro anterior indica aporte municipal y mesmarzo. La prensa 2026 anuncia tres categorías con cierre 8 mayo, pero no se recupera base oficial equivalente; no se certifica ese plazo ni se aplican condiciones PAES a todos.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=507;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Ambas fichas remiten al mismo FAQ UPLA 2025 para Beca de Honor. Se registra coincidencia de programa sin borrar UUID; no se acredita reglamento o asignación 2027 con el anuncio general futuro.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.upla.cl/admision/2025/01/21/preguntas-frecuentes-sobre-el-proceso-de-admision-y-matricula-2025/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=508;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia San Gregorio 2025 mantiene 406. Las búsquedas recuperan otros municipios/países, no bases 2026 de la beca chilena; no se interpreta esta barrera como inexistencia.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.sangregorio.cl/2025/03/14/ya-estan-abiertas-postulaciones-para-becas-municipales-de-san-gregorio-2025/
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=509;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La cuenta 2025 mantiene 406; la entrega 2026 en prensa es una pista de aportes estudiantiles. Sin publicación primaria específica no se sustituye cobertura ni se acredita calendario; se conserva la ficha.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://municochamo.cl/transparencia/cuentapublica/cuentapublica2025.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=513;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El reglamento Carahue 2025 mantiene 406. La plataforma Simplehallada declara ser de pruebas y trata subvenciones a organizaciones; no es una convocatoria real de beca superior 2026.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://carahue.cl/web/wp-content/uploads/2025/03/REQUISITOS-Y-REGLAMENTO.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=515;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El catálogo UCSC 2026 delimita Excelencia Trayectoria Educativa 2 y su 50% de arancel; la páginaactual mezcla referencias 2023 y encabezado 2027. No se confunde con Psicología 750 ni DTE 1 y no se certifica nueva tabla 2027 sin documento anual.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://admision.ucsc.cl/becas-y-financiamiento/becas-y-beneficios/ ; https://ucsc.cl/admision/pregrado/becas-y-financiamiento/becas-y-beneficios/?id=beca-deportiva ; https://acceso.mineduc.cl/wp-content/uploads/2025/11/SERV-Y-BENEF-2026-181125.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=520;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
La noticia municipal 05/03/2026 acredita apoyo superior/técnico, mensualmarzo–diciembre, y recepción 02–13/03/2026. Las nóminas de julio mezclan deportiva; se usa el llamado específico 2026 para calendario y no se trasladan umbrales 2022 como actuales.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.contulmo.cl/postula-a-la-beca-municipal-de-apoyo-a-la-educacion-superior-2026-%F0%9F%8E%93%E2%9C%A8/ ; https://www.transparencia.contulmo.cl/nomina-de-julio-2026/ ; https://www.contulmo.cl/Transparencia/Decretos/2022/05-Mayo/DE1685.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1,fecha_inicio_postulacion=DATE '2026-03-02',fecha_cierre_postulacion=DATE '2026-03-13',url_oficial='https://www.contulmo.cl/postula-a-la-beca-municipal-de-apoyo-a-la-educacion-superior-2026-%F0%9F%8E%93%E2%9C%A8/' WHERE id_beca=523;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El decreto de otorgamiento 2026 cita modificación 462 de 22 abril al calendario de San Pedro Melipilla. El reglamento 406 es de 05 marzo 2025 aunque se aloje bajo 2026; no se carga fecha del anuncio inicial como cierre definitivo sin modificación leída.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munisanpedro.gob.cl/wp-content/uploads/2026/04/Becas-2026-ok.pdf ; https://www.munisanpedro.gob.cl/noticias/becas-municipales-de-educacion-superior-y-beca-paes/ ; https://www.munisanpedro.cl/wp-content/uploads/2025/03/REGLAMENTO-BECAS-BMES-2025-1.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=525;
UPDATE becas SET descripcion_larga='AUDITORÍA INDIVIDUAL DE VIGENCIA · COHORTE 177 · 01/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Ambas fichas Viña remiten a las mismas cuentas 2022/2023 y secciónsocial. Coincidencia de antecedentes, sin nuevo calendario 2026; no se usan fondos para organizaciones ni ofertaslaborales como convocatoria superior.
FUENTES CONSULTADAS (su alcance y año están delimitados arriba): https://www.munivina.cl/desarrollo-comunitario/desarrollo-social/seccion-servicio-social/ ; https://www.munivina.cl/wp-content/uploads/2023/04/Cuenta-Publica-2022-Municipio-de-Cuidados_.pdf ; https://www.munivina.cl/wp-content/uploads/2024/04/CPVina-2023_c.pdf
Esta revisión no acredita una nueva postulación abierta.
ANTECEDENTES CONSERVADOS (las afirmaciones contradichas arriba quedan sustituidas):
' || descripcion_larga,version=version+1 WHERE id_beca=528;
COMMIT;
