BEGIN;
SET LOCAL lock_timeout='5s';
CREATE TEMP TABLE correcciones(id bigint,uuid uuid,version bigint,tipo_anterior bigint,tipo_nuevo bigint) ON COMMIT DROP;
INSERT INTO correcciones VALUES
(467,'cb393d0a-2749-4839-85ad-ff617b2ac5f1'::uuid,0,9,7),
(470,'846bcf1d-45f4-47e2-ad41-eb2ad963c3db'::uuid,0,9,7),
(471,'75e2f5b1-e021-4fe4-8534-fd2b2cf2c085'::uuid,0,9,7),
(472,'fb9b67a0-9b78-4a95-ab2f-267f2307daaf'::uuid,0,9,7),
(473,'d3f2c97f-4976-42ea-873e-e02075222ed1'::uuid,0,9,7),
(476,'1b5925f3-e30d-450b-a42a-6f368591fc2f'::uuid,0,9,7),
(478,'b9a756ea-f0e9-4b1a-957d-bc604fc1b1e7'::uuid,0,9,7),
(480,'b219c6a4-6e29-455a-bb81-2537b50cbe7c'::uuid,0,9,7),
(481,'8595e873-ce70-4269-bf04-2ccaff04662c'::uuid,0,9,7),
(486,'e531d2dc-9bfb-4f55-890e-8da5c0362556'::uuid,0,9,7),
(488,'a45dd673-3a60-4ab7-ad2f-7776047c5211'::uuid,0,9,7),
(492,'9fdb4f03-cc8c-43a2-8a30-b1151e929efc'::uuid,0,9,7),
(494,'963b7c61-9e4b-46f5-8bc4-379299acfc03'::uuid,0,9,7),
(496,'1fcb8847-91d8-40af-96e7-7511810fe763'::uuid,0,9,7),
(497,'63070a6e-b29d-47f6-b9c4-9c82cee9c72d'::uuid,0,9,7),
(498,'dd0e94d9-2435-4056-b311-b593bfa8cf03'::uuid,0,9,7),
(499,'875b069b-2c8b-4685-a262-3f60a3d95745'::uuid,0,9,7),
(502,'f3610e47-c31f-4c26-8536-03cd63cec234'::uuid,0,9,7),
(504,'b220d9ed-b064-4f12-8553-fc079bd85f53'::uuid,0,9,7),
(507,'75e41376-08d6-4002-8ca2-605a95225b2c'::uuid,0,9,7),
(509,'23daf499-8c7c-4dc7-9a92-3dac13c5a533'::uuid,0,9,7),
(511,'c87ced35-857f-4af6-8c80-515a13822743'::uuid,0,9,7),
(512,'e825b39c-c393-4952-aaa0-4c36120da38d'::uuid,0,9,7),
(515,'a9b513db-98c2-462b-afe1-02a6c84b24a6'::uuid,0,9,7),
(516,'61fdbc15-b108-4d89-9657-8fdda6b595e1'::uuid,0,9,7),
(517,'80dd62b0-76c2-4f53-87ef-efd5584104a7'::uuid,0,9,7),
(522,'f329850f-2089-4f37-afb8-f733e7c101ed'::uuid,0,9,7),
(523,'ba95a166-513e-4aac-999b-edf175edac44'::uuid,0,9,7),
(524,'3d0bbdd0-8d31-497a-969a-2ea6ddbeb029'::uuid,0,9,7),
(525,'2b63ca1f-90f6-4a5f-8776-f27a951295c0'::uuid,0,9,7),
(526,'c5cfe29b-bcad-40cf-b296-28c1bcee2828'::uuid,0,9,7),
(466,'2aeb7eab-8154-4531-98ab-9b8b8f452f56'::uuid,0,9,5),
(474,'5ccc92c6-1cf2-4343-9e30-4b1dbabb7168'::uuid,0,9,5),
(475,'ea8f47d1-b670-4afc-a1e3-73626eb14baf'::uuid,0,9,5),
(485,'6294c915-cdf0-42fd-9108-f26391938851'::uuid,0,9,5),
(493,'9fffa3df-fe63-4cbb-aff2-2b27ceb28a6a'::uuid,0,9,5),
(501,'29c288d8-3e4b-48d8-aa66-da6bcffd0a32'::uuid,0,9,5),
(505,'51d66b19-417a-4121-9791-ae9548f60718'::uuid,0,9,5),
(518,'f763f289-b70d-472a-bedd-141f216e0ed1'::uuid,1,9,5),
(519,'763f0abc-41bb-4e5e-87ee-22f36512f900'::uuid,0,9,5),
(527,'67032cda-7bcc-4b59-8293-6522cd1663ab'::uuid,0,9,5),
(482,'223844c4-9dcc-4e50-b350-a4f5d0a757cf'::uuid,0,9,2),
(495,'a2084c17-56e4-40f7-ba9f-8b1992405ada'::uuid,0,9,8),
(131,'089eced8-f950-45fa-bfeb-74c31952e6d4'::uuid,0,9,4),
(148,'7280e8f4-42b4-47f1-b842-fba32f0ba92d'::uuid,0,9,4),
(175,'af85d9b4-2afa-46b3-a8ac-1abfa270ffc1'::uuid,0,9,4),
(180,'72c5f34c-9def-4bbd-83f2-03ed9f03bb16'::uuid,0,9,4),
(220,'9b56fbcc-017f-446e-8d83-4547deacfaa5'::uuid,0,9,4),
(236,'16cc9651-6c93-4894-a9f9-6d6b8f7a4a4e'::uuid,0,9,4),
(247,'e13bb095-b015-44e3-8918-58345717512c'::uuid,0,9,4),
(292,'f191dd70-1764-4fef-9a10-7073a1734980'::uuid,0,9,4),
(306,'21bd74a2-b2a0-49b8-944a-266a7718641c'::uuid,0,9,4);
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
