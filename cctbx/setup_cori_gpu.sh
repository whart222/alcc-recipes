#!/bin/bash

set -e

source $(readlink -f $(dirname ${BASH_SOURCE[0]}))/utilities.sh
source $(readlink -f $(dirname ${BASH_SOURCE[0]}))/opt/util/fix_lib_nersc.sh


module purge
module load cgpu gcc cuda openmpi

./opt/get_mamba_linux-64.sh

mk-env openmpi
fix-sysversions-cgpu
mk-cctbx cuda build hot update
patch-dispatcher nersc
