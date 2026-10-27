"""Build publication decisions from Oracle, retained dossiers and explicit source reviews."""
import argparse
import json
from collections import Counter
from datetime import date
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CORPUS = ROOT / 'documentacion/auditoria_corpus/procesados'
FOLDER = CORPUS / 'despliegue_p12'
REVIEW_DATE = date(2026, 10, 26)
BUCH = '371af7982aa3b8152cd1d362a873b11e7744674163eef5d869aba7c715a031fe'
PARENT = 'a7add480ae1c014fbf47d21eeffd015842829399ea2988e2d743f41393504c11'
UDD = '92e4ad7a0560c3a831af47c3412ee193c26746839a7b4fbc7e949183226b0c26'
SOURCES = {
    'https://acceso.mineduc.cl/wp-content/uploads/2025/11/SERV-Y-BENEF-2026-181125.pdf':
        'Edición e índice de admisión 2026 consultados y contrastados con el expediente individual; no acreditan un cierre actual ni una convocatoria 2027. No se declara lectura nueva completa de las 404 páginas.',
    'https://admision.uss.cl/becas-y-financiamiento':
        'Oferta y condiciones por modalidad consultadas; el título 2027 coexiste con condiciones de ingreso 2026. No se transfiere un calendario entre años ni se inventa cierre.',
    'https://admision.udp.cl/becas-y-beneficios/becas-y-beneficios-udp/':
        'Condiciones de modalidades UDP y referencias 2026 consultadas; no se verificó un cierre exacto vigente.',
    'https://admision.ucn.cl/becas-y-ayudas/becas-y-beneficios-ucn/':
        'Distinción académica, alojamiento, alimentación y escolaridad segura consultados; asignación automática o matrícula según modalidad. No se publica un cierre exacto en la ficha.',
    'https://admision.utalca.cl/becas/':
        'Catálogo de beneficios y requisitos consultado; anualidad o primer año no equivalen a fecha oficial de cierre.',
    'https://dgcypa2.utalca.cl/documents/archivos/RU-46-2026.pdf':
        'Reglamento 46/2026 consultado junto al catálogo; remite a convocatorias particulares y resoluciones anuales. No se asignan fechas por defecto.',
    'https://www.elquisco.cl/beca-municipal-2026/':
        'La ficha municipal fija postulación del 1 de febrero al 31 de marzo de 2026; convocatoria documentada cerrada.',
    'https://www.corporacionloprado.cl/beca-municipal-de-educacion-superior-2026/':
        'La cuarta convocatoria fija postulación del 25 de febrero al 25 de marzo de 2026; convocatoria documentada cerrada.',
    'https://uchile.cl/dbe/buch':
        'Admisión 2027; ampliación expresa hasta 30 de octubre de 2026 al mediodía. Se conserva el horario oficial mediante temporizador específico.',
    'https://uchile.cl/convocatorias/7790/descuento-de-arancel-para-hijos-de-funcionarios-o-academicos':
        'Convocatoria 2026 del 13 de enero al 31 de diciembre; admite solicitud posterior a matrícula sin retroactividad.',
    'https://postgrados.udd.cl/programas/curso-gestion-de-compensaciones-240050/':
        'Descuento Alumni del curso confirmado; 2–25 noviembre son fechas de clases. Inscripción abierta sin cierre publicado. No se usan las fechas de clases como postulaciones.',
}


def build(snapshot_path):
    snapshot = json.loads(snapshot_path.read_text(encoding='utf-8'))
    baseline = json.loads((FOLDER / 'conciliacion_oracle_inicial.json').read_text(encoding='utf-8'))
    ids = {entry['public_id']: entry['candidato'] for entry in baseline['registros']}
    cases = {entry['candidato']: entry for entry in
             json.loads((CORPUS / 'cierre/casos.json').read_text(encoding='utf-8'))}
    results = []
    for row in snapshot['filas']:
        candidate = ids[row['public_id']]
        case = cases[candidate]
        evidence = case.get('confirmacion_esencial', case.get('confirmacion'))
        sources = evidence['fuentes']
        reviewed = [source for source in sources if source in SOURCES]
        closing = date.fromisoformat(row['fecha_cierre_postulacion']) if row['fecha_cierre_postulacion'] else None
        if row['estado_activa']:
            if candidate not in {BUCH, PARENT} or not closing or closing < REVIEW_DATE:
                raise ValueError('Activación sin una revisión vigente explícita')
            decision = 'ACTIVA_CON_CIERRE_VIGENTE_COMPROBADO'
            reason = SOURCES['https://uchile.cl/dbe/buch' if candidate == BUCH else sources[0]]
        elif closing and closing < REVIEW_DATE:
            decision = 'INACTIVA_CONVOCATORIA_DOCUMENTADA_CERRADA'
            reason = 'Cierre documentado del expediente ya vencido; no equivale a inexistencia de otras convocatorias.'
        else:
            decision = 'INACTIVA_CALENDARIO_DESCONOCIDO_O_VIGENCIA_NO_ACREDITADA'
            reason = 'No existe cierre actual acreditado en el expediente utilizado para esta selección. Mantener inactiva.'
        results.append(dict(candidato=candidate, id_beca=row['id_beca'], public_id=row['public_id'],
                            nombre=row['nombre'], institucion=row['institucion'],
                            estado_editorial=case['estado'], alcance=evidence['alcance'],
                            beneficio=evidence.get('beneficio') or row['monto_cobertura'],
                            requisitos_principales=evidence.get('requisitos_principales') or
                            'Detalle de confirmación completa y requisitos estructurados conciliados con Oracle.',
                            informe=evidence['informe'], fuentes=sources,
                            fecha_inicio=row['fecha_inicio_postulacion'], fecha_cierre=row['fecha_cierre_postulacion'],
                            hora_cierre='12:00:00' if candidate == BUCH else None,
                            zona_horaria='America/Santiago' if candidate == BUCH else None,
                            estado_activa=row['estado_activa'], decision=decision, motivo=reason,
                            fuentes_consultadas_en_esta_tanda=reviewed,
                            nueva_revision_de_fuente_pendiente=not bool(reviewed),
                            rsh_maximo=row['rsh_maximo_porcentaje'], nem_minimo=row['nem_minimo']))
    if len(results) != 528 or len({x['candidato'] for x in results}) != 528:
        raise ValueError('La selección no cubre las 528 fichas una sola vez')
    report = dict(fecha_revision=REVIEW_DATE.isoformat(), snapshot_utc=snapshot['capturado_utc'],
                  total=len(results), conteos=dict(Counter(x['decision'] for x in results)),
                  candidatas_en_tanda_fuentes_compartidas=sum(bool(x['fuentes_consultadas_en_esta_tanda']) for x in results),
                  nueva_revision_de_fuente_pendiente=sum(x['nueva_revision_de_fuente_pendiente'] for x in results),
                  desconocidos='NULL equivale a No especificado; nunca implica que el requisito no exista.',
                  fuentes_consultadas=SOURCES, registros=results)
    output = FOLDER / 'seleccion_publicacion_2026_10_26.json'
    output.write_text(json.dumps(report, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    print(json.dumps({k: v for k, v in report.items() if k not in ('registros', 'fuentes_consultadas')}, ensure_ascii=True))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('snapshot', type=Path)
    args = parser.parse_args()
    build(args.snapshot)
