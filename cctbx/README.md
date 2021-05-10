## Building CCTBX and its Dependencies

### Building for Cori GPU

* For a complete rebuild run `./setup_cori_gpu.sh` 
* For a partial rebuild (of an already installed and configured environment)
  run:
  ```bash
  source activate.sh
  mk-cctbx cuda build
  ```

**Note:** the arguments after `mk-cctbx cuda` are the usual arguments for
`boostrap.py`

### Setting up the LS49 Module

* Clone the `LS49` and `ls49_big_data` repos **inside the modules folder**
* Run `libtbx.configure LS49 ls49_big_data`

In most standard cases, this code should do the trick -- assuming you have
already activate the cctbx environment (see next section):
```bash
cd modules
git clone https://github.com/nksauter/LS49
git clone https://gitlab.com/cctbx/ls49_big_data
libtbx.configure LS49 ls49_big_data
$ module load cgpu
$ salloc -N 1 --time=60 -c 10 -C gpu -G 1 -A m1759 -q interactive
$ source ../build/conda_setpaths.sh
$ mkdir test; cd test
$ srun -n 1 -c 10 libtbx.run_tests_parallel module=LS49 module=simtbx nproc=Auto
```

##  To Run

1. Load modules
2. `source activate.sh`

### Running on Cori GPU

1. `module purge`
2. `module load cgpu gcc cuda openmpi`
3. `source activate.sh`

### Running the LS49 Tests

We use `libtbx.run_tests_parallel module=LS49 module=simtbx` from an empty
(temporary) directory. 

#### On Cori GPU

In most cases this should do the trick (after activating all modules -- cf
above):

```
mkdir test; cd test
srun -n 1 -c 10 libtbx.run_tests_parallel module=LS49 module=simtbx nproc=Auto
```
