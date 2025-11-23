#!/bin/bash

function prompt_eula_mc {
    local eula_file="eula.txt"
    echo -e "\e[1;36m \e[0m"
    echo -e "\e[1;36m \e[0m"
    echo -e "\e[36m📜  Before installing, you must accept the Minecraft EULA.\e[0m"
    echo -e "\e[32m○ Do you accept the Minecraft EULA?:\e[0m"
    echo -e "\e[32m○ Type 'y' to agree, or 'eula' to view the EULA. Anything else counts as a no.\e[0m"
    read -p "$(echo -e '\e[33mYour choice:\e[0m') " accept_eula_input
    accept_eula_input=$(echo "$accept_eula_input" | tr '[:upper:]' '[:lower:]') # Convert to lowercase
    if [[ "$accept_eula_input" == *y* || "$accept_eula_input" == *yes* ]]; then
        echo "eula=true" >"$eula_file"
        echo -e "\033[92m● You have agreed to the EULA. Starting installation...\e[0m"
    elif [[ "$accept_eula_input" == *eula* ]]; then
        echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mThe EULA can be found at https://www.minecraft.net/eula.\e[0m"
        prompt_eula_mc
    else
        echo -e "\e[1;31m[ERROR] \e[0;31mYou have not agreed to the EULA. Exiting...\e[0m"
        exit 1
    fi
}
