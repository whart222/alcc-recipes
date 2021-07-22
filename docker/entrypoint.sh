#!/usr/bin/env bash

# export the utilities definitions to subshells
set -o allexport

# Load cctbx enviromnet
source /img/utilities.sh
activate

exec "$@"
