import csv
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('prepare', Path(__file__).with_name('prepare-processed-corpus.py'))
prepare = importlib.util.module_from_spec(spec)
spec.loader.exec_module(prepare)


class CorpusPreparationTest(unittest.TestCase):
    def test_conflicting_variants_and_encoding_repairs_preserve_every_reference(self):
        with tempfile.TemporaryDirectory() as work:
            root = Path(work)
            corpus = root / 'input'
            corpus.mkdir()
            text = 'nombre,institucion,monto,url\nBeca Académica,Universidad de Viña,100,https://example.com/\n'
            (corpus / 'a.csv').write_text(text, encoding='utf-8')
            other = 'nombre,institucion,monto,url\nBeca Academica,Universidad de ViÃ±a,999,https://example.com/beca\n'
            (corpus / 'b.csv').write_text(other, encoding='utf-8')
            output = root / 'out'
            prepare.prepare(corpus, output)
            originals = [json.loads(line) for line in (output / 'originales.jsonl').read_text(encoding='utf-8').splitlines()]
            self.assertEqual(['100', '999'], [r['original']['monto'] for r in originals])
            self.assertEqual(1, len({r['candidato'] for r in originals}))
            with (output / 'archivo_administrativo.csv').open(encoding='utf-8', newline='') as f:
                rows = list(csv.DictReader(f))
            self.assertEqual(1, len(rows))
            self.assertEqual('Universidad de Viña', rows[0]['institucion'])
            self.assertEqual('false', rows[0]['estado_activa'])
            self.assertEqual('true', rows[0]['solo_crear'])
            for field in ('monto', 'url', 'fecha_inicio', 'fecha_cierre', 'rsh_maximo', 'nem_minimo', 'regiones', 'documentos_requeridos'):
                self.assertEqual('', rows[0][field], field)
            self.assertEqual(text, (corpus / 'a.csv').read_text(encoding='utf-8'))

    def test_extra_columns_are_preserved_and_flagged_without_inventing_fields(self):
        with tempfile.TemporaryDirectory() as work:
            root = Path(work)
            (root / 'input').mkdir()
            (root / 'input/a.csv').write_text('nombre,institucion,url\nBeca,Institución,https://example.com/,extra\n', encoding='utf-8')
            prepare.prepare(root / 'input', root / 'out')
            row = json.loads((root / 'out/originales.jsonl').read_text(encoding='utf-8'))
            self.assertEqual(['COLUMNAS_EXTRA'], row['hallazgos_parser'])
            self.assertEqual(['extra'], row['original']['_columnas_extra'])

    def test_lost_identity_is_rejected_instead_of_guessed(self):
        with self.assertRaises(ValueError):
            prepare.spelling('Universidad con carácter \ufffd')

    def test_evidence_cannot_activate_an_unverified_candidate(self):
        with tempfile.TemporaryDirectory() as work:
            root = Path(work)
            (root / 'input').mkdir()
            (root / 'input/a.csv').write_text('nombre,institucion,url\nBeca,Institución,\n', encoding='utf-8')
            evidence = [{'nombre': 'Beca', 'institucion': 'Institución', 'fuentes': ['https://example.com/beca'],
                         'revisado': '2026-10-01', 'campos': {'estado_activa': 'true'}}]
            with self.assertRaises(ValueError):
                prepare.prepare(root / 'input', root / 'out', evidence)


if __name__ == '__main__':
    unittest.main()
