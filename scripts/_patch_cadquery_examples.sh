#!/usr/bin/env bash
set -euo pipefail

find "./examples/" -type f -name '*.py' -print0 \
| while IFS= read -r -d '' f; do
    base="$(basename "$f" .py)"
    out="${base}.step"

    # Patch any line that *starts* with optional whitespace then show_object(...)
    if grep -qE '^[[:space:]]*show_object[[:space:]]*\(' "$f"; then
      sed -i.bak -E \
        "s/^([[:space:]]*)show_object[[:space:]]*\\([[:space:]]*([^,)]*)[^)]*\\)([[:space:]]*(#.*)?)$/\\1cq.exporters.export(\\2, \"${out}\")\\3/" \
        "$f"
      echo "patched: $f -> $out"
    fi
  done

echo "Done. Backups saved as *.bak next to each modified file."
