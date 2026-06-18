-- BecasFind · Test Seed Data · H2
INSERT INTO roles (nombre_rol) VALUES ('ADMIN');
INSERT INTO roles (nombre_rol) VALUES ('STUDENT');

INSERT INTO tipos_institucion (nombre) VALUES ('Universidad'),('Instituto Profesional'),('Centro de Formacion Tecnica'),('Fundacion'),('Organismo Gubernamental'),('Empresa Privada'),('ONG'),('Municipal');

INSERT INTO tipos_beca (nombre) VALUES ('Beca de Arancel'),('Beca de Mantencion'),('Beca de Alimentacion'),('Beca de Movilidad'),('Beca de Investigacion'),('Beca de Excelencia Academica'),('Beca Deportiva'),('Beca Cultural');

INSERT INTO regiones (nombre, abreviatura) VALUES ('Metropolitana de Santiago','RM'),('Valparaiso','V'),('Biobio','VIII'),('La Araucania','IX');

INSERT INTO comunas (id_region, nombre) VALUES (1,'Santiago'),(1,'Providencia'),(2,'Vina del Mar'),(3,'Concepcion');

INSERT INTO instituciones (id_tipo_inst, rut, nombre, sitio_web, contacto_email) VALUES (1,'71.540.100-2','DUOC UC','https://www.duoc.cl','admision@duoc.cl'),(1,'81.669.100-8','PUCV','https://www.pucv.cl','contacto@pucv.cl'),(5,'60.900.000-1','JUNAEB','https://www.junaeb.cl','contacto@junaeb.cl');

INSERT INTO usuarios (id_rol, email, password_hash, nombre_completo, activo, creado_en) VALUES (1,'admin@becasfind.cl','$2a$10$TXc76DmxvRXRH.yGYru4XOYhPEH8.HkngiiXzHhdhbJlygUmS4wNO','Admin BecasFind',true,CURRENT_TIMESTAMP);
INSERT INTO usuarios (id_rol, email, password_hash, nombre_completo, activo, creado_en) VALUES (2,'estudiante@duoc.cl','$2a$10$TXc76DmxvRXRH.yGYru4XOYhPEH8.HkngiiXzHhdhbJlygUmS4wNO','Maria Gonzalez',true,CURRENT_TIMESTAMP);

INSERT INTO becas (id_institucion, id_tipo_beca, id_usuario_creador, nombre, descripcion_corta, descripcion_larga, monto_cobertura, fecha_inicio_postulacion, fecha_cierre_postulacion, url_oficial, estado_activa) VALUES (1,1,1,'Beca Nuevo Milenio','Beca de arancel para primer ano','Descripcion larga de la Beca Nuevo Milenio. DOCUMENTOS REQUERIDOS: [OBLIGATORIO] Cedula de identidad [OPCIONAL] Carta de motivacion.','$600.000 anual','2025-10-01','2026-12-31','https://www.becas.cl',true),(1,1,1,'Beca Excelencia','Beca para alumnos con alto NEM','Descripcion larga de la Beca Excelencia.','$1.500.000 anual','2025-09-01','2026-11-30','https://www.duoc.cl/becas',true),(2,1,1,'Beca PUCV Arancel','Cobertura de arancel PUCV','Descripcion larga Beca PUCV.','$2.000.000','2025-10-01','2026-11-15','https://www.pucv.cl',true),(3,3,1,'Beca Alimentacion JUNAEB','Tarjeta electronica de alimentacion','Descripcion larga Beca BAES.','$40.000 mensual','2025-01-02','2025-03-15','https://www.junaeb.cl',true),(3,2,1,'Beca Presidente Republica','Apoyo economico mensual','Descripcion larga Beca PR.','$50.000 mensual','2025-08-01','2026-07-31','https://www.junaeb.cl',true),(1,3,1,'Beca Alimentacion DUOC','Alimentacion para estudiantes DUOC','Descripcion larga Beca Alimentacion DUOC.','$35.000 mensual','2025-01-01','2024-03-01','https://www.duoc.cl/becas',true),(1,2,1,'Beca Deportiva DUOC','Beca para deportistas destacados','Descripcion larga Beca Deportiva.','$500.000 anual','2025-01-01','2026-12-31','https://www.duoc.cl',true);

INSERT INTO requisitos_perfil (id_beca, rsh_maximo_porcentaje, nem_minimo, paes_minimo, es_para_primer_anio, es_para_curso_superior) VALUES (1,60,5.0,null,true,false),(2,80,6.0,null,true,false),(3,60,5.5,null,true,false),(4,60,4.0,null,false,true),(5,null,null,null,false,true),(6,80,5.0,null,true,false),(7,60,null,null,false,true);

INSERT INTO becas_regiones (id_beca, id_region) VALUES (1,1),(1,2),(2,1),(3,2),(6,1),(7,2);

INSERT INTO documentos_requeridos (id_beca, nombre_documento, es_obligatorio) VALUES (1,'Cedula de identidad vigente',true),(1,'Certificado de notas',true),(2,'Cedula de identidad vigente',true),(2,'Carta de motivacion',false),(3,'Cedula de identidad',true),(3,'Certificado RSH',true),(4,'Comprobante de matricula',true),(5,'Cedula de identidad',true),(6,'Cedula de identidad',true),(7,'Certificado deportivo',true);
