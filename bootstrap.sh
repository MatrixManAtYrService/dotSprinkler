#!/usr/bin/env bash

## This script implements the customizations included in dotSprinkler

installFromRepo="curl git vim tree"
declare -a installScripts=("geeknote.sh")

CONFIG_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export CONFIG_DIR

## Clone Submodules
git submodule update --init --recursive

## Install stuff
apt-get install $installFromRepo

## Run install scripts
for install in $installScripts; do
	. $CONFIG_DIR/install/$install
done
. $CONFIG_DIR/configure.sh

source $HOME/.bashrc

echo "run: geeknote login"
echo "then: personalize.sh"
