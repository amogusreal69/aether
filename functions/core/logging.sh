#!/bin/bash

function printout {
    local message="$2"
    
    case "$1" in
    error)
        echo -e "\e[1;31m[ERROR] \e[0;31m${message}\e[0m"
        ;;
    info)
        echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250m${message}\e[0m"
        ;;
    warning)
        echo -e "\e[38;2;255;165;0m[WARNING] \e[38;5;250m${message}\e[0m"
        ;;
    success)
        echo -e "\e[92m● ${message}\e[0m"
        ;;
    solution)
        echo -e "\e[1;34m[SOLUTION] \e[0;34m${message}\e[0m"
        ;;
    *)
        echo "${message}"
        ;;
    esac
}
