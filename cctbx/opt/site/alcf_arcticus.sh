#!/bin/bash


load-sysenv () {
	module use /soft/restricted/CNDA/modulefiles
	module load oneapi cmake
	#module load kokkos/openmptarget_intel
	module load kokkos/sycl_intel
}


export NERSC_SIT_DATA=/global/common/software/lcls/psdm/data
export NERSC_SIT_PSDM_DATA=/global/cscratch1/sd/psdatmgr/data/psdm
