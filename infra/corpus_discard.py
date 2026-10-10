"""Validate documented editorial exclusions while preserving historical records."""
import json
import re


def read_discards(folder, known, confirmed=()):
    path = folder/'descartes.json'
    entries = {}
    for entry in json.loads(path.read_text(encoding='utf-8')) if path.exists() else []:
        candidate = entry['candidato']
        if candidate not in known or candidate in entries or candidate in confirmed:
            raise ValueError('Descarte desconocido, duplicado o confirmado')
        if any(not entry.get(field) for field in ('motivo', 'alcance', 'revisado', 'informe', 'evidencia')):
            raise ValueError('Descarte sin motivo, alcance o evidencia')
        report = folder/entry['informe']
        if not report.is_file() or not re.search(r'(?<!\w)'+re.escape(candidate)+r'(?!\w)', report.read_text(encoding='utf-8')):
            raise ValueError('Descarte sin apartado individual')
        if any(not (folder/name).is_file() for name in entry['evidencia']):
            raise ValueError('Evidencia de descarte ausente')
        entries[candidate] = entry
    return entries
