#!/bin/bash


# this () { echo $(readlink -f $(dirname ${BASH_SOURCE[0]})); }
shopt -s expand_aliases
alias this="readlink -f \$(dirname \${BASH_SOURCE[0]})"


pushd $(this)
wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-ppc64le/latest | tar -xvj bin/micromamba
popd
