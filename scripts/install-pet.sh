#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: ./scripts/install-pet.sh <pet-directory>" >&2
  exit 2
fi

pet="$1"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
source_dir="$repo_root/$pet"
pet_json="$source_dir/pet.json"
sprite="$source_dir/spritesheet.webp"

if [ ! -d "$source_dir" ]; then
  echo "Pet package not found: $source_dir" >&2
  exit 1
fi

if [ ! -f "$pet_json" ]; then
  echo "Missing pet.json: $pet_json" >&2
  exit 1
fi

if [ ! -f "$sprite" ]; then
  echo "Missing spritesheet.webp: $sprite" >&2
  exit 1
fi

python_bin=""
if command -v python3 >/dev/null 2>&1; then
  python_bin="python3"
elif command -v python >/dev/null 2>&1; then
  python_bin="python"
else
  echo "python3 or python is required to read pet.json" >&2
  exit 1
fi

pet_id="$("$python_bin" - "$pet_json" <<'PY'
import json
import sys
with open(sys.argv[1], "r", encoding="utf-8") as f:
    data = json.load(f)
pet_id = data.get("id")
if not pet_id:
    raise SystemExit("pet.json must contain an id field")
print(pet_id)
PY
)"

display_name="$("$python_bin" - "$pet_json" <<'PY'
import json
import sys
with open(sys.argv[1], "r", encoding="utf-8") as f:
    data = json.load(f)
print(data.get("displayName") or data.get("id") or "pet")
PY
)"

dest_dir="$HOME/.codex/pets/$pet_id"
mkdir -p "$dest_dir"
cp "$pet_json" "$dest_dir/pet.json"
cp "$sprite" "$dest_dir/spritesheet.webp"

echo "Installed $display_name to $dest_dir"

