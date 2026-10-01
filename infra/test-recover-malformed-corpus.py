import csv
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('recover', Path(__file__).with_name('recover-malformed-corpus.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class StructureRecoveryTest(unittest.TestCase):
    def test_unclosed_quotes_restore_two_records_without_certifying_or_changing_originals(self):
        with tempfile.TemporaryDirectory() as temp:
            base = Path(temp)
            corpus = base / 'input'
            corpus.mkdir()
            lines = [','.join(module.FIELDS)]
            for name in ['Beca Histórica', 'Otra Beca']:
                lines.append(f'{name},Institución,Tipo,99,2026-01-01,2026-12-31,60,5.5,,Resumen,"Texto histórico. https://example.com/beca,[OBLIGATORIO] Documento histórico')
            raw = ('\r\n'.join(lines)+'\r\n').encode('utf-8')
            path = corpus / 'a.csv'
            path.write_bytes(raw)
            manifest = {'files': [{'filename':'a.csv', 'sha256_lf':hashlib.sha256(raw.replace(b'\r\n',b'\n')).hexdigest(),
                'actions':[{'line':n,'kind':'close_description_before_url','url':'https://example.com/beca'} for n in [2,3]]}]}
            first = module.transform(lines[1], manifest['files'][0]['actions'][0])
            identity = module.prepare.key(module.prepare.spelling(first['institucion']))+'\0'+module.prepare.key(module.prepare.spelling(first['nombre']))
            baseline = [{'candidato':hashlib.sha256(identity.encode('utf-8')).hexdigest()}]
            summary = module.recover(corpus,manifest,baseline,base/'output')
            self.assertEqual(2, summary['lineas_reconstruidas'])
            self.assertEqual(1, summary['candidatos_nuevos'])
            with (base/'output/recuperados_administrativos.csv').open(encoding='utf-8',newline='') as file:
                rows = list(csv.DictReader(file))
            self.assertEqual(1,len(rows))
            self.assertEqual('false',rows[0]['estado_activa'])
            self.assertEqual('true',rows[0]['solo_crear'])
            for field in ['url','monto','rsh_maximo','nem_minimo','fecha_inicio','fecha_cierre','documentos_requeridos']:
                self.assertEqual('',rows[0][field],field)
            repaired = [json.loads(line) for line in (base/'output/reparados.jsonl').read_text(encoding='utf-8').splitlines()]
            self.assertEqual('99',repaired[1]['reconstruido']['monto'])
            self.assertEqual(lines[2],repaired[1]['linea_original'])
            self.assertEqual(raw,path.read_bytes())
            manifest['files'][0]['sha256_lf']='0'*64
            with self.assertRaises(ValueError): module.recover(corpus,manifest,baseline,base/'rejected')
            self.assertFalse((base/'rejected').exists())

    def test_middle_commas_are_reassembled_only_with_reviewed_tail_anchors(self):
        values = ['Beca','Institución','Tipo','','','','','','','Resumen','Texto',' con coma','https://example.com/beca','[OBLIGATORIO] Documento']
        stream = io.StringIO()
        csv.writer(stream).writerow(values)
        line = stream.getvalue().strip()
        result = module.transform(line,{'kind':'join_description_fragments'})
        self.assertEqual('Texto, con coma',result['descripcion_larga'])
        with self.assertRaises(ValueError): module.transform(line.replace('https://example.com/beca','texto ambiguo'),{'kind':'join_description_fragments'})

    def test_empty_region_column_requires_exact_shape_and_region_token(self):
        values = ['Beca','Institución','Tipo','','','','','','','XIV,X','Resumen','Texto','https://example.com/beca','[OBLIGATORIO] Documento']
        stream = io.StringIO()
        csv.writer(stream).writerow(values)
        line = stream.getvalue().strip()
        self.assertEqual('XIV,X',module.transform(line,{'kind':'remove_empty_region_column'})['regiones'])
        with self.assertRaises(ValueError): module.transform(line.replace('XIV,X','descripción desconocida'),{'kind':'remove_empty_region_column'})

    def test_ambiguous_boundary_and_unknown_repairs_fail_closed(self):
        with self.assertRaises(ValueError): module.transform('Texto sin límite',{'kind':'close_description_before_url','url':'https://example.com/beca'})
        with self.assertRaises(ValueError): module.transform('Texto',{'kind':'inventar'})
        with tempfile.TemporaryDirectory() as temp:
            corpus = Path(temp)
            with self.assertRaises(ValueError): module.recover(corpus,{'files':[]},[],corpus/'output')


if __name__ == '__main__':
    unittest.main()
