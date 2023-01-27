#!/usr/bin/env bash

declare ROOT="/lustre/scratch119/realdata/mdt3/teams/hgi/vault"

cd "${ROOT}/hgi-vault"
git pull --rebase

source "${ROOT}/hgi-vault/.venv/bin/activate"
pip install --force-reinstall .
