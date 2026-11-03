BEGIN;
SET LOCAL lock_timeout='5s';
CREATE TEMP TABLE correcciones(id bigint,uuid uuid,version bigint,tipo_anterior bigint,tipo_nuevo bigint) ON COMMIT DROP;
INSERT INTO correcciones VALUES
(195,'a878f54c-7336-4e07-9200-11dbd1eefb8a'::uuid,0,9,7),
(198,'c6bd8e78-ca84-4014-a494-63e1202013b0'::uuid,0,9,7),
(202,'30184ba7-876c-499e-b992-de4bbbe871b9'::uuid,0,9,7),
(203,'5054a6ce-097d-4f53-a76d-516adcf90771'::uuid,0,9,7),
(204,'9b4b7934-1f13-498e-b7dd-e0a13e7c9c6b'::uuid,0,9,7),
(206,'8c1071d7-0d47-49f1-83c0-e6abe4d9f62d'::uuid,0,9,7),
(207,'4a1e3ab6-2492-4159-8718-cbdd03eae1a9'::uuid,0,9,7),
(210,'b7d2fd6e-db4b-4b4f-aa54-dd24152507f8'::uuid,0,9,7),
(212,'c5c15edc-fe9e-42a9-b262-e88b3070eb4e'::uuid,0,9,7),
(216,'7551ac2e-dc59-4df5-8acc-ca7b1958473e'::uuid,0,9,7),
(219,'94c3abb1-c020-48e2-b8bd-ad8f8e589fb7'::uuid,0,9,7),
(221,'62cf00eb-ceeb-4832-b9d6-802526fc9f24'::uuid,0,9,7),
(225,'617a1559-c694-4506-a665-acee0f9899f7'::uuid,0,9,7),
(226,'c697c921-e233-4110-8b15-cadd757a3529'::uuid,0,9,7),
(230,'4bbcb873-bb2c-43ae-bada-8786fbbe32a4'::uuid,0,9,7),
(233,'2c40d3ea-34c8-4687-b02a-fdf3eb26418e'::uuid,0,9,7),
(234,'eda4c362-f3a8-41df-a241-254c9746293f'::uuid,0,9,7),
(235,'db09f51a-331c-4bae-872d-0df2d9a378e5'::uuid,0,9,7),
(237,'554478a6-268a-4e26-827d-e56a0d8c011a'::uuid,0,9,7),
(238,'6c767779-cd1e-4f3b-ae47-f7ec9748f3d6'::uuid,0,9,7),
(239,'e5d013bd-2dad-4fca-976b-d5ad691e9deb'::uuid,0,9,7),
(240,'825e30aa-51eb-4d0a-aba5-7a25a3ea508e'::uuid,0,9,7),
(241,'4f7fa0dd-0c21-4d29-9580-7aa4701eed98'::uuid,0,9,7),
(243,'cb00dd91-75c2-4d16-9a34-0e2456c81e20'::uuid,0,9,7),
(244,'40e7d3f9-1353-4ce3-80cf-f6309d56a24f'::uuid,0,9,7),
(245,'3f6ac7f8-fa4a-4a82-8ef0-3f5904b7015f'::uuid,0,9,7),
(246,'8f084c77-beea-4f88-b3e5-05b9ce35152f'::uuid,0,9,7),
(248,'d451029f-468b-4e34-b758-aebe08749491'::uuid,0,9,7),
(252,'da9f9f5b-9006-466f-824c-08df80484463'::uuid,0,9,7),
(254,'4a7821dc-31f5-47c0-bec0-c2d9e6f6ed37'::uuid,0,9,7),
(256,'0c88fc2a-4f58-4ce9-b997-5ebeb1cf3542'::uuid,0,9,7),
(258,'ff4ef933-fe40-48f6-a450-ddf0bd6f59a3'::uuid,0,9,7),
(259,'809d36ee-134e-49c3-b9fd-463c42791633'::uuid,0,9,7),
(262,'b9768b49-2abf-47b8-9c5b-bd7c9ccd27f0'::uuid,0,9,7),
(267,'3d270aac-ca38-4f1a-b69c-dcfa1eecf09b'::uuid,0,9,7),
(271,'3eb78fcd-336c-4380-a8a9-f422fa659e10'::uuid,0,9,7),
(280,'6df00ebf-d945-4d8d-8281-c5ce0c8d4e72'::uuid,0,9,7),
(200,'c5993f59-b9d2-482f-b670-5f63d97bd9de'::uuid,0,9,5),
(209,'3bd84a69-9adf-438a-b3da-9e7108a4ae4b'::uuid,0,9,5),
(213,'14e5b9a9-abfb-41c0-99ac-2f8f83aa3ace'::uuid,0,9,5),
(215,'93ec1013-173d-4c9d-a9ed-4c40aff29e99'::uuid,0,9,5),
(217,'645f5e78-a187-4198-8b94-568b9973f208'::uuid,0,9,5),
(218,'34d248ee-0cf8-40b3-bbe1-7aa7ebe5ea47'::uuid,0,9,5),
(222,'86b45159-0446-4d4f-8be0-4248f4ed3b76'::uuid,0,9,5),
(223,'a1b8507f-d645-42d3-9c5c-8e773e5be571'::uuid,0,9,5),
(227,'1a82484e-1c2b-4867-a6b9-1f84c46c42d6'::uuid,0,9,5),
(255,'d4b5e1f3-91b1-4091-834a-2a9f9f05bfed'::uuid,0,9,5),
(257,'8f8b4b5f-1231-4ae9-9207-c6637a09f4de'::uuid,0,9,5),
(260,'b00bde27-8092-4216-9774-8745ec78d9a4'::uuid,0,9,5),
(263,'ab08a79f-417d-426b-b966-9a561ad7a1dc'::uuid,0,9,5),
(264,'bc02cf2f-a0e5-44a1-8c16-c372a1ea186b'::uuid,0,9,5),
(273,'99323baf-0dcd-4d09-a0ed-0469d52f2aa2'::uuid,0,9,5),
(277,'8e7ebac6-bb29-44e4-b665-99063e08117e'::uuid,0,9,5),
(279,'e6ef0e92-595f-4789-b6ee-99a24e8005d6'::uuid,0,9,5),
(205,'d65ed352-1244-4441-8d4f-915d14a1b1a6'::uuid,0,9,2),
(208,'9f4f8894-f4aa-4457-91e8-a34cd5f35996'::uuid,0,9,2),
(231,'0485398a-a487-4203-9441-724d97d05789'::uuid,0,9,2),
(249,'927af1a7-13bc-437a-9857-4bfcff1dea37'::uuid,0,9,2),
(278,'4a7282f8-a3fd-4945-90a0-bd43cded6ef3'::uuid,0,9,2),
(214,'eec985a2-f75c-4c54-b8ba-e3f883f21aaf'::uuid,0,9,8);
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
