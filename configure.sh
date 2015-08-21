#!/usr/bin/env bash

## Dependencies
declare -a requirements=("curl" "git")

declare -a install=("geeknote.sh")

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

# builds and exports CONFIG_LOCATIONS (requires Bash 4 or higher)
declare -A CONFIG_LOCATIONS
export CONFIG_LOCATIONS
. $CONFIG_DIR/locations.sh

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
for config in "${!CONFIG_LOCATIONS[@]}"; do
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
". ~/configs/_bashrc_continued" \
>> ~/.bashrc

## DELETE THIS
exit 2

## Create links to configured dotfiles
for config in "${!CONFIG_LOCATIONS[@]}"; do
	location=${CONFIG_LOCATIONS[$config]}
    if [ -f ${CONFIG_LOCATIONS[$config]} ]; then
		if [ -L ${CONFIG_LOCATIONS[$config]} ]; then
			echo "? $location already exists, and is alrady a link. Doing nothing."
			mklink=false;

		else
			mv -f  $location $location".bak"
			echo "? $location already exists and is not a link.  Backed up original to "$location".bak"
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
