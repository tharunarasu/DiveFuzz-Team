#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/env-final-f.sh"
mkdir -p "$DIVEFUZZ_ROOT/evidence/final/build" "$DIVEFUZZ_ROOT/.local/downloads"
exec > >(tee "$DIVEFUZZ_ROOT/evidence/final/build/tools.log") 2>&1
if [ ! -x "$JAVA_HOME/bin/java" ]; then
  curl -fL --retry 2 'https://api.adoptium.net/v3/assets/latest/17/hotspot?architecture=x64&image_type=jdk&os=linux' -o "$DIVEFUZZ_ROOT/.local/downloads/jdk17-metadata.json"
  python - "$DIVEFUZZ_ROOT" <<'PY'
import hashlib, json, pathlib, sys, urllib.request
root = pathlib.Path(sys.argv[1])
asset = json.loads((root / '.local/downloads/jdk17-metadata.json').read_text())[0]['binary']['package']
archive = root / '.local/downloads/jdk17.tar.gz'
urllib.request.urlretrieve(asset['link'], archive)
actual = hashlib.sha256(archive.read_bytes()).hexdigest()
assert actual == asset['checksum'], 'JDK checksum mismatch'
print('Verified JDK SHA256:', actual)
PY
  mkdir -p "$JAVA_HOME"
  tar -xzf "$DIVEFUZZ_ROOT/.local/downloads/jdk17.tar.gz" -C "$JAVA_HOME" --strip-components=1
fi
if [ ! -f "$DIVEFUZZ_ROOT/.local/bin/mill" ]; then
  curl -fL --retry 2 'https://github.com/com-lihaoyi/mill/releases/download/0.11.2/0.11.2' -o "$DIVEFUZZ_ROOT/.local/bin/mill"
  chmod +x "$DIVEFUZZ_ROOT/.local/bin/mill"
fi
java -version
mill -i --version
