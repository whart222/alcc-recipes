#!/bin/bash

set -e

export ALCC_CCTBX_ROOT=$(readlink -f $(dirname ${BASH_SOURCE[0]}))

source ${ALCC_CCTBX_ROOT}/utilities.sh
source ${ALCC_CCTBX_ROOT}/opt/util/fix_lib_nersc.sh
source ${ALCC_CCTBX_ROOT}/opt/site/nersc_cgpu.sh

fix-sysversions () {
    env-activate
    if fix-sysversions-cgpu
    then
        return 1
    fi
}

./opt/get_mamba_linux-64.sh

load-sysenv

mk-env openmpi
if fix-sysversions
then
    return 1
fi
mk-cctbx cuda build hot update
patch-dispatcher nersc

cat > ${ALCC_CCTBX_ROOT}/activate.sh << EOF
source ${ALCC_CCTBX_ROOT}/utilities.sh
source ${ALCC_CCTBX_ROOT}/opt/site/nersc_cgpu.sh
load-sysenv
activate
EOF
