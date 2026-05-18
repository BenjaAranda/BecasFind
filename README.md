# BecasFind

**BecasFind** es una plataforma web orientada a la búsqueda, centralización y gestión de becas estudiantiles. El proyecto permite que estudiantes consulten beneficios disponibles, filtren oportunidades según criterios académicos o socioeconómicos, guarden becas favoritas y reciban recomendaciones basadas en su perfil. Además, incorpora funcionalidades administrativas para gestionar becas, usuarios, catálogos e importación masiva de información.

> Proyecto de título enfocado en un buscador nacional de becas estudiantiles.

---

## Tabla de contenidos

- [Descripción general](#descripción-general)
- [Características principales](#características-principales)
- [Tecnologías utilizadas](#tecnologías-utilizadas)
- [Estructura del repositorio](#estructura-del-repositorio)
- [Requisitos previos](#requisitos-previos)
- [Configuración de base de datos](#configuración-de-base-de-datos)
- [Ejecución del backend](#ejecución-del-backend)
- [Ejecución del frontend](#ejecución-del-frontend)
- [Endpoints principales](#endpoints-principales)
- [Documentación disponible](#documentación-disponible)
- [Consideraciones de seguridad](#consideraciones-de-seguridad)
- [Flujo recomendado de trabajo](#flujo-recomendado-de-trabajo)
- [Autores](#autores)

---

## Descripción general

BecasFind busca resolver la dispersión de información sobre becas estudiantiles mediante una aplicación centralizada donde los usuarios pueden:

- Buscar becas disponibles.
- Revisar el detalle de cada beneficio.
- Filtrar por criterios como región, tipo de beca, institución, RSH, NEM u otros parámetros.
- Crear y actualizar su perfil estudiantil.
- Guardar becas como favoritas.
- Recibir recomendaciones personalizadas.
- Administrar información desde un panel interno.

El sistema está dividido en dos aplicaciones principales:

- **Backend:** API REST desarrollada con Spring Boot.
- **Frontend:** aplicación web desarrollada con React, TypeScript y Vite.

---

## Características principales

### Funcionalidades para estudiantes

- Registro e inicio de sesión.
- Autenticación mediante JWT.
- Recuperación y restablecimiento de contraseña.
- Búsqueda de becas.
- Visualización de detalle de becas.
- Filtros por criterios académicos, socioeconómicos y territoriales.
- Gestión de perfil estudiantil.
- Recomendación de becas según perfil.
- Guardado y eliminación de becas favoritas.

### Funcionalidades administrativas

- Gestión de usuarios.
- Gestión de becas.
- Creación, actualización y eliminación lógica de registros.
- Importación de becas mediante archivo CSV.
- Consulta de catálogos base, como regiones, comunas, instituciones, tipos de beca y tipos de institución.

---

## Tecnologías utilizadas

### Backend

- Java 17
- Spring Boot 3.4.5
- Spring Web
- Spring Data JPA
- Spring Security
- Spring Validation
- JWT con `io.jsonwebtoken`
- Maven
- MySQL
- Lombok
- Springdoc OpenAPI / Swagger UI
- OpenCSV
- H2 para pruebas

### Frontend

- React
- TypeScript
- Vite
- Tailwind CSS
- Axios
- React Router DOM
- jwt-decode
- Lucide React
- ESLint

### Base de datos e infraestructura

- MySQL 8.0
- Script DDL en `infra/ddl.sql`
- Datos iniciales en `backend/src/main/resources/data.sql`

---

## Estructura del repositorio

```text
BecasFind/
├── backend/
│   ├── pom.xml
│   └── src/
│       └── main/
│           ├── java/com/becasfind/api/
│           │   ├── config/
│           │   ├── controllers/
│           │   ├── exceptions/
│           │   ├── models/
│           │   ├── repositories/
│           │   ├── services/
│           │   ├── utils/
│           │   └── BecasFindApplication.java
│           └── resources/
│               ├── application.yml
│               └── data.sql
│
├── frontend/
│   ├── package.json
│   ├── vite.config.ts
│   └── src/
│       ├── assets/
│       ├── components/
│       ├── context/
│       ├── pages/
│       ├── services/
│       ├── types/
│       ├── App.tsx
│       └── main.tsx
│
├── infra/
│   └── ddl.sql
│
└── documentacion/
    ├── BecasFind Requerimientos y casos de uso.docx
    └── MER.png
```

---

## Requisitos previos

Antes de ejecutar el proyecto, asegúrate de tener instalado:

- Java 17 o superior.
- Maven 3.8 o superior.
- Node.js 20 o superior.
- npm.
- MySQL 8.0 o superior.
- Git.

---

## Configuración de base de datos

El proyecto utiliza MySQL como motor de base de datos.

### 1. Crear la base de datos

Puedes usar el script ubicado en:

```text
infra/ddl.sql
```

Este script crea la base de datos `becasfind` y las tablas necesarias para usuarios, roles, becas, regiones, comunas, instituciones, tipos de beca, perfiles, favoritos, requisitos y documentos requeridos.

Desde MySQL puedes ejecutarlo con:

```bash
mysql -u root -p < infra/ddl.sql
```

O bien, abrir el archivo desde una herramienta como MySQL Workbench, DBeaver o DataGrip y ejecutarlo manualmente.

### 2. Revisar credenciales locales

El archivo de configuración del backend se encuentra en:

```text
backend/src/main/resources/application.yml
```

Ajusta los datos de conexión según tu entorno local:

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/becasfind?serverTimezone=America/Santiago&allowPublicKeyRetrieval=true&useSSL=false
    username: TU_USUARIO
    password: TU_PASSWORD
```

> Recomendación: para entornos reales o despliegues, no dejar credenciales ni secretos directamente en `application.yml`. Utiliza variables de entorno.

---

## Ejecución del backend

Ubícate en la carpeta del backend:

```bash
cd backend
```

Instala dependencias y compila el proyecto:

```bash
mvn clean install
```

Ejecuta la API:

```bash
mvn spring-boot:run
```

Por defecto, el backend se levanta en:

```text
http://localhost:8080
```

La documentación Swagger/OpenAPI queda disponible en:

```text
http://localhost:8080/swagger-ui/index.html
```

---

## Ejecución del frontend

Ubícate en la carpeta del frontend:

```bash
cd frontend
```

Instala dependencias:

```bash
npm install
```

Ejecuta el entorno de desarrollo:

```bash
npm run dev
```

Por defecto, el frontend se levanta en:

```text
http://localhost:5173
```

El archivo `vite.config.ts` contiene un proxy para redirigir las llamadas `/api` hacia el backend local:

```text
http://localhost:8080
```

---

## Endpoints principales

### Autenticación

| Método | Endpoint | Descripción |
|---|---|---|
| `POST` | `/api/auth/login` | Inicio de sesión |
| `POST` | `/api/auth/register` | Registro de usuario |
| `POST` | `/api/auth/forgot-password` | Solicitud de recuperación de contraseña |
| `POST` | `/api/auth/reset-password` | Restablecimiento de contraseña |

### Becas

| Método | Endpoint | Descripción |
|---|---|---|
| `GET` | `/api/becas` | Lista becas paginadas |
| `GET` | `/api/becas/{id}` | Obtiene el detalle de una beca |
| `POST` | `/api/becas/buscar` | Busca becas con filtros |
| `GET` | `/api/becas/recomendadas` | Obtiene becas recomendadas para el usuario autenticado |
| `POST` | `/api/becas` | Crea una beca, solo administrador |
| `PUT` | `/api/becas/{id}` | Actualiza una beca, solo administrador |
| `DELETE` | `/api/becas/{id}` | Elimina una beca, solo administrador |
| `POST` | `/api/becas/importar-csv` | Importa becas desde CSV, solo administrador |

### Perfil

| Método | Endpoint | Descripción |
|---|---|---|
| `GET` | `/api/perfil` | Obtiene el perfil del estudiante autenticado |
| `PUT` | `/api/perfil` | Crea o actualiza el perfil del estudiante autenticado |

### Favoritos

| Método | Endpoint | Descripción |
|---|---|---|
| `GET` | `/api/favoritos` | Lista becas favoritas del usuario |
| `POST` | `/api/favoritos/{idBeca}` | Guarda una beca en favoritos |
| `DELETE` | `/api/favoritos/{idBeca}` | Elimina una beca de favoritos |
| `GET` | `/api/favoritos/{idBeca}/check` | Verifica si una beca está en favoritos |

### Usuarios

| Método | Endpoint | Descripción |
|---|---|---|
| `GET` | `/api/usuarios/me` | Obtiene los datos del usuario autenticado |
| `GET` | `/api/usuarios` | Lista usuarios, solo administrador |
| `GET` | `/api/usuarios/{id}` | Obtiene un usuario por ID, solo administrador |
| `POST` | `/api/usuarios` | Crea un usuario, solo administrador |
| `PUT` | `/api/usuarios/{id}` | Actualiza un usuario, solo administrador |
| `DELETE` | `/api/usuarios/{id}` | Desactiva un usuario, solo administrador |

### Catálogos

| Método | Endpoint | Descripción |
|---|---|---|
| `GET` | `/api/regiones` | Lista regiones |
| `GET` | `/api/comunas/region/{regionId}` | Lista comunas por región |
| `GET` | `/api/tipos-beca` | Lista tipos de beca |
| `GET` | `/api/tipos-institucion` | Lista tipos de institución |
| `GET` | `/api/instituciones` | Lista instituciones |

---

## Documentación disponible

El repositorio incluye una carpeta `documentacion/` con material de apoyo del proyecto:

```text
documentacion/
├── BecasFind Requerimientos y casos de uso.docx
└── MER.png
```

Estos documentos pueden utilizarse para revisar requerimientos, casos de uso y modelo entidad-relación del sistema.

---

## Consideraciones de seguridad

Antes de utilizar este proyecto en producción, se recomienda:

- Mover credenciales de base de datos a variables de entorno.
- Mover la clave JWT a una variable de entorno segura.
- Desactivar `show-sql` en producción.
- Cambiar `spring.jpa.hibernate.ddl-auto=update` por una estrategia controlada de migraciones.
- Revisar permisos de endpoints administrativos.
- Validar correctamente archivos CSV antes de importarlos.
- Configurar CORS según el dominio real del frontend.
- Usar HTTPS en despliegues públicos.

Ejemplo recomendado para variables de entorno:

```bash
DB_URL=jdbc:mysql://localhost:3306/becasfind
DB_USERNAME=root
DB_PASSWORD=tu_password
JWT_SECRET=tu_clave_segura
JWT_EXPIRATION_MS=86400000
```

---

## Flujo recomendado de trabajo

1. Clonar el repositorio.
2. Crear la base de datos con `infra/ddl.sql`.
3. Configurar credenciales en `backend/src/main/resources/application.yml`.
4. Levantar el backend en `http://localhost:8080`.
5. Levantar el frontend en `http://localhost:5173`.
6. Probar la API desde Swagger o Postman.
7. Validar el flujo completo desde la interfaz web.

---

## Comandos útiles

### Backend

```bash
cd backend
mvn clean install
mvn spring-boot:run
```

### Frontend

```bash
cd frontend
npm install
npm run dev
npm run build
npm run preview
```

---

## Autores

Proyecto desarrollado como parte de un proyecto de título orientado a la búsqueda y centralización de becas estudiantiles.

Repositorio: `BenjaAranda/BecasFind`
