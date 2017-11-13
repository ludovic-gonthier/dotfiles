#!/usr/bin/env bash
set -e;

source_directory=${HOME}/src/vim
binary_file=${HOME}/bin/vim

echo "┌ VIM - Installation start"
if [ ! -d $source_directory ]; then
	echo "├── Downloading source"
   	git clone git@github.com:vim/vim.git $source_directory/
else
	echo "├── Existing sources"
fi

echo "├ VIM sources: $source_directory"

if [ ! -d $binary_file ]; then
	echo "├── Configuring sources"
	cd $source_directory
	./configure --prefix=${HOME}\
		--disable-darwin \
		--disable-netbeans \
		--disable-selinux \
		--disable-smack \
		--enable-cscope \
		--enable-gui \
		--enable-perlinterp=dynamic \
		--enable-pythoninterp=yes \
		--enable-rubyinterp=dynamic \
		--enable-terminal \
		--with-python-config-dir=/usr/lib/python2.7/config-$(uname -m)-linux-gnu \
		--with-x
	echo "├── Compiling sources"
	make && sudo make install
	vim --version | grep clipboard
	cd -
else
	echo "├── Existing executable"
fi

exit
echo "├ Configuring"

mkdir -p ${HOME}/.vim/bundle
mkdir -p ${HOME}/.vim/undofiles

if [ -d ${HOME}/.vim/bundle/Vundle.vim ]; then
	echo "├── Installing Plugin Manager"
	git clone https://github.com/gmarik/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
	echo "├── Installing Plugins"
	$binary_file +PluginInstall +qall
fi

echo "└ VIM - Installation complete"
