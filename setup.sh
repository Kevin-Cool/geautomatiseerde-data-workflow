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
    echo "============= Checking if required packages are installed =============";
    # Check if CURL is installed
    which curl &> /dev/null || sudo apt install curl;
    # Check if JQ is installed
    if [ "$(dpkg -l | awk '/jq/ {print }'|wc -l)" -ge 1 ]; then
        echo "jq was installed";
    else
        sudo apt-get install jq;
    fi
    # Check if Git is installed
    if [[ "$(git --version)" =~ "git version" ]]; then
        echo "Git was installed";
    else
        sudo apt-get install git;
    fi
    # Check if python3 is installed
    if [[ "$(python3 -V)" =~ "Python 3" ]]; then
        echo "python3 was installed";
    else
        sudo apt-get install python3;
    fi
    # Check if pip is installed
    if [[ "$(pip -V)" =~ "pip" ]]; then
        echo "pip is installed";
    else
        sudo apt install python3-pip
    fi
    # install required python packages
    if  [[ "$(pip list | grep pandas)" =~ "pandas" ]]; then
        echo "pandas is installed";
    else
        pip install pandas;
    fi
    if [[ "$(pip list | grep matplotlib)" =~ "matplotlib" ]]; then
        echo "matplotlib is installed";
    else
        pip install matplotlib;
    fi
    if [[ "$(pip list | grep seaborn)" =~ "seaborn" ]]; then
        echo "seaborn is installed";
    else
        pip install seaborn;
    fi
    
 
}

check_for_options() {
    echo "optoins checking";
    if [ "$#" -gt "0" ]; then
        # shows more info on the different options 
        if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
            echo "OPTIONS:";
            echo "          -h, --help: shows the different possible options";
            echo "          -git: enables auto push of the generated data and reports";
            echo "          -d1, --dirraw: is used to set a directory  for the rawdata storage";
            echo "          -d2, --dirclean: is used to set a directory  for the clean data";
            echo "          -d3, --diranalyse: is used to set a directory  for the analysed data";
            echo "          -d4, --dirreport: is used to set a directory  for the generated reports";
            echo "          -d5, --dirlogs: is used to set a directory  for the logging of the automated scripts";
            exit 0
        fi
    
        while [[ $# -gt 0 ]]; do
            case $1 in
                -git) use_git="1" 
                shift ;;
                -d1 | --dirraw) echo "Give the directory where raw data will be saved, this directory way not be used for any other files";
                dir_change="1"
                read d1d
                shift ;;
                -d2 | --dirclean) echo "Give the directory where cleaned data will be saved";
                dir_change="1"
                read d2d
                shift ;;
                -d3 | --diranalyse) echo "Give the directory where analysed data will be saved";
                dir_change="1"
                read d3d
                shift ;;
                -d4 | --dirreport) echo "Give the directory where generated reports will be saved";
                dir_change="1"
                read d4d
                shift ;;
                -d5 | --dirlogs) echo "Give the directory where generated logs will be saved";
                dir_change="1"
                read logd
                shift ;;
                -h | -help) echo "the help function can not be used in combination with other options";
                exit 0
                shift ;;
                *) echo "the given option: $1 , is not a recognised option please use -h or --help for more information on wat options are possible";
                exit 0
                shift ;;
            esac
        done

    fi

}


check_all_directories(){
    echo "================== Checking if the directories exist =================="
    check_if_valid_directorie $logd
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
            echo " the new directory has been successfully created: $1";
        else
            echo " process stopped: no valid directory was given";
            exit 3;
        fi
    fi
}
check_if_execute_rights(){
    echo "making sure crontab has execute rights for the scripts";
    # analyse_and_report_gen.py
    chmod +x "$(pwd)/analyse_and_report_gen.py";
    # get_data.sh
    chmod +x "$(pwd)/get_data.sh";
    # clean_data.sh
    chmod +x "$(pwd)/clean_data.sh";
    # runtime.sh
    chmod +x "$(pwd)/runtime.sh";
}
create_cronjob(){
    echo "======================== Creating the cronjobs ========================";
    if [[ "$(crontab -l | grep $1)" == *"$1"* ]]; then
        echo "cronjob $1 already exists, replace it? (y/n)";
        read replace_crontab
        if [ "$replace_crontab" == "y" ]; then
            crontab  -l | sed "/$1/d" | crontab -
            echo "the old cronjob was removed";
            crontab -l | { cat; echo " $2 '$(pwd)/$1' $3 >> $logd/cronjob.log 2>&1"; } | crontab -
            echo "the new cronjob was added";
        else
            echo "cronjob $1 will remain and no replacement will be created";
        fi
    else
        crontab -l | { cat; echo " $2 '$(pwd)/$1' $3 >> $logd/cronjob.log 2>&1"; } | crontab -
    fi
}
schedule_all_cronjobs(){
    # 1 run get_data.sh every 12h (0 */12 * * *)
    if [ "$dir_change" -eq "1" ]; then
        create_cronjob "get_data.sh" "0 */12 * * *" "$d1d"
        #bash get_data.sh $d1d;
    else
        create_cronjob "get_data.sh" "0 */12 * * *" " "
    fi

    # 2 clean the new raw data every 24h (0 0 * * *)
    if [ "$use_git" -eq "1" ]; then
        create_cronjob "runtime.sh" "0 0 * * *" "-git $local_dir $d1d $d2d $d3d $d4d"
    else
        create_cronjob "runtime.sh" "0 0 * * *" "$local_dir $d1d $d2d $d3d $d4d"
    fi
}

#
# Variables
#
use_git="0";
dir_change="0";
local_dir="'$(pwd)'";
d1d="/home/kevin/Documents/automate/rawdata";
d2d="/home/kevin/Documents/automate/cleandata";
d3d="/home/kevin/Documents/automate/analysedata";
d4d="/home/kevin/Documents/automate/generatedreports";
logd="/home/kevin/Documents/automate";
#
# Command line parsing
#
check_for_options "$@"

#
# Script proper
#

# make sure crontab can execute all scripts
check_if_execute_rights

# make sure all required packages are installed
install_requirements

# make sure all directories are valid 
check_all_directories

# schedule all the cronjobs 
schedule_all_cronjobs