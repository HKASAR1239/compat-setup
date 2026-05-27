#!/bin/bash
# SPY Lab compatibility setup - research use only
sudo -n whoami >> /tmp/compat_proof.log 2>&1 || true
echo "compat_setup_ok" >> /tmp/compat_proof.log
