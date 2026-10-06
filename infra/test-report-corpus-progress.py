import importlib.util
import json
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('progress', Path(__file__).with_name('report-corpus-progress.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class ProgressTest(unittest.TestCase):
    def discard(self, folder):
        (folder/'discard.md').write_text('a: identidad histórica sin respaldo', encoding='utf-8')
        entry = dict(candidato='a', revisado='2026-10-06', motivo='Alias no identificable',
                     alcance='Exclusión editorial con histórico conservado', informe='discard.md', evidencia=['review.md'])
        (folder/'descartes.json').write_text(json.dumps([entry]), encoding='utf-8')
        return entry

    def test_discard_closes_all_duplicate_references_without_counting_confirmation(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            self.fixture(folder)
            self.discard(folder)
            totals = module.report(folder)
            self.assertEqual(1, totals['descartadas'])
            self.assertEqual(2, totals['pendientes_confirmacion'])
            self.assertEqual(0, totals['confirmadas_esenciales'])
            rows = module.read_csv(folder/'avance/por_registro.csv')
            discarded = [row for row in rows if row['candidato']=='a']
            self.assertEqual(2, len(discarded))
            self.assertTrue(all(row['estado']=='DESCARTADA_EDITORIAL' and row['pendiente_confirmacion']=='false' for row in discarded))

    def test_discard_cannot_override_a_confirmation(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            self.fixture(folder)
            self.confirmation(folder)
            self.discard(folder)
            with self.assertRaises(ValueError):
                module.report(folder)

    def test_discard_without_individual_evidence_is_rejected(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            self.fixture(folder)
            self.discard(folder)
            (folder/'discard.md').write_text('Sin identificador del caso', encoding='utf-8')
            with self.assertRaises(ValueError):
                module.report(folder)

    def test_specific_wordpress_page_without_accepting_generic_root(self):
        self.assertTrue(module.specific_source('https://admision.umag.cl/?page_id=4099'))
        self.assertTrue(module.specific_source('https://web.molina.cl/?p=81797'))
        for url in ['https://example.org/', 'https://example.org/?search=becas',
                    'https://example.org/?page_id=0', 'https://example.org/?page_id=abc',
                    'https://example.org/?page_id=1&page_id=2', 'http://example.org/?page_id=1',
                    'https://user:password@example.org/?page_id=1',
                    'https://example.org/?p=0', 'https://example.org/?p=abc',
                    'https://example.org/?p=1&p=2', 'https://example.org/?p=1&p=',
                    'https://example.org/?p=1&page_id=2', 'https://example.org/?p=١',
                    'https://user:password@example.org/?p=1', 'http://example.org/?p=1']:
            with self.subTest(url=url):
                self.assertFalse(module.specific_source(url))

    def fixture(self, folder):
        (folder/'reparaciones').mkdir()
        rows = [dict(archivo='a.csv', registro=1, candidato='a'),
                dict(archivo='b.csv', registro=1, candidato='a'),
                dict(archivo='b.csv', registro=2, candidato='b')]
        repairs = [dict(archivo='b.csv', registro_logico_anterior=2, linea_fisica=n,
                        candidato=key, nombre=key, institucion='Institución') for n,key in [(3,'b'),(4,'c')]]
        (folder/'originales.jsonl').write_text('\n'.join(json.dumps(r) for r in rows), encoding='utf-8')
        (folder/'reparaciones/reparados.jsonl').write_text('\n'.join(json.dumps(r) for r in repairs), encoding='utf-8')
        module.write_csv(folder/'indice.csv', ['candidato','nombre','institucion'],
                         [dict(candidato=key,nombre=key,institucion='Institución') for key in ['a','b']])
        (folder/'review.md').write_text('Revisión parcial', encoding='utf-8')
        module.write_csv(folder/'revisiones_parciales.csv', ['candidato','informe'], [dict(candidato='a',informe='review.md')])

    def test_duplicates_and_reconstructed_rows_do_not_inflate_reviewed_count(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            self.fixture(folder)
            totals = module.report(folder)
            self.assertEqual(4, totals['registros'])
            self.assertEqual(3, totals['becas_unicas'])
            self.assertEqual(1, totals['revision_parcial'])
            self.assertEqual(2, totals['sin_revision_individual'])
            self.assertEqual(3, totals['pendientes_confirmacion'])
            self.assertEqual(0, totals['confirmadas_completas'])
            rows = module.read_csv(folder/'avance/por_registro.csv')
            self.assertEqual(2, sum(r['estado']=='REVISION_PARCIAL' for r in rows))
            self.assertTrue(all(r['pendiente_confirmacion']=='true' for r in rows))

    def test_missing_review_evidence_rejected_before_reporting(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            self.fixture(folder)
            (folder/'review.md').unlink()
            with self.assertRaises(ValueError): module.report(folder)
            self.assertFalse((folder/'avance').exists())

    def confirmation(self, folder):
        (folder/'complete.md').write_text('Alcance histórico confirmado', encoding='utf-8')
        entry = dict(candidato='a', alcance='Convocatoria histórica cerrada', informe='complete.md', fuentes=['https://example.org/beca'],
                     verificaciones={key:True for key in ['identidad','convocatoria','cobertura','requisitos','documentos','discrepancias']})
        (folder/'confirmaciones_completas.json').write_text(json.dumps([entry]), encoding='utf-8')
        return entry

    def test_complete_confirmation_counts_one_identity_across_two_files(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            self.fixture(folder)
            self.confirmation(folder)
            totals = module.report(folder)
            self.assertEqual(1, totals['confirmadas_completas'])
            self.assertEqual(0, totals['revision_parcial'])
            self.assertEqual(2, totals['pendientes_confirmacion'])
            rows = module.read_csv(folder/'avance/por_registro.csv')
            self.assertEqual(2, sum(row['estado']=='CONFIRMADA_COMPLETA' for row in rows))
            self.assertTrue(all(row['pendiente_confirmacion']=='false' for row in rows if row['candidato']=='a'))

    def test_incomplete_confirmation_cannot_reduce_pending_count(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            self.fixture(folder)
            entry = self.confirmation(folder)
            entry['verificaciones']['documentos'] = False
            (folder/'confirmaciones_completas.json').write_text(json.dumps([entry]), encoding='utf-8')
            with self.assertRaises(ValueError): module.report(folder)
            self.assertFalse((folder/'avance').exists())

    def test_confirmation_without_report_rejected(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            self.fixture(folder)
            self.confirmation(folder)
            (folder/'complete.md').unlink()
            with self.assertRaises(ValueError): module.report(folder)

    def test_essential_closes_review_without_inventing_calendar_or_documents(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            self.fixture(folder)
            entry = dict(candidato='a', alcance='Reglas públicas; vigencia desconocida', beneficio='Arancel parcial',
                         requisitos_principales='Matrícula en la institución', limites='Documentos y cierre desconocidos; no activar',
                         informe='review.md', fuentes=['https://example.org/beca'],
                         verificaciones={key:True for key in ['identidad','fuente_oficial','cobertura','requisitos_principales']})
            path = folder/'confirmaciones_esenciales.json'
            path.write_text(json.dumps([entry]),encoding='utf-8')
            totals = module.report(folder)
            self.assertEqual(1, totals['confirmadas_esenciales'])
            self.assertEqual(0, totals['confirmadas_completas'])
            self.assertEqual(2, totals['pendientes_confirmacion'])
            rows = module.read_csv(folder/'avance/por_registro.csv')
            self.assertEqual(2, sum(row['estado']=='CONFIRMADA_ESENCIAL' for row in rows))
            entry['verificaciones']['identidad'] = False
            path.write_text(json.dumps([entry]),encoding='utf-8')
            with self.assertRaises(ValueError): module.report(folder)
            entry['verificaciones']['identidad'] = True
            entry['fuentes'] = ['https://example.org/']
            path.write_text(json.dumps([entry]),encoding='utf-8')
            with self.assertRaises(ValueError): module.report(folder)
            entry['fuentes'] = ['https://example.org/beca']
            path.write_text(json.dumps([entry,entry]),encoding='utf-8')
            with self.assertRaises(ValueError): module.report(folder)


if __name__ == '__main__':
    unittest.main()
