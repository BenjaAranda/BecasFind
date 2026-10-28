"""Regresiones de transición con Docker y HTTP simulados; sin acceso a Oracle."""
import contextlib
import importlib.util
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import MagicMock, patch

spec = importlib.util.spec_from_file_location('preview_transition', Path(__file__).with_name('connect-p12-preview.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class PreviewTransitionTest(unittest.TestCase):
    def exercise(self, fail_run=False, unexpected_mount=False, fail_health=False, new_image=None):
        with tempfile.TemporaryDirectory() as directory:
            home = Path(directory)
            envfile = home / '.config/becasfind/backend.env'
            envfile.parent.mkdir(parents=True)
            original = b'CORS_ALLOWED_ORIGINS=https://previous.example\nFRONTEND_URL=https://previous.example\nDB_PASSWORD=private\n'
            envfile.write_bytes(original)
            config = {'Env': original.decode().splitlines(), 'User': '999',
                      'Entrypoint': ['java', '-jar', 'app.jar'], 'Cmd': None,
                      'WorkingDir': '/app'}
            current = {'Id': 'old-id', 'Image': 'sha256:old-image', 'Config': config,
                       'State': {'Running': True}, 'Mounts': ['unexpected'] if unexpected_mount else [],
                       'NetworkSettings': {'Networks': {'becasfind-private': {}}},
                       'HostConfig': {'Privileged': False,
                                      'PortBindings': {'8080/tcp': [{'HostIp': '127.0.0.1', 'HostPort': '8080'}]},
                                      'RestartPolicy': {'Name': 'unless-stopped'}, 'Memory': 2147483648,
                                      'CapDrop': ['ALL'], 'SecurityOpt': ['no-new-privileges'],
                                      'LogConfig': {'Type': 'json-file', 'Config': {'max-size': '10m', 'max-file': '3'}}}}
            calls = []
            created = False

            def docker(*args):
                nonlocal created
                calls.append(args)
                if args[:2] == ('image', 'inspect'):
                    return json.dumps([{'Config': config, 'Id': 'sha256:new-image'}])
                if args[0] == 'run':
                    if fail_run:
                        raise RuntimeError('simulated failure')
                    created = True
                    return 'new-id'
                return ''

            response = MagicMock()
            response.__enter__.return_value = response
            response.status = 200
            response.headers = {'Access-Control-Allow-Origin': 'wrong' if fail_health else module.ORIGIN}
            with patch.object(module.Path, 'home', return_value=home), \
                    patch.object(module, 'inspect', side_effect=lambda: {**current, 'Id': 'new-id'} if created else current), \
                    patch.object(module, 'docker', side_effect=docker), \
                    patch.object(module.time, 'sleep'), \
                    patch.object(module.json, 'load', return_value={'data': {'totalElements': 528}}), \
                    patch.object(module.urllib.request, 'urlopen', return_value=response), contextlib.redirect_stdout(io.StringIO()):
                if fail_run or unexpected_mount or fail_health:
                    with self.assertRaises(RuntimeError):
                        module.main(new_image)
                    self.assertEqual(envfile.read_bytes(), original)
                else:
                    module.main(new_image)
                    updated = envfile.read_text()
                    self.assertIn('https://previous.example,' + module.ORIGIN, updated)
                    self.assertIn('FRONTEND_URL=https://previous.example\n', updated)
                    self.assertIn('DB_PASSWORD=private\n', updated)
            return calls

    def test_success_keeps_old_origin_mail_and_image(self):
        calls = self.exercise()
        run = next(call for call in calls if call[0] == 'run')
        self.assertEqual(run[-1], 'sha256:old-image')
        self.assertFalse(any(call[0] == 'rm' for call in calls))

    def test_new_catalog_image_uses_resolved_digest_and_preserves_environment(self):
        calls = self.exercise(new_image='becasfind-api:catalogo-719646b')
        run = next(call for call in calls if call[0] == 'run')
        self.assertEqual(run[-1], 'sha256:new-image')

    def test_new_image_failure_restores_previous_container(self):
        calls = self.exercise(new_image='becasfind-api:catalogo-719646b', fail_run=True)
        self.assertEqual(calls[-1], ('start', module.NAME))

    def test_failed_creation_restores_old_configuration_and_container(self):
        calls = self.exercise(fail_run=True)
        self.assertEqual(calls[-1], ('start', module.NAME))
        self.assertTrue(any(call[0] == 'rename' and call[-1] == module.NAME for call in calls))

    def test_unknown_configuration_aborts_before_stop(self):
        calls = self.exercise(unexpected_mount=True)
        self.assertFalse(any(call[0] in ('run', 'stop', 'rename', 'rm') for call in calls))

    def test_bad_cors_removes_only_new_container_and_restores_previous(self):
        calls = self.exercise(fail_health=True)
        self.assertIn(('rm', module.NAME), calls)
        self.assertEqual(calls[-1], ('start', module.NAME))


if __name__ == '__main__':
    unittest.main()
