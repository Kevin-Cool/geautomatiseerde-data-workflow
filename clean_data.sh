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
    # 1: -s to run the jq on the intire set, map(.records[]) will get all the record items from each file and combine them into one list
    # 2: -s to run the jq on the intire set, .[] will open the list, unique will remove the individual duplicate items
    # 3: -r will make sure the output is not alterd, ["value_type","value","timestamp","is_indoor","x","y"] this shows which fields from the json that will be cept
    jq -s 'map(.records[])' "$rawdata_directorie"/* | jq -s '.[] | unique' | jq -r '["value_type","value","timestamp","is_indoor","x","y"] , (.[] | [.fields.value_type, .fields.value, .fields.timestamp, .fields.is_indoor, .fields.location[0], .fields.location[1] ]) | @csv' > "$cleandata_directorie"/cleandata.csv
}


#
# Variables
#

# By default it wil use the same folder as the script is in
rawdata_directorie="./rawdata";
cleandata_directorie="./cleandata";


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

# Ghather the data and save it to the rawdata folder
clean_data;