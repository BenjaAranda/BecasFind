\set ON_ERROR_STOP on
BEGIN READ ONLY;
SELECT jsonb_build_object(
    'capturado_utc', now(),
    'fecha_santiago', (now() AT TIME ZONE 'America/Santiago')::date,
    'filas', (SELECT jsonb_agg(to_jsonb(x) ORDER BY x.id_beca) FROM (
        SELECT b.id_beca, b.public_id, b.version, b.nombre,
               i.nombre AS institucion, t.nombre AS tipo_beca,
               b.descripcion_corta, b.descripcion_larga, b.monto_cobertura,
               b.cobertura_tipo, b.cobertura_importe, b.cobertura_moneda,
               b.cobertura_periodicidad, b.cobertura_porcentaje,
               b.fecha_inicio_postulacion, b.fecha_cierre_postulacion,
               b.url_oficial, b.estado_activa, rp.rsh_maximo_porcentaje,
               rp.nem_minimo, rp.paes_minimo,
               (SELECT jsonb_agg(r.abreviatura ORDER BY r.id_region)
                  FROM becas_regiones br JOIN regiones r USING(id_region)
                 WHERE br.id_beca=b.id_beca) AS regiones,
               (SELECT jsonb_agg(jsonb_build_object('nombre', d.nombre_documento,
                                                  'obligatorio', d.es_obligatorio)
                                 ORDER BY d.id_documento)
                  FROM documentos_requeridos d WHERE d.id_beca=b.id_beca) AS documentos
          FROM becas b JOIN instituciones i USING(id_institucion)
          JOIN tipos_beca t USING(id_tipo_beca)
          LEFT JOIN requisitos_perfil rp USING(id_beca)
    ) x)
);
ROLLBACK;
