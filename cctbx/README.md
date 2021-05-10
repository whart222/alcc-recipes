## Building for Cori GPU (on cscratch)

* For a complete rebuild run `./setup_cori_gpu.sh` 
* For a partial rebuild (of an already installed and configured environment) run:
  ```bash
  source activate.sh
  mk-cctbx build
  ```

```
$ cd alcc-recipes/cctbx
$ ./opt/get_mamba_linux-64.sh
$ source utilities.sh
$ mk-env-cgpu
$ salloc --nodes=1 --constraint=haswell --time=30 -A lcls -q interactive
[on compute node] $ ./opt/util/do_patch.sh
[back on login node] $ mk-cctbx-cuda
$ cd modules # Remaining steps are optional for testing
$ git clone https://github.com/nksauter/LS49
$ git clone https://gitlab.com/cctbx/ls49_big_data
$ source ../build/conda_setpaths.sh
$ libtbx.configure LS49 ls49_big_data
$ module load cgpu
$ salloc -N 1 --time=60 -c 10 -C gpu -G 1 -A m1759 -q interactive
$ source ../build/conda_setpaths.sh
$ mkdir test; cd test
$ srun -n 1 -c 10 libtbx.run_tests_parallel module=LS49 module=simtbx nproc=Auto
```

## Compile

1. ./opt/get_mamba_linux-64.sh
2. source utilites.sh
3. mk-env
4. mk-cctbx
5. patch-dispatcher

##  To Run

just run the activate function

## To recompile

use remk-cctbx
