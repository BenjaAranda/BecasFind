# P12: despliegue de prueba y selección del catálogo

## Seguimiento de 31 fichas aplicado — 2 de noviembre de 2026

**31 seguimientos individuales, siete fichas modificadas y cinco dictámenes precisados**: Paine (51/378) y UDD NEM (158) sin calendario publicado; UANDES Funcionario (331) y Armada (376) con anuncio de postulaciones cerradas. Los Muermos (127) incorpora reglamento histórico de 2022 sin extrapolarlo; Constitución (357) corrige su enlace municipal. Quedan **103 inconclusas**: 26 de esta tanda y 77 no reconsultadas aquí. Siete consultas limitadas: 218, 231, 240, 248, 312, 513, 515. No se declara concluida la investigación.

Catálogo público verificado: **528 fichas; 11 abiertas, 132 cerradas, 282 fechas por confirmar y 103 en revisión**. Cero activaciones/eliminaciones. 528 UUID y originales conservados; 521 filas ajenas y 13 tablas idénticas. Respaldo/restauración de 14 tablas aprobados. El intento inicial de renombrado de Paine se revirtió por restricción única; el bloque aplicado conserva nombres. Solo se actualizó el recurso backend de 103 UUID; clases/dependencias y temporizador FUAS sin cambios.

Fuente vigente: `documentacion/auditoria_corpus/procesados/seguimiento_incertidumbres_31_2026_11_02/INFORME.md`, `avance.json`, `inventario_466.json`, `incertidumbres_103.csv`, `revision_31.csv` y `consultas_limitadas_7.csv`.

- [x] Documentar 31 seguimientos y aplicar/verificar siete correcciones sustentadas.
- [ ] Resolver las 103 incertidumbres según el campo y límite individual; no sustituir evidencia faltante por probabilidad.
- [ ] Recuperar fuentes suficientes para las siete consultas limitadas actuales y reconsultar las otras 77 inconclusas.

No repetir los SQL aplicados de 54, 96 o siete ni ejecutar el intento revertido. Ante nueva evidencia, nuevo bloque con respaldo y guardas. P13/P14 y promoción a producción no iniciadas. Los encabezados siguientes son cortes históricos.

## Incertidumbres: tanda de 96 aplicada — 2 de noviembre de 2026

Aplicadas y verificadas **96 fichas adicionales**: nueve dictámenes precisados y 87 inconclusos; ocho consultas limitadas por acceso o recuperación parcial. Las 150 reabiertas tienen ahora notas de reconsulta (54 + 96): **42 dictámenes precisados y 108 inconclusos**. Esto no significa que todas las convocatorias actuales estén leídas o que todos los campos estén resueltos.

Catálogo verificado: **528 fichas; 11 abiertas, 132 cerradas, 277 fechas por confirmar y 108 en revisión**. Cero activaciones/eliminaciones en esta tanda. 528 UUID y originales conservados; 432 fichas y 13 tablas ajenas idénticas, respaldo/restauración de 14 tablas aprobado. Solo se publicó el recurso backend de 108 UUID; clases y dependencias idénticas. Temporizador FUAS de siete UUID sin cambios.

Fuente vigente: `documentacion/auditoria_corpus/procesados/reconsulta_incertidumbres_96_2026_11_02/INFORME.md`, `inventario_466.json`, `avance.json`, `incertidumbres_108.csv` y `consultas_limitadas_8.csv`. No repetir el SQL de 96 ni el de 54; no regenerar expedientes aplicados con borradores de `tmp/`. P13/P14 y promoción a producción no iniciadas.

- [x] Aplicar y verificar las 96 notas/correcciones, preservando UUID y originales.
- [x] Precisar cinco adjudicaciones 2026, Talcahuano sin cupos y calendario cerrado de Tucapel y prestaciones publicadas de Huasco/Monte Patria.
- [ ] Recuperar fuentes actuales suficientes para las ocho consultas limitadas (68, 202, 218, 240, 248, 312, 357, 463).
- [ ] Resolver los campos sustentables de las 108 inconclusas según su límite individual; conservar desconocidos y contradicciones cuando no haya prueba pública suficiente.

Los encabezados siguientes conservan cortes históricos y no sustituyen este estado.

## Incertidumbres: primer bloque de 54 aplicado — 2 de noviembre de 2026

Investigación reabierta sobre 150 fichas: **54 con nueva revisión individual; 33 dictámenes precisados y 21 inconclusos; 96 sin nueva revisión individual todavía**. Aplicadas y conciliadas las 54; tres activaciones (Nuevo Milenio II y dos fichas BEA Mineduc) con cierre automático FUAS del 05/11/2026 a las 14:00 de Santiago. Catálogo comprobado: **528 fichas; 11 abiertas, 131 cerradas, 269 fechas por confirmar y 117 en revisión**. Cero eliminaciones y 528 UUID preservados.

Fuente vigente: `documentacion/auditoria_corpus/procesados/resolucion_incertidumbres_150_2026_11_02/INFORME.md`, `inventario_466.json`, `avance.json`, `sin_reconsulta_96.csv` e `incertidumbres_117.csv`. Las cifras de las secciones anteriores son históricas. No repetir el SQL de 54 ni regenerar el expediente aplicado con los borradores de `tmp/`. Los 33 dictámenes precisados no significan 33 fichas sin incógnitas. P13/P14 no iniciadas.

- [x] Aplicar y comprobar el bloque de 54 con respaldo/restauración de 14 tablas y originales conservados.
- [ ] Reconsultar individualmente las 96 restantes y continuar con las contradicciones de las 21 inconclusas de este bloque.
- [ ] Completar la petición de resolver todas las incertidumbres sustentables; conservar explícitamente los datos que la fuente no publique.

Los apartados siguientes conservan los cortes anteriores y no sustituyen el estado de este encabezado.

Actualización vigente del 01/11/2026: [revisión de las 177 restantes](../documentacion/auditoria_corpus/procesados/cierre_vigencia_177_2026_11_01/INFORME.md). 177 dictámenes publicados; 27 precisados, 150 inconclusos. Catálogo: 528 fichas; 8 abiertas, 121 cerradas, 249 fechas por confirmar y 150 en revisión. Siete calendarios cerrados y ocho coberturas precisados; cero activaciones/eliminaciones. 177 fichas distintas, 178 operaciones por aclaración posterior de Río Verde. Respaldos/restauraciones de 14 tablas y conciliación de textos/UUID comprobados. Recurso de 150 UUID en revisión compilado; imagen `sha256:93c82c8c205cebf7991365ee28c02758e064b097e8bb59f273181295b45f9ff8`. Frontend y preview conservados; no repetir los SQL; no iniciar P13/P14 ni promover producción. Los cortes siguientes son históricos.

Actualización del 01/11/2026: [seguimiento de 62 becas](../documentacion/auditoria_corpus/procesados/seguimiento_vigencia_62_2026_11_01/INFORME.md). Diez correcciones aplicadas y verificadas; cero activaciones/eliminaciones. 528 fichas: 8 abiertas, 114 cerradas, 229 fechas por confirmar y 177 en revisión. 528 UUID y textos originales conservados; 518 filas idénticas. Respaldo/restauración de 14 tablas comprobados. Backend base 37ae1a1, solo recurso de clasificación actualizado a 177 UUID; imagen `sha256:f07168fce54534b9d1cadee2032c2fd39bcf9104e7317a68eadbc7d57b63a3d7`. Preview y frontend conservados; P13/P14 no iniciadas. Los apartados siguientes son cortes anteriores.

Actualización del 30/10/2026: [auditoría y aplicación del corte](../documentacion/auditoria_corpus/procesados/auditoria_vigencia_corte_2026_10_29/INFORME_CIERRE.md). 56 cambios de fichas comprobados en dos bloques; 54 calendarios cerrados y dos activaciones ministeriales. Catálogo: 528 fichas; 8 abiertas, 112 cierres vencidos, 221 fechas por confirmar, 187 en revisión. BUCH cerró según su temporizador. Imagen backend `sha256:1a0d0bf97a0de850846e4bea63dd7b7a5829a4c9f3dbe58bcba9f61a1df78c11`; código base 37ae1a1 con recurso de UUID actualizado. Frontend y preview conservados. No repetir SQL ni iniciar P13/P14. Los cortes de abajo son históricos.

Actualización del 28/10/2026: catálogo público con estados desplegado en [nueva preview](https://becasfind-pf8timp72-benjatlou13-1274.vercel.app/explorar), frontend `719646b` y backend `37ae1a1`. Acceso anónimo a 528 fichas, selector de 323 instituciones y filtro de siete postulaciones abiertas verificados. Las 528 filas permanecen idénticas; no se activaron masivamente ni se modificaron datos. Respaldo y restauración previa comprobados. Evidencias: `documentacion/P12_CATALOGO_PREVIEW_2026_10_28.json` y `documentacion/P12_CATALOGO_APLICACION_2026_10_28.json`. Los apartados siguientes conservan el corte histórico del 27/10. No se promovió producción ni se iniciaron P13/P14.

Actualizado el 27 de octubre de 2026. Trabajo operativo completado en la preview; controles finales de GitHub asociados al commit de esta entrega. P13/P14 no iniciadas. El usuario asignó el control de P12 a este chat; no ejecutar cambios concurrentes ni repetir importaciones.

**Ampliación de esta entrega:** el usuario solicitó una auditoría individual nueva de las 466 fichas cuya vigencia no quedó acreditada. Está en curso según `tasks/PROMPT_AUDITORIA_VIGENCIA.md`; sus hallazgos y aplicación se registran en `documentacion/auditoria_corpus/procesados/auditoria_vigencia_2026_10_27/`. El cierre técnico de preview no cierra esta investigación. Los conteos siguientes son el corte previo, hasta conciliación posterior documentada.

## Estado comprobado

| Elemento | Resultado |
|---|---|
| Oracle existente | Ubuntu 22.04 ARM64; 2 OCPU/12 GB; PostgreSQL 17.11; sin recursos nuevos de pago. |
| API HTTPS | https://155-181-41-231.sslip.io ; HTTP 301; TLS, renovación y reinicio ya comprobados. |
| Preview Vercel | https://becasfind-afeqpkmym-benjatlou13-1274.vercel.app ; origen CORS exacto. |
| Backend | Perfil prod; usuario UID 999; solo 127.0.0.1:8080; memoria 2 GB; capacidades retiradas y privilegios nuevos deshabilitados. |
| Base | Contenedor becasfind-db sin puerto público; volumen preservado; 14 tablas. |
| Catálogo | 528 fichas; 528 UUID únicos; 5 activas; 57 cerradas; 466 con calendario desconocido o vigencia no acreditada. |
| Correo | Gmail SMTP gratuito habilitado; STARTTLS y autenticación desde Oracle; entrega y recuperación reales aprobadas. |
| Web | Acceso público, filtros, detalles, ADMIN/STUDENT, perfil, recomendaciones y favoritos comprobados en navegador. |

La preview conserva su configuración de acceso Vercel. Búsqueda y detalle no exigen una sesión de BecasFind. Esta entrega no equivale a promoción pública final de P14.

## Catálogo y evidencia

La importación inicial creó 528 fichas inactivas sin errores; no se repitió. El CSV y el manifiesto son instantáneas inmutables. Su SHA-256 es `757cec62e2dcb3ac980c65bc4a33c2ea204b6c2eba1b9d536188108400732d16`.

La conciliación inicial encontró igualdad de todos los campos importados. La final conserva los UUID y solo seis fichas presentan cambios justificados: UDD y las cinco publicables. Se retiraron fechas de clases UDD, se actualizaron convocatorias, tipo y nivel de ingreso, y NEM de Nuevo Milenio I. Los documentos exigidos de UANDES y los condicionales UChile también aparecen en su sección visual. Los textos públicos ya no muestran hashes ni notas de ejecución. Cero patrones bytea corruptos en PostgreSQL; no se hicieron reparaciones masivas de tildes.

Las cinco activas son BUCH, Hijos de Funcionarios UChile, UANDES Económica, Nuevo Milenio I y Gratuidad. Temporizadores systemd cierran BUCH el 30/10/2026 a las 12:00 y las dos FUAS el 05/11/2026 a las 14:00 de Santiago. Se comprobaron activos y una ejecución anticipada no desactivó fichas.

La selección tiene decisión individual para las 528. Las 466 sin evidencia suficiente de vigencia permanecen inactivas y requieren nueva evidencia antes de activarse. No se declaran falsas ni se descartan. La revisión fue limitada a expedientes y calendario; las 320 recuperaciones de texto y 59 barreras de acceso no equivalen a 379 lecturas íntegras ni certificaciones automáticas. Ver [cierre de selección](../documentacion/auditoria_corpus/procesados/despliegue_p12/CIERRE_SELECCION_2026_10_27.md).

Antes de cada bloque de cambios de datos se generó respaldo privado y se verificó restauración aislada de las 14 tablas. Los respaldos permanecen en `/home/ubuntu/.local/state/becasfind/backups/`. No se modificó la base local ni se fusionaron modalidades o UUID.

## Recuperación y recorridos

Gmail usa secretos en `~/.config/becasfind/backend.env`, con permisos privados. La contraseña de aplicación se obtuvo de la configuración local existente y se comprobó; no aparece en Git. No se contrató Resend ni otro plan. Se conservó detenido el contenedor previo `becasfind-api-pre-gmail` para reversión de configuración.

La cuenta Gmail dedicada del usuario se registró como STUDENT para aceptación. Se verificaron entrega del enlace HTTPS de la preview, cambio de contraseña, nuevo login, reutilización rechazada y sesión anterior invalidada. Se guardó un perfil sin datos personales inventados; favoritos se crearon y retiraron. No se cambió la contraseña del administrador. Las credenciales de esa cuenta permanecen exclusivamente en el directorio privado de Oracle. No se forzó ni esperó la expiración de 15 minutos en producción; esa regla ya tiene pruebas en P09.

Las comprobaciones de API HTTPS y los recorridos reales pasaron. La consola consultada no registró errores/avisos. La recarga que coincidió con el reinicio de la API mostró un error recuperable; Reintentar volvió a cargar y las pruebas finales pasaron.

## Verificaciones y referencias

- [Conciliación final](../documentacion/auditoria_corpus/procesados/despliegue_p12/conciliacion_oracle_2026_10_27.json).
- [Selección individual](../documentacion/auditoria_corpus/procesados/despliegue_p12/seleccion_publicacion_2026_10_27.json).
- [API](../documentacion/auditoria_corpus/procesados/despliegue_p12/pruebas_api_2026_10_27.json), [recuperación real](../documentacion/auditoria_corpus/procesados/despliegue_p12/prueba_recuperacion_2026_10_27.json), [navegador](../documentacion/auditoria_corpus/procesados/despliegue_p12/recorridos_web_2026_10_27.json) y [compilación/operación](../documentacion/auditoria_corpus/procesados/despliegue_p12/verificacion_tecnica_2026_10_27.json).
- Imagen Oracle: `sha256:0cb720bf46390beac784d44ef52aee06aad0383fd5cb63cbc871093be37a3d70`.
- Preview: deployment `dpl_Ho3tTsrGuWPfE14NMhmsnRCM8Yys`; frontend del commit `cdbf84cc7d3aeeee2171eb4bbca11d328adb0ee7`. No hubo cambios de interfaz en esta entrega.
- Backend compilado en Oracle con `mvn -q compile`, salida 0; mismas fuentes locales y remotas, hash en el informe técnico.
- Tres pruebas de protección de importación aprobadas; una integración PostgreSQL local omitida. Restauraciones reales verificadas en Oracle.
- [Parche de dependencias](../documentacion/P12_DEPENDENCIAS_2026_10_27.md): Vite, follow-redirects y Zod actualizados dentro de sus rangos. Auditoría local sin vulnerabilidades, lint y build aprobados. El lockfile nuevo no se presenta como desplegado en la preview anterior.
- La [bitácora anterior](../documentacion/historial/P12_DESPLIEGUE_ANTES_CONSOLIDACION_2026_10_26.md) conserva cortes históricos; no usar sus pendientes como estado actual.

## Trabajo posterior

P13 requiere autorización por fase para completar operación y rollback. P14 requiere su autorización para promover/publicar el destino final. Las nuevas convocatorias de las fichas inactivas deberán pasar el mismo control; no activar masivamente por el mero cierre de P12. Coste objetivo $0; no se autorizaron compras ni mejoras a planes de pago.
