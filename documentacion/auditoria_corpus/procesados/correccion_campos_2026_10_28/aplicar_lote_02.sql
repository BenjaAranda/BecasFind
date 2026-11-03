BEGIN;
SET LOCAL lock_timeout='5s';
CREATE TEMP TABLE correcciones(id bigint,uuid uuid,version bigint,tipo_anterior bigint,tipo_nuevo bigint) ON COMMIT DROP;
INSERT INTO correcciones VALUES
(2,'7698fdfa-3610-4c10-b74d-84be1d424eb7'::uuid,0,9,7),
(3,'935bf4e5-e962-4c04-8a08-4033f94f23eb'::uuid,0,9,7),
(4,'e095ad04-0af8-475a-9b00-79a3777d593f'::uuid,0,9,7),
(5,'cf40e337-861f-4713-b9e4-188d200340ed'::uuid,0,9,7),
(11,'da8bdcfe-2746-4a95-92c0-852042f7a903'::uuid,0,9,7),
(13,'28918504-0f77-4463-a456-84cc78d5534a'::uuid,0,9,7),
(19,'89aa67b1-a632-4585-b51b-60ce5d4c75cc'::uuid,0,9,7),
(20,'6ec7f358-681e-43d2-a8cc-5a8d7a27da76'::uuid,0,9,7),
(22,'0714d240-79cc-4583-83cc-b5cff8246167'::uuid,0,9,7),
(24,'32d2a10c-1c8b-46d9-b461-84b8082d9a6a'::uuid,0,9,7),
(25,'436dd866-ffd8-48a5-90b6-18cde836cd74'::uuid,0,9,7),
(30,'e411bffb-2c8b-432b-975f-fd0e372505e0'::uuid,0,9,7),
(31,'664e60cb-3989-4b3c-8108-e936edff7cd4'::uuid,0,9,7),
(32,'477f2e55-255d-46f9-98c5-ccab0c23040d'::uuid,0,9,7),
(33,'b9d08a38-8d37-432f-b637-82ca917311b4'::uuid,0,9,7),
(34,'90707e2d-91e0-4019-a4b4-fe6b2f7e08cc'::uuid,0,9,7),
(39,'ee214984-660e-433b-80bd-1a2ccc48e3dd'::uuid,0,9,7),
(42,'a1c86c4a-c48e-40e8-b190-a75e6684fb56'::uuid,0,9,7),
(43,'6e2e5774-e7f1-4969-b6ee-a8a6cd4d9140'::uuid,0,9,7),
(44,'e624598d-0746-4369-b52b-65cc668c40ae'::uuid,0,9,7),
(46,'890fd860-4849-4926-b966-f5bff508a257'::uuid,0,9,7),
(47,'e44d35f2-542a-491c-ae56-80883bf89e0d'::uuid,0,9,7),
(48,'30f29987-93c4-41f1-a0f6-1a49de76d07e'::uuid,0,9,7),
(49,'c1c28f20-cb82-42d2-ba12-f1f8079ee3e0'::uuid,0,9,7),
(50,'384afa53-cbcf-4992-a20c-44fc5a01ed44'::uuid,0,9,7),
(51,'c3185637-8e0b-47ff-bd29-c1304407c9ad'::uuid,0,9,7),
(55,'c9da3b0c-a207-41e4-98fd-06ae7623f75b'::uuid,0,9,7),
(56,'7073f982-63ec-46c1-8938-27c7ee13048c'::uuid,0,9,7),
(58,'519fa77e-9675-4302-b018-369fad80bd7f'::uuid,0,9,7),
(60,'01bfbc25-aaac-4c9b-b767-194e4508d3a8'::uuid,0,9,7),
(62,'267423a8-fee4-4398-a4ea-0c96fdaa894e'::uuid,0,9,7),
(63,'94d04245-92e0-4f04-ba1a-ab3271853edd'::uuid,0,9,7),
(65,'6af34d13-b2c0-4c75-b688-2e87a81c4c58'::uuid,0,9,7),
(70,'780110ee-13c0-409d-82c5-9df2c596b863'::uuid,0,9,7),
(71,'6b2016bd-a299-4f14-9db5-77053657f98c'::uuid,0,9,7),
(72,'983d92c4-5857-474a-981c-00eecd86ebef'::uuid,0,9,7),
(73,'7ce99804-4de5-4254-b013-0103abb90ff0'::uuid,0,9,7),
(77,'daa0fe10-c9b4-49ca-8e4d-199e96ea3926'::uuid,0,9,7),
(79,'848def6c-70a5-4a0d-825c-12bef34e5387'::uuid,0,9,7),
(80,'6fc9b420-ae9b-4e94-94ed-83b7b2ed7673'::uuid,0,9,7),
(82,'2aad95d1-4696-4a7f-b255-b3df3eca0bec'::uuid,0,9,5),
(85,'e46607d5-8ca6-4cd4-9bcf-dcd2e6bf0292'::uuid,0,9,7),
(91,'39dbabc3-52ea-4f92-9620-ddcf530a7642'::uuid,0,9,7),
(93,'0f07eea8-ea42-451b-8b49-cdf6e72e29f4'::uuid,0,9,7),
(96,'ad08ea6a-8ebb-4c3f-8383-05afea9ea271'::uuid,0,9,7),
(97,'55a8c454-252a-4cab-a93f-5237f5cd5b51'::uuid,0,9,7),
(99,'1594591e-fb34-47ed-8d1c-88efcd0c2387'::uuid,0,9,7),
(100,'96648d83-e8a5-4849-bc16-7fbd134fc9c4'::uuid,0,9,7),
(103,'4c37174e-858b-479d-9c77-884ecca2b344'::uuid,0,9,7),
(105,'d4bfeb79-7b05-45ad-9915-f0bfd75940bc'::uuid,0,9,7),
(106,'11c16ffe-0ef6-4e7c-a6c2-05a03404e9e9'::uuid,0,9,7),
(108,'c95d649e-7f4b-4d51-8e38-035ba87b6aa6'::uuid,0,9,7),
(111,'2bbdba80-aa8a-4855-86b4-7fc8de42e2d9'::uuid,0,9,5),
(112,'95c31b8b-aa34-4393-b483-0d9f718c10d1'::uuid,0,9,7),
(113,'996eddb7-7f41-4663-9f39-10b21144d7b3'::uuid,0,9,7);
DO $guard$
BEGIN
 IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario diferente'; END IF;
 PERFORM id_beca FROM becas WHERE id_beca IN (SELECT id FROM correcciones) FOR UPDATE;
 IF EXISTS (SELECT 1 FROM correcciones c LEFT JOIN becas b ON b.id_beca=c.id WHERE b.id_beca IS NULL OR b.public_id<>c.uuid OR b.version<>c.version OR b.id_tipo_beca<>c.tipo_anterior) THEN RAISE EXCEPTION 'Estado previo diferente; conciliar antes de aplicar'; END IF;
 IF EXISTS (SELECT 1 FROM correcciones c LEFT JOIN tipos_beca t ON t.id_tipo_beca=c.tipo_nuevo WHERE t.id_tipo_beca IS NULL) THEN RAISE EXCEPTION 'Tipo inexistente'; END IF;
END;
$guard$;
UPDATE becas b SET id_tipo_beca=c.tipo_nuevo,version=b.version+1 FROM correcciones c WHERE b.id_beca=c.id;
COMMIT;
