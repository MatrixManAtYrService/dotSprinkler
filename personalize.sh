#!/usr/bin/env bash

CONFIG_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $CONFIG_DIR

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
	echo "RSA public key already present"
fi

if [ ! -f "$HOME/.ssh/id_work_rsa" ]; then
	geeknote find "Work Key (private)"
	#Evernote escapes the ---- because it looks like markup, removing \'s
    geeknote show 1 | tail -n+8 | sed 's/\\----/----/' > $HOME/.ssh/id_work_rsa

	chmod 600 $HOME/.ssh/id_work_rsa
	echo "Fetched RSA private key"
else
	echo "RSA private key already present"
fi

if [ ! -f "$HOME/.ssh/id_work_rsa.pub" ]; then
	geeknote find "Work Key (public)"
	geeknote show 1 | tail -n 2 | head -n 1 > $HOME/.ssh/id_work_rsa.pub 
	chmod 644 $HOME/.ssh/id_work_rsa.pub
	echo "Fetched RSA public key"
else
	echo "RSA public key already present"
fi

if [ ! -f "$HOME/.ssh/config" ]; then
	geeknote find "SSH Config"
	geeknote show 1 | tail -n+8 > $HOME/.ssh/config
	chmod 644 $HOME/.ssh/config
	echo "Fetched SSH Config" 
else
	echo "SSH Config already present"
fi

ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H gitlab.com >> ~/.ssh/known_hosts
