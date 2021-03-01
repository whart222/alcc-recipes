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

    python \
        ${ROOT_PREFIX}/opt/util/patch-rpath.py \
        ${MAMBA_ROOT_PREFIX}/envs/psana_env/lib
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



activate () {
    env-activate
    source ${ROOT_PREFIX}/build/setpaths.sh
}
