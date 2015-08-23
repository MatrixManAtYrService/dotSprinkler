#!/usr/bin/env bash

## This script implements the customizations included in dotSprinkler
installFromRepo="curl git vim tree"
declare -a installScripts=("geeknote.sh")

CONFIG_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export CONFIG_DIR

## Install stuff
apt-get install $installFromRepo

## Run install scripts
for install in $installScripts; do
	. $CONFIG_DIR/install/$install
done
./configure.sh
echo "run: geeknote login"
echo "then: personalize.sh"
