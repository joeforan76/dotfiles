#!/bin/bash

set -euo pipefail

DOTFILE_MAMBA_DIR=$(realpath $(dirname $0)/..)

run_cmd () {
    echo "========================================"
    echo $1
    echo "----------------------------------------"
    eval $1
    echo "========================================"
}

run_cmd "curl -L -O \"https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh\""
run_cmd "bash Miniforge3-$(uname)-$(uname -m).sh -b"
source ${DOTFILE_MAMBA_DIR}/mamba_bashrc
run_cmd "cat ${DOTFILE_MAMBA_DIR}/mamba_bashrc >> ${HOME}/.bashrc"
run_cmd "mamba activate"
run_cmd "mamba install -y uv"


