BEGIN;
SET LOCAL lock_timeout='5s';
CREATE TEMP TABLE correcciones(id bigint,uuid uuid,version bigint,tipo_anterior bigint,tipo_nuevo bigint) ON COMMIT DROP;
INSERT INTO correcciones VALUES
(284,'11561d59-e96a-41b2-ae65-1468a1288f39'::uuid,0,9,7),
(287,'9d824eb2-83ac-43a6-b0e7-0c5f745b04a8'::uuid,0,9,7),
(289,'6a0707bc-b5fe-45da-827f-fcd8fb31ba9c'::uuid,0,9,7),
(291,'2083137e-35a7-4d96-bf4b-c66e7718fecf'::uuid,0,9,7),
(293,'b92f2e33-8568-4c55-bd95-2b0b3506e2b9'::uuid,0,9,7),
(294,'dff6bcf3-3b12-46e8-835b-94c2bd179624'::uuid,0,9,7),
(296,'fa7513fd-4c90-456d-ba67-f81fedcc07d9'::uuid,0,9,7),
(297,'cace1550-37d2-4d96-9324-8ade2478852b'::uuid,0,9,7),
(299,'7f94eb9a-3add-4d6e-b7c9-69eb9fe1cdc8'::uuid,0,9,7),
(300,'e4d1e6ae-c939-4f0d-9592-8ec6558b1e45'::uuid,0,9,7),
(301,'521ecc43-cd7d-41b7-9268-01e834c4fa44'::uuid,0,9,7),
(302,'318445bc-34e8-4ca9-a865-afd9424f3378'::uuid,0,9,7),
(309,'d08ac44a-0358-40b2-90d4-8bf0e458a1b6'::uuid,0,9,7),
(313,'316b47d8-9980-4673-afd1-d054a9782a4a'::uuid,0,9,7),
(315,'725bd129-0f0e-4f93-84ae-b2435a4a505a'::uuid,0,9,7),
(316,'a9d0f01b-1b36-432b-8f9f-20151ec88fc1'::uuid,0,9,7),
(317,'d2182b03-0dc3-492e-99e7-96ee560fc231'::uuid,0,9,7),
(318,'5b96c1f3-2d86-4332-b736-db7700914247'::uuid,0,9,7),
(319,'e7a527bf-c235-4b3f-a0a6-3a728f415e63'::uuid,0,9,7),
(321,'cfa2072d-c1f2-4bf8-b31f-3effb792c63b'::uuid,0,9,7),
(322,'4e730f8c-c167-4088-989c-27e746d3e27c'::uuid,0,9,7),
(326,'b5a8075b-4929-4962-9250-e02ee9fa6236'::uuid,0,9,7),
(328,'4c7bcadf-def3-4f76-b8bf-4f7fcb6d7625'::uuid,0,9,7),
(330,'d07b4f20-aa32-40bc-b1ab-4a4a651f8e29'::uuid,0,9,7),
(335,'bd9baef7-1706-4674-94a8-c32ca1671df2'::uuid,0,9,7),
(337,'0ae3b7e4-d5e4-463d-bc04-89aaa0f8fc4b'::uuid,0,9,7),
(338,'b67f77b3-3d34-4bdd-b777-8e1c248a16dc'::uuid,0,9,7),
(339,'84f4de8c-14a6-4f74-979b-4ee171ac3d77'::uuid,0,9,7),
(340,'735a2b59-21f1-4101-9d1b-a59a815a798d'::uuid,0,9,7),
(342,'c4c03c84-80b6-4411-92eb-03da217bd0a6'::uuid,0,9,7),
(344,'981ee801-3c80-4888-877b-db29c7dea7a7'::uuid,0,9,7),
(345,'8aadf4e9-53dc-4ebd-a682-3dd906b13c41'::uuid,0,9,7),
(348,'9cb796f5-6d14-44ed-a5d4-3f0e0447c2d4'::uuid,0,9,7),
(352,'6c1ff549-5685-4ec0-a645-b2294d25b12c'::uuid,0,9,7),
(354,'4d26d644-2873-4438-bda7-51b05e6e4f09'::uuid,0,9,7),
(355,'62681b32-4fff-4978-88a2-871898d9fcae'::uuid,0,9,7),
(357,'c8e8679f-0be1-47c4-a548-f9acfb77ad78'::uuid,0,9,7),
(359,'548e96a8-e7d8-4b16-b549-c802242d17a4'::uuid,0,9,7),
(360,'78771074-0289-4b91-8623-07a7640c145a'::uuid,0,9,7),
(361,'bf5876ae-5c03-4e17-956e-befbdf065784'::uuid,0,9,7),
(364,'8e47bc49-ad0c-428b-a373-1d8082267d2e'::uuid,0,9,7),
(365,'d4e9691e-bef1-478e-af0e-2a5e8f01012e'::uuid,0,9,7),
(367,'3b91c020-b195-4128-89eb-affe6c9e5523'::uuid,0,9,7),
(369,'c889de93-82ea-49c6-8744-4673f20071e8'::uuid,0,9,7),
(283,'87e0f3a8-aac5-4be8-b93f-e922e26819ac'::uuid,0,9,5),
(290,'8cd18541-622b-49dc-8979-e2ad429488ac'::uuid,0,9,5),
(298,'b502e036-516c-4dee-bc40-297480b3804a'::uuid,0,9,5),
(304,'de630fe3-0bee-4804-af2b-f8b7330b814d'::uuid,0,9,5),
(311,'4e6e42c8-9ad5-485a-a37d-631911a93a5c'::uuid,0,9,5),
(325,'54d25af0-92b8-4e03-8ec0-5916895c9028'::uuid,0,9,5),
(327,'c6303482-479e-4955-80d0-9827c0f9151e'::uuid,0,9,5),
(329,'3200e60d-476e-4822-94b8-94aff8b6c9c3'::uuid,0,9,5),
(333,'f203e82f-69fd-49ad-a55b-594fb8c78124'::uuid,0,9,5),
(350,'057d6d1a-dbc6-4479-a2e1-1cdfebc8eec8'::uuid,0,9,5),
(358,'af05b33d-c588-4d50-a86f-91046ce852f6'::uuid,0,9,5),
(363,'d990dc1f-2449-4123-8078-a3e724ce4ffa'::uuid,0,9,5),
(368,'141e3bc2-0962-4b38-8346-f90376d92bef'::uuid,0,9,5),
(370,'8b13ae4f-4d2c-4e03-8da1-54f5f424fea8'::uuid,0,9,5),
(295,'a0a0a8fa-b63a-4b53-8680-ffa7529fad96'::uuid,0,9,2),
(307,'0dfe63d5-b147-45b6-9849-0cf42d5b3232'::uuid,0,9,2),
(323,'de87a267-ac67-492e-9bf9-de4454db55b1'::uuid,0,9,2),
(308,'d1bacbad-1430-44d1-931c-e88e081452a9'::uuid,0,9,8);
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
