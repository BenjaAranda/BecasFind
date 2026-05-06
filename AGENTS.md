# AGENTS.md — BecasFind · Contrato Arquitectónico Inquebrantable

> **Propósito**: Este documento es la fuente de verdad ejecutable para toda sesión de
> OpenCode/IA que trabaje en este repositorio. Ningún agente puede desviarse de lo
> aquí escrito sin autorización explícita del usuario.

---

## 1. Estructura del Monorepo

```
BecasFind/
├── backend/                 # Spring Boot 3.x · Maven · Java 17+
│   ├── pom.xml
│   ├── src/main/java/com/becasfind/api/
│   │   ├── config/          # Security, CORS, Swagger/OpenAPI
│   │   ├── controllers/     # @RestController · reciben/retornan DTOs
│   │   ├── services/        # Interfaces + Impl · lógica de negocio
│   │   ├── repositories/    # Spring Data JPA
│   │   ├── models/
│   │   │   ├── entities/    # Clases @Entity JPA
│   │   │   └── dtos/        # Request y Response DTOs
│   │   ├── exceptions/      # @RestControllerAdvice global
│   │   └── utils/           # JwtUtil, helpers
│   └── src/main/resources/
│       └── application.yml
├── frontend/                # React 18+ · Vite
│   ├── package.json
│   └── src/
│       ├── assets/
│       ├── components/
│       │   ├── common/      # Botones, modales, loaders reutilizables
│       │   └── layout/      # Navbar, Sidebar, Footer, Layouts
│       ├── features/        # Agrupado por dominio
│       │   ├── auth/        # components/, services/, hooks/
│       │   ├── becas/       # components/, services/, hooks/
│       │   └── admin/       # components/, services/, hooks/
│       ├── context/         # AuthContext
│       ├── routes/          # PublicRoutes, ProtectedRoutes
│       └── config/          # Instancia de Axios
└── infra/                   # Scripts AWS, systemd, Nginx configs
```

---

## 2. Stack Tecnológico Exacto (NO improvisar)

| Capa | Tecnología | Versión |
|------|-----------|---------|
| Backend | Spring Boot (Maven) | 3.x |
| Lenguaje Back | Java | 17+ |
| Frontend | React + Vite | 18+ |
| Librerías Front | React Router DOM v6, Axios, React-Bootstrap, React Hook Form | — |
| Base de Datos | MySQL (AWS RDS) | 8.0 |
| Servidor | AWS EC2 Ubuntu | 22.04 LTS |
| Proxy Web | Nginx | — |

---

## 3. Comandos de Desarrollo

```bash
# Backend — desde raíz del monorepo
cd backend; mvn spring-boot:run

# Frontend — desde raíz del monorepo
cd frontend; npm run dev

# Backend empaquetado para producción
cd backend; mvn clean package -DskipTests

# Frontend compilado para producción
cd frontend; npm run build

# Tests (cuando existan)
cd backend; mvn test
cd frontend; npx vitest run
```

---

## 4. Protocolo de Fases (WORKFLOW OBLIGATORIO)

**CRÍTICO**: El agente NUNCA debe generar más de una fase a la vez. Debe detenerse
tras completar una fase y esperar el comando explícito del usuario para la siguiente.

| Fase | Contenido | Comando esperado |
|------|----------|-----------------|
| 1 | DDL de BD, `application.yml`, `pom.xml` | "Ejecuta FASE 1" |
| 2 | Clases `@Entity` y DTOs Request/Response | "Ejecuta FASE 2" |
| 3 | Interfaces `JpaRepository` + `@ControllerAdvice` | "Ejecuta FASE 3" |
| 4 | Spring Security 6, JWT Utils, Auth Services | "Ejecuta FASE 4" |
| 5 | Servicios Core (`BecaService`) + reglas de negocio | "Ejecuta FASE 5" |
| 6 | Controladores REST completos | "Ejecuta FASE 6" |
| 7 | React Setup, AuthContext, Axios Interceptors | "Ejecuta FASE 7" |
| 8 | React Layouts, Navbar, Vistas de Autenticación | "Ejecuta FASE 8" |
| 9 | React Buscador Principal, Tarjetas, Filtros | "Ejecuta FASE 9" |
| 10 | React Panel Admin (CRUD Becas y Usuarios) | "Ejecuta FASE 10" |

---

## 5. Anti-Patrones Prohibidos

| ❌ PROHIBIDO | ✅ OBLIGATORIO |
|-------------|---------------|
| Generar código parcial o placeholders (`// implement logic here`, `// ... resto`) | Archivos completos y funcionales |
| Usar `@Data` de Lombok en entidades JPA | Getters/setters explícitos o `@Getter @Setter` individuales |
| Retornar entidades JPA desde controladores | Retornar siempre DTOs |
| Ejecutar más de una fase a la vez | Detenerse y esperar comando explícito del usuario |
| Exponer IDs internos de BD en respuestas públicas | Usar DTOs con campos controlados |
| Hardcodear credenciales o secrets | Usar `application.yml` con variables de entorno |
| Usar `FetchType.EAGER` en asociaciones | `FetchType.LAZY` |
| Improvisar librerías no listadas en este documento | Usar solo lo definido en el Stack Tecnológico |

---

## 6. Convenciones de Código Backend

- **DTOs obligatorios**: Toda comunicación Controller↔Cliente debe usar DTOs.
  Mapeo manual o vía MapStruct. NUNCA exponer `@Entity` directamente.
- **ApiResponse<T>**: Todo endpoint debe envolver su respuesta en:
  ```json
  {
    "timestamp": "2026-05-06T...",
    "status": 200,
    "message": "Operación exitosa",
    "data": { ... }
  }
  ```
- **Manejo de errores**: `@RestControllerAdvice` interceptando:
  - `MethodArgumentNotValidException` → 400
  - `EntityNotFoundException` → 404
  - `AccessDeniedException` → 403
  - `Exception` → 500 (genérico)
- **Soft deletes**: Usar `@SQLDelete` y `@Where` donde aplique.
- **JPA**: `FetchType.LAZY` en TODAS las asociaciones.
- **Spring Security**: `SecurityFilterChain` configurado sin XML, stateless,
  CSRF deshabilitado, CORS via `CorsConfigurationSource`.

---

## 7. Convenciones de Código Frontend

- **Feature-based structure**: Agrupar por dominio, no por tipo de archivo.
- **React Hook Form**: Validación de formularios.
- **React-Bootstrap**: Componentes UI (NO otros frameworks CSS).
- **Axios interceptors**: Inyectar JWT automáticamente en cada request.
- **AuthContext**: Manejar estado de autenticación global.
- **Rutas protegidas**: Componente `<ProtectedRoute>` que verifica rol.

---

## 8. Esquema de Base de Datos (Entidades)

| Entidad | Tabla | Notas |
|---------|-------|-------|
| Region | `regiones` | id_region (PK), nombre, abreviatura |
| Comuna | `comunas` | id_comuna (PK), id_region (FK) |
| Rol | `roles` | id_rol (PK), nombre_rol |
| Usuario | `usuarios` | email único, BCrypt hash, soft delete |
| TipoInstitucion | `tipos_institucion` | id_tipo_inst (PK), nombre |
| Institucion | `instituciones` | id_tipo_inst (FK), rut, contacto |
| TipoBeca | `tipos_beca` | id_tipo_beca (PK), nombre |
| Beca | `becas` | Entidad central, múltiples FKs |
| BecaRegion | `becas_regiones` | Relación M:N |
| RequisitoPerfil | `requisitos_perfil` | 1:1 con Beca |
| DocumentoRequerido | `documentos_requeridos` | N:1 con Beca |
| PasswordResetToken | `password_reset_tokens` | UUID token, 15 min exp |

---

## 9. Reglas de Negocio del Motor de Búsqueda (CRÍTICO)

El método `BecaService.buscarBecas(...)` recibe parámetros opcionales y construye
una query dinámica con las siguientes reglas matemáticas exactas:

### BR-VIGENCIA (Filtro de Estado)
```
b.estado_activa = true AND b.fecha_cierre_postulacion >= CURRENT_DATE
```
Solo se muestran becas activas cuya fecha de cierre no haya expirado.

### BR-RSH (Registro Social de Hogares — LÍMITE SUPERIOR)
```
Si parámetro rsh = X → mostrar becas donde rp.rsh_maximo_porcentaje >= X
```
**Ejemplo**: Estudiante con RSH 60% ve becas que acepten 60%, 80% o 100%.
**NO ve** becas con RSH máximo 40%.

### BR-NEM (Notas de Enseñanza Media — LÍMITE INFERIOR)
```
Si parámetro nem = Y → mostrar becas donde rp.nem_minimo <= Y
```
**Ejemplo**: Estudiante con NEM 5.5 ve becas con mínimo 5.5, 5.0, 4.0.
**NO ve** becas con NEM mínimo 6.0.

### BR-REGION (Coincidencia exacta o Nacional)
```
Si parámetro regionId = Z → mostrar becas que tengan Z en BecaRegion
                              OR que NO tengan ninguna región asociada (becas nacionales)
```

### Paginación
Retornar `Page<BecaDTO>` estandarizado de Spring Data.

---

## 10. Git Workflow

### Convención de Ramas
- `main` → Producción
- `develop` → Integración
- `feature/<nombre>` → Nuevas funcionalidades
- `bugfix/<nombre>` → Corrección de bugs

### Conventional Commits (OBLIGATORIO)
```
feat: add JWT authentication filter
fix: resolve CORS issue on login endpoint
docs: update API Swagger annotations
refactor: extract search query builder
test: add unit tests for BecaService
chore: update Maven dependencies
```

**Formato**: `<type>: <descripción en inglés, imperativo, minúscula>`

---

## 11. Manejo de Errores y Logging

- **Backend**: Usar SLF4J. Nunca loguear passwords o tokens.
- **Validación**: `@Valid` en controladores + `@NotBlank`, `@Email`, `@NotNull` en DTOs.
- **BCrypt**: Todas las contraseñas hasheadas con `BCryptPasswordEncoder`.
- **JWT**: Expiración 24h, firmado con clave secreta en `application.yml`.

---

## 12. Verificación de Calidad

Antes de dar por completada CUALQUIER fase, el agente debe:
1. Verificar que todos los archivos generados compilen.
2. Ejecutar `mvn compile` (backend) sin errores.
3. Confirmar que no hay imports no utilizados.
4. Asegurar que no se usaron tecnologías no listadas en el Stack.

---

**Fin del Contrato Arquitectónico. Toda sesión de IA debe comenzar leyendo este archivo.**
