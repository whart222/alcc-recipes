#!/bin/bash

set-env () {
    export ROOT_PREFIX=$(readlink -f $(dirname ${BASH_SOURCE[0]}))
    export MAMBA_ROOT_PREFIX=${ROOT_PREFIX}/opt/mamba 
    eval "$(${ROOT_PREFIX}/opt/bin/micromamba shell hook -s bash)"
}


mk-env () {
    micromamba activate
    micromamba create -f ${ROOT_PREFIX}/psana_environment.yml --yes
}



