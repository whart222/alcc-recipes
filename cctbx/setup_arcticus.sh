#!/bin/bash

set -e

export ALCC_CCTBX_ROOT=$(readlink -f $(dirname ${BASH_SOURCE[0]}))

source ${ALCC_CCTBX_ROOT}/utilities_alcf.sh
#source ${ALCC_CCTBX_ROOT}/opt/util/fix_lib_alcf.sh
source ${ALCC_CCTBX_ROOT}/opt/site/alcf_arcticus.sh

fix-sysversions () {
    env-activate
    if fix-sysversions-arcticus
    then
        return 1
    fi
}

echo "*"
echo "* Download bootstrap.py"
echo "*"
${ALCC_CCTBX_ROOT}/update_bootstrap.sh > log.bootstrap 2>&1

#echo "*"
#echo "* Installing Mamba"
#echo "*"
#${ALCC_CCTBX_ROOT}/opt/get_mamba_linux-64.sh > log.mamba 2>&1

echo "*"
echo "* Load Sysenv"
echo "*"
load-sysenv > log.load_sysenv 2>&1

echo "*"
echo "* Making Environment"
echo "*"
mk-env conda-mpich > log.mk_env 2>&1
exit 0

echo "*"
echo "* Fixing Sysversions"
echo "*"
if fix-sysversions
then
    return 1
fi

echo "*"
echo "* Making CCTBX"
echo "*"
mk-cctbx kokkos build hot update > log.mk_cctbx 2>&1
patch-dispatcher alcf

cat > ${ALCC_CCTBX_ROOT}/activate.sh << EOF
source ${ALCC_CCTBX_ROOT}/utilities_alcf.sh
source ${ALCC_CCTBX_ROOT}/opt/site/alcf_arcticus.sh
load-sysenv
activate

#export CUDA_LAUNCH_BLOCKING=1
#export SIT_DATA=\${OVERWRITE_SIT_DATA:-\$NERSC_SIT_DATA}:\$SIT_DATA
#export SIT_PSDM_DATA=\${OVERWRITE_SIT_PSDM_DATA:-\$NERSC_SIT_PSDM_DATA}
EOF
