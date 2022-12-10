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

pars_options(){
    if [ "$1" == "-git" ]; then
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
}

check_dirs(){
    # Make sure all directories exist
    check_if_valid_directorie $d1d
    check_if_valid_directorie $d2d
    check_if_valid_directorie $d3d
    check_if_valid_directorie $d4d
}

check_if_valid_directorie(){
    if [ -d "$1" ]; then
        echo "$1 is a directory.";
    else
        echo "$1 does not exist, do you wish to create it (y/n)";
        read create_dir
        if [ "$create_dir" == "y" ]; then
            mkdir "$1";
            echo " the new directory has been successfully created:  $1";
        else
            echo " process stoped: no valid directorie was given"
            exit 3;
        fi
    fi
}

#
# Variables
#

d1d="/home/kevin/Documents/automate/rawdata"
d2d="/home/kevin/Documents/automate/cleandata"
d3d="/home/kevin/Documents/automate/analysedata"
d4d="/home/kevin/Documents/automate/generatedreports"
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
   pars_options "$@"
fi
# Check if all dirs exist
check_dirs
# run the script
temp
# Check if auto push to github has been enabeld
if  [ "$#" -gt "0" ] && [ "$1" == "-git" ]; then
    push_to_git
fi