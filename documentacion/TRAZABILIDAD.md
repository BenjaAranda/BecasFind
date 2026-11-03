# Trazabilidad de requisitos — 30 de septiembre de 2026

Fuentes revisadas completas: `BecasFind - ET.docx`, `3.1.2 Plan Pruebas Funcionales - Completo.docx` y `3.1.3 Planilla Casos de Prueba.xlsx`. Los originales permanecen intactos. ET delimita un catálogo informativo: no adjudica ni recibe postulaciones.

## Diferencias resueltas por el contrato vigente

- PostgreSQL 17; Vercel/Oracle, sustituyen menciones contradictorias a MySQL/Render/AWS/serverless Java.
- CP06/45/53: creación devuelve 201, no 200. Validación nativa de formulario puede impedir una petición; pruebas HTTP cubren 400 del servidor.
- CP14: UUID malformado devuelve 400; UUID válido inexistente, 401.
- CP28/29: UUID público; ruta numérica pública devuelve 400, UUID inexistente 404.
- CP30: auto-match usa RSH/NEM/región; no institución ni un filtro gubernamental. Esas reglas adicionales serían una función nueva.
- CP46: cierre desconocido permitido; fuera de búsqueda vigente. No inventar fechas.
- CP48: eliminación de beca física con relaciones en cascada; no hay soft delete de becas. Las cuentas se desactivan sin borrarse.
- CP50: archivo CSV completo atómico; errores impiden guardar filas, no importación parcial.
- CP60: contenido visual actualizado; no exigir el número antiguo de tarjetas.
- CP11–16: tests de tokens y proveedor simulado no acreditan entrega a bandeja real (P09).

## Matriz CP → RF → prueba

La planilla contiene 67 CP y el plan agrupa 19 RF. Los enlaces indican dónde se verifica el comportamiento; tener un ID en un título no demuestra calidad por sí solo. Se reforzaron aserciones permisivas de detalle, escritura y catálogo; tipos de institución se corrigió como catálogo público.

| CP | Requisito | Caso original | Pruebas versionadas |
|---|---|---|---|
| CP-01 | RF-001 | Login exitoso con credenciales válidas | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java), [login-flow.spec.ts](../frontend/e2e/tests/login-flow.spec.ts) |
| CP-02 | RF-001 | Login fallido con contraseña incorrecta | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java) |
| CP-03 | RF-001 | Login fallido con email no registrado | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java) |
| CP-04 | RF-001 | Login fallido con campos vacíos | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java), [login-flow.spec.ts](../frontend/e2e/tests/login-flow.spec.ts) |
| CP-05 | RF-001 | Login fallido con email inválido | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java), [login-flow.spec.ts](../frontend/e2e/tests/login-flow.spec.ts) |
| CP-06 | RF-002 | Registro exitoso con datos válidos | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java) |
| CP-07 | RF-002 | Registro fallido con email duplicado | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java) |
| CP-08 | RF-002 | Registro fallido con contraseña corta | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java) |
| CP-09 | RF-002 | Registro fallido con email inválido | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java) |
| CP-10 | RF-002 | Registro fallido con campos vacíos | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java) |
| CP-11 | RF-003 | Solicitar recuperación con email registrado | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java) |
| CP-12 | RF-003 | Solicitar recuperación con email no registrado | Revisión necesaria: sin etiqueta CP literal |
| CP-13 | RF-004 | Restablecer con token válido | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java) |
| CP-14 | RF-004 | Restablecer con token inválido | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java) |
| CP-15 | RF-004 | Restablecer con token expirado | Revisión necesaria: sin etiqueta CP literal |
| CP-16 | RF-004 | Restablecer con contraseña corta | [AuthTest.java](../backend/src/test/java/com/becasfind/api/tests/AuthTest.java) |
| CP-17 | RF-005 | Listado general de becas sin filtros | [BecaSearchTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaSearchTest.java) |
| CP-18 | RF-006 | Búsqueda por texto libre | [BecaSearchTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaSearchTest.java), [search-ux.spec.ts](../frontend/e2e/tests/search-ux.spec.ts) |
| CP-19 | RF-006 | Filtro por RSH (límite superior) | [BecaSearchTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaSearchTest.java) |
| CP-20 | RF-006 | Filtro por NEM (límite inferior) | [BecaSearchTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaSearchTest.java) |
| CP-21 | RF-006 | Filtro por Región | [BecaSearchTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaSearchTest.java) |
| CP-22 | RF-006 | Filtro por Tipo de Beca | [BecaSearchTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaSearchTest.java) |
| CP-23 | RF-006 | Filtro por Institución | [BecaSearchTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaSearchTest.java) |
| CP-24 | RF-006 | Filtro por Tipo de Institución | [BecaSearchTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaSearchTest.java) |
| CP-25 | RF-006 | Múltiples filtros combinados | [BecaSearchTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaSearchTest.java) |
| CP-26 | RF-017 | Ordenamiento dinámico | [BecaSearchTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaSearchTest.java) |
| CP-27 | RF-018 | Paginación de resultados | [BecaSearchTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaSearchTest.java) |
| CP-28 | RF-007 | Ver detalle con ID válido | [BecaDetailAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaDetailAdminTest.java) |
| CP-29 | RF-007 | Ver detalle con ID inexistente | [BecaDetailAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaDetailAdminTest.java) |
| CP-30 | RF-008 | Recomendaciones con perfil configurado | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-31 | RF-008 | Recomendaciones sin perfil | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-32 | RF-009 | Agregar beca a favoritos | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-33 | RF-009 | Eliminar beca de favoritos | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-34 | RF-009 | Verificar estado de favorito | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-35 | RF-009 | Listar favoritos del usuario | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-36 | RF-010 | Crear perfil de estudiante | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-37 | RF-010 | Actualizar perfil existente | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-38 | RF-010 | Ver perfil existente (precarga) | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-39 | RF-010 | Ver perfil sin configurar | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-40 | RF-011 | Ver regiones | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-41 | RF-011 | Ver comunas por región | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-42 | RF-011 | Ver tipos de beca | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-43 | RF-011 | Ver tipos de institución | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-44 | RF-011 | Ver instituciones | [StudentFeaturesTest.java](../backend/src/test/java/com/becasfind/api/tests/StudentFeaturesTest.java) |
| CP-45 | RF-012 | Crear beca exitosamente | [BecaDetailAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaDetailAdminTest.java) |
| CP-46 | RF-012 | Crear beca con campos vacíos | [BecaDetailAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaDetailAdminTest.java) |
| CP-47 | RF-012 | Editar beca existente | [BecaDetailAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaDetailAdminTest.java) |
| CP-48 | RF-012 | Eliminar beca (soft delete) | [BecaDetailAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaDetailAdminTest.java) |
| CP-49 | RF-014 | Importar CSV válido | [ImportAndUserAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/ImportAndUserAdminTest.java) |
| CP-50 | RF-014 | Importar CSV con errores | [ImportAndUserAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/ImportAndUserAdminTest.java) |
| CP-51 | RF-014 | Importar CSV sin columnas correctas | [ImportAndUserAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/ImportAndUserAdminTest.java) |
| CP-52 | RF-013 | Listar todos los usuarios | [ImportAndUserAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/ImportAndUserAdminTest.java) |
| CP-53 | RF-013 | Crear nuevo usuario | [ImportAndUserAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/ImportAndUserAdminTest.java) |
| CP-54 | RF-013 | Crear usuario con email duplicado | [ImportAndUserAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/ImportAndUserAdminTest.java) |
| CP-55 | RF-013 | Editar usuario existente | [ImportAndUserAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/ImportAndUserAdminTest.java) |
| CP-56 | RF-013 | Desactivar usuario (soft delete) | [ImportAndUserAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/ImportAndUserAdminTest.java) |
| CP-57 | RF-015 | Estudiante no accede a panel admin | [SecurityAccessTest.java](../backend/src/test/java/com/becasfind/api/tests/SecurityAccessTest.java) |
| CP-58 | RF-015 | No autenticado no accede a protegidas | [SecurityAccessTest.java](../backend/src/test/java/com/becasfind/api/tests/SecurityAccessTest.java) |
| CP-59 | RF-015 | Rutas públicas sin autenticación | [SecurityAccessTest.java](../backend/src/test/java/com/becasfind/api/tests/SecurityAccessTest.java) |
| CP-60 | RF-016 | Landing Page | [landing.spec.ts](../frontend/e2e/tests/landing.spec.ts) |
| CP-61 | RF-007 | Documentos requeridos renderizados | [BecaDetailAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaDetailAdminTest.java), [beca-detail.spec.ts](../frontend/e2e/tests/beca-detail.spec.ts) |
| CP-62 | RF-007 | Indicador de beca vencida | [BecaDetailAdminTest.java](../backend/src/test/java/com/becasfind/api/tests/BecaDetailAdminTest.java), [beca-detail.spec.ts](../frontend/e2e/tests/beca-detail.spec.ts) |
| CP-63 | RF-019 | Debounce en búsqueda (400ms) | [search-ux.spec.ts](../frontend/e2e/tests/search-ux.spec.ts) |
| CP-64 | RF-015 | Cerrar sesión limpia estado | [SecurityAccessTest.java](../backend/src/test/java/com/becasfind/api/tests/SecurityAccessTest.java) |
| CP-65 | RF-015 | Token JWT expirado | [SecurityAccessTest.java](../backend/src/test/java/com/becasfind/api/tests/SecurityAccessTest.java) |
| CP-66 | RF-006 | Persistencia de filtros en URL | [search-ux.spec.ts](../frontend/e2e/tests/search-ux.spec.ts) |
| CP-67 | RF-001 | Login redirige si ya autenticado | [login-flow.spec.ts](../frontend/e2e/tests/login-flow.spec.ts) |

## Límites de cierre

La evidencia global y los comandos están en PLAN_MEJORAS.md. Bandeja real, nube y rendimiento/accesibilidad se registran en sus tareas únicas P09/P12–P14/P08/P07. Los desconocidos del corpus no se presentan como requisitos confirmados.
