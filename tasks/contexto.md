# Contexto operativo de BecasFind

Actualizado el 27 de octubre de 2026. Fuente de trabajo: `PLAN_MEJORAS.md`; detalles y evidencia: `infra/P12_DESPLIEGUE.md`. Este chat asume P12 por petición del usuario. No coordinar escrituras concurrentes ni repetir lo aplicado.

## Trabajo activo: auditoría de las 466

El usuario reabre expresamente la investigación individual de vigencia según `tasks/PROMPT_AUDITORIA_VIGENCIA.md`. La selección conservadora anterior no equivale a investigación concluida. Fuente vigente de avance: `documentacion/auditoria_corpus/procesados/auditoria_vigencia_2026_10_27/avance.json`; inventario y evidencia por UUID en esa misma carpeta. No usar «cero pendientes» de P04 para cerrar esta auditoría distinta. No hay autorización para P13/P14 ni cambios masivos de activación.

Dos bloques de datos aplicados con restauración verificada: Deportiva UNAB (314) activada con cierre 31/01/2027; UAlumni (518) conserva inactividad y registra cierre 25/09/2026; Alimentación UANDES (445) activada exclusivamente para ingreso 2027, cierre 28/01/2027. Estado posterior: siete activas, 58 cierres vencidos y 463 cierres desconocidos en BD. El inventario fijo de investigación sigue siendo 466. Evidencia en `aplicacion_lote_01.json` y `aplicacion_lote_02.json`. No repetir esos SQL: las tres versiones ahora son 1.

Primera pasada sobre las 466 fichas y seguimiento visual de Concón: 267 con conclusión limitada al alcance documentado y 199 inconclusas. Cero sin recorrer no significa auditoría terminada: los escaneos no leídos, barreras y contradicciones permanecen pendientes por UUID. No equivale a 267 becas abiertas. Juan Gómez Millas y Bicentenario tienen calendario FUAS 2027 acreditado, pero su aplicación sigue pendiente de conciliación de condiciones. La ficha 490 dice San Pedro de la Paz y enlaza San Pedro de Melipilla: no trasladar su calendario ni corregir institución sin conciliar candidata original.

El catálogo público con estados claros se desplegó en preview el 28/10: `https://becasfind-pf8timp72-benjatlou13-1274.vercel.app`. Frontend `719646b`; backend `37ae1a1`, con selector de las 323 instituciones del catálogo. Comprobadas las 528 fichas: 7 abiertas, 58 con cierre registrado vencido, 264 con fechas por confirmar y 199 en revisión. Las 528 filas y todos sus campos permanecen idénticos antes/después; restauración previa de 14 tablas comprobada. Búsqueda, filtros, detalle y acceso sin sesión verificados. Evidencia en `documentacion/P12_CATALOGO_PREVIEW_2026_10_28.json`. Se conservaron correo, orígenes anteriores y contenedores para reversión; no hay promoción a producción ni cierre de investigación documental.

## Estado actual

Corrección de campos del 28/10: 173 fichas revisadas en cuatro lotes; 165 modificadas y verificadas en Oracle y API pública. Se corrigieron 164 categorías (163 desconocidas y una incorrecta) y se recuperaron tres beneficios vacíos. Quedan 359 categorías «No especificado», individualizadas en `documentacion/auditoria_corpus/procesados/correccion_campos_2026_10_28/pendientes_tipo.csv`. Los cuatro SQL están aplicados: no repetirlos. Copias privadas previas y restauraciones de 14 tablas verificadas; categorías/beneficios y versiones fueron los únicos cambios. No se alteraron los estados de postulación. El lote municipal reutiliza hechos documentados: no es una nueva confirmación de convocatorias. Leer el README y `avance.json` de esa carpeta para límites y contradicciones, especialmente Cunco/Villa Alegre (14). Esta revisión de campos no está terminada y no sustituye la auditoría de vigencia.

- P04 cerrada: 568 candidatas; 526 esenciales; dos completas; 40 exclusiones editoriales; cero pendientes editoriales. Los 23 descartes del último cierre son por evidencia insuficiente, no por falsedad.
- P12 operativamente completada en preview: Oracle y Vercel conectados; HTTPS/CORS/reinicio comprobados; Gmail habilitado y recuperación real aprobada; recorridos públicos, ADMIN y STUDENT aprobados. Verificación final de GitHub en la entrega vigente.
- Corte previo a la auditoría: 528 becas y UUID; cinco activas, 57 cerradas y 466 sin vigencia acreditada. Es un antecedente histórico; el estado posterior a las correcciones está arriba. No hubo nuevos descartes ni eliminaciones.
- Activas después de los dos bloques: BUCH; Hijos de Funcionarios UChile; UANDES Económica; Nuevo Milenio I; Gratuidad; Deportiva UNAB; Alimentación UANDES. Temporizadores específicos BUCH 30/10/2026 12:00 y FUAS 05/11/2026 14:00, Santiago.
- Diferencias contra la carga inicial: seis fichas justificadas en la selección original más 314, 518 y 445 en esta auditoría. El CSV inicial y su manifiesto siguen inmutables; no regenerarlos encima ni reimportarlos.

## Entorno y continuidad

- Repositorio: `BenjaAranda/BecasFind`, rama `bugfix/security-and-recovery`; commits en español. No reescribir historial ni promover producción.
- Oracle existente: `ubuntu@155.181.41.231`, directorio `/home/ubuntu/becasfind-p12`; clave privada `~/.ssh/becasfind`. Secretos solo en configuración privada; no imprimirlos ni pedirlos por chat.
- API: https://155-181-41-231.sslip.io . Preview vigente del catálogo: https://becasfind-pf8timp72-benjatlou13-1274.vercel.app . Frontend `719646b`; backend `37ae1a1`. La preview anterior `afeqpkmym` es histórica y no contiene el catálogo completo por defecto. Origen CORS exacto y FRONTEND_URL de la preview vigente.
- Gmail SMTP usa la configuración privada de Oracle. Cuenta dedicada STUDENT del usuario validada; contraseña de acceso en `~/.local/state/becasfind/cuenta-propia-validacion.json`, exclusivamente en Oracle. No modificar credenciales ADMIN. Contenedor anterior detenido `becasfind-api-pre-gmail` conservado para reversión.
- Respaldos privados y restauraciones aisladas de 14 tablas comprobados antes de cambios. No tocar la base local, volúmenes ni originales.
- No usar Firecrawl ni contactar instituciones. Solo fuentes públicas oficiales. No crear recursos de pago ni comprar dominio.
- P13/P14 pendientes de autorización por fase; P12 no equivale a publicación final.

## Evidencia para retomar

En `documentacion/auditoria_corpus/procesados/despliegue_p12/`: `CIERRE_SELECCION_2026_10_27.md`, `seleccion_publicacion_2026_10_27.json`, `conciliacion_oracle_2026_10_27.json`, `pruebas_api_2026_10_27.json`, `prueba_recuperacion_2026_10_27.json`, `recorridos_web_2026_10_27.json` y `verificacion_tecnica_2026_10_27.json`. Los informes del 26/10 son cortes anteriores, no estados actuales.

Los detalles editoriales siguen en `cierre/casos.json`, los informes referenciados y `avance/resumen.json`. Tras cambios probatorios: `python infra/report-corpus-progress.py`, `python infra/audit-editorial-evidence.py`, `git diff --check`. No reinvestigar indiscriminadamente la cohorte cerrada ni inventar renovación anual. Los planes históricos están en `documentacion/historial/`.

Preservar archivos personales sin seguimiento: `BecasFind - ET.docx` y `spa.traineddata`. Los temporales de evidencia en `tmp/` están excluidos de Git; las credenciales temporales locales de esta aceptación se retiraron después del recorrido.
