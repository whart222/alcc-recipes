# MPI4PY Testing Tool

This tool collects simple performance data for the `mpi4py` collectives:
1. `bcast`
2. `gather`

From an **empty data directory** (we will generate a `.pkl` file *per rank*)
run this tool in stages:
1. `python /path/to/test_mpi4py.py bcast gather`
2. `python /path/to/analyze_mpi4py.py`

This will print out a table of performance data and ranks.
