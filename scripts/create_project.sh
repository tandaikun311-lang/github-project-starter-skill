#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TYPE="basic-repo"
NAME=""
OUTPUT="$PWD"

usage() {
  cat <<'USAGE'
Usage:
  create_project.sh --type <basic-repo|website-repo|skill-repo|automation-repo> --name <project-name> --output <dir>

Example:
  create_project.sh --type website-repo --name my-brand-site --output ~/Projects
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --type)
      TYPE="${2:-}"
      shift 2
      ;;
    --name)
      NAME="${2:-}"
      shift 2
      ;;
    --output)
      OUTPUT="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [ -z "$NAME" ]; then
  echo "--name is required." >&2
  exit 1
fi

if ! [[ "$NAME" =~ ^[a-z0-9][a-z0-9-]*[a-z0-9]$|^[a-z0-9]$ ]]; then
  echo "Project name must use lowercase letters, numbers, and hyphens only: $NAME" >&2
  exit 1
fi

TEMPLATE="$ROOT_DIR/templates/$TYPE"
if [ ! -d "$TEMPLATE" ]; then
  echo "Unknown project type: $TYPE" >&2
  echo "Available templates:" >&2
  find "$ROOT_DIR/templates" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; >&2
  exit 1
fi

mkdir -p "$OUTPUT"
TARGET="$OUTPUT/$NAME"

if [ -e "$TARGET" ]; then
  echo "Target already exists: $TARGET" >&2
  exit 1
fi

mkdir -p "$TARGET"
cp -R "$TEMPLATE"/. "$TARGET"/

export PROJECT_NAME="$NAME"
find "$TARGET" -type f -print0 | while IFS= read -r -d '' file; do
  perl -0pi -e 's/__PROJECT_NAME__/$ENV{PROJECT_NAME}/g' "$file"
done

echo "Created $TYPE project: $TARGET"
