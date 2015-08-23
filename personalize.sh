#!/usr/bin/env bash

## Contact evernote and fetch keys
# Evernote mangles these somewhat (TODO: investigate this), sed and tail just clean it up
if [ ! -f "$HOME/.ssh/id_rsa" ]; then
	geeknote find "Low Security Private Key" 
	geeknote show 1 | sed '/^$/d' | sed 's/\\----/----/' | tail -n +8 > $HOME/.ssh/id_rsa
	echo "Fetched RSA private key"
else
	echo "RSA private key already present"
fi

if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
	geeknote find "Low Security Public Key"
	geeknote show 1 | tail -n +9 > $HOME/.ssh/id_rsa.pub
	echo "Fetched RSA public key"
else
	echo "RSA private key already present"
fi

