import csv
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('audit', Path(__file__).with_name('audit-editorial-evidence.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class EvidenceTest(unittest.TestCase):
    def test_repeated_references_share_case_and_http_access_does_not_certify(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            (folder/'avance').mkdir()
            (folder/'variantes').mkdir()
            fields = ['archivo','referencia','candidato','nombre','institucion','estado']
            with (folder/'avance/por_registro.csv').open('w',encoding='utf-8',newline='') as stream:
                writer = csv.DictWriter(stream,fieldnames=fields)
                writer.writeheader()
                writer.writerows(dict(archivo=name, referencia='1', candidato='abc', nombre='Beca', institucion='Institución', estado='REVISION_PARCIAL') for name in ['a.csv','b.csv'])
            (folder/'revisiones_parciales.csv').write_text('candidato,informe\nabc,report.md\n',encoding='utf-8')
            (folder/'variantes/grupos.csv').write_text('candidato,campos_distintos\nabc,monto\n',encoding='utf-8')
            (folder/'report.md').write_text('## Institución\nCandidato: `abc`.\nFuente: https://example.org/beca\nCalendario pendiente.\n',encoding='utf-8')
            cases, reports = module.inventory(folder)
            self.assertEqual(1,len(cases))
            self.assertEqual(2,len(cases[0]['referencias']))
            self.assertEqual('PENDIENTE_CONFIRMACION_COMPLETA',cases[0]['estado'])
            self.assertTrue(cases[0]['grupo_variantes'])
            self.assertIn('Calendario pendiente.',cases[0]['revisiones'][0]['extractos'][0])
            self.assertEqual(['https://example.org/beca'],reports['report.md']['urls'])
            (folder/'variantes/conciliaciones.json').write_text(json.dumps([dict(candidato='abc',informe='decision.md')]),encoding='utf-8')
            with self.assertRaisesRegex(ValueError, 'Conciliación'):
                module.inventory(folder)
            (folder/'variantes/grupos.csv').write_text('candidato,campos_distintos,estado\nabc,monto,CONCILIADO\n',encoding='utf-8')
            (folder/'variantes/decision.md').write_text('Decisión documentada.',encoding='utf-8')
            cases, _ = module.inventory(folder)
            self.assertEqual('variantes/decision.md',cases[0]['informe_conciliacion'])
            self.assertEqual('PENDIENTE_CONFIRMACION_COMPLETA',cases[0]['estado'])

    def test_unsupported_source_url_never_requested(self):
        sources = module.check_sources(['file:///private/file'],1)
        self.assertEqual('URL_NO_ADMITIDA',sources[0]['estado'])


if __name__ == '__main__':
    unittest.main()
