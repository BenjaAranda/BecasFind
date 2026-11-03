\set ON_ERROR_STOP on
BEGIN;
SET LOCAL lock_timeout='5s';
DO $guardas$ BEGIN
IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario cambiado'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=1 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=1 AND public_id='fc65e10e-f9ad-4698-a261-1d03b1212a14'::uuid AND version=4 AND md5(descripcion_larga)='f59d48c3f19faef5e965faec92dd2cae' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 1'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=2 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=2 AND public_id='7698fdfa-3610-4c10-b74d-84be1d424eb7'::uuid AND version=2 AND md5(descripcion_larga)='95f0ed757b44fd6170aca45415ad7986' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 2'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=19 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=19 AND public_id='89aa67b1-a632-4585-b51b-60ce5d4c75cc'::uuid AND version=2 AND md5(descripcion_larga)='5b9c859d3e84bdfdf05597f17a40fd83' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 19'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=21 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=21 AND public_id='e2114db0-b245-4950-a2bb-2660f007e342'::uuid AND version=2 AND md5(descripcion_larga)='c36c2f13cebe8f83cc249fd5ed0e351d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 21'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=33 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=33 AND public_id='b9d08a38-8d37-432f-b637-82ca917311b4'::uuid AND version=2 AND md5(descripcion_larga)='dfdb218d56d690aa6c01e6390ba893bc' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 33'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=37 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=37 AND public_id='e549c7af-aa24-4d4e-b4db-420943a15850'::uuid AND version=3 AND md5(descripcion_larga)='090dbbd1dd91938903c2447c3eedf20b' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 37'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=49 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=49 AND public_id='c1c28f20-cb82-42d2-ba12-f1f8079ee3e0'::uuid AND version=2 AND md5(descripcion_larga)='c9037cf4906e242e87352729a85cb72c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 49'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=52 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=52 AND public_id='d717e436-d0e3-4c58-92d8-bb338f3b0222'::uuid AND version=2 AND md5(descripcion_larga)='72b340edbf172b39ec908f7d71a70b0f' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 52'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=55 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=55 AND public_id='c9da3b0c-a207-41e4-98fd-06ae7623f75b'::uuid AND version=2 AND md5(descripcion_larga)='98ab87c30a0e1c71b622f5fba2283d36' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 55'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=57 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=57 AND public_id='f393ea3c-a42b-49cb-b18d-f5ac6cf22f18'::uuid AND version=2 AND md5(descripcion_larga)='30ea0a4097a573c5ec0ddf122f84f06c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 57'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=64 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=64 AND public_id='1c16f749-45f2-4b85-8838-50d1928758bc'::uuid AND version=2 AND md5(descripcion_larga)='f83daee8ebd7cb8ddd5a0c2ede20ae91' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 64'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=68 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=68 AND public_id='b57476f8-6347-4d22-bfb9-86691e11c7ef'::uuid AND version=4 AND md5(descripcion_larga)='545b436b99f9c492dfdbec19beae033d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 68'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=90 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=90 AND public_id='524d17dd-63f5-4a06-a779-e6fae7eaed90'::uuid AND version=2 AND md5(descripcion_larga)='82b3dafe32cf89abd01bbc3eaf8f145a' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 90'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=92 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=92 AND public_id='8dd7e072-983a-4b33-9c1f-caeb7d3b2f7d'::uuid AND version=2 AND md5(descripcion_larga)='214f54d8df7f7c5097339bfb18ab2190' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 92'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=100 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=100 AND public_id='96648d83-e8a5-4849-bc16-7fbd134fc9c4'::uuid AND version=2 AND md5(descripcion_larga)='c4e0183ebc0b4947f1cb4867e7ef3b79' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 100'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=102 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=102 AND public_id='ecb2bda1-fffc-4c4a-a1ef-d3682dece301'::uuid AND version=2 AND md5(descripcion_larga)='cb007e62f2874c033c5aeeedf18fa033' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 102'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=105 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=105 AND public_id='d4bfeb79-7b05-45ad-9915-f0bfd75940bc'::uuid AND version=2 AND md5(descripcion_larga)='0505acffefe355048ccf85ad4bc306e7' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 105'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=121 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=121 AND public_id='99fd11bf-6953-4d10-a099-4b51b2de5468'::uuid AND version=2 AND md5(descripcion_larga)='05ed1da834738d72ca7dd79e337a90bb' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 121'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=126 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=126 AND public_id='ac0a9ea4-cb5c-4df2-b260-651ef3dc5a89'::uuid AND version=2 AND md5(descripcion_larga)='0616a284376157ded3dc37bc73c8c65b' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 126'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=127 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=127 AND public_id='dadba91f-f202-44bb-b81a-d20c8ffc224d'::uuid AND version=2 AND md5(descripcion_larga)='16e860136a5b95fa0bf316988038980a' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 127'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=129 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=129 AND public_id='7c6bc61b-739a-4360-91c8-f9840922bb00'::uuid AND version=2 AND md5(descripcion_larga)='8f516e16df7cca086c1773beb8edcdf2' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 129'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=141 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=141 AND public_id='7ec2669e-fa97-4c01-ae14-a8b8d5edf19a'::uuid AND version=2 AND md5(descripcion_larga)='c86c6e9b8c8fbf13ca7d8dfaecd5d272' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 141'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=148 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=148 AND public_id='7280e8f4-42b4-47f1-b842-fba32f0ba92d'::uuid AND version=2 AND md5(descripcion_larga)='f00aa2d295e9715d6996954d56f709e2' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 148'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=149 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=149 AND public_id='a9c5e0e4-524f-4f4e-b8ea-5ecd7fc15ad3'::uuid AND version=2 AND md5(descripcion_larga)='e820847355902b67ac9ce2bdb98a7d5c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 149'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=157 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=157 AND public_id='a5192944-d1bc-45c8-9ffa-f7557a0b0c4d'::uuid AND version=2 AND md5(descripcion_larga)='903d2a3e5101f68d662e481e9bc74c5d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 157'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=164 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=164 AND public_id='2d68ba2f-e660-4f8f-8816-95a725271b2b'::uuid AND version=2 AND md5(descripcion_larga)='4a3c1b3d201b493f59df9bb7fdd435dc' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 164'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=172 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=172 AND public_id='2f5f3383-e3df-42ea-9705-757b0c56a15f'::uuid AND version=2 AND md5(descripcion_larga)='eb2ed315cd58ed91a6d44a74fe8e0b9d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 172'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=175 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=175 AND public_id='af85d9b4-2afa-46b3-a8ac-1abfa270ffc1'::uuid AND version=2 AND md5(descripcion_larga)='001150f0827302bf9ce6b7630bb4eafb' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 175'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=177 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=177 AND public_id='7249b8b3-e648-422c-870c-60c54181690f'::uuid AND version=2 AND md5(descripcion_larga)='6b3af7f1a0712730d64cfe0f19200274' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 177'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=198 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=198 AND public_id='c6bd8e78-ca84-4014-a494-63e1202013b0'::uuid AND version=2 AND md5(descripcion_larga)='bc3f4a944346f20f4b0384bc636a5d25' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 198'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=202 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=202 AND public_id='30184ba7-876c-499e-b992-de4bbbe871b9'::uuid AND version=2 AND md5(descripcion_larga)='206f3040452107c540db7d1355bdd76c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 202'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=209 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=209 AND public_id='3bd84a69-9adf-438a-b3da-9e7108a4ae4b'::uuid AND version=2 AND md5(descripcion_larga)='135c010d7e92458e5f9a3fd92dae94a3' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 209'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=212 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=212 AND public_id='c5c15edc-fe9e-42a9-b262-e88b3070eb4e'::uuid AND version=2 AND md5(descripcion_larga)='54fdf29f696443126115ee8b8a89c648' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 212'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=214 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=214 AND public_id='eec985a2-f75c-4c54-b8ba-e3f883f21aaf'::uuid AND version=2 AND md5(descripcion_larga)='cafbe12bddcdb528bed81630208ee86e' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 214'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=216 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=216 AND public_id='7551ac2e-dc59-4df5-8acc-ca7b1958473e'::uuid AND version=2 AND md5(descripcion_larga)='01b9a44034b8b73d39f1f5147ff85642' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 216'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=217 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=217 AND public_id='645f5e78-a187-4198-8b94-568b9973f208'::uuid AND version=2 AND md5(descripcion_larga)='7ccbbf40e5d4556ef8bab6892af84fc6' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 217'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=218 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=218 AND public_id='34d248ee-0cf8-40b3-bbe1-7aa7ebe5ea47'::uuid AND version=2 AND md5(descripcion_larga)='05758ca9bc85dd9ec3d97a00b9365c62' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 218'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=219 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=219 AND public_id='94c3abb1-c020-48e2-b8bd-ad8f8e589fb7'::uuid AND version=2 AND md5(descripcion_larga)='c56ada334ce3b2261fda241228df5201' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 219'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=221 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=221 AND public_id='62cf00eb-ceeb-4832-b9d6-802526fc9f24'::uuid AND version=2 AND md5(descripcion_larga)='0c7abf4224de7556d0a4a8868ff279ec' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 221'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=234 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=234 AND public_id='eda4c362-f3a8-41df-a241-254c9746293f'::uuid AND version=2 AND md5(descripcion_larga)='524c828b888799b4cc70143cc4194349' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 234'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=240 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=240 AND public_id='825e30aa-51eb-4d0a-aba5-7a25a3ea508e'::uuid AND version=2 AND md5(descripcion_larga)='ce11dc6800c59e663372dd9fe6cb87dd' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 240'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=243 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=243 AND public_id='cb00dd91-75c2-4d16-9a34-0e2456c81e20'::uuid AND version=2 AND md5(descripcion_larga)='f1d70ba8671b9ee12509867841edbbe0' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 243'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=248 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=248 AND public_id='d451029f-468b-4e34-b758-aebe08749491'::uuid AND version=2 AND md5(descripcion_larga)='05dae6dffcf06e8c55fdb980ace15751' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 248'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=251 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=251 AND public_id='c88b5fa2-cc4a-410b-8d69-8d5975d01409'::uuid AND version=4 AND md5(descripcion_larga)='256a15aa72bc7e969fddb38adf4185d3' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 251'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=260 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=260 AND public_id='b00bde27-8092-4216-9774-8745ec78d9a4'::uuid AND version=2 AND md5(descripcion_larga)='640732ffaa583752b36e35760cc866ba' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 260'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=261 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=261 AND public_id='bbf5e9c1-7545-40a9-800b-4973dd056260'::uuid AND version=4 AND md5(descripcion_larga)='b6260cae00b6ea06ee437f34226ec018' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 261'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=263 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=263 AND public_id='ab08a79f-417d-426b-b966-9a561ad7a1dc'::uuid AND version=2 AND md5(descripcion_larga)='615cdebaef2cabc6eb789fd88345cd3f' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 263'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=267 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=267 AND public_id='3d270aac-ca38-4f1a-b69c-dcfa1eecf09b'::uuid AND version=2 AND md5(descripcion_larga)='18f781356939a9d9fec8f9a27f547436' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 267'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=293 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=293 AND public_id='b92f2e33-8568-4c55-bd95-2b0b3506e2b9'::uuid AND version=2 AND md5(descripcion_larga)='00c5c52be4a0db3c96645db8d77944a8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 293'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=297 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=297 AND public_id='cace1550-37d2-4d96-9324-8ade2478852b'::uuid AND version=2 AND md5(descripcion_larga)='5fa43ab4e465b80e8135e2e394fc0b0a' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 297'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=299 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=299 AND public_id='7f94eb9a-3add-4d6e-b7c9-69eb9fe1cdc8'::uuid AND version=2 AND md5(descripcion_larga)='d158c72f54b8e6af6d5523b86e18ef90' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 299'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=300 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=300 AND public_id='e4d1e6ae-c939-4f0d-9592-8ec6558b1e45'::uuid AND version=2 AND md5(descripcion_larga)='cce2c8eb9bde6fefce2f974f74cfb09e' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 300'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=301 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=301 AND public_id='521ecc43-cd7d-41b7-9268-01e834c4fa44'::uuid AND version=2 AND md5(descripcion_larga)='4ffca77fc3d08dff9a6619888bbb0c87' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 301'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=312 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=312 AND public_id='dc45574b-ef2c-42e6-919f-bc0bf6f308fb'::uuid AND version=4 AND md5(descripcion_larga)='399ee7137ecfdbf5d8f86850cc4ced95' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 312'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=318 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=318 AND public_id='5b96c1f3-2d86-4332-b736-db7700914247'::uuid AND version=2 AND md5(descripcion_larga)='bb8dd4b6ed1fbfdf9d3378a872e2f417' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 318'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=329 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=329 AND public_id='3200e60d-476e-4822-94b8-94aff8b6c9c3'::uuid AND version=2 AND md5(descripcion_larga)='708f17d4256358369a0d81db91eb026d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 329'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=336 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=336 AND public_id='3bb27b3c-bca1-48d3-b322-dfa8c6e15d11'::uuid AND version=2 AND md5(descripcion_larga)='803d77d10ec83f836cc4ce6ba0605b6c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 336'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=338 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=338 AND public_id='b67f77b3-3d34-4bdd-b777-8e1c248a16dc'::uuid AND version=2 AND md5(descripcion_larga)='258d609ca437b333f0ae2b1c1670afa5' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 338'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=340 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=340 AND public_id='735a2b59-21f1-4101-9d1b-a59a815a798d'::uuid AND version=2 AND md5(descripcion_larga)='26c60c6294784efd541809163f1fbc00' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 340'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=353 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=353 AND public_id='1eafa257-d986-4f40-a58c-3eb65dea1575'::uuid AND version=2 AND md5(descripcion_larga)='b1b71c82466b296cc398f70625290429' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 353'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=354 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=354 AND public_id='4d26d644-2873-4438-bda7-51b05e6e4f09'::uuid AND version=2 AND md5(descripcion_larga)='bc5f505872e27b08368ed76a6b295ade' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 354'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=357 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=357 AND public_id='c8e8679f-0be1-47c4-a548-f9acfb77ad78'::uuid AND version=2 AND md5(descripcion_larga)='a1737cad4331c424ec050697c13a1e93' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 357'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=360 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=360 AND public_id='78771074-0289-4b91-8623-07a7640c145a'::uuid AND version=2 AND md5(descripcion_larga)='96daaa740461e25451b4ed140ba4d4fb' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 360'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=362 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=362 AND public_id='31ad2b50-30ec-4150-aeed-37ce79d5db6a'::uuid AND version=4 AND md5(descripcion_larga)='bb1650e6223186ac0227637cd9ffe448' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 362'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=365 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=365 AND public_id='d4e9691e-bef1-478e-af0e-2a5e8f01012e'::uuid AND version=2 AND md5(descripcion_larga)='a6cb08f5464db41e7a4ced57adfd8380' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 365'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=367 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=367 AND public_id='3b91c020-b195-4128-89eb-affe6c9e5523'::uuid AND version=2 AND md5(descripcion_larga)='fbfe72004f1200eef12c91fe1f11c2af' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 367'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=368 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=368 AND public_id='141e3bc2-0962-4b38-8346-f90376d92bef'::uuid AND version=2 AND md5(descripcion_larga)='0c8365d43317350148a14819f5eeb278' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 368'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=381 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=381 AND public_id='93a1499e-6648-4815-ad49-7c3b5446670b'::uuid AND version=2 AND md5(descripcion_larga)='d4b7e9b343e43290f7c130a6602a63a8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 381'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=385 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=385 AND public_id='3ddcf8c8-2a70-40ca-9632-45e470c8385e'::uuid AND version=2 AND md5(descripcion_larga)='72a9c8d8fde88fb4f06903f9f8ef42e5' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 385'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=388 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=388 AND public_id='0f7fa1b8-a97b-4d3a-bdcb-e5453dd75eb2'::uuid AND version=2 AND md5(descripcion_larga)='5d407e1d6c4432807a4a7afb60e82e1d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 388'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=391 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=391 AND public_id='76dd2495-a281-43f2-a696-aa0353e9501e'::uuid AND version=2 AND md5(descripcion_larga)='2a78fd520803ab16aa3e4acec34cc416' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 391'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=393 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=393 AND public_id='e7671aaf-f602-4cf2-bed6-6c0fe63e6165'::uuid AND version=4 AND md5(descripcion_larga)='8c71e6364820055456cd4a5e8bb19762' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 393'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=402 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=402 AND public_id='0346c14d-e1f7-479e-8d9a-9d4ff17a6d16'::uuid AND version=4 AND md5(descripcion_larga)='f5269dcba3fca9fd7daafbec6da455d8' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 402'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=403 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=403 AND public_id='2e77097d-1a77-46ff-b96a-9ebfa81e5036'::uuid AND version=2 AND md5(descripcion_larga)='82e9d24df5a8596d4ca2d0390f31624c' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 403'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=406 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=406 AND public_id='78affd44-3860-4b8c-8e16-d2df7729bbd4'::uuid AND version=2 AND md5(descripcion_larga)='cc1cd982690a4d6640589183e5abc038' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 406'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=408 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=408 AND public_id='c98615bb-8a9f-4124-b8aa-96d6e451c581'::uuid AND version=2 AND md5(descripcion_larga)='6274dbb140282b5353d676d1b6a9dd73' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 408'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=412 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=412 AND public_id='f5e0d1a7-69fb-4a5f-8078-b29d69157669'::uuid AND version=4 AND md5(descripcion_larga)='435a47cd71194bb376d16e242eee5406' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 412'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=421 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=421 AND public_id='e0c5f05d-f641-4bcc-8b11-930f6f21b12f'::uuid AND version=2 AND md5(descripcion_larga)='ebd13713b69235856f08e86152c96aed' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 421'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=424 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=424 AND public_id='bd16eeb2-e333-48c3-931f-d63e4aee44b9'::uuid AND version=2 AND md5(descripcion_larga)='472bc57f045760c2020c93041506e87f' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 424'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=426 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=426 AND public_id='f91de4a7-3178-4533-a21c-e8f1ea113fc4'::uuid AND version=4 AND md5(descripcion_larga)='a6d0d0ccb06ecc4bc3217e9ba5efc16a' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 426'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=432 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=432 AND public_id='27af4caf-be79-4d74-8327-31f118eaf49e'::uuid AND version=2 AND md5(descripcion_larga)='e0161c86d89252f146ec7230321faa5d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 432'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=438 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=438 AND public_id='70532341-595c-417b-bd04-226946138bcb'::uuid AND version=2 AND md5(descripcion_larga)='219569fec1d4972adb6a838677272374' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 438'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=440 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=440 AND public_id='82ef63fe-7a67-4c02-9145-dea0daf8fcf8'::uuid AND version=2 AND md5(descripcion_larga)='b1cc9c3251965da69505c755f4eb3f49' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 440'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=451 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=451 AND public_id='fb4e9d28-1652-477e-b905-42972ef6c0a5'::uuid AND version=2 AND md5(descripcion_larga)='7953b188475edba4b8ffc6837a54b2ce' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 451'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=456 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=456 AND public_id='93008537-4ee1-48d7-83d4-93c47f3095da'::uuid AND version=2 AND md5(descripcion_larga)='abea5eddc012150134bf29ac8e5f458d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 456'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=463 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=463 AND public_id='6f635e53-4633-4fe0-831b-0b5d3ce1da7b'::uuid AND version=2 AND md5(descripcion_larga)='4dbe29cc1ee7c1f90836701964f18e1b' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 463'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=467 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=467 AND public_id='cb393d0a-2749-4839-85ad-ff617b2ac5f1'::uuid AND version=2 AND md5(descripcion_larga)='96752a45756462869c128da700f927f3' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 467'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=490 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=490 AND public_id='fa4f6465-132e-4722-aede-f9dd25d63cd7'::uuid AND version=4 AND md5(descripcion_larga)='f82e34341a8e700c34bfd335544ed064' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 490'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=497 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=497 AND public_id='63070a6e-b29d-47f6-b9c4-9c82cee9c72d'::uuid AND version=2 AND md5(descripcion_larga)='c2d1fe788baf11ba5ba139ff485eb9ce' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 497'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=500 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=500 AND public_id='a9fc3ffc-dfee-405c-8334-806d65e7c499'::uuid AND version=4 AND md5(descripcion_larga)='f830a33a5f39517a5c829a5f0a1e881d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 500'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=504 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=504 AND public_id='b220d9ed-b064-4f12-8553-fc079bd85f53'::uuid AND version=2 AND md5(descripcion_larga)='516b8538ef04f33b68e19a909fa19030' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 504'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=505 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=505 AND public_id='51d66b19-417a-4121-9791-ae9548f60718'::uuid AND version=2 AND md5(descripcion_larga)='d7a813f29304924075efab7ad0570cfe' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 505'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=507 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=507 AND public_id='75e41376-08d6-4002-8ca2-605a95225b2c'::uuid AND version=2 AND md5(descripcion_larga)='e1478b11800deb33c4ca72990fab377d' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 507'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=508 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=508 AND public_id='3bf8f23b-f3d9-460e-9698-2e11e06653fc'::uuid AND version=2 AND md5(descripcion_larga)='8f881976d9416a66bc6c69c4daba09ba' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 508'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=525 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=525 AND public_id='2b63ca1f-90f6-4a5f-8776-f27a951295c0'::uuid AND version=2 AND md5(descripcion_larga)='315288a56fc4fbab9600eb06dca638a4' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 525'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=528 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=528 AND public_id='75c283b9-ad88-47c7-9e36-2a52051dcd98'::uuid AND version=4 AND md5(descripcion_larga)='6079bcac96f71d38933edf5e7010b669' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 528'; END IF;
END $guardas$;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
La noticia municipal del 18/06/2026 acredita adjudicación de la convocatoria 2026: 251 beneficiarios entre media, superior y deporte; 39 nuevos beneficiarios son de educación superior. Se recuperó navegando el portal municipal, no usando la noticia de prensa como prueba.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No publica importe individual superior ni fecha final de recepción. Los 216 millones son presupuesto conjunto; no se dividen entre estudiantes.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://munipapudo.cl/noticias-y-actividades/noticias/papudo-entrega-251-becas-estudiantiles-con-inversion-municipal-superior-a-los-216-millones
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,descripcion_corta='Beca estudiantil de Papudo: convocatoria 2026 adjudicada. La entrega incluye educación media, superior y deporte; cuantía individual no publicada en la noticia.',url_oficial='https://munipapudo.cl/noticias-y-actividades/noticias/papudo-entrega-251-becas-estudiantiles-con-inversion-municipal-superior-a-los-216-millones' WHERE id_beca=1;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La cuenta municipal 2021, apartado Beca Municipal, registra 34 estudiantes superiores, 36.042 pesos mensuales y 360.420 anuales por estudiante. Se navegó el portal nuevo y su normativa publicada, que no contiene un llamado específico de esta beca.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Montos históricos 2021; no acreditan recepción ni presupuesto 2026. El índice de ordenanzas no se considera exhaustivo ni prueba de desaparición.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munilaestrella.cl/Documentos/CUENTA_PUBLICA_LA_ESTRELLA_2021.pdf ; https://munilaestrella.cl/nuestras-ordenanzas/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=2;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
DIDECO publica actualmente las subvenciones municipales 2026 para proyectos y mantiene sus funciones de desarrollo comunitario. Este llamado no es una postulación individual al apoyo superior.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Faltan bases o acto anual específico del aporte superior. No utilizar plazos de rendición de organizaciones ni la beca deportiva como calendario estudiantil.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.municombarbala.cl/departamento-desarrollo-comunitario-dideco/ ; https://www.municombarbala.cl/wp-content/uploads/2026/01/BASES-SUBVENCIONES-MUNICIPALES-2026.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=19;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La sección oficial actual de concursos de Colchane publica contratación para director del consultorio, no la beca de incentivo académico. La convocatoria 2023 citada en prensa conserva únicamente valor de pista.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No se acreditó convocatoria estudiantil 2026. No aplicar plazos laborales ni actualizar el millón de pesos y NEM 6,5 desde una noticia secundaria.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://imcolchane.cl/web/concursos-publicos/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=21;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Los documentos municipales actuales encontrados para 2026 corresponden al Programa Residencia Familiar Estudiantil, con pago a familias tutoras. No identifican una renovación del convenio SIPEE del acta de 2013.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Son poblaciones y prestaciones diferentes; faltan condiciones actuales del convenio universitario. Preservar ambos UUID sin convertir el aporte a tutoras en dinero para cualquier estudiante superior.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://transparencia.laserena.cl/documentos/doc_59_21042026092751.pdf ; https://transparencia.laserena.cl/documentos/doc_59_27032026042134.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=33;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El PLADECO Hualpén 2026–2032 describe asesoramiento de postulaciones FUAS, BPR e Indígena entre octubre y febrero. Esa función municipal no es una beca propia de mantención ni demuestra renovar el convenio IP Diego Portales.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Para 37 faltan condiciones actuales del convenio; para 440 falta sustento de una mantención municipal individual distinta de la orientación estatal. No se trasladan porcentajes entre las dos fichas.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.hualpenciudad.cl/wp-content/uploads/2025/12/Pladeco-2026-2032-2-reducido.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=37;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El acta 121 de 12/11/2024, páginas 10–12, aprueba expresamente la Beca Carlos Ibáñez del Campo para 2025: 140 cupos, cien municipales y cuarenta particulares subvencionados. La discusión la define por rendimiento académico, no como selección por mayor vulnerabilidad.
LÍMITES Y DATOS SIN CONFIRMACIÓN: La aprobación 2025 no es convocatoria 2026 ni permite actualizar los 50.000 mensuales de la noticia 2022. No se ha localizado un acto anual 2026 suficiente en esta consulta.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.corporacionlinares.cl/ley20285/pdf/07/actas_de_concejo/ACTA_121_del_12_11_2024.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=49;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página específica de Colina sigue titulada Beneficiarios Proceso de Becas Educación Superior 2025. El expediente incorpora bases 2025, pero el archivo recuperado es escaneo y no se ha considerado leído por su descarga.
LÍMITES Y DATOS SIN CONFIRMACIÓN: La página de resultados 2025 no prueba llamado 2026. El calendario debe contrastarse con bases o modificaciones legibles; no extrapolar umbrales de 2024 a 2026.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.colina.cl/beneficiarios-proceso-de-becas-educacion-superior-2025/ ; https://transparencia.colina.cl/archivos/41db94d-cca6.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=52;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El portal DIDECO Pudahuel muestra un servicio de consulta de resultados de Beca de Educación Superior mediante RUT, no un formulario público de nueva postulación con calendario.
LÍMITES Y DATOS SIN CONFIRMACIÓN: El texto público no identifica año ni plazo. No consultar datos personales ni interpretar la presencia del módulo como recepción abierta.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://dideco.mpudahuel.cl/app/tramites/home.asp
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=55;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Las publicaciones educativas 2026 de San Miguel incluyen Beca Dorada INACAP para personas mayores, con financiación de una carrera técnica. Es una beca institucional difundida por el municipio.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No demuestra las condiciones de la ayuda superior municipal de la candidata. No reemplazar población ni modalidad por compartir la palabra beca.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://web.sanmiguel.cl/category/educacion/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=57;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia oficial del 02/07/2025 identifica Beca de Transporte Escolar: 60 cupos y 100.000 pesos anuales para media y superior. El aumento a 200.000 se presenta como intención que debe discutir el concejo.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No se acredita identidad con la ayuda superior general ni aprobación del aumento; no publicar 200.000 como importe confirmado ni crear calendario 2026.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://munitiltil.cl/tiltil-aumenta-cupos-de-la-beca-de-transporte-escolar-y-proyecta-duplicar-el-monto-del-beneficio/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=64;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se contrastó la identidad histórica del aporte superior de Cholchol con la variante de transporte 463. Las licitaciones del servicio vespertino no acreditan una transferencia económica individual del programa histórico 2019–2020.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Portal cholchol.cl inaccesible y búsqueda actual sin fuente específica suficiente. La página de resultados alojada en un proyecto estudiantil github.io no es fuente municipal. Esta reconsulta es limitada: no se ha releído una convocatoria municipal actual ni se afirma que no exista.
ALCANCE DE ESTA CONSULTA: LIMITADA_POR_ACCESO.
FUENTES: https://www.cholchol.cl/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=68;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Relectura de ordenanza Chiguayante de 11/07/2000: distingue áreas deportiva, artística y científica; prevé hasta cinco becas y tope 15 UTM, con continuidad superior excepcional. Marzo/abril son determinación y otorgamiento; la disposición de 2000 cambia esos meses para ese único año.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No presenta una convocatoria general superior 2026. No trasladar referencias PAA, pagos o límites de la norma histórica a una convocatoria actual sin acto anual.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.chiguayante.cl/transparencia/2017/7_ACTOS%20Y%20RESOLUCIONES%20CON%20EFECTOS%20SOBRE%20TERCEROS/ORDENANZAS/19%20Para_otorgamiento_de_Becas_a_estudiantes_destacados.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=90;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se leyó el apartado UPLA del catálogo DEMRE admisión 2026, páginas 262–264. Enumera servicios de salud, préstamos, deporte, alimentación deportiva y acompañamiento, sin una convocatoria de residencia interna de esta ficha.
LÍMITES Y DATOS SIN CONFIRMACIÓN: El apartado no es un inventario exhaustivo de toda ayuda UPLA y su silencio no acredita eliminación. Faltan cupos, prestación y calendario actuales de residencia.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=92;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Las bases oficiales Gorbea 2025 localizadas describen categorías deportivas de 200.000, 350.000 y 500.000 pesos, no el aporte superior de la cuenta pública 2023.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No sumar las categorías deportivas ni trasladarlas a la ayuda superior. Falta expediente anual específico del aporte estudiantil.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.municipalidadgorbea.cl/transparencia/images/ArchivosHOME/Anuncios/Bonos/2025/BASES%20BECAS%20DEPORTIVAS%202025%20WEB.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=100;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Relectura de ordenanza Chiguayante de 11/07/2000: distingue áreas deportiva, artística y científica; prevé hasta cinco becas y tope 15 UTM, con continuidad superior excepcional. Marzo/abril son determinación y otorgamiento; la disposición de 2000 cambia esos meses para ese único año.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No presenta una convocatoria general superior 2026. No trasladar referencias PAA, pagos o límites de la norma histórica a una convocatoria actual sin acto anual.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.chiguayante.cl/transparencia/2017/7_ACTOS%20Y%20RESOLUCIONES%20CON%20EFECTOS%20SOBRE%20TERCEROS/ORDENANZAS/19%20Para_otorgamiento_de_Becas_a_estudiantes_destacados.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=102;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La sección oficial actual de concursos de Olivar contiene cargos profesionales, educativos y programas laborales; sus estados cerrado/abierto pertenecen a esos cargos.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No permite actualizar la beca superior municipal. Falta convocatoria o acto de adjudicación que identifique el mismo apoyo y año.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://muniolivar.cl/concursos/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=105;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Releída la ficha Alto Biobío del catastro UCSC, página 60: aporte anual cuyo monto y seleccionados dependen del presupuesto 2025; exige domicilio local, RSH vigente y cédula. Publica recepción 26 de marzo–26 de abril sin convertirla en convocatoria municipal 2026.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Catastro referencial universitario; no fija importe ni ratifica recepción anual actual. No trasladar esas fechas a 2026.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=121;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Putre publica subvención municipal 2026 para organizaciones comunitarias y concursos laborales con fechas propias. La etiqueta Resultado de estos concursos no corresponde a la beca superior.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Falta documentación anual específica de la beca. No usar el cierre de veterinario, CESFAM o subvenciones como plazo estudiantil.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://imputre.cl/concursos/ ; https://imputre.cl/subvencion-2026/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=126;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se recuperó el acta 24/2022, pp. 38–42, acuerdo 226: modifica monto anual de 200.000 a 350.000 pesos en dos cuotas de 175.000, amplía a 115 cupos y elimina la limitación de un becado por familia. No modifica expresamente el NEM en los pasajes leídos.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Esto corrige el antecedente 2022, no demuestra presupuesto 2026. Persiste la discrepancia entre NEM 5,3 de trámites y 5,5 del reglamento anterior; no elegir uno sin norma aplicable.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.muermos.cl/transparencia2.0/images/A_Transparencia_2022/Actas/acta_24_22_compressed.pdf ; https://transparencia.muermos.cl/index.php?id=192%3Areglamento-interno&option=com_phocadownload&view=category
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=127;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El mapa municipal actual enlaza la postulación deportiva 2026 y los resultados de subvenciones a organizaciones; no son bases del incentivo de ingreso superior de estas candidatas.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Falta acto específico actual del incentivo superior y su monto. La categoría becas o una entrega de reconocimiento no acredita por sí sola la modalidad monetaria.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://penaflor.cl/mapa-del-sitio/ ; https://penaflor.cl/postulacion-becas-deportivas-2026/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=129;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
Se recuperó la página municipal actual de Proyecto Apadrinamiento Talcahuano: estudiantes de 10 a 23 años, residencia comunal, mérito y vulnerabilidad; apoyo económico mediante empresas. Declara expresamente que actualmente no hay cupos y avisará nuevos procesos. La identidad coincide con el alcance editorial de esta candidata.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No publica importe, cierre exacto ni umbral RSH/NEM. No inventar fecha para representar la ausencia de cupos ni describir el programa como extinguido.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://web2026.talcahuano.cl/centro-de-servicios/jovenes/vinculacion-con-el-medio
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Proyecto Apadrinamiento Talcahuano',descripcion_corta='Proyecto Apadrinamiento de Talcahuano para estudiantes de 10 a 23 años. El municipio informa que actualmente no hay cupos; nuevas convocatorias por confirmar.',url_oficial='https://web2026.talcahuano.cl/centro-de-servicios/jovenes/vinculacion-con-el-medio' WHERE id_beca=141;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El portal actual INACAP separa becas Mineduc y JUNAEB. El reconocimiento al Mérito Académico Osorno de julio 2026 entrega beca de diplomado a titulados, distinta de la rebaja de matrícula/arancel a escolares seleccionados por sus liceos del antecedente Mérito INACAP.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No se acreditó continuidad anual de esa rebaja escolar; no reemplazarla por un diplomado de educación continua ni por BECH.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://portal.inacap.cl/financiamiento-estudiantil/becas ; https://portal.inacap.cl/w/inacap-osorno-reconoci%C3%B3-a-titulados-destacados-por-su-excelencia-acad%C3%A9mica-en-ceremonia-de-m%C3%A9rito-acad%C3%A9mico-2025
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=148;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se abrió el visor oficial Antuco del procedimiento de convocatoria de Beca Municipal de Educación Superior. Describe evaluación social y académica, decreto y transferencia; el plazo de recepción solo dice Periodo. La fecha mostrada es de impresión y las firmas del formato están en blanco.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No acredita un calendario aprobado 2026 ni monto individual. No confundir fecha de impresión, duraciones internas de evaluación o plantilla procedimental con bases anuales firmadas.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://serviciosantuco.cl/procedimientos_administrativos.php
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=149;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El conjunto oficial de carreras de Puente Alto describe aporte económico a residentes que cursan estudios técnicos, profesionales o superiores, con última actualización 01/03/2024. La noticia FUAS refiere beneficios estatales 2026, no una recepción municipal propia.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No hay calendario municipal actual en el conjunto; no utilizar frecuencia anual del dataset ni plazos FUAS como apertura de esta beca. Preservar ambas fichas.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://datos.mpuentealto.cl/datasets/197867/beca-municipal-de-educacion-superior-carrera/ ; https://www.mpuentealto.cl/ya-estan-abiertas-las-postulaciones-para-acceder-a-los-beneficios-estudiantiles-de-la-educacion-superior/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=157;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El índice normativo municipal enlaza el decreto 2184 de 18/05/2023. Su única página, leída visualmente en Drive, añade un artículo transitorio que fija 273.248 pesos para postulantes y renovantes, en una cuota única durante 2023. La modificación 2680 corresponde a 2020.
LÍMITES Y DATOS SIN CONFIRMACIÓN: El importe está delimitado expresamente a 2023; no actualiza las reglas de 2020 ni acredita cuantía o calendario 2026. No se considera exhaustivo el índice normativo.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.transparenciasantacruz.cl/potestades-marco-normativo/marco-normativo ; https://drive.google.com/file/d/1XS_jZC41Rs_GVS7ePben2FbYxXLcDsA9/view
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=164;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se recuperó y leyó la ficha histórica oficial Paredones vinculada al acuerdo 22 de 31/03/2011. Describe 25 becas de 80.000 pesos; carreras diurnas presenciales de al menos cuatro semestres, notas 5,5 de egreso y 5,0 en superior y recepción anual 16 abril–15 mayo.
LÍMITES Y DATOS SIN CONFIRMACIÓN: La ficha histórica no demuestra presupuesto o llamado 2026; conserva FPS e ingreso per cápita de 150.000. No renovar esos importes ni fechas al año actual sin acto anual.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.comunaparedones.cl/index.php/descargas/transparencia-historica/category/59-beca-ensenanza-superior?download=1791:benca-ensenanza
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=172;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El FAQ UPLA de 21/01/2025 identifica Beca de Honor: 25% del arancel anual a los 15 mejores puntajes, al menos cinco para pedagogía. Se contrastó con el apartado UPLA del catálogo 2026, que no aporta condiciones de esta beca de Honor.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No certificar asignación 2026/2027 por repetición. Ambas candidatas comparten antecedente, sin eliminar UUID ni fusionar favoritos.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.upla.cl/admision/2025/01/21/preguntas-frecuentes-sobre-el-proceso-de-admision-y-matricula-2025/ ; https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=175;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El instructivo UCSH recuperado conserva resolución 2014/001 de 24/06/2014. Su beca de funcionarios comprende personal académico y de gestión, cónyuges e hijos y remite a resolución 2013/056. La página de admisión 2026 ofrece otros convenios, sin aclarar esa beca de familiares.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No extrapolar descuentos Carabineros/ANEF u otros convenios a familiares de personal UCSH. Faltan porcentaje y condiciones actuales de esta modalidad específica.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://zonaestudiantes.ucsh.cl/documentos/Instructivo_GraL_Ayudas_Estudiantiles_UCSH.pdf ; https://admisionucsh.cl/becas-y-beneficios/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=177;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia Perquenco de 601 aportes acumulados describe expresamente 2005–2017 y 70 beneficiarios de 100.000 pesos en 2017; distingue premios adicionales por promedio universitario y técnico.
LÍMITES Y DATOS SIN CONFIRMACIÓN: La mención 2026 en el menú es permiso de circulación, no edición de la beca. Falta norma anual actual; no sumar premios al aporte ordinario ni usar agregados históricos como cupos nuevos.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.perquenco.cl/perquenco-ha-beneficiado-a-601-alumnos-con-beca-municipal-para-la-educacion-superior/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=198;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La ficha esencial ya identifica un servicio no monetario de pasajes Llay Llay–Valparaíso/Viña del Mar. Se contrastó ese alcance con la consulta pública municipal actual; una compra de transporte no equivale al procedimiento de selección de estudiantes.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No se recuperaron bases de postulación individual, cupos disponibles ni cierre 2026. Portal consultado inaccesible; reconsulta limitada, sin dictamen de inexistencia ni cierre.
ALCANCE DE ESTA CONSULTA: LIMITADA_POR_ACCESO.
FUENTES: https://www.mercadopublico.cl/Procurement/Modules/RFB/DetailsAcquisition.aspx?qs=kGDvPC8G0Hqw%2B3YyfIoLpQ%3D%3D
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca de pasajes Llay Llay–Valparaíso/Viña del Mar' WHERE id_beca=202;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se leyó visualmente el ORD 318 de 17/06/2024, primera página del expediente Río Bueno: solicita aprobar presupuesto de becas 2024 para 125 estudiantes y considera seis postulantes adicionales. Es una solicitud presupuestaria, no el acto final de adjudicación.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No dividir el presupuesto para inferir un importe individual ni sustituir el tope histórico del PADEM 2007. Se conserva el antecedente separado del decreto 3126/2024 ya documentado; no acredita convocatoria 2026.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://muniriobueno.cl/uptransparencia/pdf/01_PDF_23/BECA%20MUNICIPAL%202024_C.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=209;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La resolución Recoleta 162/2023, pp.10–11, exige residencia acreditada por RSH, primera carrera de al menos cuatro semestres, promedio 5,0 y no tener gratuidad. Delega la recepción de al menos 21 días al mes que indique DIDECO; no fija un cierre anual perpetuo.
LÍMITES Y DATOS SIN CONFIRMACIÓN: El instrumento exige antecedentes 2023 y no certifica llamado 2026. No tomar la rendición de segunda cuota como recepción de nuevos postulantes.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.recoletatransparente.cl/archivos_2023/programas_sociales/RES%20162_OCR.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=212;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El catálogo DEMRE 2026, apartado UPLA p.263, confirma alimentación para deportistas de selecciones y su evaluación específica. El FAQ también distingue alimentación artístico-musical.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Son modalidades específicas; no acreditan la alimentación interna general del antecedente de 2011 ni equivalen a BAES. Falta instrumento vigente de la ayuda general.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf ; https://www.upla.cl/admision/2025/01/21/preguntas-frecuentes-sobre-el-proceso-de-admision-y-matricula-2025/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=214;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se recuperaron la noticia de la Beca Aporte Económico OMAJ y el Manual DIDECO 2026. La noticia exige alumno regular 2024, 19 aportes de 500.000 pesos y 27 mayo–24 junio; contiene diferencias entre primero–cuarto y primero–segundo año. El manual actual localizado trata becas estatales.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Falta precisión de cohorte elegible y llamado municipal actual. No transformar la noticia 2024 en postulación 2026 ni sustituirla por el concurso artístico/deportivo.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.municipalidadchillan.cl/sitio/index.php?not=3147 ; https://www.municipalidadchillan.cl/sitio/descargas/DIDECO/Manual-DIDECO-2026.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=216;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El reglamento UC disponible es texto refundido 2000/2001, no una norma 2026 por su ruta de subida 2021. Los artículos 4 y 8 delegan criterios, cupos y calendario anuales; utiliza PAA. Materiales UC 2020 describen una modalidad de apoyo mensual ligada a gratuidad distinta de la exención histórica.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No transformar puntajes PAA ni afirmar continuidad de una cobertura histórica como convocatoria actual. Falta instrumento anual o ficha específica actual que armonice las modalidades.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://registrosacademicos.uc.cl/wp-content/uploads/2021/11/padreHurtado.pdf ; https://pedagogiamediaenciencias.uc.cl/wp-content/uploads/2021/02/alternativas-financiamiento-2020.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=217;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se contrastó el alcance histórico de Reembolso de Matrícula de Licantén: modalidades del 100, 70 y 40 por ciento del primer año o semestre. La consulta del expediente y directorio municipal actual presenta barreras; no se confunde la noticia Beca Presidente de la República con este reembolso local.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No se ha recuperado convocatoria 2026 legible. Los porcentajes y población del expediente histórico no se certifican para nuevos postulantes actuales.
ALCANCE DE ESTA CONSULTA: LIMITADA_POR_ACCESO.
FUENTES: https://www.mlicanten.cl/laip/Transparencia%20Municipalidad/Cuentas%20Publicas%20de%20Gestion/2023/Cuenta%20P%C3%BAblica%202023.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=218;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
Lectura visual íntegra del calendario firmado decreto 614 de 09/03/2026: Profesionales del Futuro recibe 02–31 marzo y renovación 03–31 agosto. El reglamento distingue nuevos NEM 6,0 y PAES promedio 700; renovantes promedio 5,0 sin dos o más reprobadas; RSH 70% con evaluación especial hasta 80% y carreras de ocho semestres o más.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Agosto es renovación, no nuevos cupos. Importe anual fijado por acto anual no recuperado: no especificado. El plazo de septiembre es del Bono de Movilización. No convertir la excepción RSH en acceso automático.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.municipalidadtucapel.cl/becas ; https://www.munitucapel.cl/filesglob/1773648632.pdf ; https://www.munitucapel.cl/filesglob/1773648567.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca Profesionales del Futuro de Tucapel',fecha_inicio_postulacion=DATE '2026-08-03',fecha_cierre_postulacion=DATE '2026-08-31',descripcion_corta='Profesionales del Futuro de Tucapel: renovación del 3 al 31 de agosto de 2026, cerrada. El ingreso nuevo fue del 2 al 31 de marzo; importe anual no especificado.',url_oficial='https://www.municipalidadtucapel.cl/becas',monto_cobertura='Aporte de Profesionales del Futuro. Cuantía anual 2026 no especificada en el calendario y reglamento consultados; no trasladar importes de otros años.',cobertura_tipo='MONETARIA',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad='DESCONOCIDA',cobertura_porcentaje=NULL WHERE id_beca=219;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Recuperada la guía publicada por el portal municipal nuevo. Leído el apartado DIDECO/asistencialidad, páginas PDF 15–16: describe ayudas sociales generales mediante evaluación y RSH local; no identifica una beca Nueva Ciudad ni una convocatoria anual de educación superior.
LÍMITES Y DATOS SIN CONFIRMACIÓN: El PADEM 2019 continúa inaccesible. La asistencia genérica no sustituye la identidad ni el importe histórico de 2018. No afirmar desaparición porque el programa no figure en esta guía.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.municipalidadgraneros.cl/guia-servicios/guia.pdf ; https://www.municipalidadgraneros.cl/dideco ; https://www.daemgraneros.cl/file/padem2019.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=221;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El reglamento Requínoa localizado corresponde de forma explícita a Proceso 2014, con recepción 24/03–30/04/2014 y certificado de alumno regular 2014. Dispone que el monto y los cupos se fijan anualmente. El 2026 del nombre de la ficha no está sustentado.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Corregir año engañoso del nombre y conservar la fuente histórica. No trasladar la convocatoria 2014 ni sus documentos a 2026 ni afirmar que el programa es falso.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.transparenciarequinoa.cl/nueweb/tact/requinoa/2014/secretaria%20municipal/7.-%20JULIO2014/DA1815.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca Municipal Dr. Joaquín Contreras Silva (antecedente 2014)',descripcion_corta='Beca Dr. Joaquín Contreras Silva de Requínoa documentada para 2014. No se ha acreditado una convocatoria 2026; importe y disponibilidad actuales por confirmar.' WHERE id_beca=234;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La referencia específica SOCIAL.pdf de Vicuña no resuelve DNS en la consulta actual. Se revisó el alcance histórico ya conservado, que distingue NEM 6,0 de ingreso y promedio 4,5 de continuidad; no se convierte en una nueva convocatoria.
LÍMITES Y DATOS SIN CONFIRMACIÓN: La búsqueda dirigida no recuperó bases actuales suficientes. No se han acreditado monto, periodicidad ni calendario 2026; no se certifica cierre ni falsedad.
ALCANCE DE ESTA CONSULTA: LIMITADA_POR_ACCESO.
FUENTES: https://www.transparenciavicuna.cl/wp-content/uploads/2023/09/SOCIAL.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=240;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
La noticia municipal de 13/08/2026 acredita entrega de Beca de Enseñanza Superior 2026 a 86 estudiantes: 41 renovantes y 45 nuevos. Sustituye la duda de existencia actual basada únicamente en noticia 2016.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Los cerca de 65 millones son inversión agregada, no monto individual. Fecha de entrega no es cierre; se conserva cierre desconocido mientras no se recupere calendario.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://portal.mph.cl/?p=30433
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,descripcion_corta='Beca de Enseñanza Superior de Padre Hurtado: 86 estudiantes beneficiados en 2026. Proceso adjudicado; importe individual y día de cierre no especificados.',url_oficial='https://portal.mph.cl/?p=30433' WHERE id_beca=243;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se revisó la delimitación de la Beca Pedro Aguirre Cerda de Calle Larga: presupuesto global de siete millones en 2012, no cuantía por estudiante. El enlace específico de transparencia no resuelve DNS. Las noticias periodísticas no se usan como confirmación oficial anual.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No se recuperaron bases oficiales 2026 ni importe individual. Las noticias antiguas que exhiben una fecha actual en la cabecera del medio no se convierten en convocatoria actual.
ALCANCE DE ESTA CONSULTA: LIMITADA_POR_ACCESO.
FUENTES: https://www.transparencia.callelarga.cl/Archivos/DeptoSocial/6.-Becas/Beca%20Pedro%20Aguirre%20Cerda/programa%20BECA%20PEDRO%20AGUIRRE%20CERDA.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=248;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página Peumo recuperada publica Beneficiarios de la Beca Municipal sin año en su texto; el pie 2026 es copyright del sitio. El afiche conservado procede de marzo 2025.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No actualizar convocatoria por copyright ni fijar fecha de recepción a partir de una lista de seleccionados. Faltan bases o aviso oficial anual actual identificable.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://mpeumo.cl/page/2/?paged=2 ; https://mpeumo.cl/wp-content/uploads/2025/03/481277172_933850362293800_8297977883969411565_n.jpg
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=251;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se consultaron en navegador beneficios Santo Tomás y su enlace específico a becas internas. La vista recuperada conserva filtros y descripción general, sin tarjeta de Copago ni condiciones específicas. La Beca Matrícula 2027 es otro beneficio.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No atribuir el 100% de matrícula ni cierre 05/12/2026 a Copago. Faltan modalidad UST/IP/CFT y norma específica actual de esta beca.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.tupuedes.cl/becas-beneficios/ ; https://www.tupuedes.cl/becas-y-beneficios/becas-internas/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=260;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El portal actual Rauco identifica sus servicios y normativa comunal, pero no acredita que la plataforma beca.muniarauco.cl de la ficha original pertenezca a Rauco. El acta ordinaria 28 debate una eventual beca deportiva, no una beca superior ya reglamentada.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Persiste identidad sin sustento suficiente. Conservar UUID y advertencia; no sustituir Rauco por Arauco ni tratar una propuesta deportiva como una ayuda superior aprobada.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munirauco.cl/ ; https://www.munirauco.cl/actas/pdf/2025-2028/ORDN%C2%B0028.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=261;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Transparencia UNAP agosto 2026 publica Primera Preferencia con 50% de matrícula, referencias PSU/PDT y fundamento 10-0847-25. Se leyeron los artículos 4–10 y la disposición transitoria del reglamento enlazado, cursado el 20/08/2025: enumera cinco becas de estudios sin Primera Preferencia y conserva reglas anteriores para renovantes ya beneficiados.
LÍMITES Y DATOS SIN CONFIRMACIÓN: La tabla publicada y el reglamento enlazado no concilian la admisión de nuevos postulantes a Primera Preferencia. El 50% no se certifica para un ingreso nuevo 2026. No afirmar eliminación del programa ni extender calendario DEMRE a esta modalidad.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://transparencia.unap.cl/activa/web/index.php?a=2026&action=plantillas_generar_plantilla&ia=9320&ig=92&m=8 ; https://transparencia.unap.cl/activa/web/index.php?action=plantillas_generar_archivo&ig=92&m=2&a=2026&ia=9310
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=263;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia oficial Los Sauces 2026 corresponde a residencia Estudia Tranquilo: alojamiento en Temuco, promedio 5,0, RSH hasta 40% y recepción 16–18 febrero. La beca monetaria general de los antecedentes es otra prestación.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No trasladar requisitos o cierre de residencia a la beca monetaria ni fusionar las dos candidatas sin equivalencia positiva de modalidad y año.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munilossauces.cl/noticias/postulacion-a-residencia-estudiantil-2026-estudia--22964
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=267;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
La noticia oficial de 17/06/2026 se recuperó en navegador: entrega de 166 becas, 165 tradicionales y una excepcional PAES. Acredita ejecución y selección del ciclo 2026.
LÍMITES Y DATOS SIN CONFIRMACIÓN: El millón de pesos pertenece exclusivamente al caso excepcional PAES. No usarlo como importe de las 165 becas tradicionales. Fechas de postulación 2026 e importe ordinario no publicados en esta noticia.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://munichue.com/wp/municipalidad-de-curanilahue-entrego-166-becas-a-estudiantes-que-cursan-su-educacion-superior/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,descripcion_corta='Beca superior de Curanilahue: proceso 2026 adjudicado, con 165 becas tradicionales y un premio excepcional PAES. El millón de pesos corresponde solo al premio.',url_oficial='https://munichue.com/wp/municipalidad-de-curanilahue-entrego-166-becas-a-estudiantes-que-cursan-su-educacion-superior/' WHERE id_beca=293;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Los documentos municipales actuales encontrados para 2026 corresponden al Programa Residencia Familiar Estudiantil, con pago a familias tutoras. No identifican una renovación del convenio SIPEE del acta de 2013.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Son poblaciones y prestaciones diferentes; faltan condiciones actuales del convenio universitario. Preservar ambos UUID sin convertir el aporte a tutoras en dinero para cualquier estudiante superior.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://transparencia.laserena.cl/documentos/doc_59_21042026092751.pdf ; https://transparencia.laserena.cl/documentos/doc_59_27032026042134.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=297;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Superada la limitación técnica de tamaño y releída la cuenta gestión Fresia 2023, página impresa 139: Beca de Movilización, treinta cupos, cuatro UTM por estudiante en dos entregas semestrales mayo/agosto; no renovable, recepción marzo/abril. El presupuesto global 2024 de 36,4 millones abarca varias becas.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Ni los meses genéricos ni el presupuesto agregado fijan cierre o cuantía individual 2026. El portal de servicios consultado no aporta una convocatoria específica de esta modalidad.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munifresia.cl/transparencia/descargas/MecanismoParticipacionCiudadana/CuentaPublica/2024/CuentaPublica2024-Gestion2023.pdf ; https://mail.munifresia.cl/servicios
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=299;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Releída la ficha Cobquecura del catastro UCSC, página 13: aporte superior fuera de la comuna de 150.000 pesos y recepción 15 mayo–14 junio. Difiere de las bases municipales 2025 ya conservadas, que distinguen 130.000, 160.000 y 90.000 según modalidad.
LÍMITES Y DATOS SIN CONFIRMACIÓN: El catastro no prevalece sobre bases municipales del mismo ciclo. La nueva consulta de las bases está bloqueada; no se ha recuperado acto anual 2026 y no se promedian montos ni mezclan modalidades.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf ; https://cobquecura.cl/wp-content/uploads/BASES-APORTE-EDUCACION-SUPERIOR-ANO-2025.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=300;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia municipal Chaitén recuperada confirma primer semestre 2023 con cierre 31/03/2023 y mínimos diferenciados: egreso de media 5,0 y continuidad superior 4,5. La segunda publicación disponible identifica año 2024.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Ambos llamados conservan su año. Falta calendario 2026; no trasladar el 31 de marzo por repetición ni usar subvenciones de verano para organizaciones como beca individual.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.municipalidadchaiten.cl/abierto-se-encuentra-el-proceso-de-postulacion-a-beca-municipal/ ; https://www.municipalidadchaiten.cl/se-encuentra-abierto-el-proceso-de-postulacion-a-la-beca-municipal-2024/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=301;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El portal institucional de Toltén responde con SITIO WEB EN MANTENCIÓN. Se contrastó el alcance preservado de los antecedentes 2013/2020; no hay una convocatoria actual recuperable en esta consulta.
LÍMITES Y DATOS SIN CONFIRMACIÓN: La mantención del sitio no demuestra cierre o desaparición. No se actualizaron importe, requisitos ni calendario 2026 a partir de las copias históricas.
ALCANCE DE ESTA CONSULTA: LIMITADA_POR_ACCESO.
FUENTES: https://www.tolten.cl/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=312;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
El decreto SM-02912/2026 de 06/05/2026 aprueba adjudicación de 50 becas: 530 solicitudes, 106 admisibles. Acredita proceso evaluado y adjudicado. La modificación SM-02120/2026 de 23/03/2026 altera resultados y ceremonia, manteniendo 23 febrero–02 marzo de recepción en el calendario restatado.
LÍMITES Y DATOS SIN CONFIRMACIÓN: El decreto de mayo cita además SM-2606/2026 de 17/04/2026 no leído; la fecha final exacta queda desconocida. No inventar su alcance ni afirmar que la modificación de marzo fue la última. No copiar datos personales de la nómina.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://munipedroaguirrecerda.gob.cl/app/uploads/2026/05/2912-5.pdf ; https://munipedroaguirrecerda.gob.cl/app/uploads/2026/02/modificacion-decreto-becas.pdf ; https://munipedroaguirrecerda.gob.cl/postula-a-la-nueva-beca-municipal-de-educacion-superior-2026/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,descripcion_corta='Beca superior de Pedro Aguirre Cerda: 50 becas adjudicadas en mayo de 2026. Beneficio de hasta $500.000; fecha final tras modificaciones por confirmar.',url_oficial='https://munipedroaguirrecerda.gob.cl/app/uploads/2026/05/2912-5.pdf' WHERE id_beca=318;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La página específica de devolución de matrícula sigue fechada 15/01/2024 y enlaza formularios 2024. El aviso municipal de septiembre 2026 es orientación FUAS 2027, no nuevas bases de la devolución municipal.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Falta convocatoria actual de esa misma modalidad. No actualizar año por noticias recientes del portal ni trasladar cierre estatal.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://santajuana.cl/beca-devolucion-de-matricula/ ; https://santajuana.cl/%F0%9F%8E%93-atencion-estudiantes-y-familias-de-santa-juana-%F0%9F%8E%93/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=329;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La guía Santa María 2016 distingue ayudas universitarias para residentes locales, aportes de matrícula, pasajes o mensualidad recibidos dos veces al año. La fila separada llamada Beca Municipal exige residencia de Rinconada, por lo que sus condiciones no se atribuyen a Santa María.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No hay importe ni convocatoria anual actual de la ayuda de Santa María en esa ficha. No convertir una tabla de otra comuna en requisito ni la frecuencia semestral en plazo exacto.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.santamariatransparente.cl/web/images/stories/Contenido/Tramites/Tramites_SOCIAL2016.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=336;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Releída UdeC 2024, página 13: Quilaco, 40.000 mensuales marzo–diciembre, primera carrera superior presencial u online, residencia y RSH local; continuidad con 50% de ramos aprobados. Recepción 1–31 marzo y reevaluación 1–31 agosto. La entrada UCSC titulada Quilaco muestra contacto de Quilleco: no es evidencia de un calendario alternativo de Quilaco.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Se resuelve la falsa equivalencia entre comunas, sin certificar vigencia 2026 de la guía 2024. Faltan ratificación municipal actual y monto de este ciclo.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://cade.udec.cl/wp-content/uploads/2024/10/Catastro-Beneficios-Municipales-2.pdf ; https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=338;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se contrastó la modalidad ya acreditada por contratación: transporte vespertino Caldera–Copiapó, no aporte monetario. El portal municipal actual enumera noticias y documentos laborales/FONDESCO, que no constituyen bases individuales de movilización estudiantil.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Sin requisitos de asignación individual, cupos disponibles ni cierre acreditado. Una licitación de transporte no prueba que se acepten postulaciones hoy.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://caldera.cl/static/inicio/ ; https://www.mercadopublico.cl/Procurement/Modules/RFB/DetailsAcquisition.aspx?qs=RrIdIuqVe8AGCxHRVJoIIg%3D%3D
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca de movilización vespertina Caldera–Copiapó' WHERE id_beca=340;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
DIDECO Tocopilla mantiene función expresa de difundir, gestionar y entregar beneficios mediante Beca Municipal. Las subvenciones 2026–2027 localizadas son para organizaciones; el preuniversitario 2026 es preparación PAES.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Faltan bases individuales de la beca superior; no convertir la función orgánica o apertura de subvenciones en convocatoria estudiantil.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://imtocopilla.cl/direccion-de-desarrollo-comunitario/ ; https://imtocopilla.cl/subvencion-municipal/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=353;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Los documentos específicos educativos localizados de Temuco describen becas preuniversitarias para tercero y cuarto medio y BPR escolar. El fondo Juventud y Acción Climática 2026 tiene objeto distinto.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Falta evidencia específica que permita actualizar esta ayuda superior genérica; no trasladar población escolar o proyecto climático a estudiantes de una carrera.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://transparencia.temuco.cl/g_resoluciones/decretos/2022/general_educacion/mayo/277_DGE_2022.pdf ; https://www.temuco.cl/fondo-juventud-y-accion-climatica-2026/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=354;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El índice de búsqueda conserva el decreto Constitución 1086 de 31/03/2026, que aprueba nueva ordenanza y deroga las anteriores; su texto inicial exige estudios presenciales de al menos cuatro semestres, frente a cinco en 2025. La descarga devuelve 404. El portal migrado publica entrega de 744 becas de 200.000 pesos para 2025, no para 2026.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No se ha leído íntegro el decreto 2026 recuperado desde el índice ni conciliado eventuales modificaciones. No trasladar requisitos, importe o cierre 2025. El calendario indexado 2026 es una pista por verificar, no fecha aplicada.
ALCANCE DE ESTA CONSULTA: PARCIAL_CON_NUEVA_NORMA_POR_RECUPERAR.
FUENTES: https://www.constitucion.cl/wp-content/uploads/2026/04/D.-EXENTO-1086-ORDENANZA-BECA-MUNICIPAL-Y-REQUISITOS.pdf ; https://www.constitucion.cl/sitio/noticias/detalle.php?slug=ceremonia-simb-olica-de-la-beca-de-educaci-on-superior-2025-en-constituci-on-m-as-de-700-beneficiados
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=357;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia oficial de 17/02/2026 describe Programa Generación de Empleo: más de 70 estudiantes, 20 horas de encuestas en cuatro días y pago líquido de 60.000 pesos. El antecedente de vivienda es otro programa.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No identificar un trabajo remunerado con la beca de alojamiento o una mantención genérica sin instrumento que los relacione. Falta definición actual de la modalidad de la candidata.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.santabarbara.cl/santa-barbara-programa-pge-estudiantes/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=360;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Leídas visualmente ambas páginas del decreto Hualañé 3574 de 04/12/2019: convenio SIPEE con Universidad de Chile, adjudicación individual condicionada a requisitos durante la carrera. El convenio refiere transferencia anual municipal de un millón para diez mensualidades; el pago de 700.000 en 2019 descuenta saldo 2018.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No es beca general para cualquier institución ni convocatoria 2026. No convertir la transferencia de 700.000 en beneficio por estudiante actual. Se conserva la referencia histórica SIPEE y no se reproducen datos bancarios o identificadores personales.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.hualane.cl/TA_IGTA/Transparencia_Proactiva/Decretos_Alcaldicios/Exentos/2019/12_Diciembre/3574.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca Municipalidad de Hualañé · convenio SIPEE con Universidad de Chile',descripcion_corta='Beca de Hualañé en convenio SIPEE con la Universidad de Chile, documentada en 2019. No se han acreditado cobertura ni convocatoria actuales.' WHERE id_beca=362;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La ficha Alhué actual conserva abril/mayo para primera cuota, septiembre/octubre para segunda, pero declara junio como mes de postulación. Describe ingreso hasta 24 años y evaluación RSH hasta 60% entre 25 y 28, sin fijar año ni una secuencia de fechas coherente.
LÍMITES Y DATOS SIN CONFIRMACIÓN: La inconsistencia del calendario persiste en la fuente; no escoger arbitrariamente uno de los meses ni convertir cuotas en cierre anual. El reloj de fecha del portal no actualiza el contenido.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://municipalidadalhue.cl/portal/beca-municipal/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=365;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
El acta ordinaria 48 de Huasco, p.3, acuerdo 197, aprueba para 2026 la Beca Juanita González: 20 beneficiarios, 150.000 pesos mensuales durante diez meses marzo–diciembre y financiación Royalty. Deja sin efecto el acuerdo 195 para precisar esa financiación.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Meses de pago no son recepción. Calendario de nuevos postulantes no especificado; no usar las bases del hogar estudiantil ni presentar el beneficio como postulación abierta.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://imhuasco.cl/Transparenciamunicipal/Documentos/ConcejoMunicipal/ActasOrdinarias/2026/48.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca Juanita González de Huasco',monto_cobertura='150.000 CLP mensuales durante diez meses, marzo a diciembre de 2026; 20 beneficiarios. Beca Juanita González de Huasco.',cobertura_tipo='MONETARIA',cobertura_importe=150000.00,cobertura_moneda='CLP',cobertura_periodicidad='MENSUAL',cobertura_porcentaje=NULL,descripcion_corta='Beca Juanita González de Huasco: $150.000 mensuales durante diez meses en 2026, para 20 beneficiarios. Fechas de postulación no especificadas.',url_oficial='https://imhuasco.cl/Transparenciamunicipal/Documentos/ConcejoMunicipal/ActasOrdinarias/2026/48.pdf' WHERE id_beca=367;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El conjunto oficial de carreras de Puente Alto describe aporte económico a residentes que cursan estudios técnicos, profesionales o superiores, con última actualización 01/03/2024. La noticia FUAS refiere beneficios estatales 2026, no una recepción municipal propia.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No hay calendario municipal actual en el conjunto; no utilizar frecuencia anual del dataset ni plazos FUAS como apertura de esta beca. Preservar ambas fichas.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://datos.mpuentealto.cl/datasets/197867/beca-municipal-de-educacion-superior-carrera/ ; https://www.mpuentealto.cl/ya-estan-abiertas-las-postulaciones-para-acceder-a-los-beneficios-estudiantiles-de-la-educacion-superior/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=368;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia Chañaral del 09/01/2026 es un reconocimiento a puntajes PAES y no anuncia una beca económica a cada reconocido. La beca de matrícula de egreso técnico de diciembre 2024 es un antecedente concreto distinto de una convocatoria general 2026.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No inferir monto, cupos o recepción desde un desayuno de reconocimiento. Faltan condiciones actuales de la beca superior genérica.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munichanaral.cl/mejores_puntajes_paes_2026.html ; https://www.munichanaral.cl/new_graduacion_liceo_24.html
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=381;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Leídas visualmente páginas PDF 1–7 del manual Viña: decreto 5852 fechado 01/09/2021, aunque alojado en carpeta 2022; manual creado agosto y modificado octubre 2019. Su página interna 5 incluye pago de pasajes como ayuda social general con decreto, informe social y residencia local, admitiendo tránsito justificado. RSH figura de preferencia.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No es convocatoria estudiantil 2026 ni implica importe fijo o derecho automático; no elevar RSH preferente a requisito universal obligatorio. Calendario y disponibilidad actuales no acreditados.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munivina.cl/wp-content/uploads/2022/04/D.A-5852.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Ayuda social para pago de pasajes de Viña del Mar',descripcion_corta='Ayuda social para pagar pasajes mediante evaluación individual en Viña del Mar. Manual aprobado en 2021; importe y disponibilidad actuales por confirmar.' WHERE id_beca=385;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El portal público Santo Domingo identifica postulación y renovación de becas municipales 2026, exclusivamente por ClaveÚnica. La página pública no publica plazo ni reglas específicas de la modalidad superior.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No iniciar sesión con identidad de otra persona ni inferir apertura efectiva porque el acceso esté disponible. Mantener fechas desconocidas.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://agendabecas.santodomingo.cl/ ; https://tramites.santodomingo.cl/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=388;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Releída cuenta Codegua 2021: página 234 registra nuevo reglamento y nombre Luis Tamayo Hurtado, aprobado el 27/07/2021. Páginas 241–242: excelencia 120.000, normal primer tramo 100.000 y segundo 70.000. La ficha de subsidios 2015 publica cinco millones de presupuesto global y recepción abril/mayo.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Los importes de gestión 2021 no reemplazan automáticamente el alcance 2018 ni acreditan cuantías 2026. El presupuesto 2015 no es importe individual ni su calendario genérico es convocatoria actual.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.municipalidaddecodegua.cl/municipalidad/transparencia/plantillas%20dideco/becasmunicipales.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=391;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La plataforma oficial La Florida Beca Escolar Municipal 2026 declara expresamente kínder a cuarto medio, incluida educación diferencial; permite adquirir útiles, calzado o vestimenta y exige postulación del apoderado.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No es una beca de educación superior. Falta instrumento específico de la candidata superior; no usar el registro escolar como postulación universitaria ni afirmar falsedad de otros apoyos.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://appx.laflorida.cl/beca_escolar/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=393;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Los decretos actuales de Villa Alemana localizados modifican Beca de Talento Deportivo 2026; el aviso presupuestario 2025 de beca superior no se convierte por ello en bases de ejecución.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Falta acto de convocatoria superior que determine prestación y elegibilidad. No importar fechas o montos deportivos.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://munivillalemana.gob.cl/decretos/modifiquese-el-decreto-alcaldicio-n997-de-fecha-15-de-mayo-de-2026-que-aprueba-las-bases-generales-para-el-otorgamiento-de-beca-de-talento-deportivo-comuna-de-villa-alemana-en-los-siguientes-t/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=402;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El decreto Máfil 00164/2026 de 29/01/2026 regula becas deportivas y cultural-artísticas, con postulación 02–13 febrero. La cuenta de gestión 2024 refiere orientación de Beca Indígena estatal.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Ninguna es por sí sola la ayuda superior municipal genérica. No trasladar cierre de becas culturales o requisitos JUNAEB a esta candidata.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munimafil.cl/wp-content/uploads/2026/01/Becas-Deportivas-2026.pdf ; https://www.munimafil.cl/wp-content/uploads/2025/05/PUBLICA-2024.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=403;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Quinta Normal distingue Útiles Escolares 2026, restringida a preescolar/básica/media/especial, de Becas Culturales 2026. Estas últimas admiten formación de pregrado o posgrado, pero exigen trayectoria cultural de dos años y retribución comunitaria, con cierre 28/02/2026.
LÍMITES Y DATOS SIN CONFIRMACIÓN: La ayuda cultural puede financiar estudios, pero no identifica por sí sola la beca superior general del antecedente. No trasladar requisitos culturales a todo estudiante superior.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.quintanormal.cl/actividades/beca-de-utiles-escolares-2026-161179 ; https://www.quintanormal.cl/actividades/postula-becas-culturales-2026-161187
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=406;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La cuenta Torres del Paine de gestión 2024 informa prestaciones de 2 UTM para superior durante diez meses y atribuye fundamento a ordenanza 3 del 15/05/2023. El índice normativo publicado registra ordenanza 2 de esa fecha y el expediente anterior distingue aporte único.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Se conserva la diferencia entre referencia normativa y ejecución. No convertir la cuenta 2024 o bases sin año en convocatoria 2026 ni fijar periodicidad actual sin aclaración.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munitorresdelpaine.cl/Portal%20TA/Otros%20Antecedentes/CUENTA%20PUBLICA/Cuenta%20P%C3%BAblica%202024.pdf ; https://www.munitorresdelpaine.cl/ordenanzas-municipales/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=408;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se recuperó en navegador la página Pencahue Resultados Becas 2026, antes bloqueada: muestra un listado de beneficiarios sin nivel de estudios, importe ni calendario. La búsqueda pública municipal devuelve esa página y Registro Social de Hogares.
LÍMITES Y DATOS SIN CONFIRMACIÓN: La publicación acredita resultados de becas estudiantiles, pero no permite confirmar educación superior ni modalidad. No deducir edad/nivel a partir de nombres ni declarar agotado el archivo: el buscador muestra advertencia de limitación de resultados.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://mpencahue.cl/index.php/resultados-becas-2026/ ; https://mpencahue.cl/?s=becas
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=412;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El acta Osorno que prepara BEMART 2026 y el portal actual anuncian Beca Municipal de las Artes 2027. Se verificó que el objeto es cultural y su comité específico; no demuestra una convocatoria general de mantención superior.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Falta identificación de programa/acto actual correspondiente a esta candidata. No reemplazarla por deportiva o BEMART por compartir al concejo otorgante.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.imo.cl/sistemas/sitioweb/actas/1271_3840.pdf ; https://www.imo.cl/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=421;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se navegó el archivo de becas municipales de Coelemu hasta la tabla de mayo 2016. Identifica beca de excelencia, NEM 6,2 y recepción que termina 30/04/2016; difiere del acta 2011. El índice está actualizado a 2016; la noticia actual de octubre 2026 es deportiva.
LÍMITES Y DATOS SIN CONFIRMACIÓN: El archivo municipal consultado no determina condiciones anuales actuales. No usar la apertura diciembre/enero de filas históricas como calendario 2026 ni reemplazar por beca deportiva.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://transparencia.municoelemu.cl/index.php?action=plantillas_generar_plantilla&ig=310&m=5&a=2016&ia=7902 ; https://www.municoelemu.cl/beca-deportiva-coelemu-2026/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=424;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La sección actual Servicio Social Viña del Mar distingue validación BPR/Indígena vía JUNAEB, ayudas sociales y acreditación socioeconómica para universidades. No identifica en su texto una convocatoria propia de beca superior ni sus cupos anuales.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No identificar orientación estatal o emisión de informes con una beca propia de dinero. Los antecedentes 2022/2023 se conservan; ambas fichas siguen sin calendario municipal actual acreditado.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munivina.cl/desarrollo-comunitario/desarrollo-social/seccion-servicio-social/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=426;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia Coquimbo está fechada 08/01/2019 y cierra el 28 de febrero de ese ciclo. Distingue aporte para arancel y aporte para residencia fuera de la región; el presupuesto de 220 millones y 534 favorecidos se atribuye a 2018.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No usar noticias laterales de octubre 2026 como año del aviso ni asignar presupuesto agregado a un estudiante. Falta calendario actual de la modalidad de la candidata.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.municoquimbo.cl/index.php/noticias/4834-invitan-a-jovenes-de-coquimbo-a-postular-a-aportes-municipales-para-la-educacion-superior
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=432;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El reglamento UAI 2024, reglas de compatibilidad de excelencia y honor, reconoce beneficios a hijos o cónyuges de funcionarios y limita la combinación al 100% de matrícula/arancel. No define ahí el porcentaje propio de la beca de familiares.
LÍMITES Y DATOS SIN CONFIRMACIÓN: El tope de compatibilidad no equivale a cobertura individual del 100%. Falta norma específica actual de ese beneficio; no trasladar porcentajes de Pedro Luis González u Honor.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://alumno.uai.cl/assets/uploads/2024/04/reglamentos-uai-2024.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=438;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El PLADECO Hualpén 2026–2032 describe asesoramiento de postulaciones FUAS, BPR e Indígena entre octubre y febrero. Esa función municipal no es una beca propia de mantención ni demuestra renovar el convenio IP Diego Portales.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Para 37 faltan condiciones actuales del convenio; para 440 falta sustento de una mantención municipal individual distinta de la orientación estatal. No se trasladan porcentajes entre las dos fichas.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.hualpenciudad.cl/wp-content/uploads/2025/12/Pladeco-2026-2032-2-reducido.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=440;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
La noticia oficial Monte Patria del 28/01/2026 anuncia la beca municipal de 300.000 pesos y apertura en marzo, diferenciándola de los cupos del hogar de La Serena. Acredita continuidad anunciada para 2026.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No fija día final ni periodicidad del importe. La FAQ municipal copia requisitos de Las Condes y no se usa como fuente de residencia o instituciones elegibles de Monte Patria. No activar por el anuncio.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munimontepatria.cl/web/index.php/noticias/870-monte-patria-reconocio-a-18-estudiantes-que-obtuvieron-resultados-paes-sobresalientes ; https://www.munimontepatria.cl/web/index.php/direcciones-municipales/departamento-social?id=69
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,monto_cobertura='300.000 CLP según anuncio municipal de Monte Patria de enero de 2026; periodicidad no especificada. No equivale al cupo de hogar estudiantil.',cobertura_tipo='MONETARIA',cobertura_importe=300000.00,cobertura_moneda='CLP',cobertura_periodicidad='DESCONOCIDA',cobertura_porcentaje=NULL,descripcion_corta='Beca municipal de Monte Patria: aporte de $300.000 anunciado para 2026. Apertura en marzo sin día de cierre ni periodicidad publicados en la noticia.',url_oficial='https://www.munimontepatria.cl/web/index.php/noticias/870-monte-patria-reconocio-a-18-estudiantes-que-obtuvieron-resultados-paes-sobresalientes' WHERE id_beca=451;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia oficial Los Sauces 2026 corresponde a residencia Estudia Tranquilo: alojamiento en Temuco, promedio 5,0, RSH hasta 40% y recepción 16–18 febrero. La beca monetaria general de los antecedentes es otra prestación.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No trasladar requisitos o cierre de residencia a la beca monetaria ni fusionar las dos candidatas sin equivalencia positiva de modalidad y año.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munilossauces.cl/noticias/postulacion-a-residencia-estudiantil-2026-estudia--22964
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=456;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Revisada la separación respecto del ID 68: el expediente de licitaciones 2025/2026 corresponde a movilización vespertina superior. Los 16.329.000 pesos publicados como presupuesto de contratación son globales, no dinero entregado a cada estudiante.
LÍMITES Y DATOS SIN CONFIRMACIÓN: La reconsulta municipal actual no aporta procedimiento ni fecha de postulación individual. No fusionar con el aporte monetario histórico de Cholchol ni usar plazos de licitación como cierre estudiantil.
ALCANCE DE ESTA CONSULTA: LIMITADA_POR_ACCESO.
FUENTES: https://www.mercadopublico.cl/Procurement/Modules/RFB/DetailsAcquisition.aspx?idlicitacion=4993-30-LE26 ; https://www.cholchol.cl/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Movilización vespertina de educación superior de Cholchol' WHERE id_beca=463;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El formulario Capital del Mimbre declara expresamente año 2024, nivel superior y aplicación del decreto 865 de 07/04/2021. La fecha de ingreso a completar también termina en 2024.
LÍMITES Y DATOS SIN CONFIRMACIÓN: El formulario no acredita un llamado 2026 ni resuelve las diferencias con la norma 2010. No usar una noticia secundaria de entrega para certificar requisitos nuevos.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://municipalidadchimbarongo.cl/wp-content/uploads/FORMULARIO-DE-POSTULACION-BECA-CAPITAL-DEL-MIMBRE-SUPERIOR.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=467;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Se releyó el encabezado y fundamento del otorgamiento BMES/PAES 2026: emana de San Pedro de Melipilla. No acredita una beca de San Pedro de la Paz, institución de esta candidata.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Persiste error de identidad de origen. Conservar registro y UUID con advertencia; no copiar la adjudicación de Melipilla ni reclasificarla como beca falsa.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munisanpedro.gob.cl/wp-content/uploads/2026/04/Becas-2026-ok.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=490;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El reglamento Cauquenes 562 regula convenio con CFT San Agustín, mínimo cinco becas y NEM 5,0; su plazo anual no acredita por sí solo la convocatoria 2026 de otra modalidad. El municipio mantiene referencia al reglamento 1921/2020.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Falta establecer qué instrumento actual corresponde a esta candidata general. No sustituirla por el convenio CFT ni usar plazos de FONDEPORTE.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://cauquenes.cl/ordenanzas/pdf/562.pdf ; https://www.cauquenes.cl/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=497;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La noticia oficial Coronel de 27/01/2026 otorga Beca Municipal de Subvención de Pasajes a dos puntajes nacionales PAES. No identifica equivalencia con el programa 100 por 100 de 2019 de esta candidata.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No convertir dos adjudicaciones extraordinarias en llamado general ni trasladar condiciones deportivas de septiembre. Falta sustento actual de la misma modalidad.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.coronel.cl/noticias/orgullo-coronelino-alcalde-chamorro-premia-con-beca-a-dos-alumnos-del-liceo-bicentenario-por-puntaje-nacional-en-matematicas-paes/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=500;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La Cuenta Pública municipal de gestión 2025, p.122, identifica Beca Conectividad/Traslado para superior: 20.000 pesos mensuales durante nueve meses, 512 otorgadas y presupuesto 92.160.000. Es evidencia primaria que sustituye como sustento la pista radial de 2022.
LÍMITES Y DATOS SIN CONFIRMACIÓN: La cuenta acredita ejecución 2025, no plazo o presupuesto 2026. Faltan bases de postulación/renovación actuales; conservar importe con año explícito y no usar horarios generales de buses como recepción de beca.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.mpinto.cl/wp-content/uploads/2026/04/Cuenta-Publica-2025.pdf ; https://www.mpinto.cl/actas-de-consejo/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=504;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El mapa municipal actual enlaza la postulación deportiva 2026 y los resultados de subvenciones a organizaciones; no son bases del incentivo de ingreso superior de estas candidatas.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Falta acto específico actual del incentivo superior y su monto. La categoría becas o una entrega de reconocimiento no acredita por sí sola la modalidad monetaria.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://penaflor.cl/mapa-del-sitio/ ; https://penaflor.cl/postulacion-becas-deportivas-2026/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=505;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Releída la ficha Angol del catastro UCSC, página 82: aporte económico anual sin monto, vulnerabilidad, matrícula en carrera superior de al menos cuatro semestres, RSH y notas para cursos superiores. Se siguió desde DIDECO el portal municipal de noticias; sus publicaciones disponibles no permiten ratificar recepción anual actual.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Marzo genérico del catastro no fija cierre 2026. El decreto 1216/2024 es antecedente de adjudicación histórico y su descarga escaneada no se cuenta como lectura íntegra; no se usa para completar importes actuales.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://direcciones.ucsc.cl/content/uploads/sites/35/2024/12/Becas-Municipales.pdf ; https://dideco.angol.cl/ ; https://noticias.angol.cl/ ; https://www.angol.cl/transparencia/actos%2Cdecisiones/SECRETARIA_MUNICIPAL/2024/JUNIO/1216.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=507;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
El FAQ UPLA de 21/01/2025 identifica Beca de Honor: 25% del arancel anual a los 15 mejores puntajes, al menos cinco para pedagogía. Se contrastó con el apartado UPLA del catálogo 2026, que no aporta condiciones de esta beca de Honor.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No certificar asignación 2026/2027 por repetición. Ambas candidatas comparten antecedente, sin eliminar UUID ni fusionar favoritos.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.upla.cl/admision/2025/01/21/preguntas-frecuentes-sobre-el-proceso-de-admision-y-matricula-2025/ ; https://demre.cl/publicaciones/pdf/2026-25-11-20-servicios-y-beneficios-universitarios.pdf
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=508;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
El decreto público de otorgamiento BMES y Bono PAES 2026 de San Pedro de Melipilla aprueba beneficiarios tras postulación y evaluación. Se verificaron antecedentes, municipio y objeto; no se transcribe la nómina personal.
LÍMITES Y DATOS SIN CONFIRMACIÓN: Acredita adjudicación del ciclo, no el día final de postulación. Sigue sin leerse la modificación 462 de 22/04/2026; conservar cierre exacto desconocido y no actualizar a 2026 el reglamento 406 de 2025.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munisanpedro.gob.cl/wp-content/uploads/2026/04/Becas-2026-ok.pdf ; https://www.munisanpedro.gob.cl/noticias/becas-municipales-de-educacion-superior-y-beca-paes/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,descripcion_corta='Beca Municipal de Educación Superior de San Pedro de Melipilla: proceso 2026 adjudicado. El Bono PAES es otra modalidad; cierre final no especificado.',url_oficial='https://www.munisanpedro.gob.cl/wp-content/uploads/2026/04/Becas-2026-ok.pdf' WHERE id_beca=525;
UPDATE becas SET descripcion_larga='RECONSULTA DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
La sección actual Servicio Social Viña del Mar distingue validación BPR/Indígena vía JUNAEB, ayudas sociales y acreditación socioeconómica para universidades. No identifica en su texto una convocatoria propia de beca superior ni sus cupos anuales.
LÍMITES Y DATOS SIN CONFIRMACIÓN: No identificar orientación estatal o emisión de informes con una beca propia de dinero. Los antecedentes 2022/2023 se conservan; ambas fichas siguen sin calendario municipal actual acreditado.
ALCANCE DE ESTA CONSULTA: LECTURA_DOCUMENTAL_DELIMITADA.
FUENTES: https://www.munivina.cl/desarrollo-comunitario/desarrollo-social/seccion-servicio-social/
La fecha de revisión no actualiza el año de los antecedentes. No implica recepción de solicitudes abiertas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=528;
COMMIT;
