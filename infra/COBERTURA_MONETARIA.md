# Cobertura estructurada

Implementación de FASES 1, 2 y 5 autorizadas juntas el 30 de septiembre de 2026. No modifica NEM ni infiere información histórica.

`montoCobertura` conserva el texto original. `cobertura` es un objeto opcional en las escrituras y presente en las respuestas de búsqueda, administración, detalle y favoritos:

```json
{
  "montoCobertura": "Hasta 600.000 pesos por año",
  "cobertura": {
    "tipo": "MONETARIA",
    "importe": "600000.00",
    "moneda": "CLP",
    "periodicidad": "ANUAL"
  }
}
```

Tipos: MONETARIA, PORCENTUAL, NO_MONETARIA, DESCONOCIDA. En MONETARIA, importe admite cero, hasta 16 dígitos enteros y dos decimales; si hay importe debe haber moneda ISO 4217 reconocida por Java. Importe/periodicidad pueden ser desconocidos y permanecer nulos. No usar UF como moneda ISO; conservar esos beneficios como texto desconocido hasta definir un modelo de unidades indexadas.

PORCENTUAL permite porcentaje conocido entre 0 y 100, con dos decimales, sin importe/moneda/periodicidad. NO_MONETARIA y DESCONOCIDA no permiten campos monetarios ni porcentaje. Los importes y porcentajes se devuelven como cadenas JSON para evitar pérdida de precisión en JavaScript.

Omitir `cobertura` conserva los metadatos si el texto original no cambia. Cambiar el texto sin enviar metadatos los reinicia a DESCONOCIDA: un importe anterior no debe describir un beneficio nuevo. Enviar explícitamente `{"tipo":"DESCONOCIDA"}` elimina los metadatos. Esta regla también protege actualizaciones CSV mediante el setter de la entidad. El formato CSV histórico continúa conservando texto; no genera metadatos automáticamente.

`montoAsc`/`montoDesc` colocan primero las coberturas con importe conocido, agrupan por moneda y periodicidad en orden ascendente y ordenan numéricamente dentro de cada grupo. La dirección solo afecta al importe. Los empates usan ID ascendente; porcentajes, ayudas sin importe y datos desconocidos quedan al final. No anualiza pagos ni aplica tipos de cambio. Fecha/filtros/paginación conservan su comportamiento.

## Instalación y compatibilidad

Base vacía: instalar `infra/ddl.sql`. Base existente: guardar y comprobar un respaldo, detener escrituras y aplicar con psql y ON_ERROR_STOP la migración `infra/migrations/002_structured_coverage.sql` **antes** de arrancar el nuevo backend. El perfil prod conserva ddl-auto validate; no se migra automáticamente. CREATE TABLE IF NOT EXISTS del DDL no actualiza una tabla existente.

La migración es transaccional y repetible. Añade columnas con valor DESCONOCIDA y nulos para el histórico, sin cambiar texto ni requisitos. No se ha aplicado a la base local del usuario. Para volver al backend anterior, conservar las columnas adicionales y los metadatos: el código anterior no los utiliza. No eliminarlos para hacer rollback; restaurar un respaldo solo con un plan que preserve escrituras posteriores.

`infra/verify-profile-postgres.ps1 -MavenPath <mvn.cmd> -TestClasses MonetaryCoverageTest` ejecuta primero la comprobación SQL de migración y después siete pruebas sobre el DDL real con Hibernate validate. La comprobación SQL usa un esquema temporal: tildes/texto originales, migración repetida antes/después de añadir metadatos y rechazo de datos incoherentes. Los casos Java verifican grupos, decimales, cero, empates, páginas, favoritos, compatibilidad de escrituras, límites HTTP y persistencia entre solicitudes.

P01/P02 implementados: administración edita/vacía cobertura sin perder precisión y el buscador explica grupos. P04 añade columnas CSV opcionales validadas y auditoría/cuarentena del corpus; los originales no se modifican ni se consideran confirmados. Véase documentacion/auditoria_corpus/README.md.

## Migraciones posteriores (P03–P05)

Aplicar 002, 003, 004 y 005 en ese orden antes del backend actualizado, con respaldo comprobado, escrituras detenidas y `ON_ERROR_STOP`. No se aplicaron a la base del usuario. La 003 asigna UUID estables; 004 permite cierres desconocidos y conserva fechas existentes; 005 añade versión y convierte tres generadores IDENTITY en secuencias ordinarias conservando IDs y avance. Hibernate prod sigue validando, sin modificar esquema.

La administración devuelve `version` y el formulario la reenvía. Cada actualización del agregado incrementa versión, incluso si solo cambia requisitos/documentos. Un formulario obsoleto recibe 409 y conserva sus campos para revisarlos; volver a abrir la beca obtiene la versión vigente. Los UUID públicos no incluyen esta versión interna.

Las importaciones se serializan mediante bloqueo transaccional de la fila ADMIN, que debe existir en el esquema instalado. Resuelven catálogos antes de encolar INSERT y precargan becas por nombres del archivo (máximo 5000 filas). Para Beca/RequisitoPerfil/DocumentoRequerido se usan secuencias con allocationSize=1. Un fallo revierte todo el archivo; los huecos de secuencia tras rollback son normales.

`CsvBatchTest` observa addBatch/executeBatch JDBC: 51 becas produjeron lotes [50, 1] con PostgreSQL 17. Antes del cambio el mismo caso observaba cero lotes. No implica una cifra de throughput ni garantiza batches iguales cuando se mezclan escrituras de otras clases. `ScholarshipConcurrencyTest` cubre editores obsoletos, transacciones simultáneas, cambios exclusivos de documentos e importaciones/catálogos concurrentes. La comprobación SQL repite 004/005 y conserva una secuencia adelantada, fechas e IDs.
