#!/usr/bin/env bash

declare ROOT="/lustre/scratch119/humgen/teams/hgi"
declare CROOK_ROOT="${ROOT}/crook-shepherd/crook"
declare VAULT_ROOT="${ROOT}/vault"

# Logging
exec 1>>"${VAULT_ROOT}/var/log/crook.log"
exec 2>&1
echo "## Start: $(date) ##"

# Init LSF
source /usr/local/lsf/conf/profile.lsf

# Ensure baton is available
export PATH="/software/hgi/installs/baton:/software/sciops/pkgg/baton/2.1.0/bin:${PATH}"

cd "${CROOK_ROOT}"
source "${CROOK_ROOT}/.venv/bin/activate"

set -eu
python "${CROOK_ROOT}/crook.py" "$@"
