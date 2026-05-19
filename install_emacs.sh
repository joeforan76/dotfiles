#!/bin/bash

set -euo pipefail

DOTFILE_DIR=$(realpath $(dirname $0))

run_cmd () {
    echo "========================================"
    echo $1
    echo "----------------------------------------"
    eval $1
    echo "========================================"
}

run_cmd "git submodule init && git submodule update"
run_cmd "mamba create -y -n tools emacs=30.2"
run_cmd "mkdir -p /${HOME}/.emacs.d"
run_cmd "cp -al ${DOTFILE_DIR}/dotemacs/* ${HOME}/.emacs.d/"
run_cmd "cat ${DOTFILE_DIR}/emacs_alias >> ~/.bash_aliases"
