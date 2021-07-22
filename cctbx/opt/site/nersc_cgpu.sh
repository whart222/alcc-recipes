#!/bin/bash


load-sysenv () {
    module purge
    module load cgpu gcc cuda openmpi
}
