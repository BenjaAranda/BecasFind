# Plan de corrección, diseño y publicación de BecasFind

Creado: 29 de septiembre de 2026. Estado actualizado: 30 de septiembre de 2026, después de configurar respuestas de autenticación y permisos en FASE 4. Correcciones y verificaciones detalladas abajo; el proyecto aún no está listo para publicación. Sin despliegues.

Objetivo: publicar una aplicación segura, comprensible y verificable, manteniendo Vercel para el frontend y Oracle Always Free como opción para el backend y la base de datos.

## To do vigente

Esta lista es el estado actual. Las propuestas y secciones de avance posteriores conservan el historial; sus frases «Siguiente fase» corresponden al momento de cada avance. Una casilla completada cierra ese alcance concreto, no todas las tareas de una fase o paquete.

### Hecho y verificado

- [x] Conservar PostgreSQL 17 y actualizar el contrato para Vercel + Oracle.
- [x] Separar desarrollo/producción, exigir secretos externos y validar el esquema en producción sin datos de demostración.
- [x] Alinear esquema, migrar la base local con respaldo y probar restauración preservando datos.
- [x] Endurecer autorización JWT con actividad/rol actual, limitar intentos y restringir CORS.
- [x] Invalidar JWT anteriores al recuperar la contraseña, verificando una marca HMAC de las credenciales actuales sin exponer la contraseña ni su hash.
- [x] Unificar errores del manejador global en ApiResponse, incluyendo data:null y conservando campos de validación, códigos HTTP y cabecera Allow. Configurar también respuestas de autenticación/permisos de Spring Security: 401 para sesión ausente/inválida y 403 para falta de permisos.
- [x] Corregir recuperación de contraseña: token de un solo uso, caducidad y consumo concurrente; integrar API Resend y pantallas públicas. La activación y entrega real quedan pendientes.
- [x] Corregir reglas de vigencia, RSH/NEM, cobertura nacional/regional, recomendaciones y fechas de calendario.
- [x] Separar listado administrativo para incluir becas vencidas/inactivas y estandarizar errores de parámetros.
- [x] Corregir estado URL, debounce, paginación recomendada, respuestas antiguas y reintentos del buscador.
- [x] Corregir formularios/listados administrativos: vaciado de asociaciones, validación de interfaz, conservación de datos y errores recuperables.
- [x] Hacer atómica la importación CSV, validar archivos/valores/encoding, corregir upsert y comprobar rollback/UTF-8 en PostgreSQL temporal.
- [x] Restaurar sesión antes del render, manejar vencimiento y sincronizar cierre entre pestañas; eliminar caché de identidad redundante.
- [x] Cerrar revisión estática global sin desactivar reglas: cero errores y cero advertencias.
- [x] Renovar acceso, registro y navegación pública/administrativa con controles accesibles y adaptación móvil.
- [x] Renovar buscador, filtros plegables, tarjetas y detalle; mostrar errores/reintento y corregir navegación directa y documentos opcionales.
- [x] Renovar portada y retirar cifras/promesas sin respaldo; explicar acceso con cuenta, límites de recomendaciones y consulta de fuente oficial. Comprobar acciones por sesión, teclado y adaptación 360–1440 px.
- [x] Renovar interfaz de perfil/favoritos: carga fiable con reintento, bloqueo durante guardado, conservación de valores/cambios, vaciado explícito de asociaciones, errores de favoritos diferenciados y estados inactivos. Interfaz verificada con API controlada y persistencia HTTP con PostgreSQL; recorrido Chromium-backend-PostgreSQL real aprobado en entorno aislado.
- [x] Validar solicitudes de perfil, becas, documentos y usuarios administrativos en el servidor: límites numéricos/texto/identificadores, fechas coherentes, URL HTTP/HTTPS y contraseña UTF-8. Verificar rechazo 400 sin modificar datos y conservación de vaciados/límites válidos.
- [x] Bloquear escrituras simultáneas de favoritos en interfaz y serializarlas por usuario en backend; rechazar becas inexistentes y proteger la creación inicial concurrente del perfil. Pruebas concurrentes H2 y PostgreSQL 17 aprobadas.
- [x] Registrar comprobaciones y subir avances con Conventional Commits al PR #10 en borrador, sin modificar main.

### Pendiente, en orden de trabajo

1. [x] **FASE 11 — portada.** Diseño/textos y enlaces renovados y verificados; correo real sigue pendiente como tarea independiente.
2. [x] **Perfil y favoritos — persistencia e integración verificadas.** Interfaz y validación DTO completadas; persistencia de perfil validada por HTTP con H2 de pruebas. Persistencia HTTP, recomendaciones, aislamiento de favoritos y bloqueos concurrentes verificados con PostgreSQL 17 temporal y DDL real. Recorrido Chromium conectado a backend prod/PostgreSQL temporal aprobado: login, guardar/recargar/vaciar perfil, recomendaciones y guardar/recargar/eliminar favoritos, sin API simulada. No cubre todos los casos de abuso ni segundo navegador. Institución, carrera y año se guardan como referencia y no participan en recomendaciones actuales; no ampliar criterios sin acordarlo.
3. [ ] **FASES 1/2/5, por separado — modelo y montos.** Acordar unidades/cobertura monetaria, ampliar precisión NEM si procede y sustituir ordenamiento textual por reglas numéricas verificadas.
4. [ ] **FASE 10 — administración, alcance de diseño completado.** Formularios, confirmaciones e importación usan diálogos nativos con foco y Escape; diseño/adaptación móvil verificados con API controlada. CRUD de becas, creación/desactivación de usuarios y rechazo de permisos estudiante verificados con navegador/backend/PostgreSQL reales. El listado ahora incluye usuarios inactivos y mantiene sus accesos bloqueados. Edición de nombre/correo de usuarios activos añadida y verificada. Quedan pendientes pruebas globales de accesibilidad, unificación de errores y concurrencia administrativa/importaciones.
5. [ ] **Contrato y seguridad restante.** Invalidación tras recuperación, contrato de errores del manejador global y respuestas de autenticación/permisos corregidos y verificados. Resolver identificadores públicos frente a IDs internos y cerrar hallazgos restantes por módulo. El rechazo CORS permanece independiente; no afirmar que toda respuesta HTTP use el mismo formato.
6. [ ] **FASE 14 — datos e importación masiva.** Importación desde navegador real comprobada: creación, upsert sin duplicados, rechazo con cero escrituras y bytes UTF-8. Auditar CSV históricos, tildes, fuentes profundas, requisitos/documentos y fechas. Acordar tratamiento de datos desconocidos antes de cambiar la regla contractual de cierre por defecto. Medir batch INSERT real y concurrencia de importaciones/catálogos.
7. [ ] **Correo real.** Configurar clave privada de Resend y remitente autorizado; comprobar entrega, enlace, caducidad y acceso con la contraseña nueva en una bandeja real.
8. [ ] **Verificación integral.** Corregir suites antiguas débiles de login/buscador; contrastar documentos de requisitos/pruebas y recorrer roles, CRUD, CSV, perfil, favoritos y recuperación con backend/PostgreSQL reales.
9. [ ] **Accesibilidad y rendimiento global.** Revisar teclado, zoom, 360/390/768/1440 px y un segundo navegador; medir carga y búsqueda bajo condiciones documentadas. Los objetivos del plan aún no son resultados.
10. [ ] **Infraestructura Vercel + Oracle.** Confirmar cuenta/capacidad/gratuidad vigente, probar contenedor/persistencia/reinicio, configurar HTTPS/Nginx, BD privada, secretos, CORS y entorno de pruebas aislado; integrar controles de calidad antes de publicar.
11. [ ] **Operación y publicación.** Probar copias/restauración y rollback en el entorno de destino, documentar mantenimiento, verificar vista previa y completar flujos públicos antes de publicar.

### Evidencia y límites actuales

- Última suite completa backend: **146 pruebas H2 aprobadas**, empaquetado correcto en directorio temporal aislado. Última verificación PostgreSQL 17: **18 pruebas de seguridad aprobadas** con DDL real y validación de esquema. Las ocho pruebas de contrato HTTP, 11 de perfil/integridad/consulta administrativa y doce casos CSV PostgreSQL corresponden a verificaciones anteriores.
- Última fase de navegador: **20 casos de administración/navegación aprobados con API controlada** en ejecución en serie. Un fallo inicial de búsqueda en paralelo no se reprodujo aislado ni en la suite final; causa no confirmada. Antes se aprobaron 39 casos de perfil/favoritos/sesión/buscador, 32 de portada/sesión/navegación/recuperación y 54 de búsqueda. Estas cifras corresponden a suites de distintas etapas y no deben sumarse como casos únicos ni interpretarse como integración completa.
- Último cierre: **6 recorridos Chromium con backend prod/PostgreSQL reales aprobados**, package, `mvn compile`, lint y build aprobados. Se comprueba 401 real, eliminación del token y regreso al login. No hubo cambios de interfaz de producción.
- Avance en [PR #10](https://github.com/BenjaAranda/BecasFind/pull/10), todavía en borrador. No hay despliegue público ni garantía de disponibilidad continua de la opción gratuita.

## Punto de partida y límites

- La revisión anterior obtuvo compilación del backend, 60 pruebas del backend aprobadas y compilación del frontend. El análisis de estilo del frontend registró 10 errores y 3 advertencias. Son resultados de esa revisión, no pruebas repetidas durante esta planificación.
- Las pruebas de navegador existentes necesitan afirmaciones más exigentes: algunas verifican solamente la URL o condiciones que siempre se cumplen. No constituyen todavía una validación completa de los flujos.
- La revisión inicial detectó PostgreSQL frente al contrato MySQL. El usuario autorizó conservar PostgreSQL y actualizar el contrato; Vercel + Oracle sustituye la propuesta de Render.
- Se corregirán todos los hallazgos conocidos y se ampliará la revisión mediante pruebas reales. No se puede garantizar que no existan defectos aún no detectados.
- Cada cambio se realizará en una sola fase arquitectónica a la vez, con su comando explícito y sus comprobaciones, conforme a AGENTS.md. Los paquetes siguientes agrupan el trabajo para planificarlo; no autorizan ejecutar varias fases juntas.
- Los documentos Office de requisitos y pruebas se contrastarán antes de cerrar la cobertura. Su conversión por Graphify falló; el mapa no reemplaza su lectura ni las pruebas sobre la base de datos real.
- El mapa de dependencias quedó en `graphify-out/graph.html` y `graphify-out/GRAPH_REPORT.md`: 866 nodos y 2.853 relaciones. Su diagnóstico detecta 323 relaciones con extremos no declarados y 161 coincidencias de pares al convertir a grafo no dirigido. Cuatro SQL no se extrajeron por faltar el analizador; el mapa es auxiliar, no evidencia de integridad. Extracción AST: 0 tokens de modelo; consumo del agente semántico no disponible.

## Decisiones que deben resolverse antes de implementar

1. **Base de datos:** decisión resuelta por el usuario: conservar PostgreSQL y actualizar el contrato. Se utiliza PostgreSQL 17 y se retira el conector MySQL; no mantener ambos motores como una compatibilidad aparente sin pruebas.
2. **Contrato:** documentar Vercel + Oracle y resolver las diferencias de estructura, versiones, borrado y respuestas públicas. El contrato prohíbe IDs internos, pero búsqueda, detalle y favoritos los utilizan: definir un identificador público coherente antes de cambiar enlaces o DTOs.
3. **Datos de becas:** proponer cambiar la regla de inferir requisitos y fechas desconocidos. Una fecha artificial no debe presentarse como un plazo oficial, ni una recomendación como garantía de elegibilidad. Este cambio requiere autorización porque modifica AGENTS.md.
4. **Recuperación de contraseña:** integración de API autorizada e implementada con Resend. Pendientes cuenta/clave privada, remitente y prueba de entrega real; no declarar activo el correo antes de comprobarlo.

## Orden de ejecución

| Paquete | Prioridad | Trabajo | Fases del contrato, ejecutadas por separado | Criterio de cierre |
|---|---|---|---|---|
| A. Base y contrato | Bloqueante | Motor de BD, esquema, configuración y acuerdos | 1 → 2 → 3 | BD real reproducible y esquema compatible con JPA |
| B. Seguridad y cuentas | Bloqueante | Inicio de sesión, roles, cuentas desactivadas, recuperación | 4 → 6 → 7 → 11 | Casos de abuso y recuperación verificados |
| C. Búsqueda y recomendaciones | Alta | Vigencia, fechas, montos, filtros y perfil | 5 → 6 → 12 → 13 | Resultados y navegación correctos en casos límite |
| D. Administración e importación | Alta | CRUD, vaciado de relaciones, CSV y calidad de datos | 10 → 14 | Importación repetible sin corrupción ni falsos éxitos |
| E. Diseño y accesibilidad | Alta | Sistema visual y todas las pantallas | 7 → 8 → 9 → 10 → 11 → 12 → 13 | Revisión visual y funcional en móvil y escritorio |
| F. Verificación integral | Bloqueante para publicar | Pruebas de navegador, BD real y rendimiento | Por módulo y fase corregidos | Sin defectos bloqueantes y evidencia registrada |
| G. Preparación y publicación | Final | Vercel, Oracle, HTTPS, copias y recuperación | Infraestructura: acordar extensión del protocolo | Vista previa validada y restauración comprobada |

Los paquetes pueden volver a una fase para corregir su módulo, siempre uno por vez. No se rehacerán las 14 fases desde cero.

## A. Base de datos, configuración y contrato

- Comparar DDL, entidades y datos iniciales: roles USER/STUDENT, token UUID/cadena, fechas con o sin zona horaria, restricciones únicas y claves foráneas.
- Confirmar ON DELETE CASCADE en relaciones M:N y la política de borrado de usuarios y becas. Evitar pérdida de datos por una operación presentada como desactivación.
- Preparar instalación y actualización del esquema con los scripts existentes. Evitar depender de ddl-auto=update y sql.init=always para producción.
- Separar configuración local, pruebas y producción. Eliminar contraseñas por defecto; exigir secretos externos y evitar SQL detallado o DEBUG en producción.
- Conservar UTF-8 de extremo a extremo. Aplicar verificaciones de bytes adecuadas al motor elegido.
- Revisar versiones instaladas y dependencias con el contrato; corregir divergencias concretas sin actualizar indiscriminadamente todo el stack.
- Validar inicialización y reinicio sobre una BD real aislada, preservando usuarios y datos. H2 seguirá sirviendo para comprobaciones rápidas, pero no sustituirá esta validación.

## B. Seguridad y autenticación

- Limitar DatabaseSeeder al entorno de demostración. Un reinicio en producción no debe restablecer contraseñas ni crear cuentas de prueba.
- Comprobar que el usuario del JWT sigue activo y conserva el rol autorizado; no confiar exclusivamente en las declaraciones de un token emitido antes de una desactivación o cambio de rol.
- Revisar cada endpoint público, autenticado y administrativo, incluidos CSV, usuarios, perfiles y favoritos. Estandarizar respuestas 400/401/403/404/500 sin filtrar detalles internos.
- Retirar tokens de recuperación de los registros. Responder de forma equivalente para correos existentes e inexistentes.
- Corregir consumo y caducidad del token de recuperación: un solo uso, expiración de 15 minutos y persistencia correcta cuando se rechaza uno vencido.
- Añadir límites y validación en entradas de registro, perfil, filtros, paginación, URL y archivos; revisar los errores de validación visibles al usuario.
- Limitar intentos abusivos de autenticación y recuperación usando controles del servidor/proxy antes de introducir dependencias.
- Validar el cierre de sesión y la expiración en AuthContext y Axios. Revisar la exposición del JWT en localStorage, las superficies de inyección y los encabezados de seguridad; cualquier cambio a cookies debe diseñarse junto con CORS/CSRF.
- Configurar orígenes exactos para producción y pruebas. No habilitar indiscriminadamente todos los subdominios de Vercel para operaciones autenticadas.

Pruebas: token inválido/vencido, cuenta desactivada, rol modificado, acceso de estudiante a administración, recuperación desconocida/vencida/reutilizada y reinicio sin cambio de contraseña.

## C. Búsqueda, fechas y recomendaciones

- Restablecer la regla de vigencia: activa y cierre igual o posterior al día actual. Definir el día de negocio en Chile y probar los límites de medianoche.
- Centralizar el formato y comparación de fechas sin hora en el frontend: evitar que YYYY-MM-DD se muestre como el día anterior.
- Mantener las comparaciones correctas de RSH y NEM; documentar qué significan requisitos nulos o desconocidos.
- Ordenar montos numéricamente. Conservar el texto de cobertura y definir cómo se ordenan porcentajes, beneficios no monetarios y montos desconocidos; no extraer números arbitrarios de una descripción.
- Eliminar decisiones de recomendación basadas en IDs fijos de instituciones/tipos. Ajustar el motor al contrato y explicar los criterios realmente evaluados.
- Corregir el estado compartido de filtros, URL y texto. Buscar inmediatamente después de escribir debe usar el valor visible; limpiar filtros debe enviar los valores vacíos nuevos.
- Unificar el disparo de búsqueda: propuesta de texto automático con debounce de 400 ms y envío inmediato mediante Enter/botón, sin duplicar solicitudes. Cancelar o descartar respuestas antiguas.
- Mantener la pestaña recomendada al cambiar página o cantidad de resultados. Conservar filtros y posición al volver del detalle y al navegar con Atrás/Adelante.
- Diferenciar error de conexión, carga y ausencia de coincidencias; ofrecer reintento en lugar de convertir todos los fallos en una lista vacía.

Pruebas: RSH 60, NEM 5,5, región nacional/específica, cierre ayer/hoy/mañana, orden monetario, búsqueda rápida, limpieza, URL, paginación recomendada y respuestas fuera de orden.

## D. Administración, CSV y datos

- Separar el listado administrativo del buscador público: el administrador debe poder consultar becas vencidas e inactivas.
- Permitir vaciar regiones y documentos al editar: distinguir listas vacías de campos no enviados. Verificar entidades y relaciones después de guardar.
- Mostrar total real del servidor y errores de edición, borrado e importación. Evitar solicitudes iniciales duplicadas y operaciones repetidas por doble clic.
- Definir y probar borrado/desactivación coherente con el contrato y la interfaz.
- Hacer explícita la política de importación parcial o atómica. No capturar fallos dentro de una transacción que termina inválida y luego declarar éxito.
- Contabilizar filas mal formadas y advertencias; entregar número de fila, motivo y resultado verificable. Mover archivos a procesados solo cuando el resultado cumpla la política.
- Corregir upsert de tipo de beca, regiones y campos vaciados. Importar dos veces el mismo archivo debe producir un resultado estable sin duplicados.
- Rechazar regiones desconocidas; no convertirlas silenciosamente en cobertura nacional.
- Hacer efectivos los lotes de 50 tras revisar generación de IDs y flush por fila. Medir antes de introducir una nueva arquitectura de importación.
- Reparar archivos con mojibake y BOM sobre copias; comprobar nombres, instituciones y descripciones antes y después de importar. No modificar masivamente la BD sin respaldo.
- Validar fuentes oficiales profundas, requisitos, fechas, cobertura y marcadores de documentos obligatorios/opcionales. Registrar incertidumbre y retirar afirmaciones no verificadas conforme al acuerdo de datos.
- Resolver las instrucciones contradictorias de carga de CSV en AGENTS.md con un único método probado en Windows para texto español.

Pruebas: comillas/comas, á/é/í/ó/ú/ñ/Ñ, archivo inválido, duplicado, región desconocida, error de una fila, tipo actualizado, vaciado de relaciones y reporte exacto.

## E. Dirección de diseño propuesta

**Concepto:** guía editorial de oportunidades educativas chilenas. Interfaz clara, cercana y confiable, con la búsqueda como acción principal.

- Paleta: azul profundo para identidad, verde petróleo para acciones, fondo cálido claro y ámbar para plazos. Rojo reservado para errores/documentos obligatorios, acompañado siempre de texto o icono.
- Tipografía: jerarquía marcada entre títulos, beneficio y metadatos; evaluar una pareja de fuentes de uso libre y alojadas localmente. No introducir una biblioteca de interfaz.
- Definir colores, espaciado, tamaños, radios y estados compartidos en CSS/Tailwind; reutilizar solo componentes que tengan repetición real.
- Animaciones breves con CSS y respeto a movimiento reducido. Priorizar lectura y respuesta rápida en móviles.

| Pantalla | Cambio propuesto |
|---|---|
| Inicio | Búsqueda protagonista, explicación breve de funcionamiento y acceso sin registro. Sustituir promesas de elegibilidad garantizada y cifras sin respaldo. |
| Navegación | Identidad y rutas coherentes entre inicio, exploración, detalle, perfil y favoritos; menú móvil accesible y estado activo visible. |
| Exploración | Resultados y total claros; filtros activos removibles; panel plegable en móvil; orden y paginación fáciles de encontrar. |
| Tarjetas | Destacar beneficio, institución y cierre; acción de detalle mediante enlace accesible; favorito como botón independiente con estado anunciado. |
| Detalle | Resumen escaneable, requisitos y documentos separados, plazos consistentes y botón claro hacia la fuente oficial. Mensaje útil para un enlace inválido. |
| Registro e ingreso | Formularios breves, etiquetas persistentes, errores junto al campo, autocompletado y mensajes de sesión claros. |
| Perfil | Secciones comprensibles; explicar RSH/NEM y el uso de los datos; indicar guardado y criterios de recomendación sin prometer adjudicación. |
| Favoritos | Estado vacío con acción para explorar; error y reintento diferenciados; guardado consistente al navegar. |
| Administración | Tablas legibles, filtros de estado, formularios ordenados, confirmación con nombre de la beca y reporte de importación por filas. |

Accesibilidad: navegación completa con teclado, foco visible, etiquetas y nombres de botones, diálogos con gestión de foco, contraste WCAG AA, avisos de resultados y errores, áreas táctiles cómodas y zoom al 200 % sin perder funciones.

Primera entrega visual: prototipo local de inicio, exploración y detalle con los datos existentes, seguido por cuentas/perfil y administración. La evaluación visual se hará en navegador; esta propuesta todavía no equivale a una revisión de capturas de la interfaz actual.

## F. Calidad y simplificación

- Cada arreglo de lógica tendrá una prueba que falle con el comportamiento anterior y compruebe el resultado requerido.
- Reparar los 10 errores y 3 advertencias de lint sin desactivar reglas globalmente. Revisar dependencias de efectos, imports y tipos.
- Reescribir pruebas de navegador que pasan sin comprobar resultados; usar datos controlados y esperar eventos/resultados, evitando pausas fijas como mecanismo principal.
- Probar anónimo, estudiante y administrador: explorar → detalle → fuente; registro → login → perfil → recomendación → favorito; CRUD → CSV → consulta de datos; recuperación → ingreso con clave nueva.
- Revisar 360, 390, 768 y 1440 px, teclado y zoom. Registrar capturas comparables y probar flujos críticos en Chromium y otro navegador disponible.
- Ejecutar compilación y pruebas Maven, compilación frontend y lint; integrar estos controles en el flujo de cambios antes de publicar.
- Probar con la BD elegida real, con las 60 pruebas actuales como regresión y nuevas pruebas para los hallazgos. No convertir el número de pruebas en el criterio único de calidad.
- Medir peso de recursos, tiempos de búsqueda y carga en una máquina equivalente a Oracle. Objetivos iniciales a validar: LCP ≤ 2,5 s, CLS ≤ 0,1 y búsqueda p95 ≤ 1 s bajo una carga documentada. Son objetivos, no resultados ya obtenidos.
- Aplicar Ponytail: retirar SortSelector y recursos de plantilla solo tras confirmar que no se usan; unificar fechas y navegación duplicadas; aprovechar controles nativos y dependencias instaladas. Mantener interfaces de servicios exigidas por el contrato.
- Evaluar carga diferida del panel administrativo y paralelismo de solicitudes independientes cuando las mediciones lo justifiquen. No incorporar caché, microservicios, migración a Next.js ni motor FULLTEXT por anticipación.

Registro por hallazgo: identificador, archivo, reproducción, impacto, fase, prueba de regresión y evidencia de cierre. Estado inicial: pendiente; no marcar una corrección como completada por estar descrita en este documento.

## G. Preparación del despliegue Vercel + Oracle

1. Confirmar cuenta, región inicial y capacidad Always Free disponible. Distinguir recursos permanentes del crédito temporal; verificar presupuesto y límites antes de crear servicios.
2. Preparar y probar contenedor ARM64 del backend y persistencia de la BD elegida. Configurar reinicio automático y comprobación de salud sin exponer información sensible.
3. Base de datos privada, acceso de mantenimiento restringido, HTTPS para la API y secretos fuera del repositorio. Prever un subdominio gratuito si el presupuesto excluye un dominio propio.
4. Vercel: raíz frontend, compilación Vite, salida dist, URL pública de API y rutas SPA. Las variables VITE son públicas: no colocar contraseñas ni claves en ellas.
5. Entorno de prueba aislado con datos no personales. Las vistas previas no deben modificar por accidente la BD pública.
6. Probar copias y restauración, conservación de datos al reiniciar y retorno a la versión anterior. Volver el frontend no revierte automáticamente cambios del esquema.
7. Publicar primero una vista previa, ejecutar flujos completos y revisar HTTPS/CORS, rutas directas, errores, logs y rendimiento. Preparar la publicación pública como paso final separado.
8. Documentar operación, actualización, recuperación y costos. Oracle puede recuperar instancias inactivas; esta arquitectura gratuita no garantiza disponibilidad continua.

Referencias consultadas: [Vite en Vercel](https://vercel.com/docs/frameworks/frontend/vite), [rutas de Vercel](https://vercel.com/docs/project-configuration/vercel-json), [variables por framework](https://vercel.com/docs/environment-variables/framework-environment-variables). Condiciones de gratuidad y capacidad se volverán a comprobar al preparar la infraestructura.

## Condiciones para publicar

- Cero hallazgos bloqueantes abiertos: contraseñas de demostración en producción, autorización incorrecta, recuperación insegura, pérdida/corrupción de datos y configuración incompatible.
- Compilación, pruebas y lint aprobados; flujos críticos y base de datos real verificados.
- Diseño revisado en móvil y escritorio, sin bloqueo por teclado ni contraste insuficiente en controles principales.
- Fuentes y plazos de las becas verificados según la política acordada.
- Copia restaurada con éxito, secretos configurados y procedimiento de recuperación documentado.
- Vista previa verificable antes de promover a la página pública.

## Avance de implementación — FASE 1

- Contrato actualizado con autorización: PostgreSQL 17, frontend Vercel y backend Oracle como opción de despliegue.
- Configuración común conservadora y perfiles dev/prod; contraseñas sin valores por defecto, esquema validado, SQL automático desactivado fuera de dev y logs de producción reducidos.
- DDL alineado con entidades: token VARCHAR(36), timestamps sin zona horaria, roles ADMIN/STUDENT y unicidad de nombre/institución en becas.
- Conector MySQL retirado. Compilación y empaquetado aprobados; 60 pruebas existentes aprobadas, sin fallos ni errores.
- `infra/verify-schema.ps1`: PostgreSQL 17 temporal, esquema instalado y repetido, datos iniciales cargados y arranque real con validación Hibernate. Resultado: 16 regiones, 2 roles correctos, cero usuarios. Procesos temporales detenidos al terminar.
- Cierre posterior solicitado por el usuario: inventario de base local, respaldo completo restaurado, migración 001 ensayada dos veces y aplicada. Se completaron las cascadas de becas_regiones y la unicidad de tokens. Comparación de filas de las 14 tablas antes/después: idénticas. Las entidades no se modificaron.
- Respaldo previo restaurado y conservado en `%LOCALAPPDATA%/BecasFind/backups/phase1-2026-09-29/before-migration.dump`; copia duradera verificada por hash. Procedimiento repetible: `infra/migrate-local.ps1`.
- Arranque real con perfil prod únicamente sobre la copia migrada: Hibernate valida el esquema; número y contenido íntegro de usuarios, incluidas contraseñas, conservados. Se detuvieron los procesos temporales.

## Avance de implementación — FASE 4

- DatabaseSeeder restringido a dev, excluyendo prod/test; conserva cuentas existentes y desactivadas sin cambiar contraseña, estado o rol.
- JWT consulta el usuario activo y los permisos actuales de la BD en cada petición; una cuenta desactivada o un administrador degradado no conserva sus privilegios anteriores.
- Recomendaciones exigen autenticación antes de entrar al controlador. CORS centralizado en Spring Security, con orígenes exactos externos y puertos locales solo en dev; eliminada la configuración MVC duplicada.
- Recuperación responde igual para correos existentes/inexistentes y no registra tokens. El token vencido se elimina aunque la solicitud sea rechazada; cuenta desactivada no puede restablecer contraseña. Reutilización secuencial rechazada.
- Compilación, empaquetado y 72 pruebas backend aprobados: 60 anteriores y 12 de regresión de seguridad, sin fallos ni errores. Arranque prod probado sobre PostgreSQL 17 real y respaldo restaurado.
- Pendientes de las siguientes fases al cerrar este primer avance: envío por correo, consumo concurrente de token, límites de intentos, respuestas de error uniformes y validaciones restantes. Los dos avances siguientes resuelven concurrencia y límites; el paquete B completo y la recuperación pública todavía no están terminados.

## Avance de implementación — FASE 3, consumo concurrente de recuperación

- La consulta de token usa bloqueo pesimista de escritura dentro de la transacción de restablecimiento. La segunda solicitud espera a que termine la primera y recibe token inválido cuando ya fue consumido.
- Prueba con dos solicitudes simultáneas y contraseñas diferentes: exactamente una tiene éxito; la otra se rechaza con BadCredentialsException; la contraseña final corresponde únicamente a la ganadora y el token desaparece.
- Caso comprobado también en una base PostgreSQL 17 temporal; los datos locales no se modificaron. Arranque prod y validación de esquema nuevamente aprobados.
- Verificación reproducible: `infra/verify-schema.ps1 -ConcurrencyTestMaven <ruta a mvn.cmd>`. La prueba PostgreSQL utiliza una base separada y conserva sus registros fuera de los resultados de la suite general.
- El envío por correo y los límites de intentos siguen pendientes. Este cierre garantiza el consumo simultáneo del mismo token; no equivale a cerrar toda la recuperación pública.

## Avance de implementación — FASE 4, límites de intentos

- Límites activos por defecto para POST de login y restablecimiento (10 por 15 minutos), registro y solicitud de recuperación (5 por 15 minutos). Presupuesto separado por operación y dirección de conexión.
- Respuesta 429 con ApiResponse en español y Retry-After. Contador sincronizado para respetar el máximo ante solicitudes simultáneas; no acepta direcciones falsificadas en X-Forwarded-For.
- Memoria acotada a 4096 combinaciones. Reinicios reinician los contadores; antes de publicar se debe comprobar la identificación de clientes detrás del proxy confiable. Más de una instancia necesita límite compartido. Detalles en infra/README.md.
- Suite completa: 78 pruebas backend aprobadas, cero fallos/errores; cinco casos nuevos cubren HTTP real, expiración, independencia de presupuestos, encabezados falsos, exclusión de búsqueda, desactivación explícita y concurrencia.
- Decisión del usuario: integrar una API de correo y configurar la cuenta y el remitente después. La integración de envío y la pantalla de recuperación siguen pendientes; no se necesita incorporar una librería ajena al contrato para consumir una API HTTP.

## Avance de implementación — FASE 11, recuperación pública

- Integración Resend mediante HTTP nativo de Java 17, sin dependencias nuevas. Clave y remitente privados por variables externas; URL del frontend validada y envío deshabilitado por defecto hasta configurar la cuenta.
- Correo UTF-8 con enlace de un solo uso, expiración de 15 minutos y clave de idempotencia. Fallos de entrega revierten la generación y conservan el token anterior; respuesta pública uniforme, sin secretos en logs.
- Pantallas separadas de solicitud y nueva contraseña, diseño accesible adaptable a móvil, etiquetas asociadas y estados de envío, éxito, enlace inválido/vencido, límite y error de conexión. Eliminado el flujo que pedía tokens desde consola.
- El token viaja en fragmento y se retira del historial tras leerlo. Los errores 401 en operaciones públicas de autenticación ya no fuerzan una redirección que ocultaba el mensaje de recuperación.
- Contraseñas de registro/restablecimiento validadas antes de BCrypt, incluido límite real de 72 bytes UTF-8. Mensajes de estos DTOs corregidos en español y tamaños de correo/token acotados.
- Backend: 89 pruebas aprobadas, cero fallos/errores; compilación y empaquetado aprobados. Incluye petición de enlace, reemplazo, fallo/rollback, correo inexistente, envío deshabilitado, UTF-8, proveedor HTTP local, acceso con nueva contraseña y rechazo de reutilización.
- Frontend: compilación y revisión estática de los archivos modificados aprobadas; siete recorridos de recuperación aprobados en Chromium con respuestas API controladas. Revisión visual en 1280 px y 390 px, sin desbordamiento ni errores JavaScript. No equivalen a recepción real de correo ni cierran toda la calidad del frontend.
- La revisión estática global conserva 10 errores y 3 advertencias existentes fuera de los archivos de recuperación; siguen pendientes en el paquete de calidad. No publicar con esa verificación pendiente.
- Configuración de rutas SPA preparada en frontend/vercel.json; ejemplos de variables sin secretos. GitHub: rama bugfix/security-and-recovery y commits separados por configuración, seguridad y documentación; esta fase se publica en la misma rama tras comprobarla.
- Pendiente externo de esta fase: cuenta, remitente autorizado, clave privada y prueba de recepción real. No se han enviado correos reales ni publicado la web. Landing y registro completo no se declaran rediseñados por este avance.

## Avance de implementación — FASE 5, reglas del buscador

- Restablecida BR-VIGENCIA: activa y cierre inclusivo según el día de Chile (America/Santiago), con prueba que distingue el cambio de día UTC. No se alteraron datos locales ni fechas de becas para hacerlas visibles.
- Comparaciones RSH/NEM inclusivas conforme al contrato. Con un filtro presente, los requisitos nulos no se convierten en compatibilidad confirmada; sin ese filtro, no restringen resultados. Verificada combinación de límites y requisitos desconocidos.
- Recomendaciones reutilizan buscarBecas con RSH, NEM y región del perfil. Eliminados identificadores de tipo de institución 5/8 como regla de elegibilidad.
- Texto literal parametrizado con escape de comodines; coincidencia en nombre y descripción corta, mayúsculas/minúsculas y espacios de entrada. Regiones nacionales/exactas comprobadas y nombres de varias regiones ordenados consistentemente en el DTO.
- Validación del servicio: RSH 0–100, NEM finito 1–7, identificadores positivos, texto <=200, página <=100 y orden reconocido. Orden de fechas con desempate por id interno para evitar páginas inestables.
- Pruebas nuevas sobre entidades persistidas y HTTP real: cierre ayer/hoy/mañana, inactivas, límites, nulos, varias regiones, texto literal, recomendaciones entre instituciones, paginación estable, fecha chilena e inputs inválidos. Las pruebas se ejecutan sobre la base temporal de test y revierten sus fixtures.
- Suite completa de backend: 99 pruebas aprobadas, cero fallos/errores; compilación y empaquetado aprobados. Diez casos nuevos respecto al cierre anterior. Los archivos modificados mantienen UTF-8 sin BOM.
- Esta fase modifica servicios y reglas, sin rediseñar la interfaz ni añadir nuevos endpoints. El paquete C completo sigue abierto.
- Pendientes: monto numérico/unidad (el orden heredado por texto sigue siendo incorrecto), fechas y filtros de interfaz, listado administrativo independiente para conservar acceso a becas vencidas/inactivas. No publicar antes de cerrar estos puntos.

## Avance de implementación — FASE 6, listado administrativo

- Endpoint GET /api/becas/administracion protegido por rol ADMIN, con paginación y texto opcional. Incluye becas activas, inactivas y vencidas sin modificar el criterio del buscador público.
- Servicio administrativo reutiliza validación, texto literal y orden estable existentes; respuesta DTO/ApiResponse y límite de 100 registros.
- estadoActiva incluido consistentemente en el resumen de becas y favoritos. El panel consulta el endpoint administrativo y distingue Inactiva, Vigente y Vencida con día inclusivo de Chile. Es una adaptación del consumidor existente, sin rediseñar el CRUD.
- Parámetros con tipos incorrectos y cuerpos JSON mal formados de BecaController se traducen a ApiResponse 400 con mensaje genérico.
- Tres pruebas nuevas de API: permisos ADMIN/estudiante/visitante, consulta de beca vencida e inactiva excluida del listado público, paginación sin repetidos e inputs inválidos. Verificación de navegador: el panel usa el endpoint correcto, muestra estado inactivo y envía el texto buscado; respuestas API controladas.
- Cierre de suite backend: 102 pruebas aprobadas, cero fallos/errores; compilación y empaquetado aprobados. Frontend compila; ocho pruebas Chromium aprobadas (una administrativa y siete de recuperación). Siguen vigentes los errores previos de revisión estática fuera del ajuste de conexión.
- El listado administrativo queda separado y conectado. Pendientes del paquete C: montos numéricos/unidades, fechas visuales y filtros de la interfaz. No se han cambiado datos locales ni realizado un despliegue.

## Avance de implementación — FASE 13, interfaz del buscador

- URL como fuente de filtros, pestaña, página y tamaño; vuelta desde detalle conserva el contexto. Reinicio limpia URL, controles y petición sin reutilizar valores previos.
- Debounce real de 400 ms para filtros y texto; botón/Enter ejecutan los valores actuales sin esperar, cancelando la búsqueda pendiente. AbortController y comprobación de solicitud activa impiden que una respuesta vieja sustituya resultados recientes.
- Recomendaciones mantiene endpoint/pestaña al paginar y cambiar tamaño; cada cambio de filtro/tamaño vuelve a página cero. Selector de tamaño disponible también con una sola página.
- Fechas de calendario sin conversión errónea a medianoche UTC; cierre inclusivo por día de Chile. Función compartida en tarjetas, detalle y listado administrativo.
- Etiquetas de formularios asociadas, NEM explicado como promedio del estudiante, tarjeta accesible por teclado y favoritos con nombre/estado. Cabecera adaptable a móvil; recomendaciones no se presentan como garantía de elegibilidad.
- Errores de carga muestran aviso y Reintentar, sin conservar totales viejos; fallo de catálogos se informa. Revisión estática del buscador, filtros, tarjetas, detalle, servicio, utilidad de fechas y pruebas nuevas aprobada.
- Compilación frontend y backend aprobadas. Diez casos nuevos Chromium aprobados con respuestas API controladas; ocho recorridos anteriores de recuperación/administración también comprobados durante esta fase. Revisadas capturas en escritorio 1280 px y móvil 390 px, sin desbordamiento ni errores JavaScript. No equivale todavía a la prueba global con servicios reales.
- La revisión estática global bajó de diez errores/tres advertencias a siete errores/dos advertencias; siguen pendientes fuera del buscador corregido. La última suite backend completa permanece en 102 casos aprobados; esta fase no cambia backend.
- Persisten orden monetario por texto y definición de unidad, formularios CRUD, importación, calidad de datos, rediseño general y despliegue. No declarar cerrado el proyecto ni el paquete C completo.

Siguiente fase propuesta: FASE 10, corregir formularios y comportamiento del panel administrativo; después FASE 14 para importación. Mantener montos como cambio de modelo pendiente y activación de correo pendiente de cuenta/remitente. Ejecutar una fase a la vez tras instrucción explícita.

## Avance de implementación — FASE 10, formularios administrativos

- Edición de becas envía listas vacías explícitas al quitar todas las regiones/documentos; `null` conservaba los valores anteriores. Se preservan requisitos con valor cero y decimales al cargar la edición. Los documentos enviados incluyen únicamente nombre y obligatoriedad.
- Carga de catálogos con error visible y reintento sin borrar campos; guardado bloqueado hasta disponer de opciones. Estado inicial derivado de los datos al abrir el formulario, sin efecto que reescriba la edición.
- Validación de fechas, nombre/documentos no vacíos, URL HTTP/HTTPS, RSH 0–100, NEM 1–7 y PAES 0–1000 en la interfaz. Contraseña administrativa de 8–72 caracteres y máximo 72 bytes UTF-8. Estas comprobaciones de interfaz no sustituyen la validación de DTO/servicios pendiente de endurecer para CRUD.
- Formularios conservan datos ante error, bloquean controles/cierre durante envío y permiten reintentar. Etiquetas asociadas, nombres en acciones y layout de becas adaptable a móvil.
- Listado administrativo con un solo efecto de consulta, debounce de 400 ms, cancelación y descarte de respuestas antiguas. Total usa totalElements del servidor; eliminación ajusta la página si desaparece la última. Carga/edición/eliminación/desactivación muestran fallos y permiten reintentar.
- Compilaciones frontend/backend aprobadas y revisión estática de archivos administrativos y pruebas nuevas sin errores. Diez pruebas Chromium aprobadas (nueve nuevas y una existente), con respuestas API controladas, incluida creación/edición, vaciado, validaciones, recuperación de catálogos, fallos de escritura, usuarios y búsquedas concurrentes. Captura móvil de 390 px revisada sin desbordamiento del formulario. No se modificaron datos locales ni se probaron escrituras reales en producción.
- Revisión estática global: tres errores y cero advertencias, restantes en AuthContext y una prueba antigua de detalle. La última suite completa de backend permanece en 102 pruebas; esta fase solo modifica frontend.
- No cambia la política de borrado del backend ni cierra toda la accesibilidad de modales. Siguen pendientes importación/calidad de datos, montos/unidades, diseño general, calidad global, correo real y despliegue.

Siguiente fase propuesta: FASE 14, corregir importación CSV y sus fallos de validación/transacción. Mantener una fase por instrucción del usuario.

## Avance de implementación — FASE 14, integridad de importación CSV

- Importación atómica por archivo: se valida antes de escribir y una transacción propia confirma todos los cambios o revierte becas, requisitos, documentos y catálogos. Los contadores se devuelven solo tras commit; cualquier rechazo informa cero creadas/actualizadas. El endpoint conserva ApiResponse y HTTP 200 para el informe de validación; archivos demasiado grandes reciben 413.
- Encabezados del formato estándar obligatorios, sin duplicados ni columnas desconocidas; documentos_requeridos es opcional. Errores capturados por OpenCSV ya no se ignoran. Se rechazan duplicados beca/institución dentro del archivo, columnas mal formadas, valores inválidos, fechas inexistentes/invertidas, regiones desconocidas y campos mayores que el esquema permite.
- RSH 0–100 y NEM 1–7, sin convertir texto inválido en null. El esquema NEM actual solo admite un decimal: se rechaza mayor precisión para evitar redondeo silencioso; ampliarlo sigue siendo un cambio de modelo pendiente.
- Decodificación estricta UTF-8 con fallback Windows-1252 exigido por el contrato, eliminación de BOM de entrada y rechazo de patrones de mojibake/bytes nulos. URLs oficiales obligatorias, HTTP/HTTPS y con subpágina; es validación de estructura, no verificación de existencia ni de fuente oficial.
- Upsert actualiza tipo de beca, crea requisitos faltantes y permite vaciar regiones explícitamente. Columna de documentos presente reemplaza la lista (vacía la limpia); columna ausente conserva documentos anteriores. La actualización respeta una beca desactivada y la clasificación existente de una institución. Becas nuevas registran al administrador autenticado como creador, sin depender de un email fijo.
- Límite de 5000 filas y 10 MB por archivo; request y lectura de rechazo del servidor limitados a 11 MB. Hibernate conserva batch_size 50 y se eliminan flush forzados por cada fila, con flush cada 50 y final. Los IDs IDENTITY y las consultas intermedias impiden garantizar batch INSERT real: no se declara cerrada la optimización masiva.
- Se conserva la fecha de cierre por defecto 2026-12-31 establecida en AGENTS.md cuando está vacía. No se inventan requisitos ni se modifican CSV históricos/datos locales. Revisar fechas, fuentes, acentos y documentos del corpus sigue pendiente antes de publicar.
- Verificación final: 114 pruebas backend aprobadas, compilación y empaquetado aprobados. Doce pruebas nuevas de integridad ejecutadas también contra PostgreSQL 17 temporal: fallos de lectura/validación, rollback de catálogos y errores reales de BD, reintento, upsert, documentos, UTF-8/BOM/Windows-1252, grupo de 51 filas, creador autenticado y respuesta 413. Verificación HEX después de cada importación PostgreSQL y comparación exacta de tildes/ñ. Instancias temporales detenidas; sin importaciones en la base local. Ocho archivos modificados verificados UTF-8 sin BOM. La revisión global frontend sigue en tres errores existentes.

Siguiente fase propuesta: FASE 7, corregir los problemas restantes de AuthContext y cerrar la revisión estática global. Después abordar diseño en su fase correspondiente, manteniendo pendientes separados para el modelo monetario, validación de datos y despliegue.

## Avance de implementación — FASE 7, restauración de sesión y calidad estática

- Estado inicial de sesión leído y validado antes del primer render, sin actualizaciones síncronas dentro de un efecto. Provider y hook separados para permitir Fast Refresh; todos los consumidores actualizados. No se desactivaron reglas de ESLint ni se añadieron librerías.
- Un único estado para token/identidad/vencimiento evita estados parciales. Validación de forma de identidad/rol/expiración; tokens inválidos o vencidos se descartan, sin abrir administración. Identidad derivada del JWT del servidor al iniciar sesión/registrarse/restaurar; eliminado caché user redundante. La decodificación en frontend solo controla la interfaz: la firma, actividad y permisos siguen verificándose en backend.
- Vencimiento con temporizador y cancelación al cambiar sesión/desmontar; cierre de sesión sincronizado entre pestañas con el evento storage. Se conservan contratos de AuthContext, Axios y rutas protegidas.
- Dos pruebas antiguas de detalle ya no contienen aserciones que pasan siempre: comprueban nombres/documentos obligatorios/opcionales, estado Vencida y fecha real. Importación dinámica inefectiva de adminService en perfil reemplazada por el import compartido existente; eliminada esa advertencia de compilación.
- Revisión estática global: cero errores y cero advertencias. Build frontend y mvn compile aprobados. Catorce pruebas de sesión/detalle aprobadas (doce nuevas de sesión y dos corregidas); además se aprobaron 27 regresiones de buscador, administración y recuperación en esta fase. Respuestas API controladas; no equivalen a pruebas de correo/producción. La última suite backend completa permanece en 114 pruebas, sin cambios backend en esta fase.
- Pendientes: pruebas antiguas de login/buscador con dependencia de backend real y aserciones débiles; validación integrada completa con servicios reales, diseño/accesibilidad general, perfil/modelo monetario, calidad del corpus/importación masiva, correo real y despliegue. Cero errores estáticos no significa que todo el proyecto esté terminado.

Siguiente fase propuesta: FASE 8, mejorar navegación y vistas de autenticación con diseño coherente y accesibilidad. Mantener una fase por instrucción del usuario.

## Avance de implementación — FASE 8, navegación y acceso

- Acceso y registro comparten un layout editorial en crema, verde petróleo y dorado, coherente con recuperación. Formularios con etiquetas asociadas, autocompletado, foco visible, errores anunciados y controles bloqueados durante envío. Mostrar/ocultar cada contraseña conserva su valor; registro valida coincidencia y límite UTF-8 antes de enviar.
- Navegación pública compartida por inicio y buscador. Menús móviles público/administrativo con estado accesible, cierre al navegar y Escape con retorno de foco. Administración incluye enlace para saltar al contenido y retorno correcto a /explorar; tablas pueden desplazarse dentro del contenido.
- Sin nuevas dependencias. La portada, tarjetas/filtros y formularios internos administrativos mantienen su diseño actual: su renovación corresponde a otras fases.
- Verificación: 47 pruebas Chromium aprobadas con API controlada (seis nuevas y 41 regresiones de sesión, detalle, administración, recuperación y búsqueda). Capturas de acceso/registro a 390 y 1280 px y administración móvil revisadas; sin desbordamiento en los recorridos comprobados. Revisión estática global, build frontend y mvn compile aprobados. Backend sin cambios; última suite completa: 114 pruebas.
- Actualizados selectores de pruebas antiguas de acceso/buscador para usar la etiqueta del correo. Estas suites dependientes de backend real siguen pendientes de revisión integrada y no se incluyen en los 47 casos aprobados.

Siguiente fase propuesta: FASE 9, renovar buscador, tarjetas, filtros y detalle. Después cerrar diseño de portada, perfil/modelo monetario, validación CRUD y calidad de datos; correo real y despliegue siguen pendientes. Una fase por instrucción explícita.

## Avance de implementación — FASE 9, exploración y detalle

- Buscador con título editorial y jerarquía clara, fondo cálido/verde petróleo compartido con acceso, tarjetas más amplias con beneficio y cierre destacados. Controles y paginación con foco visible y mayores áreas táctiles. Esqueleto de carga anunciado y compatible con movimiento reducido.
- Filtros plegables en móvil, visibles en escritorio; conservan valores al cerrar. Chips permiten quitar texto, RSH o NEM individualmente. Se conservan URL, debounce de 400 ms, paginación y descarte de respuestas antiguas.
- Detalle comparte navegación pública, mejora lectura de requisitos/documentos/fechas y mantiene enlace oficial. Un error ya no redirige silenciosamente: ofrece reintento y vuelta al buscador. Peticiones canceladas al salir y respuestas descartadas; enlace directo vuelve a /explorar. Eliminada captura global de Escape/botones de ratón que interfería con menú y navegación del navegador.
- Parser de documentos contempla descripciones con solo marcadores opcionales y separa ítems por líneas, marcadores o punto y coma. Sigue dando prioridad a documentos estructurados. No se modifican requisitos ni fuentes existentes.
- Favoritos en resultados bloquean escrituras simultáneas de la misma beca; un fallo revierte el cambio optimista y anuncia el error. El botón sigue siendo independiente de abrir la tarjeta, con estado accesible.
- Verificación: 54 casos distintos Chromium aprobados con API controlada durante la fase (primera ejecución de 53; después, 19 de buscador/detalle repetidos con el último cambio, incluido un caso nuevo de favorito fallido). Capturas de buscador/detalle a 390 y 1280 px revisadas; sin desbordamiento en recorridos comprobados. Revisión estática global y build frontend aprobados; mvn compile aprobado, sin cambios backend. Última suite completa backend: 114 pruebas.
- Sin dependencias nuevas. No equivale a integración con servicios reales. Mantener pendientes la auditoría de datos/fuentes, orden monetario/modelo, perfil, validación CRUD del servidor, optimización CSV, correo real y despliegue.
- Una ejecución intermedia agotó el tiempo al desplazar la página para cerrar filtros móviles. No se reprodujo en el caso aislado ni en la repetición completa final de los 19 casos (28 segundos); causa no confirmada. No se relajaron aserciones ni se forzaron clics para aprobar.

Siguiente fase propuesta: FASE 11, renovar la portada y revisar sus textos/promesas con el comportamiento real. Mantener una fase por instrucción explícita.

## Avance de implementación — FASE 11, portada

- Portada editorial coherente con acceso/buscador: crema, verde petróleo y dorado, jerarquía tipográfica y explicación en tres pasos. Sin dependencias, imágenes ni fuentes externas nuevas.
- Eliminadas afirmaciones de ser el primer motor, tener cientos de becas, cobertura comprobada de las 16 regiones y garantizar beneficios; no se anuncia un filtro de monto inexistente. Explica criterios reales de búsqueda/recomendación y consulta de convocatoria oficial.
- Respeta acceso actual: buscador requiere sesión. Visitantes reciben acciones hacia registro/login; usuarios autenticados hacia búsqueda/perfil. No se modifican rutas protegidas ni se promete exploración anónima.
- Enlace para saltar al contenido verificado con teclado, encabezados semánticos, iconos decorativos ocultos y controles con foco visible. Layout comprobado a 360/390/768/1440 px; capturas de escritorio/móvil revisadas sin desbordamiento.
- Verificación: 32 pruebas Chromium aprobadas con API controlada (siete nuevas de portada, doce de sesión, seis de navegación/acceso y siete de recuperación). Lint global cero errores/advertencias, build frontend y mvn compile aprobados. Backend sin cambios; última suite completa permanece en 114 casos.
- No activa envío real ni publica el sitio. To do actualizado; próxima FASE 12: perfil y favoritos, una fase por instrucción explícita.

## Avance de implementación — FASE 12, interfaz de perfil y favoritos

- Ambas pantallas comparten navegación y diseño editorial. Etiquetas asociadas, campos opcionales explicados, estados de carga/error/éxito anunciados y foco visible. Capturas de escritorio/móvil revisadas a 390/1280 px sin desbordamiento.
- Perfil carga datos y catálogos juntos; cualquier fallo bloquea edición/guardado y ofrece reintento, evitando sobrescribir datos con un formulario vacío. Un perfil inexistente es la respuesta null, no cualquier error. Respuestas descartadas al desmontar.
- Se conserva RSH cero y NEM decimal. Interfaz valida RSH entero 0–100, NEM 1–7 con un decimal según esquema actual y carrera hasta 255 caracteres. Guardado envía null al vaciar región/institución/carrera, recorta espacios, bloquea controles/envíos concurrentes y conserva cambios ante fallo. Estas reglas aún necesitan validación del servidor; no cambian DTOs ni esquema en esta fase.
- Explicación precisa: recomendaciones evalúan RSH/NEM/región; institución/carrera/año se guardan como referencia. Enlace lleva al modo recomendado usando perfil guardado, sin prometer elegibilidad.
- Favoritos distingue error de lista vacía, permite reintentar carga y cancela peticiones al salir. Quitar usa botón compartido con estado/área táctil, bloquea envíos por beca, conserva tarjeta si falla y anuncia éxito. Becas inactivas permanecen guardadas con aviso visible, igual que becas vencidas.
- Verificación final: 39 pruebas Chromium aprobadas con API controlada (diez nuevas y 29 regresiones). Dos fixtures iniciales se corrigieron para mantener fallos hasta reintento, compatibles con doble montaje de StrictMode en desarrollo; no se relajaron aserciones. Lint global cero errores/advertencias, build frontend y mvn compile aprobados. Última suite backend completa: 114 casos; sin cambios backend.
- Pendientes específicos: validación de perfil en DTO/servidor, concurrencia de favoritos en backend y verificación integral con PostgreSQL real. Próxima FASE 2: endurecer solicitudes de perfil/administración; una fase por instrucción explícita.

## Avance de implementación — FASE 2, validación de solicitudes

- Perfil: RSH 0–100, NEM 1–7 con un decimal, identificadores positivos y carrera hasta 255 caracteres. Campos opcionales mantienen null; no cambia esquema ni reglas de recomendación.
- Becas: nombre/cobertura hasta 255 y URL hasta 500 caracteres, IDs y regiones positivos/no nulos, RSH/NEM/PAES dentro de rangos, estado no nulo e inicio no posterior a cierre. URLs opcionales deben ser HTTP/HTTPS con host y sin credenciales; existencia/fuente oficial sigue pendiente.
- Validación en cascada de documentos: lista sin elementos nulos, nombre obligatorio hasta 255 y obligatoriedad explícita. Listas vacías siguen permitiendo borrar asociaciones; datos no enviados conservan el comportamiento existente del servicio.
- Usuarios administrativos: correo hasta 254, nombre hasta 255, rol positivo y contraseña de 8–72 caracteres con máximo 72 bytes UTF-8. Mensajes nuevos incluyen tildes; no se agregan bibliotecas.
- Los controladores ya usaban @Valid: no se cambian en esta fase. Fechas/URL/contraseña se comprueban mediante propiedades calculadas @AssertTrue ocultas del JSON; se conservan DTOs de respuesta y contratos HTTP existentes.
- Cinco pruebas nuevas de API realizan múltiples solicitudes inválidas y comprueban 400/errores por campo, conteos y snapshots sin cambios, perfil opcional con valores límite/vaciado y edición que elimina documentos/regiones. Comparación de colecciones normaliza solo orden, manteniendo todos los valores: asociaciones JPA no garantizan orden.
- Verificación final: 119 pruebas backend aprobadas, empaquetado y mvn compile aprobados. H2 de pruebas aislada; no se modificó la base local ni se ejecutó PostgreSQL en esta fase. Frontend sin cambios; última revisión estática/build de interfaz sigue aprobada desde FASE 12.
- Pendientes: consistencia del servicio, referencias/concurrencia y política de borrado, verificación integral PostgreSQL, modelo monetario, calidad de fuentes/datos, correo y despliegue. Próxima FASE 5, una fase por instrucción explícita.


## Avance FASE 5 — integridad de servicios (30 de septiembre de 2026)

- Las regiones inexistentes se rechazan sin crear una beca nacional ni modificar datos parcialmente. Editar una beca sin requisitos previos ahora crea su registro de requisitos.
- Favoritos y guardado de perfil bloquean la fila del usuario dentro de la transacción: dos solicitudes simultáneas no crean registros duplicados. Guardar un favorito exige que la beca exista y la protege durante la operación.
- Se conserva la política existente: eliminación de becas y desactivación de usuarios. Una prueba de eliminación comprueba la limpieza de favoritos, regiones, requisitos y documentos.
- Verificación: 125 pruebas backend aprobadas; seis nuevas pruebas de integridad, incluyendo escrituras concurrentes. Empaquetado y mvn compile aprobados. Motor H2 aislado; PostgreSQL no ejecutado en esta fase.
- Pendientes: repetir concurrencia/borrado con PostgreSQL real, revisar concurrencia administrativa/importaciones y contrato de respuestas. Próxima FASE 6; una fase por instrucción explícita. Correo, calidad de datos y despliegue siguen pendientes.


## Avance FASE 6 — respuestas HTTP (30 de septiembre de 2026)

- JSON malformado, tipos de parámetros inválidos y archivos/parámetros ausentes devuelven 400 en la capa HTTP. Métodos no admitidos devuelven 405 con Allow; contenido incompatible devuelve 415. No se exponen detalles del parser.
- Registro público y creación administrativa de usuarios/becas devuelven 201 tanto en HTTP como en el cuerpo. ApiResponse incluye data incluso si es null. Se corrigen tildes en mensajes del manejador global.
- Se conservan validationErrors y los demás campos de ErrorResponse para la interfaz. Su unificación completa con ApiResponse sigue pendiente y requiere una revisión conjunta de consumidores y filtros de seguridad.
- Verificación: 131 pruebas backend aprobadas, incluyendo seis nuevas pruebas HTTP con múltiples endpoints y rechazo de escrituras administrativas para estudiantes. Maven package y compile aprobados; H2 aislado. Frontend sin cambios; no se ejecutó PostgreSQL ni se desplegó.
- Próxima FASE 10: diseño y accesibilidad de administración. Una fase por instrucción explícita. Continúan pendientes pruebas reales, datos, correo y publicación.


## Avance FASE 10 — administración accesible (30 de septiembre de 2026)

- Formularios de becas/usuarios, confirmaciones de eliminación/desactivación e importación CSV usan un diálogo nativo compartido. El contenido del fondo queda inerte; Escape cierra cuando no hay una escritura pendiente y el foco vuelve al origen si sigue disponible. Se bloquea el desplazamiento del fondo y el formulario largo se desplaza dentro del diálogo.
- Se aplica el diseño crema/petróleo a formularios, tablas y acciones, con foco visible. Cabeceras se acomodan a móvil y la tabla de usuarios se desplaza dentro de su contenedor. Usuario incluye autocompletado y límites de nombre/correo; el selector CSV está etiquetado y bloqueado durante el envío.
- Verificación final: 20 casos Chromium aprobados con API controlada, incluyendo cuatro casos nuevos de foco, Escape durante guardado y adaptación a 390/1280 px. Capturas de formulario inspeccionadas en ambos tamaños; lint sin errores/advertencias, build y Maven compile aprobados. Una prueba de búsqueda falló en la ejecución paralela inicial y pasó aislada y en la ejecución completa en serie; causa no confirmada.
- Backend sin cambios. Las 131 pruebas backend corresponden a la etapa anterior; no se repitió esa suite ni PostgreSQL en esta fase. No hubo despliegue ni envío de correo real.
- Próxima tarea propuesta: cerrar integración de perfil/favoritos con PostgreSQL en FASE 12. Una fase por instrucción explícita. Persisten tareas de modelo monetario, datos/fuentes, accesibilidad global, correo e infraestructura.


## Avance FASE 12 — persistencia PostgreSQL (30 de septiembre de 2026)

- ProfilePersistenceTest añade cuatro pruebas HTTP: perfil con cero/decimales/tildes y vaciado explícito, rollback por región inválida, favoritos idempotentes/aislados por cuenta y recomendaciones equivalentes a la búsqueda con el perfil persistido.
- infra/verify-profile-postgres.ps1 inicia PostgreSQL 17 exclusivamente en loopback y puerto temporal. Instala infra/ddl.sql en una base nueva por clase, sustituye sus catálogos semilla por fixtures y usa ddl-auto:validate. Ejecuta ProfilePersistenceTest y CoreServiceIntegrityTest, restaura variables de entorno y detiene el servidor incluso si hay fallos. Conserva logs en TEMP; no modifica la base local.
- Resultado PostgreSQL: 10 pruebas aprobadas, incluyendo creación inicial de perfil/favoritos concurrente y limpieza de dependencias tras eliminación. La primera ejecución del verificador falló por catálogos semilla duplicados; se corrigió únicamente el montaje de fixtures y la ejecución final pasó.
- Regresión completa: 135 pruebas backend H2 aprobadas, cero fallos/errores; Maven package y compile aprobados. No se cambió código de producción ni el frontend.
- Pendiente de cierre integral: navegador conectado a backend/PostgreSQL real, sin interceptar API. Las verificaciones anteriores de interfaz usaron API controlada; no declarar aún ese recorrido end-to-end aprobado. Próximo paso: continuar FASE 12 con ese recorrido. Correo, datos, modelo monetario y despliegue siguen pendientes.


## Avance FASE 12 — navegador conectado al backend real (30 de septiembre de 2026)

- Se añade una suite live separada de las pruebas con mocks. Un caso recorre múltiples acciones: login con JWT real; guardar perfil con cero, decimal y tildes; recargar; vaciar región/institución/carrera; abrir recomendaciones; guardar favorito; recargar favoritos; comprobar persistencia por API; eliminar y comprobar ausencia tras recarga/API.
- infra/verify-profile-browser.ps1 instala DDL y fixtures en PostgreSQL temporal, arranca el JAR con perfil prod, ddl-auto:validate y sin inicialización automática. Vite apunta a esa API y CORS solo permite el origen temporal. Las URLs de datasource y variables de esquema se fijan explícitamente para evitar heredar la base local. Servicios limitados a loopback; procesos detenidos y variables restauradas al terminar.
- Resultado final: un recorrido Chromium real aprobado con múltiples comprobaciones UI/API; ejecución inicial y repetición tras endurecer el aislamiento aprobadas. Lint/build frontend y Maven compile aprobados. Las 135 pruebas backend H2 y 10 PostgreSQL siguen siendo evidencia de la etapa anterior; no se repitieron completas aquí.
- No se modificó código de producción ni la base local. Sigue pendiente ampliar recorridos reales de administración/roles/importación, recuperación con correo real y verificación global de accesibilidad/rendimiento. Próxima FASE 10: CRUD administrativo real; mantener una fase por instrucción explícita. Sin despliegues.


## Avance FASE 10 — administración con backend real (30 de septiembre de 2026)

- Tres casos nuevos de navegador real: crear/recargar/editar/eliminar beca conservando RSH cero y NEM decimal; crear usuario/desactivarlo y comprobar bloqueo de token previo/nuevo login; rechazar rutas y API administrativas con cuenta estudiante. Se comprueba la eliminación por 404 y la persistencia con API real.
- Verificador ampliado: confirma por SQL PostgreSQL que el usuario desactivado sigue almacenado y activo=false; se conserva la política de soft delete.
- Hallazgo abierto: @Where(activo=true) de Usuario excluye cuentas inactivas también del listado administrativo. La interfaz tiene un estado Inactivo que no recibe esos registros. No se modificó el modelo en esta fase; revisar una consulta administrativa controlada en su fase correspondiente. Tampoco existe formulario de edición de usuarios en la interfaz actual.
- La primera ejecución esperaba ver al usuario inactivo y falló, identificando el filtro real; otra ejecución esperaba 401 para el token desactivado pero el filtro de seguridad devuelve 403, coherente con las pruebas backend existentes. Los nuevos accesos por login reciben 401. Las pruebas finales verifican este comportamiento exacto sin aceptar estados alternativos.
- Resultado final: cuatro recorridos Chromium reales aprobados (tres nuevos y regresión de perfil/favoritos), backend prod, DDL real y PostgreSQL temporal; comprobación SQL de desactivación aprobada. Lint/build frontend y Maven compile aprobados. Suite completa backend no repetida; última evidencia sigue en 135 H2 y 10 PostgreSQL.
- Sin cambios de código de producción, base local ni despliegues. Próxima FASE 14: importación CSV desde navegador con backend real. Siguen pendientes las mejoras de listado/edición de usuarios, correo, modelo monetario, datos y verificación global.


## Avance FASE 14 — CSV desde navegador real (30 de septiembre de 2026)

- Un caso nuevo ejecuta tres importaciones reales con archivos UTF-8 sin BOM: crea una beca con tildes/Ñ; actualiza su monto sin duplicarla; envía una fila válida seguida de otra con región inexistente y confirma cero escrituras/ninguna fila parcial.
- Tras cada importación se ejecutan consultas PostgreSQL encode(convert_to(nombre,'UTF8'),'hex') sobre becas/instituciones para detectar mojibake y verificar los bytes exactos del nombre importado. Se comprueban contadores de creación/actualización/error, resultados de API y visibilidad en administración.
- Hallazgo del entorno: la búsqueda completa con Ñ falló en el clúster con locale C y pasó al configurar ICU es-CL. El verificador temporal ahora usa esa configuración. Verificar locale/proveedor y búsqueda con tildes/Ñ en el destino antes de publicar; no se cambió la base local ni código de búsqueda.
- Las filas inválidas devuelven HTTP 200 con errores en ImportResultDTO. La prueba comprueba ese contrato y rollback, sin aceptar HTTP alternativos. La expectativa inicial de 400 se corrigió tras observar la respuesta real.
- Resultado final: cinco recorridos Chromium reales aprobados (CSV nuevo y cuatro regresiones de administración/perfil/permisos). Lint/build frontend y Maven compile aprobados. No se repitieron completas las 135 pruebas H2 ni las 10 PostgreSQL anteriores.
- Sigue pendiente auditar fuentes/CSV históricos, fechas/requisitos, medir batch INSERT y concurrencia de importaciones. Próxima tarea propuesta: corregir listado administrativo de usuarios inactivos por fases de repositorio/servicio correspondientes; conservar soft delete y autenticación actual. Correo, modelo monetario, accesibilidad global e infraestructura permanecen pendientes. Sin despliegues.


## Avance FASE 3 — consulta administrativa de usuarios (30 de septiembre de 2026)

- UsuarioRepository incorpora findAllForAdministration con una proyección nativa de seis campos controlados: identificador, correo, nombre, rol, actividad y fecha. Incluye cuentas desactivadas y ordena por identificador; no selecciona password_hash ni devuelve entidades.
- Se conserva @Where(activo=true) y todas las consultas de identidad existentes. AdminUserProjectionTest comprueba cuentas activas/inactivas, campos/tipos, orden y exclusión de la cuenta inactiva en consultas habituales.
- Resultado: 11 pruebas PostgreSQL temporal aprobadas con DDL real/validate, incluida la nueva consulta. Regresión completa H2: 136 aprobadas, cero fallos/errores. Maven package y compile aprobados.
- Alcance cerrado: repositorio y pruebas de FASE 3. La consulta aún no está conectada al servicio; el listado visible sigue excluyendo cuentas inactivas. Próxima FASE 5: mapear esta proyección al UsuarioDTO existente y verificar endpoint/roles/recorrido real. No modificar autenticación ni la política de soft delete.
- Frontend sin cambios; no se repitieron pruebas de navegador. Siguen pendientes edición de usuarios, errores uniformes, modelo monetario, calidad de datos, correo y despliegue. Mantener una fase por instrucción explícita.


## Avance FASE 5 — usuarios inactivos visibles en administración (30 de septiembre de 2026)

- UsuarioServiceImpl.findAll usa la proyección administrativa y la mapea al UsuarioDTO existente. No se alteran entidades, autenticación, controladores ni consultas de identidad. El endpoint continúa restringido al rol ADMIN.
- AdminUserProjectionTest comprueba también por HTTP que el listado devuelve actividad/rol/fecha y excluye campos de contraseña. El recorrido real ahora exige ver la cuenta desactivada como Inactivo tras recarga, sin botón de desactivación; el token previo sigue rechazado con 403 y login nuevo con 401.
- Verificación final: 136 pruebas H2 aprobadas, package y compile aprobados; cinco recorridos Chromium con backend prod/PostgreSQL reales aprobados, incluidos permisos, CSV y perfil/favoritos. Lint/build frontend aprobados. Las 11 pruebas PostgreSQL específicas corresponden a la fase anterior y no se repitieron como suite separada aquí.
- Hallazgo de usuarios inactivos cerrado en el listado. Pendiente edición de usuarios activos en la interfaz (próxima FASE 10), contrato/errores, modelo monetario, datos, correo, pruebas globales e infraestructura. Base local intacta; servicios temporales detenidos. Sin despliegues.


## Avance FASE 10 — edición de usuarios activos (30 de septiembre de 2026)

- El listado ofrece Editar solo para cuentas activas. UsuarioForm reutiliza el diálogo accesible con valores precargados; envía únicamente email/nombreCompleto a PUT y conserva datos tras errores. Rol/contraseña aparecen solo durante creación; el DTO de edición no permite cambiarlos.
- Se bloquean controles durante el guardado y se distingue Crear/Guardar cambios. Cuentas inactivas siguen visibles sin acciones de edición/desactivación. No se agrega reactivación ni cambio de permisos.
- Verificación: 14 casos de formularios con API controlada aprobados, incluida edición con error/reintento, cambios conservados y payload exacto. Cinco recorridos Chromium reales aprobados: se amplía creación/desactivación con edición de nombre y recarga persistente antes del bloqueo de acceso. Lint/build y Maven compile aprobados.
- Backend sin cambios; última suite completa sigue en 136 H2 y suite específica PostgreSQL en 11 casos, no repetidas aquí. Recorrido real usa backend prod/PostgreSQL temporal; base local intacta y procesos detenidos.
- Siguiente tarea propuesta: FASE 4, revisar invalidación de sesiones tras cambiar contraseña. Permanecen modelo monetario, contrato/errores, calidad histórica de datos, correo real, accesibilidad/rendimiento global e infraestructura. Sin despliegues; una fase por instrucción explícita.


## Avance FASE 4 — invalidación de sesiones tras recuperación (30 de septiembre de 2026)

- Se reprodujo el fallo: un JWT anterior a recuperar la contraseña seguía obteniendo HTTP 200. Ahora login/registro incluyen una marca HMAC de las credenciales y cada solicitud protegida la compara con las credenciales actuales. Después de recuperar la contraseña el token anterior recibe 403 y un login nuevo permite acceso.
- El JWT no contiene la contraseña ni su hash. Tokens de versiones anteriores sin la marca deben iniciar sesión nuevamente al aplicar esta versión. No se requiere migración del esquema ni nuevas dependencias.
- Resultado: 140 pruebas H2, 14 pruebas AccountSecurityTest en PostgreSQL 17 con DDL real/validate y cinco recorridos Chromium con backend prod/PostgreSQL aprobados. Package y Maven compile aprobados; servicios temporales detenidos y base local intacta. Las pruebas de recuperación usan envío de correo simulado: la entrega real permanece pendiente.
- El verificador PostgreSQL acepta -TestClasses AccountSecurityTest; conserva por defecto las clases de perfil/integridad/proyección administrativa. No hubo cambios de frontend ni despliegues.
- Próxima tarea propuesta: uniformar contratos de errores y respuestas de sesión inválida en FASE 6. Siguen pendientes modelo monetario, datos históricos, correo real, accesibilidad/rendimiento global e infraestructura. Una fase por instrucción explícita.

## Avance FASE 6 — contrato común de errores (30 de septiembre de 2026)

- GlobalExceptionHandler retorna ApiResponse en todos sus manejadores. Se elimina el DTO ErrorResponse sin consumidores restantes. Los errores incluyen timestamp/status/message/data:null; error/path/validationErrors se mantienen como campos opcionales compatibles. No se agregan esos campos nulos a respuestas exitosas.
- Se conservan códigos HTTP, detalles de validación, mensajes y cabecera Allow. Se corrige la tilde en el mensaje predeterminado «Operación exitosa». Dos pruebas nuevas reproducen la ausencia de data y verifican validación, login fallido, recurso inexistente y autorización por rol.
- Resultado final: 142 pruebas H2 aprobadas, ocho casos HttpContractTest con PostgreSQL 17/DDL real/validate aprobados y cinco recorridos Chromium reales aprobados. Maven package/compile aprobados. Frontend sin cambios; lint/build no repetidos. Base local intacta y servicios temporales detenidos; sin despliegues.
- Alcance: errores gestionados por los controladores/advice. Sesión ausente/inválida y denegación en filtros de seguridad aún requieren configuración de entry point/handler en FASE 4; no declarar uniformidad integral de toda respuesta HTTP. Próxima tarea propuesta: ese alcance de seguridad. Permanecen montos, datos históricos, correo real, accesibilidad/rendimiento e infraestructura.

## Avance FASE 4 — respuestas de autenticación y permisos (30 de septiembre de 2026)

- SecurityConfig configura entry point 401 JSON/ApiResponse y WWW-Authenticate: Bearer para sesiones ausentes, malformadas, vencidas, con firma inválida, cuentas inexistentes/inactivas o credenciales modificadas. Usuarios autenticados sin permisos mantienen 403; su sesión sigue funcionando en recursos permitidos. Se conserva acceso público con un token opcional inválido.
- El listado administrativo de becas ahora exige autenticación antes de la regla pública /api/becas/**. No se modifican reglas de roles ni lógica de negocio. El interceptor existente reconoce 401 y elimina la sesión antes de volver al login; no se modifica código frontend de producción.
- Cuatro pruebas nuevas verifican formato JSON/estados/cabecera, firma/caducidad y preservación de sesión con 403. Se actualizan expectativas específicas de tokens invalidados a 401. La suite antigua ImportAndUserAdminTest restaura correo/nombre/actividad de sus fixtures y exige rechazo del CSV vacío por contenido; antes aceptaba un fallo de autenticación causado por contaminación entre pruebas.
- Resultado: 146 pruebas H2 y 18 PostgreSQL (SecurityResponseTest + AccountSecurityTest) aprobadas; seis recorridos Chromium reales aprobados, incluyendo JSON 401 y cierre de sesión. Package/compile, lint/build aprobados. La primera comprobación del cuerpo en navegador falló porque la navegación inmediata descartó la respuesta; se verifica el JSON mediante API real y la redirección mediante navegador. No se simula el backend.
- El JAR habitual estaba ocupado por un proceso ajeno al verificador. Se generó un POM temporal con directorio de salida aislado y se eliminó después; el proceso existente no se interrumpió. verify-profile-browser.ps1 acepta BackendJarPath opcional para probar ese empaquetado. Base local intacta y servicios de pruebas detenidos. Sin despliegues ni entrega de correo real.
- Próxima tarea propuesta: revisar límites de solicitudes públicas de registro/recuperación en FASE 2. Siguen pendientes identificadores públicos, modelo monetario, datos históricos, correo real, accesibilidad/rendimiento e infraestructura. Rechazo CORS independiente del contrato de autenticación; una fase por instrucción explícita.
