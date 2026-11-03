# Revisión editorial: Universidad de Talca

Consulta oficial el 30 de septiembre de 2026. Alcance: diez filas históricas que corresponden a siete nombres de beneficios. No se modifican originales ni base de datos. Este informe es evidencia parcial, no un archivo importable.

## Contraste con la fuente

Fuente: [Becas y ayudas de la Universidad de Talca](https://admision.utalca.cl/becas/).

| Beneficio histórico | Información contrastada |
|---|---|
| Universidad de Talca | Arancel anual o 22 UTM según condiciones; NEM 6,3 y criterios de posición relativa. |
| Más alto puntaje PAES | Arancel anual o 22 UTM; mayor promedio de Competencia Lectora y Matemática 1 entre matriculados. |
| Mejores Puntajes Regionales PAES | Arancel o dinero; mejor promedio regional. Sin importe fijo confirmado. |
| Excelencia Deportiva | Arancel o dinero; admisión especial deportiva y representación universitaria. |
| Abate Molina | 75 % del arancel anual; hijos de funcionarios de planta/contrata o estudiantes bajo su cuidado judicial, con condiciones adicionales. |
| Apoyo para Mujeres Ingenieras | Aporte mensual sin importe confirmado; ingenierías que exigen M2, ranking superior 30 % y acreditación socioeconómica. |
| Arancel para Pedagogías | Exención anual; ranking superior 30 %, matrícula regular y ausencia de otro beneficio de arancel completo. |

Deportiva menciona egreso «hace al menos dos años»; confirmar en bases, sin invertirlo a un máximo. El título del sitio dice admisión 2027, pero estas secciones no aportan cierres fechados ni una lista universal de documentos.

## Decisiones para preparar una corrección

- Conservar coberturas alternativas en texto. No convertir UTM ni crear un único importe que represente simultáneamente exención y dinero. Las unidades indexadas permanecen fuera del alcance aprobado.
- No convertir posiciones de ranking a NEM, PAES o RSH. Una acreditación socioeconómica no autoriza inventar un tramo RSH.
- Mantener fechas/documentos desconocidos hasta obtener evidencia individual; no usar 2026-12-31 por defecto ni heredar el calendario FUAS de beneficios MINEDUC.
- Corregir tildes en nombres preparados para futuras filas, conservando la referencia del registro histórico. Las coincidencias de nombre son candidatos a duplicado, no prueba de identidad de convocatoria.

## Duplicados trazables

Referencias tomadas de `filas.csv`; números de registro de datos, sin contar cabecera. Prefijo común: `ScrapperBecasFind/data_lake_becas/03_procesados/`.

| Candidato | Primera referencia | Segunda referencia | Resolución actual |
|---|---|---|---|
| Excelencia Deportiva | becas_utalca.csv, registro 4 | bloque5_docs.csv, registro 4 | Comparar contenido completo, convocatoria y documentos antes de fusionar. |
| Arancel para Pedagogías | becas_utalca.csv, registro 7 | bloque5_docs.csv, registro 5 | Comparar contenido completo, convocatoria y documentos antes de fusionar. |
| Abate Molina | becas_utalca.csv, registro 5 | bloque5_docs.csv, registro 6 | Comparar contenido completo, convocatoria y documentos antes de fusionar. |

El lote suma siete beneficios contrastados, no diez beneficios distintos. Las diez filas permanecen en cuarentena. Pendiente: bases y calendario por convocatoria, documentos específicos y comparación de originales para resolver los tres pares sin perder información.
