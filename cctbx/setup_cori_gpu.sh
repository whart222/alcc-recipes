#!/bin/bash

source $(readlink -f $(dirname ${BASH_SOURCE[0]}))/utilities.sh


fix-sysversions () {
    # Fix libreadline.so warnings on Cori
    pushd $CONDA_PREFIX/lib
    ln -sf /lib64/libtinfo.so.6
    ln -sf /lib64/libreadline.so.7
    ln -sf /usr/lib64/libuuid.so
    ln -sf /usr/lib64/libuuid.so libuuid.so.1
    popd
}


module purge
module load cgpu gcc cuda openmpi

./opt/get_mamba_linux-64.sh

mk-env openmpi
fix-sysversions
mk-cctbx cuda
patch-dispatcher
