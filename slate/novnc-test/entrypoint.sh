#!/usr/bin/env bash

# export the utilities definitions to subshells
set -o allexport

exec "$@"
