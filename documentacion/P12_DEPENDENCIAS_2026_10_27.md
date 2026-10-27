# Corrección de dependencias detectadas por Quality

La ejecución [40574401310](https://github.com/BenjaAranda/BecasFind/actions/runs/40574401310) detuvo el frontend en `npm audit --audit-level=high`: tres paquetes afectados. Backend y protecciones del importador pasaron. Se actualizaron únicamente dependencias dentro de los rangos existentes, mediante npm; no se editó manualmente el lockfile ni se relajó el umbral de auditoría.

| Paquete | Versión anterior fijada | Versión corregida fijada | Fuente |
|---|---|---|---|
| follow-redirects | 1.16.0 | 1.16.2 | [Aviso del mantenedor](https://github.com/advisories/GHSA-q3jh-wrc6-jgq8) |
| Vite | 8.3.1 | 8.3.5 | [Aviso aplicable](https://github.com/advisories/GHSA-587h-7wmj-h5pm), [notas oficiales](https://github.com/vitejs/vite/releases/tag/v8.3.5) |
| Zod, transitiva | 4.4.3 | 4.6.7 | [Aviso revisado](https://github.com/advisories/GHSA-mrhx-c7xc-m3w5) |

Vite actualiza también sus dependencias asociadas Rolldown, tipos OXC, PostCSS y Nano ID. Se revisó ese cambio transitivo. React, Tailwind, Axios y los demás rangos de `package.json` permanecen iguales; no se cambió la interfaz.

Comprobaciones locales posteriores: instalación reproducible con `npm ci --ignore-scripts`, auditoría con cero vulnerabilidades, lint aprobado y compilación TypeScript/Vite aprobada. La compilación conserva la advertencia de deprecación `module.register()` del runtime local; no se trató como fallo ni se ocultó.

El parche queda en el código versionado y deberá usarse en el siguiente build desplegado. La preview comprobada en P12 sigue identificada por su deployment y commit anteriores; no se afirma que contenga este nuevo lockfile ni se promovió producción. Las pruebas de GitHub posteriores comprueban el parche antes del cierre de esta entrega.
