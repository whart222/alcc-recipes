#!/bin/bash

set-env () {
    export ROOT_PREFIX=$(readlink -f $(dirname ${BASH_SOURCE[0]}))
    export MAMBA_ROOT_PREFIX=${ROOT_PREFIX}/opt/mamba 
    eval "$(${ROOT_PREFIX}/opt/bin/micromamba shell hook -s bash)"
}



activate() {
    set-env
    micromamba activate psana_env
}



mk-env () {
    micromamba activate
    micromamba install python=3.8 -c defaults --yes
    micromamba create -f ${ROOT_PREFIX}/psana_environment.yml --yes
    python ${ROOT_PREFIX}/opt/util/patch-rpath.py ${MAMBA_ROOT_PREFIX}/envs/psana_env/lib
}
