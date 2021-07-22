#!/bin/bash


load-sysenv () {
    module swap PrgEnv-intel PrgEnv-gnu 2> /dev/null
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/shifter/opt/mpich-7.7.10/lib64/
}


export NERSC_SIT_DATA=/global/common/software/lcls/psdm/data
export NERSC_SIT_PSDM_DATA=/global/cscratch1/sd/psdatmgr/data/psdm
