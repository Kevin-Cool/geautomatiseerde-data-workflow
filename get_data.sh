#!/bin/bash
#
# Script get_data.sh - connect to the gent api, get the latest air quality info and safe the return as json in the rawdata folder
#
# Author: Kevin Cool

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
#
# Functions
#

gather_raw_data() {
    curl -X GET $URL -H "Accept: application/json" -o "$directorie"/"rawdata-$(date +%Y%m%d-%H%M%S).json";
}
check_if_valid_directorie(){
    if [ -d "$directorie" ]; then
        echo "$directorie is a directory.";
    else
        echo "$directorie does not exist, do you wish to create it (y/n)";
        read create_dir
        if [ "$create_dir" == "y" ]; then
            mkdir "$directorie";
            echo " the new directory has been successfully created:  $directorie";
        else
            echo " process stoped: no valid directorie was given"
            exit 3;
        fi
    fi
}

#
# Variables
#

# By default it wil use the same folder as the script is in
directorie="/home/kevin/Documents/automate/rawdata";
# The url of the API 
URL="https://data.stad.gent/api/records/1.0/search/?dataset=api-luftdateninfo";


#
# Command line parsing
#

if [ "$#" -gt "1" ]; then
    echo "Expected at most 1 argument, got $#" >&2;
    exit 2;
fi



#
# Script proper
#

# If new dir was given use that one 
if [ "$#" -eq "1" ]; then
    directorie=$1;
fi
check_if_valid_directorie
# Ghather the data and save it to the rawdata folder
gather_raw_data;