BEGIN;
SET LOCAL lock_timeout='5s';
CREATE TEMP TABLE correcciones(id bigint,uuid uuid,version bigint,tipo_anterior bigint,tipo_nuevo bigint) ON COMMIT DROP;
INSERT INTO correcciones VALUES
(479,'bde44176-44ab-4658-bf1e-f785e009597f'::uuid,0,9,2),
(383,'47d224f7-9731-4ca3-a691-a177f0b5966c'::uuid,0,9,3),
(120,'dab03438-369e-4df8-ab04-656eae47be98'::uuid,0,9,4),
(445,'929f4d5c-231e-4443-92c9-6ca2cb1cde87'::uuid,1,9,8),
(314,'a721fbc7-5b58-46db-ac88-5999638e9c38'::uuid,1,5,2),
(16,'a638d02b-a625-4cee-848d-d80051de3d86'::uuid,0,9,2),
(18,'76c33271-0c0c-4272-bfd8-aaac404ceb66'::uuid,0,9,4),
(36,'a9293228-4708-4047-b420-57fa19613c7f'::uuid,0,9,5),
(75,'1e9edc0f-6b95-47a1-bf41-19759949d0f7'::uuid,0,9,4),
(98,'71116d23-3945-46cb-9394-46ef67db49fd'::uuid,0,9,2),
(114,'6cba2ff3-7c1a-4938-b511-d04b384ac4a2'::uuid,0,9,4),
(132,'2120c1b4-12d2-48d4-9ae2-460317c24da5'::uuid,0,9,7),
(166,'3e8215fc-2554-465f-bedd-5d8dcf7a5f6a'::uuid,0,9,5),
(174,'419b8f9d-a696-4139-be2d-2e1561801e90'::uuid,0,9,5),
(187,'bd0b68e3-6abc-411a-9e55-01f918483576'::uuid,0,9,2),
(199,'59e502a2-ccd0-49f2-b2a3-4df4b0b0de1e'::uuid,0,9,5),
(201,'c0515fbf-4ff3-4781-9623-d4fb6bd5d554'::uuid,0,9,4),
(224,'c40dabd6-af08-4c3d-a6e3-3c320a4c3717'::uuid,0,9,5),
(232,'47940298-b473-496b-8257-e7995ea82d43'::uuid,0,9,2),
(250,'f4cea848-5ebe-4c19-b51f-d0b868496fdb'::uuid,0,9,4),
(268,'3e34cf23-7dbb-446f-ade9-16ca13b5f004'::uuid,0,9,5),
(269,'d12d90d3-2fdc-4d6b-b0f3-d9d776686d8f'::uuid,0,9,5),
(275,'74742803-319e-4295-b5a4-c29eb9f43f8a'::uuid,0,9,8),
(276,'6911b56a-30e5-4638-b9de-388952541ac7'::uuid,0,9,4),
(281,'5a06faae-7a6d-44a7-bb04-c259b8488977'::uuid,0,9,4),
(286,'ac5b1d28-04cc-4245-9a37-3291782ad8c7'::uuid,0,9,5),
(288,'6321fa90-534d-4031-acb2-39e78afb3c6c'::uuid,0,9,7),
(303,'a26a15e6-89fc-4918-9035-58d4ae648aee'::uuid,0,9,2),
(305,'4f9fa436-5263-48d6-82a2-9f79895ae1ce'::uuid,0,9,5),
(310,'9635ce70-13f6-427d-a012-6d470a51d2d0'::uuid,1,9,5),
(324,'5d1cb63f-a806-4a2e-92b3-50ad3c0cb92a'::uuid,0,9,7),
(331,'214dac55-77e8-440a-80db-37c3c18e15f5'::uuid,0,9,5),
(341,'73e995f5-9a74-40b3-980c-86433f6f2982'::uuid,0,9,7),
(343,'267502a0-fee7-49a1-8b2f-49d8e0ad3cd9'::uuid,0,9,4),
(346,'e12518fa-caec-47b6-b7e7-e241ab301941'::uuid,0,9,8),
(349,'12162948-fc74-4e7a-bc0e-602f309da68a'::uuid,0,9,5),
(351,'6e1c5af0-ae83-4351-9347-eb40dc09afae'::uuid,0,9,4),
(372,'9becda5a-54bb-4614-ae45-2db48b39f295'::uuid,0,9,5),
(376,'330cbb6d-1567-4336-aaaf-07aa70523abb'::uuid,0,9,5),
(377,'a3ee81d1-9903-4d65-a988-a86402ae710a'::uuid,0,9,5),
(422,'6a252421-22bc-4121-acd6-5a2ce84a1929'::uuid,0,9,5),
(430,'557600a2-493d-473c-8249-d54de32b5c69'::uuid,0,9,5),
(437,'ea5ac8c6-5d0f-4aaf-b69a-26c89f50cb7f'::uuid,0,9,4),
(459,'4af21b24-d546-4733-a831-92cd00d094cc'::uuid,0,9,7),
(460,'f34f34e9-bb29-47a7-8dfb-6c1c470da438'::uuid,0,9,4),
(462,'2df0d353-0c2f-433b-8ddf-a9397e2aff6b'::uuid,0,9,2),
(469,'6c0662b5-f973-4078-97f0-4f4a3ea9a837'::uuid,0,9,5),
(487,'cafc1ede-8dc7-4422-b297-39354c45b603'::uuid,0,9,2);
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
