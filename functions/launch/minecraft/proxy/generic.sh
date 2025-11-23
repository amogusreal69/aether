#!/bin/bash

function launchProxyServer {
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mChecking if Java is up to date...\e[0m"
    install_java
    if [[ -n "$HOSTING_NAME" && -n "$DISCORD_LINK" && "$ENABLE_FORCED_MOTD" == "1" ]]; then
        echo -e '\e[38;2;255;165;0m[WARNING] \e[38;5;250mForced MOTD does not work with proxy servers.\e[0m'
    fi
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mRemember! You can change the server software you are using by deleting the \"system\" file in the File Manager and restarting the server.\e[0m"
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mStarting Minecraft Proxy Server, this may take a while...\e[0m"
    java -Xms128M -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15 $STARTUP_ARGUMENT -jar server.jar
}
