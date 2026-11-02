#!/bin/sh
# Agentic Coding Framework (ACF) installer
# Based on the Agentic Coding Framework by Gabriel Slawski (CC BY 4.0)
# https://github.com/Gabrielx23/agentic-coding-framework
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/Gabrielx23/agentic-coding-framework/main/install.sh | sh
#   curl -fsSL .../install.sh | sh -s -- --ref v0.1.0 --dir ./my-project
#
# Rules:
#   acf/          framework files. Installed, or replaced on upgrade.
#   acf-project/  project-owned files. Created only if missing. Never overwritten.
#   AGENTS.md     root rules. Created only if missing. Never overwritten.

set -eu

REPO="Gabrielx23/agentic-coding-framework"
REF="main"
DIR="."
DRY_RUN=0
YES=0

usage() {
  cat <<'EOF'
ACF installer

Options:
  --ref <tag|branch>   Version to install (default: main). Example: v0.1.0
  --dir <path>         Project directory (default: current directory)
  --dry-run            Show what the installer would do. Change nothing.
  --yes                Do not ask before replacing an existing acf/ directory
  -h, --help           Show this help
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --ref) REF="${2:?--ref needs a value}"; shift 2 ;;
    --dir) DIR="${2:?--dir needs a value}"; shift 2 ;;
    --dry-run) DRY_RUN=1; shift ;;
    --yes|-y) YES=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
done

say()  { printf '%s\n' "$*"; }
step() { printf '  %s\n' "$*"; }
fail() { printf 'Error: %s\n' "$*" >&2; exit 1; }

command -v tar >/dev/null 2>&1 || fail "tar is required."
if command -v curl >/dev/null 2>&1; then
  fetch() { curl -fsSL "$1" -o "$2"; }
elif command -v wget >/dev/null 2>&1; then
  fetch() { wget -q "$1" -O "$2"; }
else
  fail "curl or wget is required."
fi

[ -d "$DIR" ] || fail "Directory not found: $DIR"
DIR=$(cd "$DIR" && pwd)

# Download the requested version into a temporary directory.
TMP=$(mktemp -d 2>/dev/null || mktemp -d -t acf)
trap 'rm -rf "$TMP"' EXIT INT TERM

case "$REF" in
  v[0-9]*) URL="https://codeload.github.com/$REPO/tar.gz/refs/tags/$REF" ;;
  *)       URL="https://codeload.github.com/$REPO/tar.gz/refs/heads/$REF" ;;
esac

say "ACF installer"
say "  Version: $REF"
say "  Project: $DIR"
[ "$DRY_RUN" -eq 1 ] && say "  Mode:    dry run (no changes)"
say ""

fetch "$URL" "$TMP/acf.tar.gz" || fail "Download failed: $URL"
tar -xzf "$TMP/acf.tar.gz" -C "$TMP" || fail "Could not unpack the archive."
SRC=$(find "$TMP" -mindepth 1 -maxdepth 1 -type d | head -n 1)
[ -n "$SRC" ] && [ -d "$SRC/acf" ] || fail "The archive does not contain acf/. Check --ref."

NEW_VERSION=$(cat "$SRC/acf/VERSION" 2>/dev/null || echo "unknown")

run() { if [ "$DRY_RUN" -eq 1 ]; then step "[dry run] $*"; else "$@"; fi; }

# 1. Framework files: install or replace acf/.
if [ -d "$DIR/acf" ]; then
  OLD_VERSION=$(cat "$DIR/acf/VERSION" 2>/dev/null || echo "unknown")
  say "acf/ exists (version $OLD_VERSION). It will be replaced with version $NEW_VERSION."
  if [ -f "$DIR/acf/NOTICE.md" ]; then
    step "Your acf/NOTICE.md is kept, because it records your changes."
  fi
  if [ "$DRY_RUN" -eq 0 ] && [ "$YES" -eq 0 ]; then
    if (exec </dev/tty) 2>/dev/null; then
      printf '  Replace acf/? [y/N] '
      read -r ANSWER </dev/tty 2>/dev/null || ANSWER=""
      case "$ANSWER" in y|Y|yes|YES) ;; *) say "Stopped. Nothing changed."; exit 0 ;; esac
    else
      fail "acf/ exists. Run again with --yes to replace it."
    fi
  fi
  if [ -f "$DIR/acf/NOTICE.md" ]; then run cp "$DIR/acf/NOTICE.md" "$TMP/NOTICE.keep"; fi
  run rm -rf "$DIR/acf"
  run cp -R "$SRC/acf" "$DIR/acf"
  if [ -f "$TMP/NOTICE.keep" ]; then run cp "$TMP/NOTICE.keep" "$DIR/acf/NOTICE.md"; fi
  step "Replaced acf/ ($OLD_VERSION -> $NEW_VERSION)."
else
  run cp -R "$SRC/acf" "$DIR/acf"
  step "Installed acf/ (version $NEW_VERSION)."
fi

# 2. Project-owned files: create only what is missing. Never overwrite.
CREATED=0
for item in $(cd "$SRC/acf-project" && find . -mindepth 1 | sort); do
  target="$DIR/acf-project/${item#./}"
  if [ -d "$SRC/acf-project/$item" ]; then
    [ -d "$target" ] || { run mkdir -p "$target"; CREATED=1; }
  elif [ ! -e "$target" ]; then
    run mkdir -p "$(dirname "$target")"
    run cp "$SRC/acf-project/$item" "$target"
    CREATED=1
  fi
done
if [ "$CREATED" -eq 1 ]; then
  step "Created missing parts of acf-project/. Existing files were not touched."
else
  step "acf-project/ is complete. Nothing changed."
fi

# 3. Root AGENTS.md: create only if missing.
if [ -e "$DIR/AGENTS.md" ]; then
  run cp "$SRC/AGENTS.md" "$DIR/AGENTS.acf-example.md"
  step "AGENTS.md exists and was not changed."
  step "Compare it with AGENTS.acf-example.md, merge new rules, then delete the example."
else
  run cp "$SRC/AGENTS.md" "$DIR/AGENTS.md"
  step "Created AGENTS.md."
fi

say ""
say "Done. Next steps:"
say "  1. Fill acf-project/ACF_CHARTER.md and acf-project/metrics.md."
say "  2. Add your project rules under 'Project overrides' in AGENTS.md."
say "  3. If your tool uses CLAUDE.md, .github/copilot-instructions.md, or Cursor rules,"
say "     point that file to AGENTS.md."
say "  4. Protect the guardrail files with CODEOWNERS or branch rules. Sample:"
say "     https://github.com/$REPO/blob/main/examples/ci/CODEOWNERS"
say "  5. Read the guide: acf/guide/00-key-terms.md"
say ""
say "ACF by Gabriel Slawski, licensed under CC BY 4.0. Keep acf/NOTICE.md."
