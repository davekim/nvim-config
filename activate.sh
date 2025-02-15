#!/bin/bash

set -euo pipefail

dir=$(cd "$(dirname "$0")"; pwd)
mkdir -p "${HOME}/.config/nvim"

for name in lua init.lua lazy-lock.json; do
    # TODO: Make this safer
    rm -rf "${HOME}/.config/nvim/${name}"
    ln -s "${dir}/nvim/${name}" "${HOME}/.config/nvim/${name}"
done
