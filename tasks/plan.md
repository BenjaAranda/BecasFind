# Plan de ejecución editorial por lotes

Solicitud: organizar iteraciones mayores y continuar. Autorizado por el usuario el 2 de octubre de 2026. El único listado de pendientes es [PLAN_MEJORAS.md](../PLAN_MEJORAS.md); este documento explica la ejecución de P04.

## Secuencia y aceptación

| Paso | Resultado revisable | Verificación | Dependencia |
|---|---|---|---|
| Selección | 25–40 hashes únicos y referencias originales | Sin duplicar candidatas; variantes enlazadas | Inventario actual |
| Contraste | Una matriz individual con fuentes y bloqueo específico | Cada conclusión respaldada; distinguir fuente leída de búsqueda y reutilización | Selección |
| Registro | Enlazar informe individual y actualizar inventario una vez | Cuatro controles esenciales autorizados; seis solo para confirmación exhaustiva; originales intactos | Contraste |
| Correcciones | Un CSV cuando haya campos justificadamente corregibles | Respaldo/restauración; atomicidad; UTF-8; sin alterar otras becas | Registro |
| Entrega | Commit español y conteo real | Pruebas aplicables; diff; SHA remoto | Registro y correcciones si existen |

Punto de control después de contraste y después de registro: no confundir revisión parcial, conciliación y confirmación completa. Fuentes compartidas ahorran lecturas, pero no trasladan requisitos entre becas. No crear automatización nueva, contratar servicios ni desplegar.
