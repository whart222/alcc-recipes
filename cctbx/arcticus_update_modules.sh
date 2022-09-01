#!/bin/bash

set -e

export ALCC_CCTBX_ROOT=$(readlink -f $(dirname ${BASH_SOURCE[0]}))

source ${ALCC_CCTBX_ROOT}/utilities_alcf.sh
#source ${ALCC_CCTBX_ROOT}/opt/site/alcf_arcticus.sh
source ${ALCC_CCTBX_SITE_ARCTICUS}

echo "*"
echo "* Load Sysenv (see log.load_sysenv)"
echo "*"
load-sysenv > log.load_sysenv 2>&1

echo "*"
echo "* Update modules directory (see log.update)"
echo "*"
mk-cctbx kokkos-alcf hot update > log.update 2>&1

cd modules/cctbx_project
git checkout kokkos_arcticus_update
git pull

cd ../kokkos
git checkout develop
git pull
