BEGIN;
SET LOCAL lock_timeout='5s';
CREATE TEMP TABLE correcciones(id bigint,uuid uuid,version bigint,tipo_anterior bigint,tipo_nuevo bigint) ON COMMIT DROP;
INSERT INTO correcciones VALUES
(6,'d6cff74c-42a3-47ef-b300-bab09ccf0b76'::uuid,0,9,4),
(15,'3548bf9f-2b84-42e8-8ac0-b14272f80fd0'::uuid,0,9,4),
(21,'e2114db0-b245-4950-a2bb-2660f007e342'::uuid,0,9,4),
(26,'0c372274-cdc0-498c-bf75-13bf07c0c9f2'::uuid,0,9,4),
(29,'09536ef4-7a7c-4fcf-9ec6-7ac005f88353'::uuid,0,9,4),
(38,'83155f59-8a14-4f44-911b-9c9225a5d06a'::uuid,0,9,4),
(40,'c5ef4520-9b26-430b-b122-2cbc5061f770'::uuid,0,9,4),
(74,'b5ab1857-8377-4c27-8f35-ca62aabcce98'::uuid,0,9,4),
(83,'a01d0d98-da82-4111-9030-344bedcc65ef'::uuid,0,9,4),
(87,'3f0c550a-ea26-4661-91e5-b391c64cebc9'::uuid,0,9,4),
(89,'6313c90b-4332-4718-acbf-613a6591c8ed'::uuid,0,9,4),
(101,'e50604ba-024c-46a2-a1a6-1e940d86ea7a'::uuid,0,9,4),
(107,'fe455bbb-f320-4d3c-88e9-c23dabbabad6'::uuid,0,9,4),
(211,'3112dffa-bfb6-4917-884b-1bc63e2fe7c6'::uuid,0,9,4),
(266,'4643d856-726f-4ffd-87c0-b795f9d806f9'::uuid,0,9,4),
(332,'91f1a6fe-7d85-4079-8b30-c123669e2eab'::uuid,0,9,4),
(334,'88ac6a26-91b8-4051-82dd-e61355adeff4'::uuid,0,9,4),
(347,'51454f1c-5ff8-40a4-aacd-cbeff79838db'::uuid,0,9,4),
(366,'1e938225-cba2-4b78-9da2-98902b06ce31'::uuid,0,9,4),
(373,'e2213b53-51f8-4b59-b02c-f90a5fc88c4b'::uuid,0,9,4),
(396,'55ed985e-7701-4293-9526-e7ddabfa856b'::uuid,0,9,4),
(404,'3b92e7cd-b4ac-4627-9ecf-e6b44118acbc'::uuid,0,9,4),
(433,'2c5426ce-4880-4f95-b5db-22f873d8877f'::uuid,0,9,4),
(439,'2bcd548a-5a13-41b9-8764-2a8bd1c07541'::uuid,0,9,4),
(477,'06e92527-a183-4b37-9481-c88011de170b'::uuid,0,9,4),
(483,'7d95bc16-d5ae-43cd-93de-ffb012951f37'::uuid,0,9,4),
(484,'d2d2f486-7d6e-4ae6-85ff-8f19587f7c65'::uuid,0,9,4),
(489,'c8982c95-c281-4d09-9cf7-317a8de7b21a'::uuid,0,9,4),
(491,'5981f08c-922c-40b5-85c9-7a9f6a510012'::uuid,0,9,4),
(503,'86cad381-f81f-4b75-92f6-e8b5a17ba04e'::uuid,0,9,4),
(508,'3bf8f23b-f3d9-460e-9698-2e11e06653fc'::uuid,0,9,4),
(520,'c16d155f-4014-4769-b4cc-2a9f1a1052f8'::uuid,0,9,4),
(7,'bc7e4182-acc9-49fa-a062-1f2c158c6616'::uuid,0,9,5),
(10,'7dab4aa9-2da1-48f5-b984-e14ffcd7ece3'::uuid,0,9,5),
(17,'5f919505-ad66-404a-bb3c-33dd6995265d'::uuid,0,9,5),
(35,'0573fb91-8350-4e79-850c-322ffc876913'::uuid,0,9,5),
(41,'82c2c767-66b0-4366-9056-f33c4be2e707'::uuid,0,9,5),
(53,'d80f5bb9-1beb-436d-aa41-b722f6d6364f'::uuid,0,9,5),
(54,'44605026-b9cf-4fb3-bb25-8a3a8a894aff'::uuid,0,9,5),
(61,'27c77d21-e30e-4bc3-9f08-ceaa37a11068'::uuid,0,9,5),
(64,'1c16f749-45f2-4b85-8838-50d1928758bc'::uuid,0,9,5),
(66,'f7dd45a3-baf6-4868-a346-93841e1cfd76'::uuid,0,9,5),
(67,'df838dc6-c288-460a-8fa1-8e8f01d1e35e'::uuid,0,9,5),
(69,'8c92fdba-65f3-4aee-96c8-e0c1db40d654'::uuid,0,9,5),
(88,'8db019ff-fe62-4bfe-b2de-5376be1ae71d'::uuid,0,9,5),
(95,'f761a86e-2e8e-4a5f-80b2-0212c05522d6'::uuid,0,9,5),
(57,'f393ea3c-a42b-49cb-b18d-f5ac6cf22f18'::uuid,0,9,7),
(84,'914b8c1b-8f90-4c85-bdd1-024cf76b54b7'::uuid,0,9,7),
(92,'8dd7e072-983a-4b33-9c1f-caeb7d3b2f7d'::uuid,0,9,7),
(94,'a8ee4d92-d507-4ac1-87d4-c2f3bfc44673'::uuid,0,9,7),
(126,'ac0a9ea4-cb5c-4df2-b260-651ef3dc5a89'::uuid,0,9,7),
(150,'4c9c4533-7b00-4b77-8542-a3bb88c1b178'::uuid,0,9,7),
(192,'7c4cf49e-9e43-432a-b662-a72837ca5a94'::uuid,0,9,7),
(8,'e367096b-2790-45ea-904e-5e5373a90e08'::uuid,0,9,2),
(9,'5c6c8dbf-70a4-4c00-ae68-1c4392a31085'::uuid,0,9,2),
(12,'98c9d555-3d2d-4934-b772-de3c7829fc89'::uuid,0,9,2),
(76,'6e1979d4-9c61-4b08-a45b-6b6d6e2525ca'::uuid,0,9,2),
(78,'dec83ba5-bc47-487a-95ae-392055063d2e'::uuid,0,9,2),
(109,'e9549296-13fb-469f-a7eb-bc2214bc13a0'::uuid,0,9,2),
(110,'1a8ab1b1-7e39-4aa7-8330-1dcd511bd514'::uuid,0,9,2),
(81,'25edd97c-70fc-4b4b-9237-7e64dc751d79'::uuid,0,9,8);
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
