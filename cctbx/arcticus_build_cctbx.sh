#!/bin/bash

set -e
export ALCC_CCTBX_ROOT=$(readlink -f $(dirname ${BASH_SOURCE[0]}))

rm -f ${ALCC_CCTBX_ROOT}/activate.sh
source ${ALCC_CCTBX_ROOT}/utilities_alcf.sh
source ${ALCC_CCTBX_ROOT}/opt/site/alcf_arcticus.sh

echo "*"
echo "* Building CCTBX"
echo "*"
mk-cctbx kokkos-alcf build hot > log.mk_cctbx 2>&1
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
