# Contexto mínimo de BecasFind

Actualizado el 19 de octubre de 2026. Retomar leyendo AGENTS.md, este archivo, PLAN_MEJORAS.md y el estado real de Git. El método está en tasks/plan.md. Cargar informes y registros únicamente por candidata.

## Estado vigente

- Repositorio: https://github.com/BenjaAranda/BecasFind; rama bugfix/security-and-recovery.
- Última decisión editorial subida: 88f2742. Convenio ENAC confirmado históricamente; Excelencia Académica ENAC corregida a su modalidad interna. No acredita vigencia 2026.
- 93 archivos originales; 647 referencias; 568 candidatas: **516 confirmaciones esenciales, 2 completas, 11 descartes ratificados y 39 pendientes**. Pendientes: 28 aclaraciones y 11 exclusiones históricas sin ratificar. Las 132 son un corte anterior.
- Conteos: documentacion/auditoria_corpus/procesados/avance/resumen.json. No usar el resumen.json de la raíz de esa carpeta como avance editorial.
- Cola única: documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv. Leer carencia e informes por hash antes de consultar fuentes.

## Límites

Prioridad: revisión de becas. Sin Firecrawl, pruebas de aplicación, importaciones, activaciones ni despliegue. P12–P14 no autorizadas. Fuente oficial específica debe demostrar identidad y existencia. Registrar campos publicados; dejar «No especificado» cuando el expediente no los publique. No sustituir modalidades por parecido. No descartar por antigüedad, error HTTP o ausencia en búsquedas. Duplicidad o falsedad requieren evidencia positiva individual. Preservar originales y separar confirmación histórica de vigencia publicable.

Producto: costo previsto $0; azul y blanco institucional; búsqueda y detalle públicos; sesión para guardar datos y administración; PostgreSQL 17; Gmail SMTP con secretos externos. Nunca copiar credenciales al contexto.

## Retomar sin repetir

Informes bajo documentacion/auditoria_corpus/procesados/:

- **ENAC:** CONFIRMACION_ESENCIAL_BECAS_INTERNAS_ENAC_2013_2015_2026_10_19.md. Fichas oficiales archivadas identifican Convenio (20–100%) y Excelencia interna (50% anual al mejor promedio por promoción). Las otras cuatro candidatas no se equiparan con Hermanos, arancel general 2023 ni SERBIMA. SERBIMA ya leído completo; su beca Humberto Elgueta Guerín no acredita esas modalidades.
- **Romeral:** LECTURA_ACTAS_ROMERAL_2026_10_19.md y manifiesto JSON. OCR de 27 actas y 611 páginas. Acta 20, páginas 26–27 revisadas visualmente: residencia en Talca; no demuestra equivalencia con la candidata de mantención. Buscar reglamento y respuesta al concejo. PDF y OCR en tmp/romeral-actas-2026/; no repetir descarga ni OCR.
- **Timaukel:** CONTRASTE_ARCHIVO_TIMAUKEL_2020_2026_10_19.md. Llamado de mayo de 2020 a Mantención y Excelencia. Falta afiche/bases que identifiquen nivel educativo y otorgante. El afiche actual y archivado devolvió 404; cambiar de pista.
- **Archivos históricos:** consulta terminada de 25 dominios: 10 respuestas, 15 errores y 158 recursos. Índice en tasks/indice_archivos_historicos.json; respuestas locales en tmp/archivo-pendientes-20261019/. Son enlaces sin confirmar. Próxima acción: documentos específicos nuevos UFRO/UCT/UBO y Nanning/Iquique; comprobar identidad antes de trasladar datos. No reiniciar el barrido completo.
- UAI/INACAP y Valdivia ya contrastadas el 19 de octubre; Talca/General Lagos con JUNAEB. Sus catálogos no prueban automáticamente las candidatas genéricas. Consultar informes por hash.

## Rendimiento y conservación

Agrupar por institución y leer una vez cada fuente compartida. Buscar por hash; evitar volcar CSV, índices e informes completos. Registrar decisiones nuevas, sin duplicar informes. No hay OCR ni consultas activos.

Python del PATH carece de pypdf; usar el runtime de load_workspace_dependencies. Poppler y OCR Windows español comprobados; auxiliares en tmp/.

Limpieza verificada: **609 PNG regenerables eliminados; 647.954.754 bytes liberados**. Conservados 27 PDF, 611 textos OCR y las imágenes 016187ad14c7-p26.png y -p27.png. Manifiesto local: tmp/romeral-actas-2026/limpieza-renderizados-20261019.json. Regenerar solo una página necesaria con Poppler; el auxiliar OCR reutiliza textos existentes.

Preservar tmp/ (fuentes), BecasFind - ET.docx, originales, respaldos y documentacion/historial/. La eliminación previa de backend/target, frontend/dist e infra/__pycache__ fue rechazada por la política automática; no reintentar con otra herramienta. No se incluyeron en esta limpieza.

## Guardar decisiones

Actualizar informe y registros pertinentes; conservar originales.jsonl y reparaciones/reparados.jsonl. Ejecutar primero python infra/report-corpus-progress.py y después python infra/audit-editorial-evidence.py. Revisar diff y subir commit Conventional Commits en español. Sin reescribir historial ni force-push. Si solo cambia contexto, basta verificar documentos y diff; no ejecutar auditorías de aplicación.
