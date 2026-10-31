BEGIN;
SET LOCAL lock_timeout='5s';
DO $guard$
BEGIN
    PERFORM id_beca FROM becas WHERE id_beca IN (253,356) FOR UPDATE;
    IF (SELECT count(*) FROM becas WHERE id_beca IN (253,356) AND estado_activa AND version=2)<>2
        OR EXISTS (SELECT 1 FROM documentos_requeridos WHERE id_beca IN (253,356)) THEN
        RAISE EXCEPTION 'Las fichas o sus documentos cambiaron; no repetir';
    END IF;
END;
$guard$;
INSERT INTO documentos_requeridos (id_beca,nombre_documento,es_obligatorio) VALUES
    (253,'Formulario de acreditación económica completo',true),
    (253,'Antecedentes familiares de ingresos y gastos solicitados en el formulario; hasta diez archivos PDF',true),
    (356,'Solo para solicitudes como hijo de jubilado: certificado AFP o resolución de pensión IPS',true);
UPDATE becas SET version=version+1 WHERE id_beca IN (253,356);
COMMIT;
