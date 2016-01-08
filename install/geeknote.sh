#!/usr/bin/env bash

INSTALL_DIR="$CONFIG_DIR/install"
if type "geeknote" &>/dev/null; then
	echo ". geeknote already installed"
else
	if [[ $EUID -eq 0 ]] || [[ "`uname -o`" = "Cygwin" ]]; then
		pip install setuptools
		cd "$INSTALL_DIR/geeknote" && python setup.py install
		echo ". installed geeknote, run \"geeknote login\" to authenticate."
	else
		echo "? rerun as root to install geeknote"
	fi
fi
