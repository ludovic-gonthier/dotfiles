#!/usr/bin/env bash
set -e;

source_directory=${HOME}/src/universal-ctags
binary_file=${HOME}/bin/ctags

install_source () {
    pushd $source_directory
    if [ -f src/auto/config.cache ]; then
        rm src/auto/config.cache
    fi

    echo "├── Configuring sources"
    ./autogen.sh
    ./configure --prefix=${HOME}
    echo "├── Building sources"
    make
    echo "├── Compiling sources"
    make install

    popd
}

echo "├── Universal CTAGS - Installation start"
if [ ! -d $source_directory ]; then
    echo "├────  Downloading sources"
    git clone git@github.com:universal-ctags/ctags.git $source_directory
else
    echo "├────  Updating sources"
    pushd $source_directory
    git pull --rebase origin master
    popd
fi

echo "├── Prerequisites packages"
sudo apt install \
    gcc \
    make \
    pkg-config \
    autoconf \
    automake \
    python3-docutils \
    libseccomp-dev \
    libjansson-dev \
    libyaml-dev \
    libxml2-dev

if [ ! -x $binary_file ]; then
    install_source
else
    echo "├── Existing executable"

    read -r -p "Update it? [Y/n]" choice
    case "$choice" in
    y | Y)
      rm $binare_file
      install_source
      ;;
    esac
fi

echo "└ Universal CTAGS  Installation complete"
