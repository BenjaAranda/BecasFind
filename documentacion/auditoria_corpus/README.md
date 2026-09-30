# Auditoría del corpus — 30 de septiembre de 2026

Se revisaron 94 CSV y 645 filas del data lake del repositorio, sin modificar originales ni importar a la base del usuario. Hay 577 claves normalizadas y 48 grupos de posibles duplicados. La normalización es una señal para revisión, no una autorización para fusionar becas.

Se comprobaron 387 URLs: 294 respondieron HTTP 200 y las restantes tuvieron errores de red, dirección o servidor. HTTP 200 no confirma que una página sea oficial ni valida fechas, requisitos, cobertura o documentos. Hay 262 cierres 2026-12-31 que requieren evidencia individual; no se declara que todos sean ficticios.

- `filas.csv`: hallazgos por fila y ubicación original.
- `duplicados.csv`: grupos candidatos para revisión.
- `fuentes.csv`: estado HTTP, fecha de comprobación y hash del contenido recibido.
- `cuarentena.csv`: copia segura sin requisitos, documentos, fechas ni cobertura numérica que no se hayan confirmado. No publica vigencia.
- `resumen.json`: cifras reproducibles.

Ejecutar `python infra/audit-scholarship-corpus.py --check-links` para actualizar la auditoría. Requiere Python 3.11 o posterior, solo biblioteca estándar. No descarga documentos privados ni supera autenticación. El scraper externo no fue modificado.

La verificación editorial por fuente y el enriquecimiento histórico continúan pendientes: las 645 filas están en cuarentena porque no poseen evidencia completa revisada. Los hallazgos no deben presentarse como datos confirmados. Para liberar una fila deben comprobarse institución/fuente oficial, enlace específico, convocatoria, fecha, requisitos, documentos y cobertura. Si una información no aparece, mantenerla desconocida.

## CSV estructurado

El formato antiguo sigue válido. Columnas opcionales: `cobertura_tipo,cobertura_importe,cobertura_moneda,cobertura_periodicidad,cobertura_porcentaje`. Si se añade cualquier columna de cobertura, incluir `cobertura_tipo`; tipo vacío equivale a DESCONOCIDA y solo admite otros campos vacíos. MONETARIA requiere moneda ISO válida cuando hay importe; PORCENTUAL admite 0–100. Precisión de dos decimales, sin separadores de miles. No convertir UF/UTM/divisas.

Omitir las columnas conserva metadatos cuando el texto original no cambia. DESCONOCIDA los elimina expresamente. La validación de todas las filas precede a las escrituras; cualquier error revierte el archivo completo. Fechas vacías permanecen nulas y no se consideran vigentes. La migración 004 permite cierres desconocidos sin alterar fechas históricas existentes.
