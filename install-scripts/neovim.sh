#!/usr/bin/env bash
set -e;
set -x;

version="stable"

source_directory=${HOME}/src/neovim
binary_file=${HOME}/bin/vim

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "┌ NeoVIM - Installation start"
echo "├── Prerequisites packages"
sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
echo "├ NeoVIM source directory: $source_directory"
if [ ! -d $source_directory ]; then
    echo "├── Downloading source"
    git clone https://github.com/neovim/neovim.git ${source_directory}
fi
cd $source_directory
echo "├── Updating sources"
git fetch --all --tags --force
git reset --hard tags/${version}

echo "├── Compiling sources"
make clean
make distclean
make CMAKE_INSTALL_PREFIX=$HOME/src/neovim
make CMAKE_BUILD_TYPE=Release
make install
cd -
echo "├ Configuring"

mkdir -p ${HOME}/.vim/autoload
mkdir -p ${HOME}/.vim/undofiles

echo "├── Installing Plugins"
rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "└ NeoVIM - Installation complete"
