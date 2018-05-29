#!/usr/bin/env bash
set -e;

version="2.17.0"
source_directory=${HOME}/src/git-$version
subtree_source_directory=$source_directory/contrib/subtree/
binary_file=${HOME}/bin/git
subtree_binary_file=${HOME}/bin/git-subtree
current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d $source_directory ]; then
    $current_directory/helper/download_unzip https://github.com/git/git/archive/v$version.zip ~/src/
fi

sudo apt-get install -y \
    asciidoc \
    expat \
    libcurl4-openssl-dev \
    wish \
    zlibc

if [ ! -x $binary_file ]; then
    cd $source_directory
    make configure
    ./configure --prefix=${HOME}
    make all
    make install
    cd -
fi
if [ ! -x $subtree_binary_file ]; then
    cd $subtree_source_directory
    make prefix=${HOME}
    make prefix=${HOME} install
    make prefix=${HOME} install-doc
fi
