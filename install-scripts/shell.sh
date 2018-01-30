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
echo "├── Set default TERM to zsh"
chsh -s /bin/zsh

echo "├── ZSH - OH-MY-ZSH - Installation start"
if [ ! -d $source_directory ]; then
    echo "├────  Downloading sources"
    git clone git://github.com/robbyrussell/oh-my-zsh.git $source_directory
else
    echo "├────  Already installed"
fi
echo "├── ZSH - OH-MY-ZSH - Installation complete"
echo "└ ZSH - Installation complete"
