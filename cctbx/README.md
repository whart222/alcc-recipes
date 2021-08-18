# Install Scripts for CCTBX Across NERSC, OLCF, and ALCF

This is a collection of setup and management scripts for CCTBX. If you have
a completed setup, all you need to do is load any modules and run:
`source activate.sh` (cf. below for more details).

## Building CCTBX and its Dependencies

### Building for Cori GPU

* For a complete rebuild run `./setup_cori_gpu.sh` 
* For a partial rebuild (of an already installed and configured environment)
  run: `mk-cctbx cuda build` (assuming that you've already run `source
  activate.sh`)

**And get some coffee**

**Note:** the arguments after `mk-cctbx cuda` are the usual arguments for
`boostrap.py`

**WARNING:** If the build script can't find `-lcuda`, then confirm that you're
building on a Cori GPU compute (instead of a login node).

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
