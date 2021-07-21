#!/bin/bash

set -e

source $(readlink -f $(dirname ${BASH_SOURCE[0]}))/utilities.sh
source $(readlink -f $(dirname ${BASH_SOURCE[0]}))/opt/util/fix_lib_nersc.sh

fix-sysversions () {
    env-activate
    if fix-sysversions-perlmutter
    then
        return 1
    fi
}

module load PrgEnv-gnu cudatoolkit craype-accel-nvidia80 gcc

./opt/get_mamba_linux-64.sh

mk-env cray-cuda-mpich
if fix-sysversions
then
    return 1
fi
mk-cctbx cuda build hot update
patch-dispatcher nersc
