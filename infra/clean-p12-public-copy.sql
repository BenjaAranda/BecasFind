BEGIN;
SET LOCAL lock_timeout='5s';
DO $guard$
BEGIN
    PERFORM id_beca FROM becas WHERE id_beca IN (104,253,272,320,356) FOR UPDATE;
    IF (SELECT count(*) FROM becas WHERE id_beca IN (104,253,272,320,356) AND estado_activa AND version=1)<>5
        OR (SELECT count(*) FROM tipos_beca WHERE nombre='Beca de Arancel')<>1 THEN
        RAISE EXCEPTION 'La selección o las versiones cambiaron; revisar antes de limpiar';
    END IF;
END;
$guard$;
-- La trazabilidad íntegra se conserva en expedientes y conciliación por UUID.
UPDATE becas SET descripcion_larga=regexp_replace(
        regexp_replace(descripcion_larga, E'\nTRAZABILIDAD EDITORIAL:.*$', '', 's'),
        ' candidato [0-9a-f]{64}[.].*$', '', 's'),
    id_tipo_beca=(SELECT id_tipo_beca FROM tipos_beca WHERE nombre='Beca de Arancel'),
    version=version+1
WHERE id_beca IN (104,253,272,320,356);
UPDATE becas SET descripcion_larga=replace(replace(replace(descripcion_larga,
    'Fuentes públicas: convocatoria y Decreto Universitario 0013621 de 20 abril 2026; sus ocho páginas leídas.',
    'Convocatoria y Reglamento BUCH: Decreto Universitario 0013621 de 20 de abril de 2026.'),
    'Ampliación publicada en la convocatoria oficial; el cierre al mediodía se aplica con un temporizador operativo específico.',
    'Plazo ampliado según la convocatoria oficial.'),
    'Los documentos de respaldo no especificados por la fuente se describen sin inventar una lista; el formulario autenticado no fue abierto con datos de un postulante. ', '')
WHERE id_beca=104;
UPDATE requisitos_perfil SET es_para_primer_anio=true, es_para_curso_superior=false WHERE id_beca IN (104,253);
UPDATE requisitos_perfil SET es_para_primer_anio=true, es_para_curso_superior=true WHERE id_beca IN (272,320,356);
COMMIT;
