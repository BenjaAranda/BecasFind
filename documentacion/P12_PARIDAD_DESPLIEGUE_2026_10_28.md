# P12: versión probada frente a versión desplegada

## Estado posterior: catálogo con estados desplegado

El usuario confirmó que la otra tarea terminó y autorizó continuar la preview. Se desplegó frontend `719646b` y backend `37ae1a1` en `https://becasfind-pf8timp72-benjatlou13-1274.vercel.app`. Quality del backend final y su árbol de frontend terminó correctamente: ejecución40778376684. Acceso sin sesión de BecasFind, 528 fichas, filtros de 323 instituciones, detalle y alternancia de vistas comprobados. Datos y UUID intactos; correos y orígenes anteriores conservados. Evidencia posterior en `P12_CATALOGO_PREVIEW_2026_10_28.json`. Las secciones inferiores describen la transición anterior; no repetirla.

## Actualización: preview corregida compilada

**Aplicación confirmada por el usuario:** el 28/10/2026 a las 22:06:19 UTC, el helper
agregó el nuevo origen y aprobó API/CORS local. Conservó orígenes, FRONTEND_URL e imagen;
el contenedor anterior queda detenido para reversión. Evidencia en
`P12_TRANSICION_PREVIEW_2026_10_28.json`. No repetir el script. Solo permanecen
pendientes inicialmente el preflight externo y el recorrido de la nueva preview.
El usuario comprobó después el preflight externo (22:07:08 UTC): HTTP 200 y origen
exacto autorizado. Queda pendiente el recorrido en navegador. Los párrafos
posteriores que dicen «pendiente el ajuste» describen el momento previo a esta salida.

Se creó y comprobó READY el deployment `dpl_J1JHhskcABsrZLiyFjzP2x9BnpN7`,
target `staging`, commit `f2facacf2a0393a8cfc138641cd63002847742bc`.
URL: https://becasfind-ejsx6hw61-benjatlou13-1274.vercel.app
La ruta `/explorar` devuelve HTML 200 con el bundle `index-DAkkapYI.js`, mediante
acceso autenticado del conector Vercel. No se ejecutó el navegador ni se comprobó
la API desde ese origen. Se conservó la protección Vercel y la URL antigua.

Queda pendiente el ajuste en Oracle. `infra/connect-p12-preview.ps1` ejecuta el
helper Python en el servidor desde PowerShell, usando la clave SSH del usuario.
Agrega exclusivamente el nuevo origen a CORS, preserva FRONTEND_URL y los orígenes
anteriores, verifica configuración/variables contra el contenedor actual, conserva
la misma imagen y reinicia brevemente la API. Guarda una copia privada del archivo
de entorno y el contenedor anterior; ante fallo de creación o de comprobación local
API/CORS, restaura la configuración y el contenedor previos. No modifica PostgreSQL.
Si encuentra una configuración distinta de la prevista, se detiene para revisión.

```powershell
& "C:\Users\benja\Documents\BecasFind\infra\connect-p12-preview.ps1"
```

Ejecutar cuando la sesión del otro chat no esté recreando el contenedor API.
Esta sesión no pudo aplicarlo: lectura de clave y conexión SSH denegadas por el
entorno. No se cambiaron permisos ni se intentó sortear esa restricción.

Validación del helper: cuatro pruebas simuladas aprobadas (preservación de origen,
correo e imagen; restauración tras fallo de creación; bloqueo de configuración
inesperada; restauración tras fallo CORS). Sintaxis Python/PowerShell correcta.
Runner: `python infra/test-connect-p12-preview.py`. Son pruebas locales sin red;
no acreditan ejecución remota. Después corresponde comprobar preflight externo
y recorrido en navegador. El correo continúa apuntando a la preview anterior.

Los apartados siguientes conservan el diagnóstico anterior a crear este deployment.

Comprobación de solo lectura realizada el 28/10/2026. No se modificó el catálogo,
la API, la interfaz en preparación ni la configuración de Oracle/Vercel.

## Resultado

Vercel confirma que el deployment `dpl_Ho3tTsrGuWPfE14NMhmsnRCM8Yys` está READY,
target `staging`, con el commit `cdbf84cc7d3aeeee2171eb4bbca11d328adb0ee7`.
La lista del proyecto contiene esa preview y un intento de producción cancelado;
no se encontró una preview posterior con las correcciones de dependencias.

Preview: https://becasfind-afeqpkmym-benjatlou13-1274.vercel.app

| Paquete | Lockfile del deployment | Lockfile corregido |
|---|---|---|
| Vite | 8.3.1 | 8.3.5 |
| follow-redirects | 1.16.0 | 1.16.2 |
| Zod | 4.4.3 | 4.6.7 |

Las versiones de la segunda columna se obtuvieron del lockfile del commit identificado
por Vercel. No se inspeccionó el contenido minificado del bundle ni se afirma que todos
esos paquetes se ejecuten en el navegador. Vite es una herramienta de compilación.

El parche está en `f816b6ecbc0c031b7a1c8a2cedcb529cfe9fd4db`. La comparación
`git diff cdbf84c f2facac -- frontend` cambia exclusivamente `frontend/package-lock.json`:
87 inserciones y 87 eliminaciones. No hay cambios de interfaz versionados entre esos
dos puntos. Los cambios de catálogo público que existen en el árbol local no están
incluidos en esta comparación y pertenecen al otro trabajo en curso.

## Calidad comprobada en GitHub

Para el commit `f2facacf2a0393a8cfc138641cd63002847742bc`, la ejecución
[Quality 40621290969](https://github.com/BenjaAranda/BecasFind/actions/runs/40621290969)
terminó con éxito en sus tres trabajos:

- Frontend: npm ci, lint, auditoría, build, rendimiento y Playwright aprobados.
- Backend: Maven verify y protecciones de preparación/importación aprobados.
- PostgreSQL: migraciones y pruebas reales aprobadas.

Esta evidencia corresponde al commit; no acredita los cambios locales todavía sin
versionar ni convierte el parche en desplegado. Se consultaron los estados de los
trabajos y sus pasos; no se volvió a ejecutar la batería ni se modificaron umbrales.

## Secuencia concreta para incorporar el parche en preview

1. Fijar el commit probado, sin incluir el árbol local en preparación. Usar como
   referencia `f2facacf2a0393a8cfc138641cd63002847742bc` o verificar nuevamente
   Quality si se elige otro commit.
2. Crear un deployment explícitamente `staging`, conservando VITE_API_URL HTTPS,
   configuración de acceso Vercel y plan existente. No promover producción.
3. Obtener el nuevo origen. La URL única de un deployment es distinta de la anterior;
   no asumir que el CORS exacto configurado para la preview antigua lo admite.
4. Incorporar el origen exacto nuevo al CORS de Oracle conservando el anterior durante
   la transición. Coordinar esa actualización de configuración con la sesión que tenga
   acceso, sin ejecutar a la vez cambios de contenedores o scripts del otro chat.
5. Comprobar preflight desde el nuevo origen, búsqueda/detalle, login y rutas SPA.
   Antes de retirar el origen anterior, actualizar y verificar FRONTEND_URL y el destino
   de recuperación. Los enlaces de correo existentes no deben quedar inutilizables
   por retirar prematuramente la preview anterior.
6. Registrar deployment, commit y verificaciones. Conservar la preview anterior para
   una transición reversible. No atribuir al backend un nuevo build de frontend.

No se ejecutó esta transición: falta la coordinación de configuración remota y no
conviene dejar una preview nueva con CORS incompleto. La auditoría de becas puede
continuar sin interferencia. P13/P14 no se iniciaron.
