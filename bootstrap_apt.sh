#!/usr/bin/env bash

## This script implements the customizations included in dotSprinkler

installFromRepo="curl git vim tree python python-pip screen"
declare -a installScripts=("geeknote.sh" "githooks.sh")

CONFIG_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export CONFIG_DIR

cd $CONFIG_DIR
## Clone Submodules
git submodule update --init --recursive

## Install stuff
apt-get install $installFromRepo

## Run install scripts
for install in ${installScripts[@]}; do
    echo ". Running $install"
	. $CONFIG_DIR/install/$install
done
. $CONFIG_DIR/configure.sh

source $HOME/.bashrc

echo "run: geeknote login"
echo "then: personalize.sh"
