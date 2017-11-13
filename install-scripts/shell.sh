#!/usr/bin/env bash
set -e;

local_files=(
	${HOME}/.aliases.local
	${HOME}/.zshenv.local
	${HOME}/.zshrc.local
)
source_directory=${HOME}/.oh-my-zsh

echo "┌ ZSH - Configuration start"
echo "├──  Creating empty local files"
for file in local_files;
do
	if [ ! -e $file ]; then
		echo "├────  Creating $file"
		touch $file
	fi
done

echo "├── ZSH - OH-MY-ZSH - Installation start"
if [ ! -d $source_directory ]; then
	echo "├────  Downloading sources"
	wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sudo sh
else
	echo "├────  Already installed"
fi
echo "├── ZSH - OH-MY-ZSH - Installation complete"
echo "└ ZSH - Installation complete"
