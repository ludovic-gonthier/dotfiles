#!/usr/bin/env bash
set -e;

source_directory=${HOME}/src/tmux
binary_file=${HOME}/bin/tmux

echo "┌ TMUX - Installation start"
if [ ! -d $source_directory ]; then
	echo "├── Downloading source"
	git clone git@github.com:tmux/tmux.git $source_directory
else
	echo "├── Existing sources"
fi

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
