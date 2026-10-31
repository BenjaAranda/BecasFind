# Carga administrativa confirmada para P12

Preparada e importada el 26 de octubre de 2026. Instantánea inicial inmutable: 528 creadas; cero actualizadas y cero errores. Estado actual en `CIERRE_SELECCION_2026_10_27.md`; no repetir la carga.

`confirmadas_inactivas.csv` selecciona las 526 candidatas confirmadas esenciales y las dos completas del cierre editorial. Excluye las 40 descartadas. Todas las filas tienen `estado_activa=false` y `solo_crear=true`: la carga es administrativa y no acredita vigencia actual. No cambiar estos indicadores masivamente.

`trazabilidad.json` relaciona cada fila CSV con el hash de candidata, fuentes, informes y referencias originales. Incluye SHA-256 del CSV y los expedientes de entrada. No sobrescribir esta instantánea: las revisiones futuras se generan con `python infra/prepare-p12-catalog.py --output <carpeta_nueva>` y se revisan antes de cualquier operación.

Las esenciales usan el beneficio, requisitos, alcance, límites y documentos de `cierre/casos.json`. No se copian los campos no verificados de los CSV históricos ni se convierten requisitos narrativos a límites RSH/NEM automáticos. Las fechas presentes conservan el alcance histórico del expediente, sin activación. Los siete beneficios que exceden el límite de 255 caracteres de `monto` permanecen íntegros en la descripción larga; ese campo corto queda vacío. Una taxonomía no comprobada se expresa como `No especificado`. Los textos con comas se entrecomillan mediante el escritor CSV, conservando decimales y requisitos literalmente.

Las dos completas conservan los campos de sus CSV específicos. Se sustituye su resumen corto anterior para no describirlas como pendientes de confirmación. Todos los originales permanecen intactos. Una fuente con URL no específica no se traslada al enlace de la ficha; se conserva en la trazabilidad. La ausencia de un enlace admisible solo se permite en estas fichas inactivas.

Antes de importar: respaldo privado del destino, comprobación de restauración aislada y registro de los conteos. Importar con una cuenta ADMIN propia. Después comprobar errores de fila, conteos, repetición sin cambios y UTF-8 en PostgreSQL. No usar credenciales de demostración ni subir respaldos al repositorio. La preparación estructural de este paquete no equivale a una importación probada ni a una revisión actual de fuentes.

La activación requiere una comprobación separada de convocatoria y cierre oficial vigente, registrada por candidata y modalidad. El catálogo público puede seguir vacío después de esta carga.

## Ejecución asistida desde Windows

`infra/import-p12-catalog.ps1` comprueba el SHA-256 revisado y transfiere CSV e importador Python al servidor existente. Usa por defecto la clave protegida `~/.ssh/becasfind`; el usuario introduce su frase directamente en SSH. El importador solicita la contraseña de BecasFind con entrada oculta y utiliza la API de loopback, sin guardar ni imprimir el token. No lee las credenciales Oracle.

Antes de importar, crea un respaldo privado con `pg_dump`, lo restaura en una base temporal nueva y compara conteos y huellas del contenido de las 14 tablas. Elimina únicamente esa base temporal creada por la ejecución; conserva el respaldo. Cualquier fallo de restauración impide importar. Después comprueba el resultado de la API, el aumento de filas, la ausencia de nuevas activaciones y patrones de doble codificación. No ejecuta una activación ni un cambio de plan.

Pruebas locales: `python infra/test-import-p12-catalog.py` comprueba rechazo de un CSV modificado, bloqueo de importación si falla restauración y detención ante errores de filas. La sintaxis PowerShell se comprueba por separado. Estas pruebas no equivalen a haber ejecutado SSH, restauración o importación contra Oracle.

## Resultado posterior

Selección del 27/10: cinco activas; 57 cerradas; 466 con vigencia no acreditada. Todas conservadas y con decisión individual. Correo y recorridos reales comprobados; ver `prueba_recuperacion_2026_10_27.json` y `recorridos_web_2026_10_27.json`. Los informes iniciales no reflejan las seis correcciones posteriores; la conciliación final conserva los 528 UUID.
