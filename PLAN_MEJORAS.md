# Plan de corrección, diseño y publicación de BecasFind

Fecha: 29 de septiembre de 2026. Estado: FASE 1 cerrada, incluida migración local y respaldo restaurado; FASE 4 de autenticación implementada con pruebas. Resto pendiente. Sin despliegues.

Objetivo: publicar una aplicación segura, comprensible y verificable, manteniendo Vercel para el frontend y Oracle Always Free como opción para el backend y la base de datos.

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
4. **Recuperación de contraseña:** elegir un servicio de correo compatible con el presupuesto y autorizar su integración. Hasta contar con envío real, no publicar una recuperación que prometa un correo que no se envía.

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
