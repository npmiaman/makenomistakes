#!/usr/bin/env bash
# Usage: evals/render.sh <fixture_dir> <out_dir> [case ids...]
# cases.tsv columns: id, expect, setup ("-" for none), prompt (may be empty = scout mode).
# For each case in cases.tsv: copy the fixture (cp -R keeps git state and the live deploy
# slot), run the case's setup, then render SKILL.md exactly as Claude Code would —
# frontmatter stripped, $ARGUMENTS substituted, snapshot inlined, reference paths absolute.
# Then give one subagent per case: "read caseN.prompt.md and follow it in caseN/".
set -eu
here=$(cd "$(dirname "$0")/../skills/makenomistakes" && pwd); fixture=$1; out=$2; shift 2
mkdir -p "$out"
tail -n +2 "$(dirname "$0")/cases.tsv" | while IFS=$'\t' read -r id expect setup prompt; do
  if [ $# -gt 0 ] && ! printf '%s\n' "$@" | grep -qx "$id"; then continue; fi
  w="$out/case$id"; rm -rf "$w"; cp -R "$fixture" "$w"
  git -C "$w" remote set-url origin "$w/.origin.git" 2>/dev/null   # each copy pushes to its own origin
  [ "$setup" != "-" ] && (cd "$w" && eval "$setup")
  snap=$(cd "$w" && bash "$here/scripts/snapshot.sh")
  python3 -I - "$here/SKILL.md" "$prompt" "$snap" "$out/case$id.prompt.md" "$here/references/" <<'PY'
import sys, re
src, args, snap, out, refs = sys.argv[1:6]
t = open(src).read()
t = re.sub(r'^---\n.*?\n---\n', '', t, flags=re.S)
t = t.replace('$ARGUMENTS', args)
t = t.replace('!`bash "${CLAUDE_SKILL_DIR}/scripts/snapshot.sh"`', '```\n' + snap + '\n```')
t = t.replace('](references/', '](' + refs).replace('`references/', '`' + refs)
open(out, 'w').write(t)
n = len(t)
print(f"case rendered: {out} ({n} chars){'  WARNING: over 20k' if n > 20000 else ''}")
PY
  echo "  expect: $expect"
done
