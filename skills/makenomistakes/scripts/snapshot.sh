#!/usr/bin/env bash
# Situational snapshot injected at the end of /makenomistakes.
# Must never fail (a non-zero exit aborts the skill) and must stay fast.
# Every list is capped; sections with nothing to report print nothing.
set +e
export GIT_OPTIONAL_LOCKS=0   # never take index.lock (parallel worktrees)

echo "cwd: $PWD"

root=$PWD
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  root=$(git rev-parse --show-toplevel)
  echo "repo: $root"
  common=$(cd "$root" && cd "$(git rev-parse --git-common-dir)" 2>/dev/null && pwd)
  gitdir=$(cd "$root" && cd "$(git rev-parse --git-dir)" 2>/dev/null && pwd)
  [ -n "$common" ] && [ "$common" != "$gitdir" ] && echo "worktree of: $(dirname "$common")"
  branch=$(git branch --show-current 2>/dev/null)
  echo "branch: ${branch:-detached at $(git rev-parse --short HEAD 2>/dev/null || echo 'no commits')}"
  up=$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
  [ -n "$up" ] && echo "upstream: $up ($(git rev-list --left-right --count "$up"...HEAD 2>/dev/null | awk '{print "behind " $1 ", ahead " $2}'))"
  base=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null)
  [ -n "$base" ] && [ "$base" != "$up" ] && echo "default: $base ($(git rev-list --count "$base"..HEAD 2>/dev/null) commits ahead)"
  wt=$(git worktree list 2>/dev/null | wc -l | tr -d ' ')
  [ "${wt:-0}" -gt 1 ] && echo "worktrees: $wt (git worktree list)"
  n=$(git status --short 2>/dev/null | wc -l | tr -d ' ')
  if [ "${n:-0}" -gt 0 ]; then
    echo "--- uncommitted: $n files (first 20)"
    git status --short 2>/dev/null | head -20
    echo "--- diff stat vs HEAD"
    git diff HEAD --stat 2>/dev/null | tail -8
  else
    echo "uncommitted: none"
  fi
  echo "--- last 8 commits"
  git log --oneline -8 2>/dev/null
else
  echo "repo: none (not a git repo)"
fi

cd "$root" 2>/dev/null || exit 0

# Steering
steer=""
for f in CLAUDE.md CLAUDE.local.md AGENTS.md CONTEXT.md CODING_STANDARDS.md README.md; do [ -e "$f" ] && steer="$steer $f"; done
for f in apps/*/CLAUDE.md packages/*/CLAUDE.md services/*/CLAUDE.md; do [ -e "$f" ] && steer="$steer $f"; done
[ -n "$steer" ] && echo "steering:$steer"

# Manifests and workspace scripts (root first, then up to 10 workspaces)
man=""
for f in package.json pyproject.toml go.mod Cargo.toml Gemfile pom.xml build.gradle Makefile justfile turbo.json pnpm-workspace.yaml; do [ -e "$f" ] && man="$man $f"; done
[ -n "$man" ] && echo "manifests:$man"
if command -v node >/dev/null 2>&1; then
  pk=""
  [ -f package.json ] && pk="package.json"
  for d in apps/* packages/* services/* libs/*; do [ -f "$d/package.json" ] && pk="$pk $d/package.json"; done
  if [ -n "$pk" ]; then
    echo "--- scripts"
    node -e '
      for (const p of process.argv.slice(1).slice(0, 11)) {
        try { const s = Object.keys(require(require("path").resolve(p)).scripts || {}).slice(0, 12);
              if (s.length) console.log(`${p.replace(/\/?package\.json$/, "") || "."}: ${s.join(" ")}`); } catch {}
      }' $pk 2>/dev/null
  fi
fi
ws=$(ls -d apps/* packages/* services/* libs/* 2>/dev/null | head -12 | tr '\n' ' ')
[ -n "$ws" ] && echo "workspaces: $ws"

# Gates: CI, git hooks, Claude Code hooks and project skills
ci=""
[ -d .github/workflows ] && ci="$ci $(ls .github/workflows | head -8 | tr '\n' ' ')"
[ -f .gitlab-ci.yml ] && ci="$ci .gitlab-ci.yml"
[ -d .circleci ] && ci="$ci .circleci/"
echo "CI:${ci:- none}"
hooks=""
hp=$(git config core.hooksPath 2>/dev/null)
[ -n "$hp" ] && [ -d "$hp" ] && hooks="$hooks $hp/{$(ls "$hp" | head -8 | tr '\n' ',' | sed 's/,$//')}"
[ -d .husky ] && hooks="$hooks .husky/{$(ls .husky | grep -v '^_' | head -8 | tr '\n' ',' | sed 's/,$//')}"
for f in .pre-commit-config.yaml lefthook.yml; do [ -e "$f" ] && hooks="$hooks $f"; done
gh=$(git rev-parse --git-path hooks 2>/dev/null)
[ -z "$hp" ] && [ -d "$gh" ] && { x=$(ls "$gh" 2>/dev/null | grep -v '\.sample$' | head -6 | tr '\n' ' '); [ -n "$x" ] && hooks="$hooks .git/hooks: $x"; }
[ -n "$hooks" ] && echo "git hooks:$hooks"
cl=""
for s in .claude/settings.json .claude/settings.local.json; do
  [ -f "$s" ] && { ev=$(grep -oE '"(PreToolUse|PostToolUse|Stop|SessionStart|UserPromptSubmit|SubagentStop|PreCompact|SessionEnd)"' "$s" | tr -d '"' | sort -u | tr '\n' ' '); [ -n "$ev" ] && cl="$cl hooks($s): $ev"; }
done
for d in skills commands agents; do
  [ -d ".claude/$d" ] && { x=$(ls ".claude/$d" | sed 's/\.md$//' | head -10 | tr '\n' ' '); [ -n "$x" ] && cl="$cl $d: $x"; }
done
[ -n "$cl" ] && echo "claude:$cl"

# Deploy
dep=""
for d in . deploy infra ops; do
  for f in Dockerfile docker-compose.yml docker-compose.yaml compose.yml compose.yaml Caddyfile fly.toml Procfile render.yaml vercel.json netlify.toml; do
    [ -e "$d/$f" ] && dep="$dep ${d#./}/$f"
  done
  [ -d "$d/systemd" ] && dep="$dep $d/systemd/"
  ls "$d"/*.tf >/dev/null 2>&1 && dep="$dep $d/*.tf"
done
for f in apps/*/vercel.json apps/*/Dockerfile; do [ -e "$f" ] && dep="$dep $f"; done
[ -n "$dep" ] && echo "deploy:$(echo "$dep" | sed 's#\./##g' | tr ' ' '\n' | head -14 | tr '\n' ' ')"

# Docs
if [ -d docs ]; then
  echo "docs/: $(ls docs | head -12 | tr '\n' ' ')"
  [ -d docs/adr ] && echo "ADRs: docs/adr ($(ls docs/adr | wc -l | tr -d ' ') files)"
  [ -f docs/agents/issue-tracker.md ] && echo "issue tracker: configured (docs/agents/issue-tracker.md)"
fi

echo "--- top-level layout"
ls -1A 2>/dev/null | grep -vE '^(\.git|node_modules|\.DS_Store)$' | head -30 | tr '\n' ' '
echo
exit 0
