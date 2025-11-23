#!/bin/bash

function install_pufferfish {
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mDownloading Pufferfish Server...\e[0m"
    if [ -n "$MCJARS_API_KEY" ]; then
        jar_url=$(curl --silent --request GET --header "Authorization: $MCJARS_API_KEY" --url "https://versions.mcjars.app/api/v2/builds/PUFFERFISH/$pufferfish" | jq -r '.builds[0].jarUrl')
    else
        jar_url=$(curl --silent --request GET --url "https://versions.mcjars.app/api/v2/builds/PUFFERFISH/$pufferfish" | jq -r '.builds[0].jarUrl')
    fi
    curl -o server.jar "$jar_url"
    jar_bytes=$(stat -c%s server.jar 2>/dev/null || stat -f%z server.jar 2>/dev/null)
    jar_size=$(printf "%.2f MB" $((jar_bytes / 1000000)))
    create_config "mc_java_pufferfish"
    port_assign
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mServer jar downloaded successfully (Size: $jar_size)\e[0m"
    install_java
    launchJavaServer
    exit
}
