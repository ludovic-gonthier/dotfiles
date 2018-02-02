#!/bin/bash
set -eu
IFS=$'\n'

sudo apt-get install -y \
    autoconf \
    python-pip \
    stow \
    wget \
    zsh
