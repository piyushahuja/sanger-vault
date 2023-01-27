#!/usr/bin/env bash

set -euo pipefail
declare ROOT="/lustre/scratch119/realdata/mdt3/teams/hgi/vault"

# Logging
exec 1>>"${ROOT}/var/log/handler.log"
exec 2>&1
echo "## Start: $(date) ##"

# Locking
exec 123>"${ROOT}/var/lock/handler.lock"
flock -nx 123
locked=$?

case ${1-} in
  ready)
    echo "* Challenge response: ${locked}"
    exit ${locked}
    ;;

  *)
    if (( locked )); then
      echo "* Cannot proceed; locked"
      exit 1
    fi
    ;;
esac

echo "* Archiving"
declare DATE="$(date --iso-8601=seconds)"
tee "${ROOT}/var/fofn/${DATE}.fofn" \
| xargs -0 /bin/tar Pczf "${ROOT}/archive/${DATE}.tar.gz" --remove-files --force-local --
