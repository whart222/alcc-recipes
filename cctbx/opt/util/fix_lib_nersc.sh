#!/bin/bash


fix_lib () {
    for so_file in $1/*.so
    do
        ln -sf $so_file
    done
}



fix-sysversions-cgpu () {

    if ! [[ -d ${GCC_ROOT}/lib64 ]]
    then
        echo "Could not find GCC library dir"
        return 1
    fi

    if ! [[ -d ${OPENMPI_DIR}/lib ]]
    then
        echo "Could not find OpenMPI library dir"
        return 1
    fi


    if [[ -d $CONDA_PREFIX ]]
    then
        pushd $CONDA_PREFIX/lib

        fix_lib ${GCC_ROOT}/lib64
        fix_lib ${OPENMPI_DIR}/lib
        fix_lib /usr/lib64
        fix_lib /lib64

        popd

        return 0
    else
        echo "Could not find target conda library"
        return 1
    fi
}
