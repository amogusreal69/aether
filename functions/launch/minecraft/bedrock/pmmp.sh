#!/bin/bash

function launchPMMP {
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mRemember! You can change the server software you are using by deleting the \"system\" file in the File Manager and restarting the server.\e[0m"
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mStarting PocketMine MP Server, this may take a while...\e[0m"
    ./start.sh
}
