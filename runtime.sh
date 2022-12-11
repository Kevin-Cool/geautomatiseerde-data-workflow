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
    bash "$d0d/clean_data.sh" $d1d $d2d
    # 3 analyse data and create reports
    python3 "$d0d/analyse_and_report_gen.py" $d2d $d3d $d4d
}

push_to_git(){
    git add .
    git commit -m "automated update"
    git push origin main
}

pars_options(){
    if [ "$1" == "-git" ]; then
        d0d=$2;
        d1d=$3;
        d2d=$4; 
        d3d=$5;
        d4d=$6;
    else
        d0d=$1;
        d1d=$2;
        d2d=$3;
        d3d=$4;
        d4d=$5;
    fi
}
#
# Variables
#
d0d="$(pwd)";
d1d="/home/kevin/Documents/automate/rawdata";
d2d="/home/kevin/Documents/automate/cleandata";
d3d="/home/kevin/Documents/automate/analysedata";
d4d="/home/kevin/Documents/automate/generatedreports";
#
# Command line parsing
#

if [ "$#" -gt "5" ]; then
    echo "Expected at most 5 argument, got $#" >&2
fi

#
# Script proper
#

# echo current time for log file 
echo "running runtime.sh $(date +%Y%m%d-%H%M%S)"
# Check if the default directory needs to be changed
if [ "$#" -gt "1" ]; then
   pars_options "$@"
fi
# run the script
temp
# Check if auto push to github has been enabled
if  [ "$#" -gt "0" ] && [ "$1" == "-git" ]; then
    push_to_git
fi