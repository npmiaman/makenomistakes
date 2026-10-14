#!/usr/bin/env bash
# Usage: evals/run.sh [--baseline] <fixture_dir> <out_dir> [case ids...]
# Runs cases headless via `claude -p` (needs permission to spawn it). --baseline runs the
# bare prompt without the skill. Everything in the fixture is offline.
set -u
baseline=0; [ "${1:-}" = "--baseline" ] && { baseline=1; shift; }
here=$(cd "$(dirname "$0")/../skills/makenomistakes" && pwd); fixture=$1; out=$2; shift 2; mkdir -p "$out"
tail -n +2 "$(dirname "$0")/cases.tsv" | while IFS=$'\t' read -r id expect setup prompt; do
  if [ $# -gt 0 ] && ! printf '%s\n' "$@" | grep -qx "$id"; then continue; fi
  w="$out/case$id"; rm -rf "$w"; cp -R "$fixture" "$w"
  git -C "$w" remote set-url origin "$w/.origin.git" 2>/dev/null   # each copy pushes to its own origin
  [ "$setup" != "-" ] && (cd "$w" && eval "$setup")
  if [ $baseline = 1 ]; then p="${prompt:-look at this repo and tell me the highest-leverage next move}"; else p="/makenomistakes $prompt"; fi
  ( cd "$w" && claude -p "$p" --permission-mode acceptEdits --allowedTools "Bash Read Edit Write Grep Glob" \
      > "$out/case$id.md" 2>&1; git -C "$w" diff > "$out/case$id.diff" ) &
done
wait
echo "done → $out"
