#!/usr/bin/env bash

## This script restores any backups made by clearExisting.sh

CONFIG_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export CONFIG_DIR

# populate locations
declare -A CONFIG_LOCATIONS
export CONFIG_LOCATIONS
. $CONFIG_DIR/locations.sh


for location in "${!CONFIG_LOCATIONS[@]}"; do
	if [ -L ${CONFIG_LOCATIONS[$location]} ] ; then
		echo "${CONFIG_LOCATIONS[$location]} is a link, deleting it"
		echo "rm -rvf ${CONFIG_LOCATIONS[$location]}" | awk '{print "    "$0}'
	else
		echo "${CONFIG_LOCATIONS[$location]} is not a link, backing it up, then deleting the original"
		echo "mv -vf \"${CONFIG_LOCATIONS[$location]}\" \"${CONFIG_LOCATIONS[$location]}.bak\"" | awk '{print "    "$0}'
		echo "rm -rvf ${CONFIG_LOCATIONS[$location]}" | awk '{print "    "$0}'
	fi
done


if cat $HOME/.bashrc | grep _bashrc_continued 1>& /dev/null; then 
	echo "undoing .bashrc redirect"
	echo "sed -i '/\(_bashrc_continued\|Reference to external config file\)/d' $HOME/.bashrc"
else
	echo "didn't find .bashrc redirect"
fi

