#!/bin/bash

set -e

export ALCC_CCTBX_ROOT=$(readlink -f $(dirname ${BASH_SOURCE[0]}))

source ${ALCC_CCTBX_ROOT}/utilities_alcf.sh
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

echo "*"
echo "* Load Sysenv"
echo "*"
load-sysenv > log.load_sysenv 2>&1

echo "*"
echo "* Making Environment"
echo "*"
#mk-env conda-mpich > log.mk_env 2>&1
mk-env aurora-mpich > log.mk_env 2>&1
#echo "*"
#echo "* Fixing Sysversions"
#echo "*"
#if fix-sysversions
#then
#    return 1
#fi

echo "*"
echo "* Done"
echo "*"
