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
install_requirements(){
    echo "============= Checking if required packages are installed ============="
    # Check if CURL is installed
    which curl &> /dev/null || sudo apt install curl
    # Check if JQ is installed
    if [ "$(dpkg -l | awk '/jq/ {print }'|wc -l)" -ge 1 ]; then
        echo "jq was installed"
    else
        sudo apt-get install jq;
    fi
    # Check if Git is installed
    if [[ "$(git -v)" =~ "git version" ]]; then
        echo "Git was installed"
    else
        sudo apt-get install git;
    fi
    # Check if python3 is installed
    if [[ "$(python3 -V)" =~ "Python 3" ]]; then
        echo "python3 was installed"
    else
        sudo apt-get install python3;
    fi
    # Check if pip is installed
    if [[ "$(pip -V)" =~ "pip" ]]; then
        echo "pip is installed"
    else
        sudo apt install python3-pip
    fi
    # install required python packages
    if  [[ "$(pip list | grep pandas)" =~ "pandas" ]]; then
        echo "pandas is installed"
    else
        pip install pandas
    fi
    if [[ "$(pip list | grep matplotlib)" =~ "matplotlib" ]]; then
        echo "matplotlib is installed"
    else
        pip install matplotlib
    fi
    if [[ "$(pip list | grep seaborn)" =~ "seaborn" ]]; then
        echo "seaborn is installed"
    else
        pip install seaborn
    fi

    
 
}

create_crontabs() {
    printf "0 */12 * * * %s/automated.sh %s\n" "$SCRIPTDIR" "$DATADIRECTORY";
    printf "0 0 * * * /bin/python%s %s/analyse.py %s %s\n" "$pythonV" "$SCRIPTDIR" "$DATADIRECTORY/csv" "$BASEDIR";
    crontab -l | { cat; echo "0 0 0 0 0 some entry"; } | crontab -

}


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

install_requirements
temp