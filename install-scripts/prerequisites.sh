#!/bin/bash
set -eu
IFS=$'\n'

sudo apt-get install -y \
    autoconf \
    python3-pip \
    stow \
    wget \
    zsh
