#!/usr/bin/env bash
#
# Script runtime.sh -- this script will clean data and create new reports and upload them to github
#
# Author: 

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide some errors in pipes

#
# Functions
#

temp() {
    # 2 clean the new raw data 
    echo "Cleaning gatherd data"
    bash clean_data.sh
    # start the vevn for python
    echo "Starting the venv"
    . env\\Scripts\\activate
    # 3 analyse data and create reports
    echo "new report gen"
    py analyse_and_report_gen.py
    # 5 auto update
    git add .
    git commit -m "automated update"
    git push origin main
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