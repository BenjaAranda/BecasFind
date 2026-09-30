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

Pendiente fuera de estas fases: controles administrativos para editar metadatos (FASE 10), explicación visible del orden por grupos (FASE 9) y enriquecimiento del corpus mediante fuentes verificadas/importación estructurada (FASE 14). Los registros históricos sin metadatos no se convierten mágicamente en importes ordenables.
