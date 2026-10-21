# Método vigente de revisión esencial

Actualizado el 21 de octubre de 2026. Alcance y estado global: [PLAN_MEJORAS.md](../PLAN_MEJORAS.md). Contexto mínimo para retomar: [contexto.md](contexto.md).

## Punto de partida

Quedan **26 candidatas**: 19 aclaraciones y 7 exclusiones históricas sin ratificar. La cola única es `documentacion/auditoria_corpus/procesados/pendientes_esenciales_actuales.csv`. Sus fuentes e informes ya consultados deben leerse antes de repetir consultas. La cifra de 132 es histórica; no reconstruir esa cola desde un informe antiguo. El 20/10 se excluyó además la copia de Valdivia `35f9a8955aef575df868a6d378cbd6bc7ba653a0bdd2a242aedfc9d46fe5b313` respecto de `dbcdf820447cc2d3a206a3db3a4943a999a500d92860f58843dd045b194c6e18`; ambos originales se preservan y la ficha canónica sigue pendiente. Véase `REVISION_DUPLICADO_VALDIVIA_2026_10_20.md`. El 20/10 se excluyó la identidad documental duplicada de Iquique (`1d5e0e1a3d7093d6cd170875d30b640fc8e17c11a5ee6e1a0adf27f48e46680a`) respecto de `b8b0e486aadb5a9ea10a112dcb4f875f4b70455792e81803392506fd81120baf`; la ficha canónica permanece pendiente y ambos originales siguen preservados. Véase `REVISION_DUPLICADO_IQUIQUE_2026_10_20.md`. El 20/10 se excluyó una identidad documental duplicada de Puerto Montt (`8e06647a5b0809fa08e8825421fa64cc8f63723877eafde0470f1cef87df1216`) respecto de `ba64f69ca2f4923b0cc3eeaab9e3b32f62b3d1640a4d98961cc106164d9c7212`; la ficha canónica continúa pendiente y ambos originales siguen preservados. UDD se confirmó como descuento corporativo de postgrado/educación continua; no exigir pregrado cuando el original no lo especifica. El 21/10 se ratificó el descarte de la candidata Beca Hermanos UAI únicamente para 2026, con el reglamento completo de esa cohorte; no se concluye sobre años anteriores. Véase `RATIFICACION_DESCARTE_BECA_HERMANOS_UAI_2026_10_21.md`. El 21/10 se confirmó la Beca Municipal histórica de Toltén mediante publicaciones de 2013 y requisitos de 2020; monto, cupos y vigencia 2026 quedan sin respaldo. Véase `CONFIRMACION_ESENCIAL_BECA_MUNICIPAL_TOLTEN_2026_10_21.md`. El mismo día se confirmó con alcance corregido la ayuda social de Viña del Mar para pago de pasajes; no se clasifica como beca exclusiva para estudiantes. Informe: `CONFIRMACION_ESENCIAL_AYUDA_SOCIAL_PASAJES_VINA_2026_10_21.md`. El 20/10 se confirmaron la Beca Interna UdeC, la línea histórica de Mantención Timaukel (2020), la categoría municipal histórica de Beca Estudiantil Cochamó (Cuenta Pública 2025), las ayudas universitarias municipales de Santa María documentadas en 2016 y la línea municipal de becas monetarias de estudio de Putre documentada por DIDECO en 2011; véanse `CONFIRMACION_ESENCIAL_BECA_INTERNA_UDEC_2026_10_20.md`, `CONFIRMACION_ESENCIAL_TIMAUKEL_2026_10_20.md`, `CONFIRMACION_ESENCIAL_BECA_ESTUDIANTIL_COHAMO_2026_10_20.md`, `CONFIRMACION_ESENCIAL_AYUDAS_UNIVERSITARIAS_SANTA_MARIA_2026_10_20.md` y `CONFIRMACION_ESENCIAL_BECAS_ESTUDIO_PUTRE_2026_10_20.md`. Cochamó no acredita nivel superior ni convocatoria 2026; Timaukel tampoco acredita nivel superior ni convocatoria 2026. Santa María no acredita vigencia 2026. Putre no acredita nivel superior, monto ni convocatoria actual.

## Ejecución

1. Agrupar las pendientes por institución. Extraer del registro la identidad alegada, el hecho esencial faltante y los documentos ya leídos. Cargar solo esos apartados.
2. Elegir una acción nueva que pueda resolver el hecho: recuperar bases enlazadas, abrir un decreto, leer un apartado pendiente o localizar otra publicación oficial específica. No volver al mismo catálogo general sin una pista nueva.
3. Leer una vez cada fuente compartida. Identificar institución, programa/modalidad y año. Registrar qué beneficio y destinatarios publica. Corregir datos contradichos del mismo programa; no sustituirlo por otro parecido.
4. Confirmar esencialmente cuando la fuente específica demuestra identidad y existencia. Investigar los campos restantes en fuentes oficiales; los que el expediente no publique quedan «No especificado», con año y alcance. La falta de importe, documentos o calendario no bloquea por sí sola. La falta de identidad sí.
5. Resolver variantes por modalidad y convocatoria. Duplicidad o falsedad requieren evidencia positiva individual. Preservar originales; no descartar por error HTTP, antigüedad o ausencia en búsqueda.
6. Actualizar el informe pertinente y sus registros una sola vez por bloque de decisiones. No crear otro informe si solo repite la carencia existente. Diferenciar consultas, cierres esenciales nuevos, descartes y variantes resueltas.
7. Regenerar primero el avance con `python infra/report-corpus-progress.py` y después comprobar coherencia con `python infra/audit-editorial-evidence.py`, que lee ese avance. Revisar cambios y subir un commit en español. No ejecutar pruebas de aplicación durante la revisión documental.

## Control de rendimiento

- Trabajar el conjunto restante agrupado; no convertir cada consulta en una entrega de una o dos candidatas.
- Si diez casos seguidos no producen evidencia nueva, cambiar la fuente o la técnica. No recorrer otra vez el mismo ciclo de búsquedas.
- Limitar salidas de herramientas al dato necesario. Consultar primero el resumen y luego los hashes en curso; evitar volcar CSV completos con notas acumuladas.
- No usar Firecrawl. Usar búsqueda web y lectura oficial directa; verificar contenido, no solo HTTP o fragmentos del buscador.
- Si solo una institución puede resolver la identidad, registrar el documento o respuesta exacta que falta. No enviar consultas sin autorización ni declarar confirmación por agotamiento de búsquedas.

## Cierre

Cada cierre exige evidencia individual enlazada. Una revisión sin evidencia nueva no cambia el conteo. No hay cierre global mientras existan candidatas sin resolución respaldada. La confirmación histórica y la vigencia publicable se verifican por separado; no activar, importar ni desplegar durante esta tarea.

El [método acumulado anterior](../documentacion/historial/PLAN_REVISION_ANTES_CONSOLIDACION_2026_10_19.md) se conserva solo para trazabilidad.
