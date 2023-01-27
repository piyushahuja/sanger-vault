#!/usr/bin/env bash

declare ROOT="/lustre/scratch119/realdata/mdt3/projects/cramtastic"
declare USER="$(whoami)"

declare -i MiB=$(( 1024 * 1024 ))
declare -i MIN_SIZE=$(( 2 * MiB ))
declare -i MAX_SIZE=$(( 20 * MiB ))

declare -i Days=$(( 24 * 60 ))
declare -i MAX_AGE=$(( 10 * Days ))

create_file() {
  local path="$1"
  local -i size=$(( MIN_SIZE + ( "${RANDOM}${RANDOM}" % (MAX_SIZE - MIN_SIZE)) ))
  local -i age=$(( "${RANDOM}${RANDOM}" % MAX_AGE ))
  local mtime="$(date -d "${age} minutes ago" "+%Y%m%d%H%M")"

  dd if=/dev/urandom "of=${path}" count=1 bs=${size}
  chmod g=u "${path}"
  touch -mt "${mtime}" "${path}"
}

main() {
  local files="${1-10}"
  local path="${ROOT}/${USER}"

  if [[ -d "${path}" ]]; then
    >&2 printf "%s\n" "State already exists in ${path}" \
                      "Please clean this up first, then try again"
    exit 1
  fi

  mkdir -p "${path}"
  chmod ug+wx "${path}"

  for f in $(seq -w "${files}"); do
    create_file "${path}/file-${f}"
  done
}

main "$@"
