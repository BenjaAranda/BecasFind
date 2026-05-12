-- =============================================
-- BecasFind · Data Seeding · MySQL 8.0
-- =============================================
-- Orden estricto por Foreign Keys:
--   Roles → Regiones → Comunas → TiposInst
--   → Instituciones → TiposBeca → Usuarios
--   → Becas → RequisitosPerfil → BecasRegiones → DocumentosRequeridos
-- =============================================

-- =============================================
-- 1. ROLES
-- =============================================
INSERT IGNORE INTO roles (nombre_rol) VALUES ('ADMIN');
INSERT IGNORE INTO roles (nombre_rol) VALUES ('STUDENT');

-- =============================================
-- 2. REGIONES
-- =============================================
INSERT IGNORE INTO regiones (id_region, nombre, abreviatura) VALUES
(1,  'Arica y Parinacota',           'XV'),
(2,  'Tarapacá',                     'I'),
(3,  'Antofagasta',                  'II'),
(4,  'Atacama',                      'III'),
(5,  'Coquimbo',                     'IV'),
(6,  'Valparaíso',                   'V'),
(7,  'Metropolitana de Santiago',    'RM'),
(8,  'O''Higgins',                   'VI'),
(9,  'Maule',                        'VII'),
(10, 'Ñuble',                        'XVI'),
(11, 'Biobío',                       'VIII'),
(12, 'La Araucanía',                 'IX'),
(13, 'Los Ríos',                     'XIV'),
(14, 'Los Lagos',                    'X'),
(15, 'Aysén',                        'XI'),
(16, 'Magallanes',                   'XII');

-- =============================================
-- 3. COMUNAS (2 por región clave)
-- =============================================
INSERT IGNORE INTO comunas (id_comuna, id_region, nombre) VALUES
-- Valparaíso (id_region=6)
(1, 6, 'Viña del Mar'),
(2, 6, 'Valparaíso'),
-- Metropolitana (id_region=7)
(3, 7, 'Santiago'),
(4, 7, 'Providencia'),
-- Biobío (id_region=11)
(5, 11, 'Concepción'),
(6, 11, 'Talcahuano');

-- =============================================
-- 4. TIPOS DE INSTITUCIÓN
-- =============================================
INSERT IGNORE INTO tipos_institucion (id_tipo_inst, nombre) VALUES
(1, 'Universidad'),
(2, 'Instituto Profesional'),
(3, 'Centro de Formación Técnica'),
(4, 'Fundación'),
(5, 'Organismo Gubernamental'),
(6, 'Empresa Privada'),
(7, 'ONG');

-- =============================================
-- 5. INSTITUCIONES
-- =============================================
INSERT IGNORE INTO instituciones (id_institucion, id_tipo_inst, rut, nombre, sitio_web, contacto_email) VALUES
(1, 1, '71.540.100-2', 'DUOC UC', 'https://www.duoc.cl', 'admision@duoc.cl'),
(2, 1, '71.314.500-7', 'UTFSM', 'https://www.usm.cl', 'admision@usm.cl'),
(3, 1, '81.669.100-8', 'PUCV', 'https://www.pucv.cl', 'contacto@pucv.cl');

-- =============================================
-- 6. TIPOS DE BECA
-- =============================================
INSERT IGNORE INTO tipos_beca (id_tipo_beca, nombre) VALUES
(1, 'Beca de Arancel'),
(2, 'Beca de Mantención'),
(3, 'Beca de Alimentación'),
(4, 'Beca de Movilidad'),
(5, 'Beca de Investigación'),
(6, 'Beca de Excelencia Académica'),
(7, 'Beca Deportiva'),
(8, 'Beca Cultural');

-- =============================================
-- 7. USUARIOS
-- =============================================
-- NOTA: Los password_hash deben generarse con BCryptPasswordEncoder.
-- Reemplazar los hashes si es necesario usando la app o un generador BCrypt online.
--
-- Password admin123 → hash generado con BCrypt 12 rounds
-- Password student123 → hash generado con BCrypt 12 rounds
INSERT IGNORE INTO usuarios (id_usuario, id_rol, email, password_hash, nombre_completo, activo, creado_en) VALUES
(1, (SELECT id_rol FROM roles WHERE nombre_rol = 'ADMIN'),   'admin@becasfind.cl',   '$2a$12$LJ3m4ys3GZfnYMz8kVsX.uLFpB.uN3h5XQvGhFxQG7pHXtVmL3Ob.', 'Admin BecasFind',    TRUE, NOW()),
(2, (SELECT id_rol FROM roles WHERE nombre_rol = 'STUDENT'), 'estudiante@duoc.cl',    '$2a$12$LJ3m4ys3GZfnYMz8kVsX.uLFpB.uN3h5XQvGhFxQG7pHXtVmL3Ob.', 'María González',     TRUE, NOW());

-- =============================================
-- 8. BECAS
-- =============================================
-- Beca 1: ACTIVA (fecha cierre futura → visible en búsqueda)
INSERT IGNORE INTO becas (id_beca, id_institucion, id_tipo_beca, id_usuario_creador, nombre, descripcion_corta, descripcion_larga, monto_cobertura, fecha_inicio_postulacion, fecha_cierre_postulacion, url_oficial, estado_activa) VALUES
(1, 1, 1, 1,
 'Beca Nuevo Milenio',
 'Beca de arancel dirigida a estudiantes de primer año con alto rendimiento académico.',
 'La Beca Nuevo Milenio es un beneficio estatal destinado a estudiantes que ingresan a primer año en instituciones técnico-profesionales acreditadas. Cubre el arancel anual de la carrera hasta por un monto máximo de $600.000. Está enfocada en jóvenes pertenecientes al 60% más vulnerable de la población según el Registro Social de Hogares.',
 '$600.000 anual',
 '2025-10-01',
 '2026-12-31',
 'https://portal.becasylemas.cl/beca-nuevo-milenio',
 TRUE);

-- Beca 2: EXPIRADA (fecha cierre en el pasado → NO visible en búsqueda, prueba BR-VIGENCIA)
INSERT IGNORE INTO becas (id_beca, id_institucion, id_tipo_beca, id_usuario_creador, nombre, descripcion_corta, descripcion_larga, monto_cobertura, fecha_inicio_postulacion, fecha_cierre_postulacion, url_oficial, estado_activa) VALUES
(2, 3, 3, 1,
 'Beca de Alimentación BAES 2024',
 'Tarjeta electrónica de alimentación para estudiantes de educación superior.',
 'La Beca BAES (Beca de Alimentación para la Educación Superior) entrega una tarjeta electrónica con un monto mensual equivalente a 1,5 UTM para que los estudiantes puedan adquirir alimentos. Esta convocatoria ya ha expirado y permite probar que el buscador excluye correctamente las becas vencidas.',
 '$40.000 mensual (expirada)',
 '2024-01-02',
 '2024-03-15',
 'https://www.junaeb.cl/beca-baes',
 TRUE);

-- Beca 3: ACTIVA (excelencia académica, NEM alto, RSH amplio)
INSERT IGNORE INTO becas (id_beca, id_institucion, id_tipo_beca, id_usuario_creador, nombre, descripcion_corta, descripcion_larga, monto_cobertura, fecha_inicio_postulacion, fecha_cierre_postulacion, url_oficial, estado_activa) VALUES
(3, 2, 1, 1,
 'Beca Excelencia Académica UTFSM',
 'Beca de arancel completo para estudiantes con excelencia académica en la UTFSM.',
 'La Beca Excelencia Académica de la Universidad Técnica Federico Santa María cubre el 100% del arancel de referencia para estudiantes con promedio NEM igual o superior a 6.0. Está orientada a alumnos del 80% más vulnerable y exige mantener un rendimiento destacado durante toda la carrera.',
 'Arancel completo ($3.500.000 anual aprox.)',
 '2025-09-01',
 '2026-11-30',
 'https://www.usm.cl/admision/becas',
 TRUE);

-- Beca 4: ACTIVA (nacional, sin requisito NEM/RSH)
INSERT IGNORE INTO becas (id_beca, id_institucion, id_tipo_beca, id_usuario_creador, nombre, descripcion_corta, descripcion_larga, monto_cobertura, fecha_inicio_postulacion, fecha_cierre_postulacion, url_oficial, estado_activa) VALUES
(4, 1, 2, 1,
 'Beca de Mantención DUOC',
 'Apoyo económico mensual para gastos de manutención durante los estudios.',
 'Beca interna de DUOC UC que entrega un apoyo económico de $50.000 mensuales durante 10 meses del año académico para estudiantes que demuestren necesidad socioeconómica. Es de alcance nacional y no exige requisitos académicos mínimos, solo estar matriculado y tener asistencia regular.',
 '$50.000 mensual por 10 meses',
 '2025-08-01',
 '2026-07-31',
 'https://www.duoc.cl/becas-internas',
 TRUE);

-- =============================================
-- 9. REQUISITOS DE PERFIL (1:1 con Beca)
-- =============================================
-- Beca Nuevo Milenio: RSH <= 60%, NEM >= 5.0, primer año
INSERT IGNORE INTO requisitos_perfil (id_requisito, id_beca, rsh_maximo_porcentaje, nem_minimo, paes_minimo, es_para_primer_anio, es_para_curso_superior) VALUES
(1, 1, 60, 5.0, NULL, TRUE, FALSE);

-- Beca BAES 2024: RSH <= 60%, NEM >= 4.0 (expirada)
INSERT IGNORE INTO requisitos_perfil (id_requisito, id_beca, rsh_maximo_porcentaje, nem_minimo, paes_minimo, es_para_primer_anio, es_para_curso_superior) VALUES
(2, 2, 60, 4.0, NULL, FALSE, TRUE);

-- Beca Excelencia UTFSM: RSH <= 80%, NEM >= 6.0, primer año
INSERT IGNORE INTO requisitos_perfil (id_requisito, id_beca, rsh_maximo_porcentaje, nem_minimo, paes_minimo, es_para_primer_anio, es_para_curso_superior) VALUES
(3, 3, 80, 6.0, NULL, TRUE, FALSE);

-- Beca Mantención DUOC: sin requisitos de RSH ni NEM (nacional, abierta)
INSERT IGNORE INTO requisitos_perfil (id_requisito, id_beca, rsh_maximo_porcentaje, nem_minimo, paes_minimo, es_para_primer_anio, es_para_curso_superior) VALUES
(4, 4, NULL, NULL, NULL, FALSE, TRUE);

-- =============================================
-- 10. BECAS_REGIONES (Relación M:N)
-- =============================================
-- Beca Nuevo Milenio: Valparaíso y Metropolitana
INSERT IGNORE INTO becas_regiones (id_beca, id_region) VALUES
(1, 6),
(1, 7);

-- Beca BAES 2024: SIN regiones (Nacional — no se inserta registro)

-- Beca Excelencia UTFSM: Valparaíso
INSERT IGNORE INTO becas_regiones (id_beca, id_region) VALUES
(3, 6);

-- Beca Mantención DUOC: SIN regiones (Nacional — no se inserta registro)

-- =============================================
-- 11. DOCUMENTOS REQUERIDOS
-- =============================================
-- Beca Nuevo Milenio
INSERT IGNORE INTO documentos_requeridos (id_documento, id_beca, nombre_documento, es_obligatorio) VALUES
(1, 1, 'Cédula de identidad vigente', TRUE),
(2, 1, 'Certificado de notas de enseñanza media', TRUE),
(3, 1, 'Registro Social de Hogares actualizado', TRUE),
(4, 1, 'Matrícula del año en curso', TRUE);

-- Beca Excelencia UTFSM
INSERT IGNORE INTO documentos_requeridos (id_documento, id_beca, nombre_documento, es_obligatorio) VALUES
(5, 3, 'Cédula de identidad vigente', TRUE),
(6, 3, 'Certificado de notas de enseñanza media (NEM)', TRUE),
(7, 3, 'Carta de motivación personal', FALSE);

-- Beca Mantención DUOC
INSERT IGNORE INTO documentos_requeridos (id_documento, id_beca, nombre_documento, es_obligatorio) VALUES
(8, 4, 'Cédula de identidad vigente', TRUE),
(9, 4, 'Comprobante de matrícula DUOC UC', TRUE),
(10, 4, 'Cartola de Registro Social de Hogares', TRUE);
