# Contexto operativo de BecasFind

Actualizado el 30 de octubre de 2026. Fuente de trabajo: `PLAN_MEJORAS.md`; detalles y evidencia: `infra/P12_DESPLIEGUE.md`. Este chat asume P12 por petición del usuario. No coordinar escrituras concurrentes ni repetir lo aplicado.

## Auditoría de vigencia: corte final

Auditoría de vigencia cerrada al corte documental del 30/10 con resultados inconclusos conservados: 466 dictámenes; 4 con cierre no vencido, 68 cierres de convocatorias identificadas (incluidas históricas), 88 calendarios por modalidad, 119 sin calendario publicado en el expediente y 187 inconclusas. No equivale a investigación exhaustiva de todas las fuentes ni a 466 confirmaciones actuales. Fuente vigente: documentacion/auditoria_corpus/procesados/auditoria_vigencia_corte_2026_10_29/INFORME_CIERRE.md, inventario.json y avance.json. Aplicados y conciliados 56 cambios (54 calendarios cerrados y dos activaciones: 255/327); no repetir los SQL. Todos los UUID conservados. Web verificada: 528 fichas; 8 abiertas, 112 cierres vencidos, 221 fechas por confirmar y 187 en revisión. BUCH cerró por su temporizador el 30/10 a las 12:00. Backend con recurso de 187 UUID actualizado; frontend 719646b conservado. No iniciar P13/P14.

## Estado actual

Tanda final de las 19 terminada el 29/10 por petición expresa: 19 dictámenes INCONCLUSA, cero confirmaciones nuevas y cero sin dictamen. En 17 afecta cobertura actual; en dos, identidad (Rauco y San Pedro de la Paz). Resultado individual publicado al inicio de cada detalle y verificado. Fuente vigente: documentacion/auditoria_corpus/procesados/correccion_campos_2026_10_28/RESULTADO_FINAL_19.md y dictamenes_finales_19.json. Los 19 se conservan en casos_inconclusos_actuales.csv; pendientes_documentales_actuales.csv y pendientes_tipo.csv quedan vacíos para esta tanda. No confundir cierre del dictamen con datos confirmados ni con cierre de la auditoría de 466. No repetir búsquedas ya agotadas salvo nueva fuente específica. No repetir SQL: 19 textos añadidos sin perder el contenido previo; categorías, UUID, fechas y activación conservados. Total 523 fichas distintas modificadas en las entregas anteriores; la numeración de lotes no son fases. No iniciar P13/P14.

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

## Antecedentes históricos de los lotes (no son el estado vigente)

Revisión final de las 55 categorías: leer `correccion_campos_2026_10_28/REVISION_ULTIMAS_55.md` bajo procesados. Cunco (14) rectificada con fuente propia y fechas 06–30/04/2026; el expediente esencial anterior de Villa Alegre es un antecedente equivocado que no debe reimportarse. San Pedro de la Paz (490) tiene identidad sin resolver; su enlace de Melipilla fue retirado y se publicó advertencia. Los cuatro beneficios de 182/186/274/419 ya fueron recuperados. 32 tipos desconocidos persisten; no afirmar investigación completa.

Lote 11 aplicado: leer `CONTINUACION_32.md`. Tres tipos añadidos (mixto, articulación no monetaria, admisión sin beca), diez categorías completadas. Rauco (261) tenía enlace de Arauco: retirado y advertido; identidad aún sin confirmar. Cola actual 22. Conteo acumulado recalculado contra instantánea inicial: 503 fichas distintas y 501 categorías; corrige sobreconteo previo de una revisita. No repetir SQL.

Lote 12 de datos aplicado: 20 descripciones breves completadas y tipos académicos de Natales (193) y San Javier (270). En San Javier se distinguió el programa del Liceo Manuel Montt de la beca general de $45.000 mensuales; no trasladar ese importe. Quedan 19 categorías desconocidas. Evidencia en `INVESTIGACION_22.md`. No repetir SQL ni confundir numeración de lotes con fases.

Lote 13 de datos aplicado (no fase P13): Hualpén (37) clasificada como arancel por catastro UdeC 2024; no aplicar su porcentaje como vigente ni a 2022. Maipú (405/506): RSH90 y primer año/continuidad completados; NEM/PAES conservados desconocidos. Versiones ahora 2. Quedan 19 tipos; la cola incluye próximo documento específico por registro. Evidencia en `CONTINUACION_20.md`. No repetir SQL.

Actualización lote 14 de datos: clasificación descriptiva aplicada en las 19, sin confirmar ninguna cobertura ni resolver identidad. Nuevos tipos «Apoyo municipal · cobertura por confirmar» (17) e «Identidad del programa por confirmar» (2). La cola documental real conserva las 19 en `pendientes_documentales_actuales.csv`; cero etiquetas literales «No especificado» NO significa cero incertidumbres. Los títulos de Rauco y San Pedro de la Paz identifican antecedentes con identidad pendiente. Leer `CLASIFICACION_19_Y_LIMITES.md`; no volver a declarar que faltan filas sin revisar ni afirmar auditoría concluida. Total 523 fichas distintas; sin cambios de vigencia.
