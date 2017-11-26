#!/usr/bin/env bash
set -e;

version='8.0.1341'
source_directory=${HOME}/src/vim-${version}
binary_file=${HOME}/bin/vim
dataroot_directory=${HOME}/share/vim/vim80

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "┌ VIM - Installation start"
if [ ! -d $source_directory ]; then
	echo "├── Downloading source"
	$current_directory/../helper/download_unzip https://github.com/vim/vim/archive/v${version}.zip ~/src/
else
	echo "├── Existing sources"
fi

if [ ! -d $dataroot_directory ]; then
	mkdir -p $dataroot_directory
fi
echo "├── Prerequisites packages"
sudo apt-get install -y \
	debhelper \
    exuberant-ctags \
	libacl1-dev \
	libgpmg1-dev \
	libgtk-3-dev \
	libncurses5-dev \
	libxaw7-dev \
	libxpm-dev \
	libxt-dev
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
		--enable-pythoninterp=yes \
		--enable-rubyinterp=dynamic \
		--enable-terminal \
		--enable-multibyte \
		--with-features=huge \
		--with-gnome \
		--with-python-config-dir=/usr/lib/python2.7/config-$(uname -m)-linux-gnu
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

echo "└ VIM - Installation complete"
