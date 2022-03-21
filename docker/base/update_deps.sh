#!/bin/bash

set -e

__loc () {
    echo $(dirname $(realpath ${BASH_SOURCE[0]}))
}


__get_from_github () {
    user=$1
    repo=$2
    branch=$3

    if [[ -e ${branch}.zip ]]
    then
        rm ${branch}.zip
    fi

    wget https://github.com/${user}/${repo}/archive/refs/heads/${branch}.zip
    
    if [[ -e ${repo} ]]
    then
        rm -rf ${repo}
    fi

    unzip $branch
    mv ${repo}-${branch} $repo
    rm $branch.zip
}


pushd $(__loc)/vim

# https://github.com/tpope/vim-pathogen/archive/refs/heads/master.zip
__get_from_github tpope vim-pathogen master
# https://github.com/kana/vim-textobj-line/archive/refs/heads/master.zip
__get_from_github kana vim-textobj-line master
# https://github.com/kana/vim-textobj-user/archive/refs/heads/master.zip
__get_from_github kana vim-textobj-user master
# https://github.com/preservim/vim-markdown/archive/refs/heads/master.zip
__get_from_github preservim vim-markdown master
# https://github.com/ervandew/supertab/archive/refs/heads/master.zip
__get_from_github ervandew supertab master

popd