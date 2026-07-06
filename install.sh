#!/bin/bash

set -euo pipefail

run_cmd () {
    echo "========================================"
    echo $1
    echo "----------------------------------------"
    eval $1
    echo "========================================"
}

prepend_to_path() {
    local DIR=$1
    if [[ -d "${DIR}" && ":${PATH}:" != *":${DIR}:"* ]]; then
        export PATH="${DIR}:${PATH}"
    fi
}

DOTFILE_DIR=$(realpath $(dirname $0))

run_cmd "ln ${DOTFILE_DIR}/tmux/.tmux.conf ${HOME}"
run_cmd "ln ${DOTFILE_DIR}/gitconfig/.gitconfig ${HOME}"

run_cmd "cat ${DOTFILE_DIR}/bashrc_append >> ${HOME}/.bashrc"

if [ -f /opt/rocm/bin/rocminfo ]; then
    run_cmd "cat ${DOTFILE_DIR}/bashrc_rocm_path >> ${HOME}/.bashrc"
fi

if command -v srun >/dev/null 2>&1; then
    BINDIR="${HOME}/.local/bin"
    mkdir -p "${BINDIR}"
    prepend_to_path "${BINDIR}"
    run_cmd "cp ${DOTFILE_DIR}/slurm/jobshell ${BINDIR}"
fi
