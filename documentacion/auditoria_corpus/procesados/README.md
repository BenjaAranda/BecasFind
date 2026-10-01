# Histórico procesado incorporado — 1 de octubre de 2026

Se conservaron los 93 CSV originales de `03_procesados`, con 641 registros CSV lógicos. La consolidación produce 562 candidatos por nombre e institución normalizados: 59 grupos tienen varias referencias. Una coincidencia normalizada no demuestra que dos convocatorias sean el mismo beneficio. No se eliminaron originales ni se resolvieron automáticamente discrepancias de año, importe o requisitos.

La base local recibió 549 candidatos inactivos y omitió 13 ya existentes, sin actualizar sus campos ni versiones. Total: 567 becas, incluidas las 18 previas. El respaldo custom se restauró y comparó en una base temporal antes de importar. La repetición omitió los 562 candidatos, con cero creaciones, actualizaciones y errores. La búsqueda y el catálogo institucional públicos conservaron su respuesta. Los resultados y hashes están en [IMPORTACION_LOCAL.json](IMPORTACION_LOCAL.json); el respaldo completo y sus credenciales permanecen privados fuera de Git.

## Archivos y significado

- [originales.jsonl](originales.jsonl): todos los campos históricos, archivo, registro, hash y candidato. Las columnas adicionales y ausentes se registran sin adivinar su desplazamiento; hay 17 registros con advertencias de estructura.
- [indice.csv](indice.csv): 562 identidades candidatas, variantes históricas y referencias. No representa un catálogo certificado.
- [consolidacion.json](consolidacion.json): conteos y hashes de los 93 originales.
- [archivo_administrativo.csv](archivo_administrativo.csv): carga segura con `estado_activa=false` y `solo_crear=true`. Conserva desconocidos y referencias al histórico. Los valores sin evidencia no se incorporan como requisitos válidos.
- [campos_confirmados.json](campos_confirmados.json): evidencia parcial de cinco candidatos MINEDUC, con fuentes, fecha de revisión y límites. Aplicar esos campos mantiene las becas inactivas. Si la beca ya existe, `solo_crear` conserva su versión y la evidencia queda disponible para una corrección editorial posterior.
- `filas.csv`, `duplicados.csv`, `fuentes.csv`, `cuarentena.csv` y `resumen.json`: auditoría HTTP de este subconjunto. HTTP 200 no acredita una convocatoria. `cuarentena.csv` no es el archivo de carga administrativa.

Se repararon de manera reversible identidades con doble codificación y algunas tildes conocidas para agrupar candidatos; los bytes originales y sus variantes quedan conservados. No se reconstruyen caracteres perdidos ni requisitos.

## Revisión oficial y pendientes

Las revisiones documentadas de [Duoc UC/AIEP](../REVISION_DUOC_AIEP.md), [MINEDUC](../REVISION_MINEDUC.md), [Universidad de Talca](../REVISION_UTALCA.md) y [Universidad de los Andes](../REVISION_UANDES.md) son parciales. Registran referencias específicas, coberturas diferenciadas y contradicciones de calendarios. Ninguna constituye confirmación completa para publicar todos los candidatos.

[Universidad de Chile](../REVISION_UCHILE.md) añade siete registros contrastados. [correcciones_uchile.json](correcciones_uchile.json) y su CSV aplicaron siete correcciones parciales al archivo local, manteniéndolo inactivo; los restantes 560 registros permanecieron idénticos. Resultado, hash y restauración previa en [CORRECCION_UCHILE_LOCAL.json](CORRECCION_UCHILE_LOCAL.json). Este CSV permite actualizar únicamente esos siete candidatos ya archivados; no repetirlo sobre registros posteriormente curados sin comparar primero la versión y sus cambios.

Falta contrastar las demás identidades con fuentes oficiales específicas; resolver las 17 estructuras mal formadas y los 59 grupos de variantes; comprobar convocatoria, cierre, requisitos y documentos; y aplicar cada corrección de forma trazable. Una fuente ausente o inaccesible deja el dato pendiente, no prueba que el beneficio no exista. Los datos ya visibles en desarrollo tampoco equivalen a un catálogo editorial certificado.

Preparación reproducible desde la raíz:

```bash
python infra/prepare-processed-corpus.py
python infra/test-prepare-processed-corpus.py
```

El helper usa biblioteca estándar, no descarga fuentes ni importa por sí mismo. Importar únicamente el archivo administrativo mediante el endpoint autenticado, después de respaldar y comprobar restauración. Las columnas opcionales aceptan `true`/`false`: `solo_crear=true` omite becas existentes; `estado_activa=false` permite conservar URL desconocida. Cualquier URL no vacía debe seguir siendo específica y válida. La ausencia de columnas mantiene la compatibilidad del importador anterior.

Validación de esta entrega: 184 pruebas backend, 22 pruebas con PostgreSQL/DDL real, 220 casos Chromium/Firefox y diez recorridos de navegador con backend/PostgreSQL reales. Cuatro pruebas del helper, compile, package, lint y build aprobados. La segunda revisión independiente quedó sin ejecutar por límite de uso; los tres hallazgos requeridos de la primera se corrigieron y se cubrieron con pruebas. No hubo correo, despliegue ni fusión de main.
