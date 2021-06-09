#!/bin/bash

set -e

source $(readlink -f $(dirname ${BASH_SOURCE[0]}))/utilities.sh
source $(readlink -f $(dirname ${BASH_SOURCE[0]}))/opt/util/fix_lib_nersc.sh

fix-sysversions () {
    env-activate
    if fix-sysversions-cgpu
    then
        return 1
    fi
}

module purge
module load cgpu gcc cuda openmpi

./opt/get_mamba_linux-64.sh

mk-env openmpi
if fix-sysversions
then
    return 1
fi
mk-cctbx cuda build hot update
patch-dispatcher nersc
