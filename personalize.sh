#!/usr/bin/env bash

## Contact evernote and fetch keys
mkdir -vp -m 700 $HOME/.ssh

if [ ! -f "$HOME/.ssh/id_rsa" ]; then
	geeknote find "Blue Key (private)"
	#Evernote escapes the ---- because it looks like markup, removing \'s
	geeknote show 1 | tail -n 52 | head -n 51 | sed 's/\\----/----/' > $HOME/.ssh/id_rsa
	chmod 600 $HOME/.ssh/id_rsa
	echo "Fetched RSA private key"
else
	echo "RSA private key already present"
fi

if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
	geeknote find "Blue Key (public)"
	geeknote show 1 | tail -n 2 | head -n 1 > $HOME/.ssh/id_rsa.pub 
	chmod 644 $HOME/.ssh/id_rsa.pub
	echo "Fetched RSA public key"
else
	echo "RSA private key already present"
fi
