"""Record a publication decision for every imported dossier without recertifying it."""
import argparse
from collections import Counter
from datetime import date
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FOLDER = ROOT/'documentacion/auditoria_corpus/procesados/despliegue_p12'
NOTES = {
    'https://admision.uandes.cl/becas/beca-uandes-economica':
        'Ficha actual coherente para admisión 2027: 19/10/2026–28/01/2027; 15–70% según evaluación económica. Sustituye el calendario contradictorio del expediente anterior.',
    'https://admision.uandes.cl/becas/beca-alimentacion-uandes':
        'Calendario 19/10/2026–28/01/2027 y asignación marzo 2027; pie aún dice admisión 2026. Se conserva inactiva por contradicción de anualidad; no se modifica su cobertura.',
    'https://admision.uandes.cl/becas/beca-armada-de-chile':
        'Solo meses noviembre 2026/enero 2027; faltan días de inicio y cierre. No inventar fechas.',
    'https://admision.uandes.cl/becas/beca-hijo-funcionario':
        'Solo meses noviembre 2026/enero 2027. Bonificación de puntaje y rebaja de arancel son condiciones distintas; no inventar cierre.',
    'https://admision.uandes.cl/becas/beca-uandes-nem':
        'Ventana expresa 11/08–11/09/2026 vencida; reforzamiento enero 2027 no es postulación. NEM depende de carrera; promedio PAES del colegio no es puntaje personal.',
    'https://uchile.cl/convocatorias/7734/beca-de-atencion-economica-bae-':
        '13/10–15/12/2026 corresponde a actualización FOCES; la fuente lo advierte. Nuevos: 19–28/01/2027; antiguos dependen de unidad académica. No activar usando el encabezado.',
    'https://uchile.cl/dbe/bab':
        'Proceso enero 2027, aún futuro. Preselección automática y beneficios condicionados; no se anuncia como abierto en octubre.',
    'https://uchile.cl/dbe/residencias':
        'Encabezado octubre–diciembre 2027 frente a matrícula/selección enero 2027. Inconsistencia temporal; mantener inactiva y no transferir fechas BAE.',
    'https://munipetorca.cl/docs/becamunicipaleducacionsuperior/':
        'Segundo semestre: postulación 14–21/10/2026 cerrada. Validación hasta 28/10 y depósitos noviembre no amplían postulación.',
    'https://imda.gob.cl/beca-municipal/':
        'Segundo llamado 19–23/10/2026 cerrado; no se interpreta como abierto por conservar la convocatoria en línea.',
    'https://www.uai.cl/admision/becas-y-aranceles/becas':
        'Reglas generales aún 2026. El cierre 22/12/2026 es de María Isabel Sprenger; no corresponde a las tres candidatas Total/Mantención/Puntaje. No transferirlo.',
    'https://municipalidadrengo.cl/actualidad/boletin-municipal/beca-municipal-rengo/':
        '30 de noviembre es rendición; resultados/pago mayo. No se usa como cierre de solicitud.',
    'https://www.municunco.cl/wp-content/uploads/2026/03/FOLLETO-BECA-MUNICIPAL-2026-OK.pdf':
        '18/12/2026 es rendición y requisito de futura postulación 2027; no es plazo vigente de solicitud.',
    'https://www.munidalcahue.cl/transparencia/inicio/documentos/otros/concursos/2026/202603BECASMUNICIPALES.pdf':
        '27/11/2026 y último día hábil de noviembre corresponden a rendición; proceso de solicitud anterior cerrado.',
    'https://www.duoc.cl/admision/financiamiento/becas-duocuc/':
        'Calendario semestral genérico; no se extrapola una convocatoria anual de cada modalidad desde la navegación 2027.',
    'https://www.duoc.cl/preguntas_frecuentes/beca-deportiva/':
        'FAQ indica mayo/octubre y requisitos deportivos; no prueba anualidad concreta del proceso consultado. Conservar inactiva sin asignar un año por defecto.',
    'https://www.duoc.cl/preguntas_frecuentes/beca-liceo-politecnico-andes/':
        'Beneficio sin fecha específica de postulación; no se inventa cierre aunque exista una rebaja renovable.',
    'https://www.chileatiende.gob.cl/fichas/10453/1/pdf':
        'BMES solo renovación; octubre/noviembre/diciembre son resultados, no nueva convocatoria.',
    'https://www.chileatiende.gob.cl/fichas/2086':
        'Fechas de resultados del segundo semestre no acreditan apertura de solicitudes; no se transfieren como cierre.',
    'https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-nuevo-milenio-bnm':
        'Ficha MINEDUC recuperada mediante búsqueda oficial: modalidad I remite expresamente a 2027. Modalidad II conserva acreditación al 31/12/2025 y no se extrapola. FUAS actual hasta 05/11/2026 a las 14:00, contrastado con Universidad Central.',
    'https://portal.beneficiosestudiantiles.cl/gratuidad':
        'MINEDUC publica requisitos 2027; primer FUAS abierto 01/10–05/11/2026 a las 14:00 según anuncio vigente y Universidad Central. Lista institucional visible 2026: advertencia expresa en la ficha pública; matrícula elegible y asignación siguen condicionadas.',
    'https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-juan-gomez-millas-bjgm':
        'La ficha recuperada por búsqueda oficial conserva acreditación al 31/12/2025 y carreras enero 2025. No se sustituye el año por suposición ni se activa solo por el FUAS general.',
    'https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-bicentenario-bb':
        'Ficha mezcla acreditación institucional diciembre 2026 con carreras enero 2026. Se mantiene inactiva por anualidad de elegibilidad no resuelta, aunque FUAS esté abierto.',
    'https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-excelencia-academica-bea':
        'La convocatoria general FUAS no resuelve por sí sola modalidad/año ni las referencias institucionales heredadas. Mantener inactiva, preservando la identificación editorial como beneficio MINEDUC.',
    'https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-de-alimentacion-baes':
        'BAES es asignación asociada a otros beneficios; no se transfiere automáticamente el plazo FUAS como solicitud independiente.',
}
ACTIVE = {
    104: ('2026-10-30', '12:00:00', 'BUCH ingreso 2027; cien cupos; cierre ampliado oficial y temporizador.'),
    356: ('2026-12-31', None, 'Hijos de Funcionarios UChile; convocatoria 2026 y requisitos individuales.'),
    253: ('2027-01-28', None, NOTES['https://admision.uandes.cl/becas/beca-uandes-economica']),
    272: ('2026-11-05', '14:00:00', NOTES['https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-nuevo-milenio-bnm']),
    320: ('2026-11-05', '14:00:00', NOTES['https://portal.beneficiosestudiantiles.cl/gratuidad']),
}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('snapshot', type=Path)
    args = parser.parse_args()
    snapshot = json.loads(args.snapshot.read_text(encoding='utf-8'))
    today = date.fromisoformat(snapshot['fecha_santiago'])
    previous = json.loads((FOLDER/'seleccion_publicacion_2026_10_26.json').read_text(encoding='utf-8'))
    dossiers = {row['public_id']: row for row in previous['registros']}
    collection = json.loads((FOLDER/'fuentes_calendario_recuperadas_2026_10_26.json').read_text(encoding='utf-8'))
    sources = {item['url']: item for item in collection}
    rows = []
    for row in snapshot['filas']:
        dossier = dict(dossiers[row['public_id']])
        url = row['url_oficial']
        source = sources.get(url)
        closing = date.fromisoformat(row['fecha_cierre_postulacion']) if row['fecha_cierre_postulacion'] else None
        if row['estado_activa']:
            checked = ACTIVE[row['id_beca']]
            if row['fecha_cierre_postulacion'] != checked[0] or closing < today:
                raise ValueError('Activación distinta de la evidencia revisada')
            decision, reason = 'ACTIVA_CON_CIERRE_VIGENTE_COMPROBADO', checked[2]
            hour = checked[1]
        elif closing and closing < today:
            decision = 'INACTIVA_CONVOCATORIA_DOCUMENTADA_CERRADA'
            reason = 'Convocatoria del expediente cerrada; no se ha acreditado otra apertura vigente.'
            hour = None
        else:
            decision = 'INACTIVA_CALENDARIO_DESCONOCIDO_O_VIGENCIA_NO_ACREDITADA'
            reason = 'No se acreditó un cierre vigente aplicable a esta modalidad; preservar inactiva, sin afirmar inexistencia.'
            hour = None
        observation = NOTES.get(url)
        if not observation:
            if source and source['estado_recuperacion'] == 'NO_RECUPERADA':
                observation = 'Consulta pública sin texto recuperable: ' + source.get('error', 'barrera de acceso')
            elif source:
                observation = ('Control limitado del expediente y pasajes de calendario recuperados; '
                               'no se declara lectura íntegra ni certificación de los campos por HTTP. '
                               'Esos pasajes no se usan para activar esta modalidad sin evidencia específica suficiente.')
            else:
                observation = 'Expediente y fuente compartida ya contrastados en la primera tanda; conservar sus límites.'
        dossier.update(fecha_inicio=row['fecha_inicio_postulacion'], fecha_cierre=row['fecha_cierre_postulacion'],
                       estado_activa=row['estado_activa'], decision=decision, motivo=reason,
                       hora_cierre=hour, zona_horaria='America/Santiago' if hour else None,
                       observacion_vigencia=observation, control_seleccion_resuelto=True,
                       requiere_nueva_evidencia_para_activarse=not row['estado_activa'],
                       rsh_maximo=row['rsh_maximo_porcentaje'], nem_minimo=row['nem_minimo'])
        dossier.pop('nueva_revision_de_fuente_pendiente', None)
        if row['estado_activa']:
            dossier['alcance'] = reason
            dossier['descripcion_publica_conciliada'] = row['descripcion_larga']
        if source:
            dossier['consulta_publica'] = {key: source.get(key) for key in
                                          ('url', 'url_final', 'http', 'sha256', 'estado_recuperacion', 'error')}
        rows.append(dossier)
    if len(rows) != 528 or len({x['public_id'] for x in rows}) != 528:
        raise ValueError('El control no cubre exactamente el inventario importado')
    batches = [rows[i:i+50] for i in range(0, 450, 50)] + [rows[450:]]
    report = dict(fecha_revision=today.isoformat(), snapshot_utc=snapshot['capturado_utc'], total=528,
                  conteos=dict(Counter(r['decision'] for r in rows)), decisiones_sin_resolver=0,
                  alcance='Selección publicable, no reconfirmación exhaustiva. Un cierre desconocido resuelve la selección como inactiva; no certifica vigencia ni falsedad.',
                  fuentes_recuperacion=dict(Counter(x['estado_recuperacion'] for x in collection)),
                  limites='Consulta limitada de calendario y expedientes; fuentes inaccesibles, extractos parciales y años ambiguos no autorizan activar. No se infiere una convocatoria nueva ni se declara lectura completa de 379 documentos.',
                  lotes=[dict(numero=i+1, cantidad=len(batch), candidatas=[r['candidato'] for r in batch])
                         for i, batch in enumerate(batches)], registros=rows)
    output = FOLDER/('seleccion_publicacion_'+today.isoformat().replace('-', '_')+'.json')
    output.write_text(json.dumps(report, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    print(json.dumps({key: report[key] for key in ('fecha_revision', 'total', 'conteos', 'decisiones_sin_resolver')}))


if __name__ == '__main__':
    main()
