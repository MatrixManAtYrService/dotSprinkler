#!/usr/bin/env bash

## Contact evernote and fetch keys

mkdir -vp $HOME/.ssh

if [ ! -f "$HOME/.ssh/id_rsa" ]; then
	geeknote find "Low Security Private Key" 
	# Evernote escapes the -----'s and adds a newline, probably because it is interpreting them as markdown, stripping these out.
	geeknote show 1 | sed '/^$/d' | sed 's/\\----/----/' | tail -n +8 > $HOME/.ssh/id_rsa
	chmod 700 $HOME/.ssh/id_rsa
	echo "Fetched RSA private key"
else
	echo "RSA private key already present"
fi

if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
	geeknote find "Low Security Public Key"
	# Evernote replaces mail@address.com with [mail@address.com](user@
	geeknote show 1 | tail -n +9 | sed 's/\[[^]]*\](mailto:\([^)]*\))/\1/' | sed '/^$/d' > $HOME/.ssh/id_rsa.pub 
	echo "Fetched RSA public key"
else
	echo "RSA private key already present"
fi


