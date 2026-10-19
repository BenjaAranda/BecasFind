# Contexto de trabajo — BecasFind

Actualizado el 19 de octubre de 2026. Leer este archivo, `AGENTS.md`, `PLAN_MEJORAS.md` y el estado real de Git al retomar. Este resumen orienta; los registros documentales son la fuente de los conteos.

## Tarea activa y estado comprobado

Terminar la revisión esencial de las 132 candidatas que estaban pendientes en el corte del 12 de octubre. La cola actual contiene **40**, no 132: 28 requieren aclaración y 12 son exclusiones históricas todavía sin ratificar. El último contraste no cerró ninguna candidata; las búsquedas repetidas no son avance.

| Inventario | Cantidad |
|---|---:|
| Archivos originales | 93 |
| Referencias originales | 647 |
| Identidades candidatas | 568 |
| Confirmadas esenciales | 515 |
| Confirmadas completas | 2 |
| Descartes ratificados | 11 |
| Pendientes de cierre | 40 |

No confundir candidatas con programas distintos. Confirmación histórica y vigencia publicable son controles separados.

## Archivos que se deben consultar

Todos los siguientes registros están en `documentacion/auditoria_corpus/procesados/`:

- `avance/resumen.json`: conteos reproducibles actuales. `resumen.json` de la raíz de esa carpeta pertenece a otra auditoría; no usarlo como avance editorial.
- `pendientes_esenciales_actuales.csv`: cola única con hash, carencia, fuentes consultadas y siguiente acción.
- `originales.jsonl`: originales y trazas que se deben preservar.
- `confirmaciones_esenciales.json`, `confirmaciones_completas.json`, `descartes.json` y `revisiones_parciales.csv`: decisiones y referencias. Distinguir los descartes ratificados de las exclusiones históricas presentes también en la cola pendiente.
- `avance/por_registro.csv` y `avance/por_archivo.csv`: estado por referencia y archivo.
- `variantes/`: evidencias de conciliación. No deducir su estado global de conteos antiguos de los planes.

Los informes antiguos son antecedentes para localizar evidencia, no pruebas que sustituyan la lectura oficial. Consultar solo los apartados de las candidatas en curso.

## Criterios y límites vigentes

- Fuente oficial específica que identifique el programa y su existencia; registrar beneficio y destinatarios publicados. Si el expediente no publica un campo, dejar «No especificado» y delimitar año y alcance. No exigir cifras ni calendario ausentes para cerrar una identidad demostrada.
- No reemplazar una candidata por un beneficio parecido. La falta de fuente que identifique el programa sigue siendo una carencia esencial.
- No descartar por antigüedad, error HTTP o ausencia en búsquedas. Duplicidad o falsedad requieren evidencia positiva individual; preservar originales.
- No usar Firecrawl. Usar búsqueda web, sitios oficiales y lectura directa de documentos. Un resultado de búsqueda aislado no certifica una ficha.
- Prioridad exclusiva: becas. Pruebas de backend/frontend, importaciones, activación y despliegue están aplazados. P12–P14 no autorizadas.
- Costo mensual previsto: $0. Diseño azul y blanco institucional; navegación pública; sesión para guardar datos y administración. PostgreSQL 17; correo Gmail SMTP con secretos externos. No reabrir estas decisiones ni copiar credenciales al contexto.

## Evitar el bucle de búsquedas

Antes de cada consulta, leer la carencia y los informes ya vinculados al hash. Reutilizar la conclusión y cambiar a una fuente concreta pendiente: bases, decreto, reglamento, convocatoria o documento histórico oficial.

No repetir catálogos generales sin un enlace, apartado o año nuevo que pueda resolver el hecho faltante. UAI/INACAP y Valdivia ya tienen contraste del 19 de octubre. Talca y General Lagos ya fueron contrastadas con programas JUNAEB; esas fuentes no prueban la beca municipal genérica. Los catálogos de UCT/UA/UBO/UdeC ya fueron consultados y no permiten reasignar programas por parecido.

Avance documental nuevo del 19 de octubre: `LECTURA_ACTAS_ROMERAL_2026_10_19.md` y su manifiesto JSON registran OCR de 611 páginas de 27 actas de 2026. El Acta 20, páginas 26–27 leídas visualmente, identifica una residencia municipal en Talca, sin demostrar equivalencia con la candidata de mantención. Buscar su reglamento y la respuesta al requerimiento del concejo. El PDF `Convenio-Serbima-ENAC.pdf` se leyó completo y su página 6 visualmente: es un folleto SERBIMA con becas Humberto Elgueta Guerín; no acredita un convenio estudiantil ENAC. Se corrigió esa atribución en el informe de UCT/ENAC/Mejillones del 13 de octubre y en las dos carencias afectadas. No volver a tratar su lectura como pendiente ni trasladar sus beneficios a ENAC. Siguen 40 candidatas abiertas.

Herramientas ya comprobadas para documentos: `pypdf` está en el Python del runtime indicado por `load_workspace_dependencies`, no en el `python` del PATH. Poppler y el OCR local de Windows en español funcionan; los auxiliares `tmp/read_romeral_20261019.py` y `tmp/ocr_romeral_20261019.ps1` conservan la recuperación y el OCR por página. Ambos procesos terminaron; no hay OCR pendiente ni trabajo en segundo plano que esperar. Las páginas y PDFs recuperados permanecen en `tmp/romeral-actas-2026/`; no volver a descargarlos para revisar un pasaje.

Agrupar por institución y leer una sola vez las fuentes compartidas. Registrar únicamente evidencia nueva o una decisión nueva en el informe pertinente; evitar otro informe que repita la misma aclaración. Si solo la institución puede resolver la identidad, documentar exactamente el acto o respuesta necesaria; el envío de consultas requiere autorización.

## Continuidad y Git

- Repositorio: `https://github.com/BenjaAranda/BecasFind`.
- Rama observada: `bugfix/security-and-recovery`; comprobar antes de trabajar. Último commit anterior a esta consolidación: `6702e9b`.
- Commits nuevos: Conventional Commits con descripción en español; subir los cambios autorizados. No reescribir historial ni hacer force-push.
- Archivos personales: `BecasFind - ET.docx` y material de `tmp/`; no eliminarlos como si fueran caché. `tmp/` contiene PDFs de fuentes y sus renderizados.
- Los planes anteriores a esta consolidación están en `documentacion/historial/`. No cargarlos por defecto.

Para verificar coherencia después de cambiar decisiones editoriales: `python infra/audit-editorial-evidence.py` y `python infra/report-corpus-progress.py`. Revisar el diff y los conteos; no ejecutar suites de aplicación por una edición documental.

Este archivo conserva el contexto relevante para retomar; no significa que las 40 pendientes estén confirmadas ni que la aplicación esté publicada.

La limpieza local de `backend/target`, `frontend/dist` e `infra/__pycache__` fue rechazada por la política automática del entorno el 19 de octubre. Esas salidas regenerables ocupaban 68.412.732 bytes y permanecen en disco. No reintentar su eliminación con otra herramienta para eludir el bloqueo.
