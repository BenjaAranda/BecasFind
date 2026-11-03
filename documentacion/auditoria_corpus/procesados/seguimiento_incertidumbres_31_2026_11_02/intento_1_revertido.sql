\set ON_ERROR_STOP on
BEGIN;
SET LOCAL lock_timeout='5s';
DO $guardas$ BEGIN
IF (SELECT count(*) FROM becas)<>528 THEN RAISE EXCEPTION 'Inventario cambiado'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=51 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=51 AND public_id='c3185637-8e0b-47ff-bd29-c1304407c9ad'::uuid AND version=3 AND md5(descripcion_larga)='fb52da4b7c6789fa90a10f87fbdc5f43' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 51'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=127 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=127 AND public_id='dadba91f-f202-44bb-b81a-d20c8ffc224d'::uuid AND version=3 AND md5(descripcion_larga)='4da574841a0f50f3a29dcc8970bfae3e' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 127'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=158 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=158 AND public_id='c6af8cf1-d8ee-4803-8107-9253a30e2903'::uuid AND version=3 AND md5(descripcion_larga)='93d13a494ba735312f9894e604a3fcc6' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 158'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=331 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=331 AND public_id='214dac55-77e8-440a-80db-37c3c18e15f5'::uuid AND version=3 AND md5(descripcion_larga)='90708606480e9ce27dba76003dfde9f9' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 331'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=357 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=357 AND public_id='c8e8679f-0be1-47c4-a548-f9acfb77ad78'::uuid AND version=3 AND md5(descripcion_larga)='18a9a6b3a280e5d33721b7eb0d4af1bb' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 357'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=376 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=376 AND public_id='330cbb6d-1567-4336-aaaf-07aa70523abb'::uuid AND version=3 AND md5(descripcion_larga)='bef052e5ba6d2d76f8ef27d3878cfbc3' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 376'; END IF;
PERFORM id_beca FROM becas WHERE id_beca=378 FOR UPDATE;
IF NOT EXISTS(SELECT 1 FROM becas WHERE id_beca=378 AND public_id='21b70095-4dfe-46aa-90ad-c3908ed358a0'::uuid AND version=3 AND md5(descripcion_larga)='d519c47b62ad22d87bd707942b57bb10' AND NOT estado_activa AND fecha_inicio_postulacion IS NULL AND fecha_cierre_postulacion IS NULL) THEN RAISE EXCEPTION 'Estado previo distinto: 378'; END IF;
END $guardas$;
UPDATE becas SET descripcion_larga='ACLARACIÓN DOCUMENTAL · 02/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
La ficha municipal de Beca de Ingreso de Paine publica recepción de antecedentes mediante formulario y exige concentración de notas de cuarto medio 2025, matrícula superior, RSH y residencia. Se vincula al banner municipal 2026 ya leído y conservado. No publica cuantía ni plazo final en la ficha.
LÍMITES: Importe, cupos, días de recepción y continuidad/renovación no especificados. Mantener las dos fichas y UUID; el formulario de ingreso no acredita una beca diferente para cursos superiores. Sin activación.
FUENTES: https://www.paine.cl/dideco-beca-superior/ ; https://www.paine.cl/wp-content/uploads/2026/03/FORMULARIO-DE-BECA-DE-INGRESO.pdf ; https://www.paine.cl/wp-content/uploads/2026/03/BANNER-WEB-POSTULACIONES-Becas-Educacion-Superior-2026-1-scaled.jpg
No se anuncian postulaciones abiertas ni se rellenan fechas desconocidas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca de ingreso a educación superior de Paine',monto_cobertura='Aporte de la Beca de Ingreso a Educación Superior de Paine 2026; importe, cupos y periodicidad no especificados en la ficha municipal consultada.',cobertura_tipo='MONETARIA',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad='DESCONOCIDA',cobertura_porcentaje=NULL,descripcion_corta='Beca de ingreso superior Paine 2026: formulario municipal con matrícula, RSH, residencia y notas de cuarto medio 2025. Importe y cierre no especificados.',url_oficial='https://www.paine.cl/dideco-beca-superior/' WHERE id_beca=51;
UPDATE becas SET descripcion_larga='ACLARACIÓN DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Leído el reglamento modificado 2022 enlazado por el índice municipal: siete páginas. Artículo quinto exige NEM 5,5 a nuevos y permite una asignatura reprobada a antiguos; artículo segundo fija 350.000 anuales en dos cuotas de 175.000. El texto actualizado mantiene expresamente 5,5 y recepción anual 1–31 marzo.
LÍMITES: Queda aclarada la redacción del instrumento 2022 frente al 5,3 de la ficha de trámites; falta acto anual actual que acredite importe, cupos y eventual modificación para 2026. No imponer NEM histórico como filtro vigente ni trasladar el calendario automáticamente.
FUENTES: https://www.muermos.cl/transparencia2.0/images/A_Transparencia_2022/Actas/acta_24_22_compressed.pdf ; https://transparencia.muermos.cl/index.php?id=192%3Areglamento-interno&option=com_phocadownload&view=category ; https://www.muermos.cl/transparencia2.0/images/A_Transparencia_2022/reglamentos/REGLAMENTO_BECA_MUNICIPAL_2022.pdf
No se anuncian postulaciones abiertas ni se rellenan fechas desconocidas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1 WHERE id_beca=127;
UPDATE becas SET descripcion_larga='ACLARACIÓN DOCUMENTAL · 02/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
Se operó el selector real de la ficha Beca NEM UDD y se esperó la carga del resultado. La tabla de Arquitectura Santiago, Admisión 2027, publica 30% con NEM 6,7 o más, 20% con 6,6–6,69 y 10% con 6,3–6,59. Descuento de arancel por ingreso vía Admisión Directa; renovación según promedio de la promoción.
LÍMITES: La tabla es específica de carrera y sede; no equivale a un descuento universal del 30% ni a un mínimo NEM general. Otras carreras deben consultarse en el selector. No publica días de cierre y no se acredita recepción abierta. El aviso general de próxima publicación no sustituye la tabla efectivamente visible.
FUENTES: https://www.udd.cl/admision-pregrado/becas/?udd_beca=172769
No se anuncian postulaciones abiertas ni se rellenan fechas desconocidas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,monto_cobertura='Descuento según carrera y NEM. Arquitectura Santiago, Admisión 2027: 10% con NEM 6,3–6,59; 20% con 6,6–6,69; 30% desde 6,7. No es un porcentaje universal.',cobertura_tipo='PORCENTUAL',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=NULL,descripcion_corta='Beca NEM UDD por Admisión Directa. La tabla 2027 varía por carrera y NEM; Arquitectura Santiago publica 10%, 20% o 30%. Cierre específico no publicado.' WHERE id_beca=158;
UPDATE becas SET descripcion_larga='ACLARACIÓN DOCUMENTAL · 02/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
La ficha oficial UANDES identifica 50% del arancel anual para hijos de personal de la Universidad/ESE con contrato indefinido de 33 horas o más. La bonificación de 5% al puntaje es distinta y tiene reglas de 22 horas, incluyendo clínica; el descuento de 50% no incluye personal de clínica. El sitio muestra Postulaciones cerradas.
LÍMITES: El encabezado anuncia noviembre 2026–enero 2027 sin días, mientras el pie delimita la información a Admisión 2026. Se confirman los campos publicados y el aviso cerrado al corte; no se certifica un calendario completo 2027 ni se activa por el mes anunciado.
FUENTES: https://admision.uandes.cl/becas/beca-hijo-funcionario
No se anuncian postulaciones abiertas ni se rellenan fechas desconocidas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,cobertura_tipo='PORCENTUAL',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=50.00,url_oficial='https://admision.uandes.cl/becas/beca-hijo-funcionario',monto_cobertura='50% del arancel anual; hijos de funcionarios de Universidad/ESE con contrato indefinido de 33 horas o más. Bonificación de puntaje 5% es otro beneficio.',descripcion_corta='Hijos de funcionarios UANDES/ESE: 50% del arancel con contrato indefinido de al menos 33 horas. La web informa postulaciones cerradas y próximos meses sin días.' WHERE id_beca=331;
UPDATE becas SET descripcion_larga='ACLARACIÓN DOCUMENTAL · 02/11/2026
DICTAMEN: REVISION_INCONCLUSA.
Recuperada ficha operativa oficial DIDECO de Constitución: identifica Beca Municipal de Educación Superior, apoyo económico y recepción/revisión de solicitudes. Es una referencia específica útil que reemplaza la descarga caída de la ficha.
LÍMITES: No publica importe, umbrales ni calendario; no sustituye la ordenanza 1086/2026 cuya descarga sigue pendiente. No trasladar las reglas 2025 a la convocatoria actual.
FUENTES: https://www.constitucion.cl/dideco/ficha/becas-municipales-de-educacion-superior
No se anuncian postulaciones abiertas ni se rellenan fechas desconocidas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,url_oficial='https://www.constitucion.cl/dideco/ficha/becas-municipales-de-educacion-superior' WHERE id_beca=357;
UPDATE becas SET descripcion_larga='ACLARACIÓN DOCUMENTAL · 02/11/2026
DICTAMEN: CERRADA_CONFIRMADA.
La ficha oficial UANDES acredita 50% del arancel anual, sin matrícula, para hijos de personal activo o en retiro de Armada, ingreso por PAES, primer ingreso y exclusión de Bachillerato/mitad de año. Exige en mantención pertenecer al 50% superior y no reprobar. La página indica Postulaciones cerradas.
LÍMITES: Anuncia noviembre 2026–enero 2027 sin días y conserva cupos/pie Admisión 2026. No combinar fechas del índice antiguo con meses de la página actual ni certificar el calendario 2027. Sin activación.
FUENTES: https://admision.uandes.cl/becas/beca-armada-de-chile
No se anuncian postulaciones abiertas ni se rellenan fechas desconocidas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,cobertura_tipo='PORCENTUAL',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad=NULL,cobertura_porcentaje=50.00,url_oficial='https://admision.uandes.cl/becas/beca-armada-de-chile',monto_cobertura='50% del arancel anual, sin matrícula; hijos de personal activo o retirado de Armada. Condiciones publicadas por UANDES; días del próximo proceso no especificados.',descripcion_corta='Armada UANDES: 50% del arancel para hijos de personal activo o retirado; ingreso vía PAES. La web informa postulaciones cerradas; próximo calendario sin días.' WHERE id_beca=376;
UPDATE becas SET descripcion_larga='ACLARACIÓN DOCUMENTAL · 02/11/2026
DICTAMEN: SIN_CALENDARIO_PUBLICADO.
La ficha municipal de Beca de Ingreso de Paine publica recepción de antecedentes mediante formulario y exige concentración de notas de cuarto medio 2025, matrícula superior, RSH y residencia. Se vincula al banner municipal 2026 ya leído y conservado. No publica cuantía ni plazo final en la ficha.
LÍMITES: Importe, cupos, días de recepción y continuidad/renovación no especificados. Mantener las dos fichas y UUID; el formulario de ingreso no acredita una beca diferente para cursos superiores. Sin activación.
FUENTES: https://www.paine.cl/dideco-beca-superior/ ; https://www.paine.cl/wp-content/uploads/2026/03/FORMULARIO-DE-BECA-DE-INGRESO.pdf ; https://www.paine.cl/wp-content/uploads/2026/03/BANNER-WEB-POSTULACIONES-Becas-Educacion-Superior-2026-1-scaled.jpg
No se anuncian postulaciones abiertas ni se rellenan fechas desconocidas.
ANTECEDENTES CONSERVADOS (prevalecen las precisiones documentadas arriba):
' || descripcion_larga,version=version+1,nombre='Beca de ingreso a educación superior de Paine',monto_cobertura='Aporte de la Beca de Ingreso a Educación Superior de Paine 2026; importe, cupos y periodicidad no especificados en la ficha municipal consultada.',cobertura_tipo='MONETARIA',cobertura_importe=NULL,cobertura_moneda=NULL,cobertura_periodicidad='DESCONOCIDA',cobertura_porcentaje=NULL,descripcion_corta='Beca de ingreso superior Paine 2026: formulario municipal con matrícula, RSH, residencia y notas de cuarto medio 2025. Importe y cierre no especificados.',url_oficial='https://www.paine.cl/dideco-beca-superior/' WHERE id_beca=378;
COMMIT;
