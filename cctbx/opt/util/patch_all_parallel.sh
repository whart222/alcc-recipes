#! /usr/bin/env bash

PATCH_SCRIPT=$(readlink -f $(dirname ${BASH_SOURCE[0]}))/patch-rpath_onefile.py

TARGET_ROOT=$1

for f in $(find $TARGET_ROOT -name "*.so"); do
  while true; do
    let n_running=$(jobs|grep patch-rpath_onefile|wc -l)
    if [[ n_running -le 64 ]]; then break; fi
    sleep 5
  done
  python $PATCH_SCRIPT $f &
done

while true; do
  sleep 6
  let n_running=$(jobs|grep patch-rpath_onefile|wc -l)
  if [[ n_running -eq 0 ]]; then break; fi
done

echo Finished!
