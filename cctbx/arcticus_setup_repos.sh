#!/bin/bash

set -e

export ALCC_CCTBX_ROOT=$(readlink -f $(dirname ${BASH_SOURCE[0]}))

mkdir modules && cd modules
git clone -b kokkos_arcticus_update https://github.com/cctbx/cctbx_project.git
git clone -b develop https://github.com/kokkos/kokkos.git
git clone -b develop https://github.com/kokkos/kokkos-kernels.git
git clone https://github.com/nksauter/LS49
git clone https://gitlab.com/cctbx/ls49_big_data
git clone https://gitlab.com/cctbx/uc_metrics
git clone https://github.com/lanl/lunus
