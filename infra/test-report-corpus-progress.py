import importlib.util
import json
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('progress', Path(__file__).with_name('report-corpus-progress.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class ProgressTest(unittest.TestCase):
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


if __name__ == '__main__':
    unittest.main()
