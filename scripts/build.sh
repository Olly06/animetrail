#!/usr/bin/env bash
# Crea i pacchetti in dist/ a partire da src/:
#   animetrail-<versione>-firefox.zip       (manifest invariato, da firmare/inviare ad AMO)
#   animetrail-<versione>-chrome-store.zip  (senza il campo "key": lo store assegna l'ID)
# Esclude i file nascosti (es. .amo-upload-uuid creato da web-ext).
set -euo pipefail
cd "$(dirname "$0")/.."

python3 - <<'PY'
import json, os, zipfile

SRC, DIST = 'src', 'dist'
manifest = json.load(open(f'{SRC}/manifest.json', encoding='utf-8'))
version = manifest['version']
os.makedirs(DIST, exist_ok=True)

def build(out, transform=None):
    with zipfile.ZipFile(out, 'w', zipfile.ZIP_DEFLATED) as z:
        for root, dirs, files in os.walk(SRC):
            dirs.sort()
            for name in sorted(files):
                if name.startswith('.'):
                    continue
                path = os.path.join(root, name)
                rel = os.path.relpath(path, SRC)
                if rel == 'manifest.json' and transform:
                    data = json.load(open(path, encoding='utf-8'))
                    z.writestr(rel, json.dumps(transform(data), indent=2, ensure_ascii=False) + '\n')
                else:
                    z.write(path, rel)
    print(f'{out}  {os.path.getsize(out) // 1024} KB')

build(f'{DIST}/animetrail-{version}-firefox.zip')
build(f'{DIST}/animetrail-{version}-chrome-store.zip', lambda m: {k: v for k, v in m.items() if k != 'key'})

desc = len(manifest['description'])
print(f'versione {version}, descrizione {desc} caratteri' + ('  ATTENZIONE: Chrome Web Store accetta max 132' if desc > 132 else ''))
PY
