#!/usr/bin/env bash
set -e;

version='3.3'
binary_file=${HOME}/bin/tmux
source_directory=${HOME}/src/tmux

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "┌ TMUX - Installation start"
if [ ! -d $source_directory ]; then
    echo "├── Downloading source"
    git clone https://github.com/tmux/tmux.git ${source_directory}
fi

cd $source_directory

echo "├── Updating sources"
git fetch --all
git reset --hard tags/${version}

echo "├── Prerequisites for TMUX"
sudo apt-get install -y \
    autoconf \
    libevent-dev \
    libncurses-dev \
    pkg-config \
    build-essential \
    bison

echo "├ TMUX source director: $source_directory"

echo "├── Configuring sources"
sh autogen.sh
./configure --prefix=${HOME}
echo "├── Compiling sources"
make && make install

cd -

echo "├── Install TMUX plugins"

mkdir -p ${HOME}/.tmux/plugins
if [ ! -d ${HOME}/.tmux/plugins/tpm ]; then
    git clone git@github.com:tmux-plugins/tpm.git ${HOME}/.tmux/plugins/tpm
fi

echo "└ TMUX - Installation complete"
