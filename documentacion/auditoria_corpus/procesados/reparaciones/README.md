# Recuperación estructural del histórico

Entrega del 1 de octubre de 2026. Diez archivos tenían 17 registros lógicos mal formados. El manifiesto revisado permite reconstruir 23 filas físicas mediante tres reparaciones concretas: cierre de comillas antes de URL, eliminación de columna vacía de región y reunión de fragmentos de descripción.

Los seis registros adicionales estaban absorbidos por descripciones de ENAC/IPCHILE. El inventario reconstruido pasa de 641 a 647 registros y de 562 a 568 candidatos. No se suman las 23 filas al inventario anterior: sustituyen sus 17 registros afectados. Los 93 originales permanecen intactos; el índice y la consolidación iniciales siguen siendo fotografías de la primera entrega.

- `estructura_reparada.csv`: texto histórico reconstruido; no importar como datos confirmados.
- `reparados.jsonl`: línea original, hash, ubicación física y registro lógico anterior, reparación y campos recuperados.
- `recuperados_administrativos.csv`: seis identidades nuevas inactivas, con requisitos, cobertura, fechas y documentos desconocidos; solo creación.
- `IMPORTACION_LOCAL.json`: seis creadas, cero actualizadas/errores; repetición omitió las seis. Los 567 registros anteriores se conservaron exactamente; total local 573. Respaldo restaurado antes de importar; búsqueda y catálogo públicos conservados.

Las 17 anomalías estructurales identificadas están resueltas. Continúan la confirmación editorial y los 59 grupos de variantes; esta reparación no certifica campos históricos. [Revisión oficial parcial](../../REVISION_ENAC_IPCHILE.md).

Desde la raíz:

```bash
python infra/recover-malformed-corpus.py
python infra/test-recover-malformed-corpus.py
```

El helper valida las huellas de contenido con saltos LF, la estructura completa de cada archivo afectado y los límites revisados antes de escribir. No modifica originales, consulta fuentes ni importa a la base. No reutilizar una carga histórica para sobrescribir registros posteriormente curados.
