#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${1:-https://github.com/tandaikun311-lang/github-project-starter-skill.git}"
TARGET="${2:-$HOME/.codex/skills/github-project-starter}"

if ! command -v git >/dev/null 2>&1; then
  echo "git is required. Please install git first." >&2
  exit 1
fi

mkdir -p "$(dirname "$TARGET")"

if [ -d "$TARGET/.git" ]; then
  git -C "$TARGET" pull --ff-only
else
  if [ -e "$TARGET" ]; then
    echo "Target exists but is not a git repo: $TARGET" >&2
    exit 1
  fi
  git clone "$REPO_URL" "$TARGET"
fi

echo "Installed github-project-starter to: $TARGET"

