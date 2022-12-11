#!/bin/bash
#
# Script clean_data.sh - ghaters all rawdata files from the rawdata folder, ignores duplicate readings and compiles the important data to a new file 
#
# Author: Kevin Cool

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
#
# Functions
#

clean_data() {
    jq -s 'map(.records[])' "$rawdata_directorie"/* | jq -s '.[] | unique' | jq -r '["value_type","value","timestamp","is_indoor","x","y"] , (.[] | [.fields.value_type, .fields.value, .fields.timestamp, .fields.is_indoor, .fields.location[0], .fields.location[1] ]) | @csv' > "$cleandata_directorie"/cleandata.csv
}


#
# Variables
#

# By default it will use the same folder as the script is in
rawdata_directorie="/home/kevin/Documents/automate/rawdata";
cleandata_directorie="/home/kevin/Documents/automate/cleandata";


#
# Command line parsing
#

if [ "$#" -gt "2" ]; then
    echo "Expected at most 2 argument, got $#" >&2;
    exit 2;
fi



#
# Script proper
#

# If new directory where given use those
if [ "$#" -eq "2" ]; then
    rawdata_directorie=$1;
    cleandata_directorie=$2;
fi

# Gather the data and save it to the rawdata folder

# echo current time for log file 
echo "running clean_data.sh $(date +%Y%m%d-%H%M%S)"

clean_data;