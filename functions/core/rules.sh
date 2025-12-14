#!/bin/bash

function rules {
    accept_rules_file="system/rulesagreed"

    if [ -f "$accept_rules_file" ]; then
        printout success "Rules already accepted. Continuing..."
        echo -e "\e[1;36m \e[0m"
        return
    fi

    echo -e "\e[38;2;195;144;230m👋  Welcome to the setup wizard! This wizard will help you setup your Minecraft Server.\e[0m"
    echo -e "\e[36m○ Before continuing, you must agree to our server rules.\e[0m"
    echo -e "\e[32mThese rules help maintain a fair, secure, and high-performance environment for all users.\e[0m"
    echo -e "\e[1;36m \e[0m"
    echo -e "\e[32m1) \e[0m Chunk-altering plugins are strictly prohibited."
    echo -e "\e[32m2) \e[0m Mining or any resource-intensive activities that degrade performance are not allowed."
    echo -e "\e[32m3) \e[0m Use server resources responsibly – excessive CPU, RAM, or network usage is not permitted."
    echo -e "\e[32m4) \e[0m Exploiting bugs, abusing services, or bypassing restrictions is strictly forbidden."
    echo -e "\e[32m5) \e[0m All users must comply with our Terms of Service – violations may result in suspension."
    echo -e "\e[1;36m \e[0m"
    echo -e "\e[31m⚠️  Breaking any of these rules may result in a suspension of our service or a ban.\e[0m"
    echo -e "\e[1;36m \e[0m"
    echo -e "\e[36mBy continuing, you confirm that you understand and agree to follow these rules.\e[0m"
    echo -e "\e[1;36m \e[0m"
    echo -e "\e[33m○ Do you agree on theses server rules? (type y to agree):\e[0m"
    read -p "$(echo -e '\e[33mYour choice:\e[0m') " accept_rules
    accept_rules=$(echo "$accept_rules" | tr '[:upper:]' '[:lower:]') # Convert to lowercase
    if [[ "$accept_rules" == *y* || "$accept_rules" == *yes* ]]; then
        mkdir -p "system"
        touch "$accept_rules_file"
        printout success "Rules has been accepted. Starting installation..."
        echo -e "\e[1;36m \e[0m"
    else
        printout error "You must accept to our rules to use this server! Exiting..."
        exit 1
    fi
}
