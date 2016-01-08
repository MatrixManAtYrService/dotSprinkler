#!/usr/bin/env bash

## This script implements the customizations included in dotSprinkler

if ! type "apt-cyg" &>/dev/null
then
    echo "apt-cyg missing, do this from cmd:"
    echo '    cd C:\cygwin64'
    echo "    setup-x86_64 -q -P wget,tar,qawk,bzip2,subversion,vim"
    RUN=false
else
    echo ". Found apt-cyg"
    installFromRepo="curl git vim tree python python-pip screen"
    declare -a installScripts=("geeknote.sh")
    easy_install-2.7 pip


    CONFIG_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
    export CONFIG_DIR

    cd $CONFIG_DIR
    ## Clone Submodules
    git submodule update --init --recursive

    ## Install stuff
    apt-cyg install $installFromRepo

    ## Run install scripts
    for install in $installScripts; do
        . $CONFIG_DIR/install/$install
    done
    . $CONFIG_DIR/configure.sh

    source $HOME/.bashrc

    echo "run: geeknote login"
    echo "then: personalize.sh"
fi

