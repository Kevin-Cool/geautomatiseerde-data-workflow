#!/usr/bin/env bash
#
# Script setup.sh -- this script will install all necessary dependencies and it will create cronjobs to schedule everything
#
# Author: 

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide some errors in pipes

#
# Functions
#

temp() {
    # 1 run get_data.sh 12h
    echo "do the 12h update"
    bash get_data.sh

    # 2 clean the new raw data 24h
    echo "do the 24h update"
    bash runtime.sh
}

#
# Variables
#

#
# Command line parsing
#

if [ "$#" -ne "0" ]; then
    echo "Expected 1 argument, got $#" >&2
fi

#
# Script proper
#

temp