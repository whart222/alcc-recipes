#!/bin/bash


load-sysenv () {
    module purge
    module load cgpu gcc cuda openmpi
}


export NERSC_SIT_DATA=/global/common/software/lcls/psdm/data
export NERSC_SIT_PSDM_DATA=/global/cscratch1/sd/psdatmgr/data/psdm
