import importlib.util
import csv
import json
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('variants', Path(__file__).with_name('report-corpus-variants.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class VariantsTest(unittest.TestCase):
    def test_reconstruction_replaces_malformed_row_and_retains_conflicting_values(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            (folder/'reparaciones').mkdir()
            originals = [dict(archivo='a.csv', registro=1, candidato='a', original={'monto':'100', 'url':'/a'}),
                         dict(archivo='b.csv', registro=1, candidato='a', original={'monto':'corrupto'}),
                         dict(archivo='b.csv', registro=2, candidato='b', original={'monto':'300'})]
            repairs = [dict(archivo='b.csv', registro_logico_anterior=1, linea_fisica=2, candidato='a',
                            nombre='Beca A', institucion='Institución', reconstruido={'monto':'200', 'url':'/a'})]
            for path, data in [('originales.jsonl', originals), ('reparaciones/reparados.jsonl', repairs)]:
                (folder/path).write_text('\n'.join(json.dumps(row) for row in data), encoding='utf-8')
            (folder/'indice.csv').write_text('candidato,nombre,institucion\na,Beca A,Institución\nb,Beca B,Institución\n', encoding='utf-8')
            self.assertEqual(dict(grupos=1, referencias=2, referencias_adicionales=1, grupos_con_campos_distintos=1, grupos_conciliados=0, grupos_pendientes=1), module.report(folder))
            groups = json.loads((folder/'variantes/referencias.json').read_text(encoding='utf-8'))
            self.assertEqual(['monto'], groups[0]['campos_distintos'])
            self.assertEqual(['100', '200'], [row['campos']['monto'] for row in groups[0]['referencias']])
            with (folder/'variantes/grupos.csv').open(encoding='utf-8', newline='') as stream:
                self.assertEqual('PENDIENTE_CONCILIACION', next(csv.DictReader(stream))['estado'])
            (folder/'variantes/review.md').write_text('Identidad confirmada; monto histórico desconocido',encoding='utf-8')
            entry = dict(candidato='a', fuentes=['https://example.org/beca'], decision_identidad='Mismo beneficio', informe='review.md', campos={})
            (folder/'variantes/conciliaciones.json').write_text(json.dumps([entry]),encoding='utf-8')
            with self.assertRaises(ValueError): module.report(folder)
            entry['campos'] = {'monto':'DESCONOCIDO; no usar importes históricos como prueba'}
            (folder/'variantes/conciliaciones.json').write_text(json.dumps([entry]),encoding='utf-8')
            self.assertEqual(1,module.report(folder)['grupos_conciliados'])


if __name__ == '__main__':
    unittest.main()
