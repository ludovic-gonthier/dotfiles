#!/usr/bin/env bash
set -e;

version="v2.44.0"

source_directory=${HOME}/src/git
subtree_source_directory=$source_directory/contrib/subtree/
subtree_binary_file=${HOME}/bin/git-subtree
current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "┌ GIT - Installation start"
echo "├── Prerequisites packages"
sudo apt-get install -y \
    asciidoc \
    expat \
    libcurl4-openssl-dev \
    wish \
    zlibc
echo "├ GIT source directory: $source_directory"
if [ ! -d $source_directory ]; then
    echo "├── Downloading source"
    git clone https://github.com/git/git.git ${source_directory}
fi
echo "├── Updating sources"

cd $source_directory
git fetch --all --tags --force
git checkout ${version}
git reset --hard tags/${version}

echo "├── Compiling sources"
make configure
./configure --prefix=${HOME}
make all
make install
cd -

echo "├── Installing Plugins"
if [ ! -x $subtree_binary_file ]; then
    cd $subtree_source_directory
    make prefix=${HOME}
    make prefix=${HOME} install
    make prefix=${HOME} install-doc
fi
echo "└ GIT - Installation complete"