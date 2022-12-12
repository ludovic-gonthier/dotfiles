#!/usr/bin/env bash
set -e;
set -x;

version="nightly"

source_directory=${HOME}/src/neovim-${version}
binary_file=${HOME}/bin/vim

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dl=$current_directory/helper/download_unzip

echo "┌ NeoVIM - Installation start"
if [ ! -d $source_directory ]; then
    echo "├── Downloading source"
    $dl https://github.com/neovim/neovim/archive/${version}.zip ~/src/
else
    echo "├── Existing sources"
fi

echo "├── Prerequisites packages"
sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
echo "├ NeoVIM sources: $source_directory"

echo "├── Configuring sources"
cd $source_directory
make distclean
echo "├── Compiling sources"
make CMAKE_INSTALL_PREFIX=$HOME/src/neovim CMAKE_BUILD_TYPE=RelWithDebInfo install
if [ -x $binary_file ]; then
    rm ${binary_file}
fi
ln -s ${source_directory}/build/bin/nvim ${binary_file}
cd -

echo "├ Configuring"

mkdir -p ${HOME}/.vim/autoload
mkdir -p ${HOME}/.vim/undofiles

echo "├── Installing Plugins"
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

if [ ! -d ${HOME}/.vim/ftplugin ]; then
    echo "├── Installing FileType Plugins"
    ln -s $current_directory/.vim/ftplugin/ ${HOME}/.vim/ftplugin
fi
if [ ! -d ${HOME}/.vim/ultisnips-snippets ]; then
    echo "├── Installing Snippets"
    ln -s $current_directory/.vim/ultisnips-snippets/ ${HOME}/.vim/ultisnips-snippets
fi

# Install COC plugins
vim -c 'CocInstall -sync coc-json coc-html coc-reason coc-tsserver coc-phpls coc-clangd|q'

echo "└ NeoVIM - Installation complete"
