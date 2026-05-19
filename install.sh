#!/bin/bash

set -euo pipefail

run_cmd () {
    echo "========================================"
    echo $1
    echo "----------------------------------------"
    eval $1
    echo "========================================"
}


DOTFILE_DIR=$(realpath $(dirname $0))

run_cmd "ln ${DOTFILE_DIR}/tmux/.tmux.conf ${HOME}"
run_cmd "ln ${DOTFILE_DIR}/gitconfig/.gitconfig ${HOME}"

run_cmd "cat ${DOTFILE_DIR}/bashrc_append >> ${HOME}/.bashrc"
