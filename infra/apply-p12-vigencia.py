"""Apply the two reviewed calendar decisions after a private verified backup."""
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
import urllib.request


def main():
    os.umask(0o077)
    folder = Path(__file__).resolve().parent
    spec = importlib.util.spec_from_file_location('p12_import', folder / 'import-p12-catalog.py')
    helper = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(helper)
    if helper.sql('becasfind', helper.mojibake_query()) != '0':
        raise RuntimeError('Hay patrones de codificación pendientes. No se aplicara el cambio.')
    if helper.sql('becasfind', 'SELECT count(*) FROM becas') != '528':
        raise RuntimeError('El catalogo cambio. Revisar antes de continuar.')
    if helper.sql('becasfind', 'SELECT count(*) FROM becas WHERE estado_activa') != '0':
        raise RuntimeError('Ya hay fichas activas. Revisar el estado actual antes de continuar.')
    helper.verify_backup()
    with (folder / 'apply-p12-vigencia.sql').open('rb') as source:
        subprocess.run(['sudo', '-n', 'docker', 'exec', '-i', 'becasfind-db', 'psql',
                        '-X', '-U', 'postgres', '-d', 'becasfind', '-v', 'ON_ERROR_STOP=1'],
                       stdin=source, check=True)
    with urllib.request.urlopen('http://127.0.0.1:8080/api/becas', timeout=30) as response:
        page = json.load(response)['data']
    if page.get('totalElements') != 1 or page['content'][0].get('nombre') != 'Beca Hijos de Funcionarios':
        raise RuntimeError('El cambio SQL terminó, pero la API requiere comprobacion. No repetir automáticamente.')
    print('API verificada: una ficha publica; 528 fichas totales. Calendario UDD corregido sin activacion.')


if __name__ == '__main__':
    try:
        main()
    except (RuntimeError, OSError, ValueError, KeyError, IndexError, subprocess.CalledProcessError) as error:
        print('ERROR: la aplicación del cambio se detuvo. No repetir sin revisar el estado.', file=sys.stderr)
        if isinstance(error, RuntimeError):
            print(str(error), file=sys.stderr)
        sys.exit(1)
