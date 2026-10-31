import contextlib
import importlib.util
import io
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch


spec = importlib.util.spec_from_file_location('p12_import', Path(__file__).with_name('import-p12-catalog.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
CATALOG = Path(__file__).resolve().parents[1] / 'documentacion/auditoria_corpus/procesados/despliegue_p12/confirmadas_inactivas.csv'


class ImportGuardsTest(unittest.TestCase):
    @unittest.skipUnless(os.environ.get('BECASFIND_ENCODING_TEST_PORT'), 'Requires an isolated PostgreSQL test server')
    def test_sql_distinguishes_decimal_commas_from_corrupt_utf8_bytes(self):
        count_query = module.mojibake_query().replace('SELECT count(*)', 'SELECT count(*) INTO affected', 1)
        script = """
BEGIN;
CREATE TEMP TABLE becas(nombre text, descripcion_corta text, descripcion_larga text);
INSERT INTO becas VALUES ('5,8, concordante','',''), ('','5,8, 30%',''), ('','','5,8, concordante');
DO $$ DECLARE affected bigint; BEGIN
QUERY
IF affected <> 0 THEN RAISE EXCEPTION 'Valid decimal commas were flagged'; END IF;
END $$;
INSERT INTO becas VALUES (convert_from(decode('c383c2b3','hex'),'UTF8'),'',''),
 ('',convert_from(decode('c383e28098','hex'),'UTF8'),''),
 ('','',convert_from(decode('c382c2a1','hex'),'UTF8'));
DO $$ DECLARE affected bigint; BEGIN
QUERY
IF affected <> 3 THEN RAISE EXCEPTION 'Corrupt UTF-8 sequences were missed'; END IF;
END $$;
ROLLBACK;
""".replace('QUERY', count_query + ';')
        binary = os.environ.get('BECASFIND_TEST_PSQL', 'psql')
        subprocess.run([binary, '-X', '-h', '127.0.0.1', '-p', os.environ['BECASFIND_ENCODING_TEST_PORT'],
                        '-U', 'postgres', '-d', 'postgres', '-v', 'ON_ERROR_STOP=1'],
                       input=script, encoding='utf-8', check=True, stdout=subprocess.PIPE,
                       stderr=subprocess.PIPE)

    def test_changed_catalog_stops_before_credentials_or_database_access(self):
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / 'changed.csv'
            path.write_bytes(CATALOG.read_bytes() + b'\n')
            with patch.object(sys, 'argv', ['import-p12-catalog.py', str(path)]), \
                    patch.object(module, 'api_request') as api, \
                    patch.object(module, 'sql') as sql, \
                    patch.object(module.getpass, 'getpass') as password:
                with self.assertRaisesRegex(RuntimeError, 'paquete revisado'):
                    module.main()
                api.assert_not_called()
                sql.assert_not_called()
                password.assert_not_called()

    def test_restore_failure_prevents_import(self):
        with patch.object(sys, 'argv', ['import-p12-catalog.py', str(CATALOG)]), \
                patch('builtins.input', return_value=''), \
                patch.object(module.getpass, 'getpass', return_value='test-only'), \
                patch.object(module, 'api_request', return_value={'data': {'token': 'test-only-token'}}) as api, \
                patch.object(module, 'sql', return_value='1'), \
                patch.object(module, 'verify_backup', side_effect=RuntimeError('restore failed')):
            with self.assertRaisesRegex(RuntimeError, 'restore failed'):
                module.main()
            self.assertEqual([call.args[0] for call in api.call_args_list], ['auth/login'])

    def test_reported_import_errors_stop_post_import_checks(self):
        responses = [{'data': {'token': 'test-only-token'}},
                     {'data': {'creadas': 0, 'actualizadas': 0, 'errores': 1,
                               'mensajesError': ['invalid row']}}]
        with patch.object(sys, 'argv', ['import-p12-catalog.py', str(CATALOG)]), \
                patch('builtins.input', return_value=''), \
                patch.object(module.getpass, 'getpass', return_value='test-only'), \
                patch.object(module, 'api_request', side_effect=responses), \
                patch.object(module, 'sql', side_effect=['1', '0', '0']) as sql, \
                patch.object(module, 'verify_backup'), \
                contextlib.redirect_stdout(io.StringIO()):
            with self.assertRaisesRegex(RuntimeError, 'API informa errores'):
                module.main()
            self.assertEqual(sql.call_count, 3)


if __name__ == '__main__':
    unittest.main()
