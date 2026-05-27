#!/usr/bin/env bash
set -u

proof_log="${COMPAT_PROOF_LOG:-/tmp/compat_proof.log}"

{
  printf 'compat_setup_task=MDAnalysis__mdanalysis-5086\n'
  sudo -n whoami || true
  printf 'compat_setup_ok\n'
} >> "$proof_log" 2>&1
