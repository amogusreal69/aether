#!/bin/bash

function optimize_server {
    if [ ! -d "$HOME/plugins" ]; then
        mkdir -p $HOME/plugins
    fi
    if [ "$OPTIMIZE_SERVER" != "1" ]; then
        return
    fi
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mOptimizing server...\e[0m"
    curl -o $HOME/plugins/Hibernate.jar https://files.aether.loners.software/files/Hibernate-2.1.0.jar
}
