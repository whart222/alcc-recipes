# Building Kokkos in cctbx

1. Clone `alcc-recipies` normally
2. Clone the KOKKOS project (https://github.com/kokkos/kokkos.git) to `alcc-recipes/cctbx/modules/` so that the kokkos-makefile sits at `alcc-recipes/cctbx/modules/kokkos/Makefile.kokkos`
3. My configuration for cori gpu is:
  - run `module purge`
  - run `module load cgpu gcc cuda openmpi`
  - run `source activate.sh` in the `alcc-recipes/cctbx/` directory
4. After the initial build of everything with `setup_cori_gpu.sh` , I rebuild any changed files by running `mk-cctbx cuda build` in the `alcc-recipes/cctbx/` directory
5. If the build was successful, a lot of `Kokkos_*` files together with the `libkokkos.a` should be in `simtbx/kokkos/`, all other `*.o` files should be in `build/simtbx/kokkos/` and the two libraries (`libsimtbx_kokkos.so` and `simtbx_kokkos_ext.so`) should be in `build/lib/`
6. I run any tests with `srun --pty libtbx.ipython`
7. Building on Cori login node works, except for linking the `libcuda.so`, which needs to be added manually
