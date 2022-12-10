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
    bash clean_data.sh $d1d $d2d
    # start the vevn for python
    #echo "Starting the venv"
    #. env\\Scripts\\activate
    # 3 analyse data and create reports
    echo "new report gen"
    python3 analyse_and_report_gen.py  $d2d $d3d $d4d
    # 5 auto update
}

push_to_git(){
    git add .
    git commit -m "automated update"
    git push origin main
}

#
# Variables
#

d1d="./rawdata"
d2d="./cleandata"
d3d="./analysedata"
d4d="./generatedreports"
#
# Command line parsing
#

if [ "$#" -gt "5" ]; then
    echo "Expected at most 5 argument, got $#" >&2
fi

#
# Script proper
#

# Check if the defoult dir need to be changed
if [ "$#" -gt "1" ]; then
    if [ "$1" -eq "-git" ]; then
        d1d=$2
        d2d=$3
        d3d=$4
        d4d=$5
    else
        d1d=$1
        d2d=$2
        d3d=$3
        d4d=$4
    fi
fi
# run the script
temp
# Check if auto push to github has been enabeld
if  [ "$#" -gt "0" ] && [ "$1" -eq "-git" ]; then
    push_to_git
fi