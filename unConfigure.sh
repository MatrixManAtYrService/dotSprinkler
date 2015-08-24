#!/usr/bin/env bash

## This script restores any backups made by configure.sh or clearExisting.sh.

CONFIG_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export CONFIG_DIR

# populate locations
declare -A CONFIG_LOCATIONS
export CONFIG_LOCATIONS
. $CONFIG_DIR/locations.sh

for location in "${!CONFIG_LOCATIONS[@]}"; do
	if [ -a ${CONFIG_LOCATIONS[$location]}.bak ] ; then
		if [ -d ${CONFIG_LOCATIONS[$location]}.bak ] ; then
			echo ${CONFIG_LOCATIONS[$location]}".bak/ exists, restoring it"
			rm -rf ${CONFIG_LOCATIONS[$location]} | awk '{print "    "$0}'
			mv -vf ${CONFIG_LOCATIONS[$location]}".bak" ${CONFIG_LOCATIONS[$location]} | awk '{print "    "$0}'
		else
			echo ${CONFIG_LOCATIONS[$location]}".bak exists, restoring it"
			mv -vf ${CONFIG_LOCATIONS[$location]}".bak" ${CONFIG_LOCATIONS[$location]} | awk '{print "    "$0}'
		fi
	else
		echo "${CONFIG_LOCATIONS[$location]}.bak does not exist, doing nothing"
	fi
done
