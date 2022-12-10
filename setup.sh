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
    if [[ "$(git --version)" =~ "git version" ]]; then
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
    echo "============== Finished checking for installed packages ==============="
    
 
}

check_for_options() {
    echo "optoins checking"
    if [ "$#" -gt "0" ]; then
        # shows more info on the different options 
        if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
            echo "OPTIONS:"
            echo "          -h, --help: shows the different posibel options"
            echo "          -git: enabels autopush of the generated data and reports"
            echo "          -d1, --dirraw: is used to set a directorie for the rawdata storage"
            echo "          -d2, --dirclean: is used to set a directorie for the clean data"
            echo "          -d3, --diranalyse: is used to set a directorie for the analysed data"
            echo "          -d4, --dirreport: is used to set a directorie for the generated reports"
            exit 0
        fi
    
        while [[ $# -gt 0 ]]; do
            case $1 in
                -git) use_git="1" 
                shift ;;
                -d1 | --dirraw) echo "Give the directorie where raw data will be saved, this directorie way not be used for any other files"
                d1="1"
                read d1d
                shift ;;
                -d2 | --dirclean) echo "Give the directorie where cleaned data will be saved"
                d2="1"
                read d2d
                shift ;;
                -d3 | --diranalyse) echo "Give the directorie where analysed data will be saved"
                d3="1"
                read d3d
                shift ;;
                -d4 | --dirreport) echo "Give the directorie where generated reports will be saved"
                d4="1"
                read d4d
                shift ;;
                -h | -help) echo "the help function can not be used in combination with other options"
                exit 0
                shift ;;
                *) echo "the given option: $1 , is not a recoginsed option please use -h or --help for more information on wat options are posible"
                exit 0
                shift ;;
            esac
        done

    fi

}


create_crontabs() {
    printf "0 */12 * * * %s/automated.sh %s\n" "$SCRIPTDIR" "$DATADIRECTORY";
    printf "0 0 * * * /bin/python%s %s/analyse.py %s %s\n" "$pythonV" "$SCRIPTDIR" "$DATADIRECTORY/csv" "$BASEDIR";
    crontab -l | { cat; echo "0 0 0 0 0 some entry"; } | crontab -

}


temp() {
    # 1 run get_data.sh 12h
    echo "do the 12h update";
    if [ "$d1" -eq "1" ]; then
        bash get_data.sh $d1d;
    else
        bash get_data.sh;
    fi

    # 2 clean the new raw data 24h
    echo "do the 24h update";
    # Check if the defoult directorie was changed 
    if [ "$d1" -eq "0" ] || [ "$d2" -eq "0" ] || [ "$d3" -eq "0" ] || [ "$d4" -eq "0" ]; then
        # if dir is not changed check if auto push to git has been enabeld
        if [ "$use_git" -eq "1" ]; then
            bash runtime.sh -git;
        else
            bash runtime.sh;
        fi
    else
    # if any defoult dir was changed pass all dir locations, and check if auto push to github has been enabeld 
        if [ "$use_git" -eq "1" ]; then
            bash runtime.sh -git $d1d $d2d $d3d $d4d ;
        else
            bash runtime.sh $d1d $d2d $d3d $d4d ;
        fi
    fi
}

#
# Variables
#
use_git="0";
d1="0"
d1d="/home/kevin/Documents/automate/rawdata"
d2="0"
d2d="/home/kevin/Documents/automate/cleandata"
d3="0"
d3d="/home/kevin/Documents/automate/analysedata"
d4="0"
d4d="/home/kevin/Documents/automate/generatedreports"
#
# Command line parsing
#
check_for_options "$@"

#
# Script proper
#


install_requirements
temp