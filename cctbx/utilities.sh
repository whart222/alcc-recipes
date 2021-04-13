#!/bin/bash



export ROOT_PREFIX=$(readlink -f $(dirname ${BASH_SOURCE[0]}))



setup-env () {
    export MAMBA_ROOT_PREFIX=${ROOT_PREFIX}/opt/mamba 
    eval "$(${ROOT_PREFIX}/opt/bin/micromamba shell hook -s bash)"
}



mk-env () {
    setup-env

    micromamba activate
    micromamba install python=3.8 -c defaults --yes

    micromamba create -f ${ROOT_PREFIX}/psana_environment.yml --yes

    # switch to mpich -- the psana package explicitly downloads openmpi which
    # is incompatible with some systems
    if [[ $1 == "mpich" ]]
    then
        micromamba activate psana_env
        micromamba install conda -c defaults --yes
        # HACK: mamba/micromamba does not support --force removal yet
        # https://github.com/mamba-org/mamba/issues/412
        conda remove --force mpi4py mpi openmpi --yes
        micromamba install mpi4py -c defaults --yes
        micromamba deactivate
    fi 

    echo "You must patch your .so files using Patchelf. Follow these steps:"
    echo "(1) $ salloc --nodes=1 --tasks-per-node=32 --constraint=haswell --time=2:00:00 -A lcls -q interactive"
    echo "(2) Activate a conda environment with patchelf available"
    echo "(3) $ $ROOT_PREFIX/opt/util/patch_all_parallel.sh $MAMBA_ROOT_PREFIX/envs/psana_env/lib"
}



env-activate () {
    setup-env
    micromamba activate psana_env
}



fix-sysversions () {
    # Fix libreadline.so warnings on Cori
    if [[ $NERSC_HOST == "cori" ]]
    then
        pushd $CONDA_PREFIX/lib
        ln -sf /lib64/libtinfo.so.6
        ln -sf /lib64/libreadline.so.7
        ln -sf /usr/lib64/libuuid.so
        ln -sf /usr/lib64/libuuid.so libuuid.so.1
        popd
    fi
}



mk-cctbx () {
    env-activate

    fix-sysversions

    pushd ${ROOT_PREFIX}

    python bootstrap.py --builder=dials \
                        --use-conda ${CONDA_PREFIX} \
                        --nproc=${NPROC:-8} \
                        --config-flags="--enable_cxx11" \
                        --config-flags="--no_bin_python" \
                        --config-flags="--enable_openmp_if_possible=True" \
                        hot update build
    popd
}
mk-cctbx-cuda () {
    env-activate

    fix-sysversions

    pushd ${ROOT_PREFIX}

    python bootstrap.py --builder=dials \
                        --use-conda ${CONDA_PREFIX} \
                        --nproc=${NPROC:-8} \
                        --config-flags="--enable_cxx11" \
                        --config-flags="--no_bin_python" \
                        --config-flags="--enable_openmp_if_possible=True" \
                        --config-flags="--enable_cuda" \
                        --python=37 \
                        hot update
    module load cgpu cuda
    python bootstrap.py --builder=dials \
                        --use-conda ${CONDA_PREFIX} \
                        --nproc=${NPROC:-8} \
                        --config-flags="--enable_cxx11" \
                        --config-flags="--no_bin_python" \
                        --config-flags="--enable_openmp_if_possible=True" \
                        --config-flags="--enable_cuda" \
                        --python=37 \
                        build
    popd
}



mk-cctbx-no-boost () {
    env-activate

    fix-sysversions

    pushd ${ROOT_PREFIX}

    python bootstrap.py --builder=dials \
                        --use-conda ${CONDA_PREFIX} \
                        --nproc=${NPROC:-8} \
                        --config-flags="--enable_cxx11" \
                        --config-flags="--no_bin_python" \
                        --config-flags="--enable_openmp_if_possible=True" \
                        --no-boost-src \
                        hot update build
    popd
}



remk-cctbx () {
    env-activate

    fix-sysversions

    pushd ${ROOT_PREFIX}

    python bootstrap.py --builder=dials \
                        --use-conda ${CONDA_PREFIX} \
                        --nproc=${NPROC:-8} \
                        --config-flags="--enable_cxx11" \
                        --config-flags="--no_bin_python" \
                        --config-flags="--enable_openmp_if_possible=True" \
                        build
    popd
}



remk-cctbx-no-boost () {
    env-activate

    fix-sysversions

    pushd ${ROOT_PREFIX}

    python bootstrap.py --builder=dials \
                        --use-conda ${CONDA_PREFIX} \
                        --nproc=${NPROC:-8} \
                        --config-flags="--enable_cxx11" \
                        --config-flags="--no_bin_python" \
                        --config-flags="--enable_openmp_if_possible=True" \
                        --no-boost-src \
                        build
    popd
}



patch-dispatcher () {

    pushd ${ROOT_PREFIX}/build
    ln -fs ${ROOT_PREFIX}/dispatcher_includes/dispatcher_include_$1.sh \
           dispatcher_include.sh
    popd

    libtbx.refresh
}


activate () {
    env-activate
    source ${ROOT_PREFIX}/build/setpaths.sh
}
