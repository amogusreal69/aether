#!/bin/bash

function printout {
    local message="$2"
    
    case "$1" in
    error)
        echo -e "\e[30;41;1m[ERROR]\e[0m ${message}"
        ;;
    info)
        echo -e "\e[30;44;1m[INFO]\e[0m ${message}"
        ;;
    warning)
        echo -e "\e[30;43;1m[WARNING]\e[0m ${message}"
        ;;
    success)
        echo -e "\e[30;42;1m[SUCCESS]\e[0m ${message}"
        ;;
    solution)
        echo -e "\e[30;46;1m[SOLUTION]\e[0m ${message}"
        ;;
    *)
        echo "${message}"
        ;;
    esac
}
