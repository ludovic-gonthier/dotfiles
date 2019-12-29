#!/usr/bin/env bash
set -e;
set -x;

version='8.0.1520'
source_directory=${HOME}/src/vim-${version}
binary_file=${HOME}/bin/vim
dataroot_directory=${HOME}/share/vim/vim80

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dl=$current_directory/helper/download_unzip

echo "┌ VIM - Installation start"
if [ ! -d $source_directory ]; then
    echo "├── Downloading source"
    $dl https://github.com/vim/vim/archive/v${version}.zip ~/src/
else
    echo "├── Existing sources"
fi

if [ ! -d $dataroot_directory ]; then
    mkdir -p $dataroot_directory
fi
echo "├── Prerequisites packages"
sudo apt-get install -y \
    debhelper \
    libacl1-dev \
    libgpmg1-dev \
    libgtk-3-dev \
    libncurses5-dev \
    libxaw7-dev \
    libxpm-dev \
    libxt-dev \
    python-dev \
    python3-dev \
    zlib1g-dev
echo "├ VIM sources: $source_directory"

if [ ! -x $binary_file ]; then
    echo "├── Configuring sources"
    cd $source_directory
    if [ -f src/auto/config.cache ]; then
        rm src/auto/config.cache
    fi
    ./configure --prefix=${HOME}\
        --datarootdir=$dataroot_directory \
        --enable-cscope \
        --enable-gnome-check \
        --enable-gui=gnome2 \
        --enable-perlinterp=dynamic \
        --enable-python3interp=yes \
        --enable-rubyinterp=dynamic \
        --enable-terminal \
        --enable-multibyte \
        --with-features=huge \
        --with-gnome \
        --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-$(uname -m)-linux-gnu
    echo "├── Compiling sources"
    make
    make install
    cd -
else
    echo "├── Existing executable"
fi

echo "├ Configuring"

mkdir -p ${HOME}/.vim/bundle
mkdir -p ${HOME}/.vim/undofiles

if [ ! -d ${HOME}/.vim/bundle/Vundle.vim ]; then
    echo "├── Installing Plugin Manager"
    git clone https://github.com/gmarik/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
    echo "├── Installing Plugins"
    $binary_file +PluginInstall +qall
fi

if [ ! -d ${HOME}/.vim/ftplugin ]; then
    echo "├── Installing FileType Plugins"
    ln -s $current_directory/.vim/ftplugin/ ${HOME}/.vim/ftplugin
fi
if [ ! -d ${HOME}/.vim/ultisnips-snippets ]; then
    echo "├── Installing Snippets"
    ln -s $current_directory/.vim/ultisnips-snippets/ ${HOME}/.vim/ultisnips-snippets
fi

echo "└ VIM - Installation complete"
