#!/usr/bin/env bash

## Dependencies
declare -a requirements=("curl" "git")

declare -A locations
locations[_bash_profile]="$HOME/.bash_profile"
locations[_bash_aliases]="$HOME/.bash_aliases"
locations[_vimrc]="$HOME/.vimrc"
locations[_i3_config]="$HOME/.i3/config"
locations[_uncrustify_cfg]="$HOME/.uncrustify_cfg"
locations[_gitconfig]="$HOME/.gitconfig"
locations[_vim]="$HOME/.vim"

declare -a installs=("geeknote.sh")

CONFIG_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export CONFIG_DIR

RUN=true;
## Is Bash version 4 or higher?
MAJOR_BASH_VERSION=$(echo $BASH_VERSION | grep -o ^[0-9]*)
if [ "$MAJOR_BASH_VERSION" -lt 4 ]; then
	echo "! Bash version is $BASH_VERSION, must be greater than 4.0.0"
	RUN=false
else
	echo ". Bash 4.0.0 or higher"
fi

## Are this script's dependencies installed?
for req in "${requirements[@]}" ; do
	if ! type "$req" &>/dev/null
	then
		echo "! Missing $req."
		RUN=false
	else
		echo ". Found $req."
	fi
done

## Do the referenced dotfiles exist?
for config in "${!locations[@]}"; do
    if [ -a $CONFIG_DIR/$config ]; then
        echo ". Found config: $CONFIG_DIR/$config"
    else
        echo "! Missing config: $CONFIG_DIR/$config"
		RUN=false
    fi
done

## Was a fatal error encountered?
if [[ "$RUN" = false ]] ; then
	echo "Exiting"
	exit 1
fi

## Use existing .bashrc first, then call configured one
echo "Extending .bashrc to $CONFIG_DIR/_bashrc_extended."
printf "\n%s\n%s\n" \
"#Reference to external config file" \
"(exec \"~/configs/_bashrc_continued\")" \
>> ~/.bashrc

## Create links to configured dotfiles
for config in "${!locations[@]}"; do
	location=${locations[$config]}
    if [ -f ${locations[$config]} ]; then
		if [ -L ${locations[$config]} ]; then
			echo "? $location already exists, and is alrady a link. Doing nothing."
			mklink=false;

		else
			echo "? $location already exists, and is not a link.  Moved original to $CONFIG_DIR"
			echo "      Reconcile: $CONFIG_DIR/_$config (currently ignored)"
			echo "      with: $CONFIG_DIR/$config (currently used)."
			mv $location $CONFIG_DIR/_$config
			mklink=true;
		fi
	else
		echo ". $location does not exist"
		mklink=true;
    fi

	if [[ "$mklink" = true ]] ; then
		echo "      linking $location to $CONFIG_DIR/$config"
		ln -s $CONFIG_DIR/$config $location
	fi
done

## Run install scripts
for install in $installs; do
	. $CONFIG_DIR/install/$install
done
rm -rf $CONFIG_DIR/install/temp/*
