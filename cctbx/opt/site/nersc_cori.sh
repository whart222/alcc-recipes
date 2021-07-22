#!/bin/bash


load-sysenv () {
    module swap PrgEnv-intel PrgEnv-gnu 2> /dev/null
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/shifter/opt/mpich-7.7.10/lib64/
}
