-- =============================================
-- BecasFind · DDL Completo · MySQL 8.0
-- =============================================

CREATE DATABASE IF NOT EXISTS becasfind
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE becasfind;

-- =============================================
-- Tabla: regiones
-- =============================================
CREATE TABLE IF NOT EXISTS regiones (
    id_region BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    abreviatura VARCHAR(10) NOT NULL
) ENGINE=InnoDB;

-- =============================================
-- Tabla: comunas
-- =============================================
CREATE TABLE IF NOT EXISTS comunas (
    id_comuna BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_region BIGINT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    CONSTRAINT fk_comuna_region FOREIGN KEY (id_region) REFERENCES regiones(id_region)
) ENGINE=InnoDB;

CREATE INDEX idx_comuna_region ON comunas(id_region);

-- =============================================
-- Tabla: roles
-- =============================================
CREATE TABLE IF NOT EXISTS roles (
    id_rol BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- =============================================
-- Tabla: usuarios
-- Soft delete vía columna activo (TRUE = activo, FALSE = eliminado)
-- =============================================
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_rol BIGINT NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    nombre_completo VARCHAR(255) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
) ENGINE=InnoDB;

CREATE INDEX idx_usuario_email ON usuarios(email);
CREATE INDEX idx_usuario_activo ON usuarios(activo);

-- =============================================
-- Tabla: tipos_institucion
-- =============================================
CREATE TABLE IF NOT EXISTS tipos_institucion (
    id_tipo_inst BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- =============================================
-- Tabla: instituciones
-- =============================================
CREATE TABLE IF NOT EXISTS instituciones (
    id_institucion BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_tipo_inst BIGINT NOT NULL,
    rut VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(255) NOT NULL,
    sitio_web VARCHAR(255),
    contacto_email VARCHAR(255),
    CONSTRAINT fk_institucion_tipo FOREIGN KEY (id_tipo_inst) REFERENCES tipos_institucion(id_tipo_inst)
) ENGINE=InnoDB;

CREATE INDEX idx_institucion_tipo ON instituciones(id_tipo_inst);

-- =============================================
-- Tabla: tipos_beca
-- =============================================
CREATE TABLE IF NOT EXISTS tipos_beca (
    id_tipo_beca BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- =============================================
-- Tabla: becas (Entidad Central)
-- =============================================
CREATE TABLE IF NOT EXISTS becas (
    id_beca BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_institucion BIGINT NOT NULL,
    id_tipo_beca BIGINT NOT NULL,
    id_usuario_creador BIGINT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    descripcion_corta TEXT,
    descripcion_larga TEXT,
    monto_cobertura VARCHAR(255),
    fecha_inicio_postulacion DATE,
    fecha_cierre_postulacion DATE NOT NULL,
    url_oficial VARCHAR(500),
    estado_activa BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_beca_institucion FOREIGN KEY (id_institucion) REFERENCES instituciones(id_institucion),
    CONSTRAINT fk_beca_tipo FOREIGN KEY (id_tipo_beca) REFERENCES tipos_beca(id_tipo_beca),
    CONSTRAINT fk_beca_usuario FOREIGN KEY (id_usuario_creador) REFERENCES usuarios(id_usuario)
) ENGINE=InnoDB;

CREATE INDEX idx_beca_institucion ON becas(id_institucion);
CREATE INDEX idx_beca_tipo ON becas(id_tipo_beca);
CREATE INDEX idx_beca_estado ON becas(estado_activa);
CREATE INDEX idx_beca_fecha_cierre ON becas(fecha_cierre_postulacion);
CREATE INDEX idx_beca_vigencia ON becas(estado_activa, fecha_cierre_postulacion);

-- =============================================
-- Tabla: becas_regiones (Relación M:N Beca ↔ Región)
-- =============================================
CREATE TABLE IF NOT EXISTS becas_regiones (
    id_beca BIGINT NOT NULL,
    id_region BIGINT NOT NULL,
    PRIMARY KEY (id_beca, id_region),
    CONSTRAINT fk_br_beca FOREIGN KEY (id_beca) REFERENCES becas(id_beca) ON DELETE CASCADE,
    CONSTRAINT fk_br_region FOREIGN KEY (id_region) REFERENCES regiones(id_region) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_br_region ON becas_regiones(id_region);

-- =============================================
-- Tabla: requisitos_perfil (Relación 1:1 con Beca)
-- =============================================
CREATE TABLE IF NOT EXISTS requisitos_perfil (
    id_requisito BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_beca BIGINT NOT NULL UNIQUE,
    rsh_maximo_porcentaje INT,
    nem_minimo DECIMAL(3,1),
    paes_minimo INT,
    es_para_primer_anio BOOLEAN NOT NULL DEFAULT FALSE,
    es_para_curso_superior BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT fk_rp_beca FOREIGN KEY (id_beca) REFERENCES becas(id_beca) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================
-- Tabla: documentos_requeridos (Relación N:1 con Beca)
-- =============================================
CREATE TABLE IF NOT EXISTS documentos_requeridos (
    id_documento BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_beca BIGINT NOT NULL,
    nombre_documento VARCHAR(255) NOT NULL,
    es_obligatorio BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_dr_beca FOREIGN KEY (id_beca) REFERENCES becas(id_beca) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_dr_beca ON documentos_requeridos(id_beca);

-- =============================================
-- Tabla: password_reset_tokens
-- Token UUID con expiración de 15 minutos
-- =============================================
CREATE TABLE IF NOT EXISTS password_reset_tokens (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    token CHAR(36) NOT NULL,
    id_usuario BIGINT NOT NULL,
    fecha_expiracion TIMESTAMP NOT NULL,
    CONSTRAINT fk_prt_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_prt_token ON password_reset_tokens(token);
CREATE INDEX idx_prt_usuario ON password_reset_tokens(id_usuario);

-- =============================================
-- Tabla: perfiles_estudiante (Relación 1:1 con Usuario)
-- =============================================
CREATE TABLE IF NOT EXISTS perfiles_estudiante (
    id_perfil BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_usuario BIGINT NOT NULL UNIQUE,
    rsh_porcentaje INT,
    nem_promedio DECIMAL(3,1),
    id_region BIGINT,
    id_institucion BIGINT,
    carrera_interes VARCHAR(255),
    es_primer_anio BOOLEAN NOT NULL DEFAULT FALSE,
    es_curso_superior BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT fk_pe_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_pe_region FOREIGN KEY (id_region) REFERENCES regiones(id_region) ON DELETE SET NULL,
    CONSTRAINT fk_pe_institucion FOREIGN KEY (id_institucion) REFERENCES instituciones(id_institucion) ON DELETE SET NULL
) ENGINE=InnoDB;

-- =============================================
-- Tabla: becas_favoritas (Relación M:N Usuario ↔ Beca)
-- =============================================
CREATE TABLE IF NOT EXISTS becas_favoritas (
    id_usuario BIGINT NOT NULL,
    id_beca BIGINT NOT NULL,
    PRIMARY KEY (id_usuario, id_beca),
    CONSTRAINT fk_bf_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_bf_beca FOREIGN KEY (id_beca) REFERENCES becas(id_beca) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_bf_usuario ON becas_favoritas(id_usuario);
CREATE INDEX idx_bf_beca ON becas_favoritas(id_beca);

-- =============================================
-- Datos semilla: Roles
-- =============================================
INSERT INTO roles (nombre_rol) VALUES ('ADMIN');
INSERT INTO roles (nombre_rol) VALUES ('USER');

-- =============================================
-- Datos semilla: Tipos de Institución
-- =============================================
INSERT INTO tipos_institucion (nombre) VALUES ('Universidad');
INSERT INTO tipos_institucion (nombre) VALUES ('Instituto Profesional');
INSERT INTO tipos_institucion (nombre) VALUES ('Centro de Formación Técnica');
INSERT INTO tipos_institucion (nombre) VALUES ('Fundación');
INSERT INTO tipos_institucion (nombre) VALUES ('Organismo Gubernamental');
INSERT INTO tipos_institucion (nombre) VALUES ('Empresa Privada');
INSERT INTO tipos_institucion (nombre) VALUES ('ONG');

-- =============================================
-- Datos semilla: Tipos de Beca
-- =============================================
INSERT INTO tipos_beca (nombre) VALUES ('Beca de Arancel');
INSERT INTO tipos_beca (nombre) VALUES ('Beca de Mantención');
INSERT INTO tipos_beca (nombre) VALUES ('Beca de Alimentación');
INSERT INTO tipos_beca (nombre) VALUES ('Beca de Movilidad');
INSERT INTO tipos_beca (nombre) VALUES ('Beca de Investigación');
INSERT INTO tipos_beca (nombre) VALUES ('Beca de Excelencia Académica');
INSERT INTO tipos_beca (nombre) VALUES ('Beca Deportiva');
INSERT INTO tipos_beca (nombre) VALUES ('Beca Cultural');

-- =============================================
-- Datos semilla: Regiones de Chile
-- =============================================
INSERT INTO regiones (nombre, abreviatura) VALUES ('Arica y Parinacota', 'XV');
INSERT INTO regiones (nombre, abreviatura) VALUES ('Tarapacá', 'I');
INSERT INTO regiones (nombre, abreviatura) VALUES ('Antofagasta', 'II');
INSERT INTO regiones (nombre, abreviatura) VALUES ('Atacama', 'III');
INSERT INTO regiones (nombre, abreviatura) VALUES ('Coquimbo', 'IV');
INSERT INTO regiones (nombre, abreviatura) VALUES ('Valparaíso', 'V');
INSERT INTO regiones (nombre, abreviatura) VALUES ('Metropolitana de Santiago', 'RM');
INSERT INTO regiones (nombre, abreviatura) VALUES ("O'Higgins", 'VI');
INSERT INTO regiones (nombre, abreviatura) VALUES ('Maule', 'VII');
INSERT INTO regiones (nombre, abreviatura) VALUES ('Ñuble', 'XVI');
INSERT INTO regiones (nombre, abreviatura) VALUES ('Biobío', 'VIII');
INSERT INTO regiones (nombre, abreviatura) VALUES ('La Araucanía', 'IX');
INSERT INTO regiones (nombre, abreviatura) VALUES ('Los Ríos', 'XIV');
INSERT INTO regiones (nombre, abreviatura) VALUES ('Los Lagos', 'X');
INSERT INTO regiones (nombre, abreviatura) VALUES ('Aysén', 'XI');
INSERT INTO regiones (nombre, abreviatura) VALUES ('Magallanes', 'XII');
