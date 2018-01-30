#!/bin/bash
set -eu
IFS=$'\n'

sudo apt-get install -y \
    python-pip \
    stow \
    wget \
    zsh
