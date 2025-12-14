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
        printout success "You have agreed to the EULA. Starting installation..."
    elif [[ "$accept_eula_input" == *eula* ]]; then
        printout info "The EULA can be found at https://www.minecraft.net/eula."
        prompt_eula_mc
    else
        printout error "You have not agreed to the EULA. Exiting..."
        exit 1
    fi
}
