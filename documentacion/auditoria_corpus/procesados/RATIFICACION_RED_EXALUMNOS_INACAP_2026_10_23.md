# Ratificación de exclusión: Beca Red de Egresados INACAP

Fecha: 23 de octubre de 2026. Candidata: `34caa8abfdbea88cf08a57fa33f7e0629f9dec390d260879a8dfa6869d1d936c`.

## Registro original y fuente recuperada

El original de `ScrapperBecasFind/data_lake_becas/03_procesados/becas_inacap.csv`, registro 5, se titula “Beca Red de Egresados”. Atribuye a familiares directos de titulados un 15% de descuento semestral sobre arancel, exige probar parentesco y fija fechas 2026. La única URL de origen es una página antigua de “becas y beneficios” que ya no entrega la ficha.

La fuente institucional [Portal Exalumnos INACAP](https://portal.inacap.cl/exalumnos), consultada el 23/10/2026, se presenta como portal de exalumnos. Publica un 30% de descuento en cursos y diplomados de Educación Continua y 40% en aquellos con Sello STEM. Además identifica como propósitos de la Red conectar exalumnos, apoyarlos en empleabilidad y emprendimiento, y mantenerlos vinculados. La página histórica institucional [Cómo formar parte de la Red de Exalumnos Destacados](https://portales.inacap.cl/exalumnos/red-exalumno-destacado/como-ser-parte) dice que las personas tituladas forman parte de la Red al titularse y atribuye a exalumnos el descuento para programas de Educación Continua.

## Decisión y alcance

La fuente identifica una prestación real asociada a la Red, pero con destinatario y alcance diferentes: exalumnos, cursos/diplomados de Educación Continua y descuentos publicados de 30%/40%, no familiares de titulados, arancel semestral de una carrera superior ni 15%. Por tanto, se ratifica `PROGRAMA_DISTINTO` y se excluye del catálogo la candidata tal como está descrita; se conservan intactos sus CSV originales, variantes y registro administrativo inactivo.

Esta decisión no afirma que INACAP nunca haya ofrecido una beca independiente para familiares de titulados. Las fuentes públicas consultadas no permiten confirmar esa beca separada ni su inexistencia; no se trasladan sus condiciones al beneficio de la Red. Si aparece una fuente oficial que identifique el programa familiar, la candidatura podrá reabrirse como modalidad separada. La exclusión se limita al alias y a la atribución actual “Beca Red de Egresados, 15% para familiares”.

**Resultado de calidad:** identidad de la Red confirmada; atribución de los destinatarios y cobertura del registro contradicha por la prestación institucional recuperada; convocatoria 2026, fechas y documentos de la supuesta beca familiar no confirmados.
