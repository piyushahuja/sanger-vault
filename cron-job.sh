#!/usr/bin/env bash

declare ROOT="/lustre/scratch119/realdata/mdt3/teams/hgi/vault"

# Logging
declare DATE="$(date --iso-8601=minutes)"
exec &> >(tee "${ROOT}/var/log/sandman-${DATE}.log")

# Paths covered by vaults
declare -a VAULT_DIRS=(
  #"/lustre/scratch114/teams/hgi"
  "/lustre/scratch119/realdata/mdt3/projects/cramtastic"
)

sudo -u sandman "${ROOT}/bin/sandman" --weaponise --force-drain "${VAULT_DIRS[@]}"
#sudo -u sandman "${ROOT}/bin/sandman" "${VAULT_DIRS[@]}"
