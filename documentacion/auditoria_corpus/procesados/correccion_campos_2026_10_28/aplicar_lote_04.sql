BEGIN;
SET LOCAL lock_timeout='5s';
CREATE TEMP TABLE correcciones(id bigint,uuid uuid,version bigint,tipo_anterior bigint,tipo_nuevo bigint) ON COMMIT DROP;
INSERT INTO correcciones VALUES
(115,'c7a19c94-6821-43ec-ae63-be7125b86796'::uuid,0,9,7),
(116,'a5aeebbd-0be7-48ea-825d-7cbb8099e7fb'::uuid,0,9,7),
(117,'64dd46e4-c0b3-421b-8877-9b90bcbd5e03'::uuid,0,9,7),
(118,'1d6ba3fc-74c3-41c5-aaaa-ea4b7bd74dbb'::uuid,0,9,7),
(119,'042462f0-a8e9-4c40-80ea-1150b178668d'::uuid,0,9,7),
(121,'99fd11bf-6953-4d10-a099-4b51b2de5468'::uuid,0,9,7),
(122,'1d094e6a-ce66-4551-80e9-476525a1bcad'::uuid,0,9,7),
(125,'33d96d0d-f819-4949-ab85-a6ca61b73bcb'::uuid,0,9,7),
(127,'dadba91f-f202-44bb-b81a-d20c8ffc224d'::uuid,0,9,7),
(128,'9b9a66e2-2676-45ee-9b76-f9032fa0df06'::uuid,0,9,7),
(130,'1b141394-e39a-43b3-905e-d76beccd32e3'::uuid,0,9,7),
(133,'7becac1b-17c8-4653-babf-1d5dd8c9b726'::uuid,0,9,7),
(135,'33832e5a-348a-481a-9355-4cb88829a48c'::uuid,0,9,7),
(136,'e9b695d5-6b81-4727-bfd3-84c885702130'::uuid,0,9,7),
(137,'94f20830-16a1-403c-be90-677024a674ec'::uuid,0,9,7),
(138,'eaaeaf30-b43e-4562-b9db-e5c6facb46e5'::uuid,0,9,7),
(139,'e19f64bb-5645-41af-8abf-43457e19775f'::uuid,0,9,7),
(140,'9a699f86-0df1-40d4-91ef-81e0f1e7c7ba'::uuid,0,9,7),
(142,'98a63c13-f0fa-4331-844d-362bcabd8347'::uuid,0,9,7),
(143,'47306906-36c3-4a5a-b429-2204e715c9a0'::uuid,0,9,7),
(144,'748ab45c-3386-4eaa-ae98-d9a2d9d89efb'::uuid,0,9,7),
(145,'048c8cbd-9baa-473c-bc11-1ac0899a55ab'::uuid,0,9,7),
(147,'4d8e556f-9769-4476-a63a-9fe399176c9d'::uuid,0,9,7),
(149,'a9c5e0e4-524f-4f4e-b8ea-5ecd7fc15ad3'::uuid,0,9,7),
(152,'080e209e-a886-44ac-a224-191f45c2eefd'::uuid,0,9,7),
(154,'3fbb74c4-279f-4ecf-8c5e-4b9cbe98c4d3'::uuid,0,9,7),
(155,'1ef19ead-4f2a-489a-9f51-f7c966f6abd9'::uuid,0,9,7),
(156,'fec2dc6f-d651-41eb-972e-a9e418ee2e3d'::uuid,0,9,7),
(159,'82238e26-0d6e-456b-92be-b1deef4a2b8b'::uuid,0,9,7),
(160,'97495e4e-2b93-4704-b80d-308605f92db4'::uuid,0,9,7),
(161,'bc110abe-9d75-4a65-b6de-82eef4db4c12'::uuid,0,9,7),
(162,'05be509f-114c-4cd5-8b00-72dae5895b54'::uuid,0,9,7),
(164,'2d68ba2f-e660-4f8f-8816-95a725271b2b'::uuid,0,9,7),
(168,'6de0793f-f3f3-453e-a1db-7b79bd796c88'::uuid,0,9,7),
(169,'0c1f76fd-7b3e-4774-9a7f-51ef92412f95'::uuid,0,9,7),
(172,'2f5f3383-e3df-42ea-9705-757b0c56a15f'::uuid,0,9,7),
(176,'af10e0d8-02a2-49d4-b863-c70215e23dc3'::uuid,0,9,7),
(179,'61343ed1-6067-4ff3-a855-8359299426c4'::uuid,0,9,7),
(185,'977e9190-46f2-4e17-a190-6a831ce02abd'::uuid,0,9,7),
(188,'96a2f04e-fa92-4963-bbca-0820613a6941'::uuid,0,9,7),
(189,'976b9336-ded8-4207-ae3b-2b9b9410f060'::uuid,0,9,7),
(191,'23278ac1-625b-4224-b952-043c07b75daa'::uuid,0,9,7),
(194,'9673a00c-aa29-4217-b638-9851f82efff4'::uuid,0,9,7),
(124,'34df6d9a-f687-4609-83ec-2de1a210d257'::uuid,0,9,5),
(129,'7c6bc61b-739a-4360-91c8-f9840922bb00'::uuid,0,9,5),
(146,'f10dcc10-b985-4bb8-aa58-329d54d8ed60'::uuid,0,9,5),
(151,'4c415177-cfe8-4201-997d-60c1733ec2ed'::uuid,0,9,5),
(153,'e06b1f9b-7cd0-4af1-8d57-926ee5e38500'::uuid,0,9,5),
(157,'a5192944-d1bc-45c8-9ffa-f7557a0b0c4d'::uuid,0,9,5),
(163,'b1d62d46-4a52-4e7d-8636-fada31c21cb9'::uuid,0,9,5),
(173,'5c0aba1f-d33b-49c0-8ae9-e84f4d7611a3'::uuid,0,9,5),
(177,'7249b8b3-e648-422c-870c-60c54181690f'::uuid,0,9,5),
(178,'9cfd384d-a492-486b-9533-5c25cd7c3dbc'::uuid,0,9,5),
(184,'4d808fec-66c5-4d13-9b72-b5265fc7fe68'::uuid,0,9,5),
(134,'3adc76b0-5f00-4243-ac2b-20d9547ced3a'::uuid,0,9,2),
(170,'eea290f9-20ed-4b2a-ab5a-7f13ca27b668'::uuid,0,9,2),
(171,'4928b026-41a3-4596-a6c7-cef68f579807'::uuid,0,9,2),
(165,'07ea6341-bf45-4a3d-b0dd-7335383d4ab0'::uuid,0,9,8),
(190,'e1fa97ad-9e9d-47d4-a16e-d9bc092aa6d0'::uuid,0,9,8);
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
