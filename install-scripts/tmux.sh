#!/usr/bin/env bash
set -e;

version='2.6'
binary_file=${HOME}/bin/tmux
source_directory=${HOME}/src/tmux-${version}

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "┌ TMUX - Installation start"
if [ ! -d $source_directory ]; then
    echo "├── Downloading source"
    $current_directory/helper/download_unzip https://github.com/tmux/tmux/archive/$version.zip ~/src/
else
    echo "├── Existing sources"
fi

echo "├── Prerequisites for TMUX"
sudo apt-get install -y \
    autoconf \
    libevent-dev \
    libncurses-dev \
    pkg-config

echo "├ TMUX sources: $source_directory"

if [ ! -x $binary_file ]; then
    echo "├── Configuring sources"
    cd $source_directory
    sh autogen.sh
    ./configure --prefix=${HOME}
    echo "├── Compiling sources"
    make && make install
    cd -
else
    echo "├── Existing executable"
fi

echo "├── Install TMUX plugins"

mkdir -p ${HOME}/.tmux/plugins
if [ ! -d ${HOME}/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
fi

echo "└ TMUX - Installation complete"
