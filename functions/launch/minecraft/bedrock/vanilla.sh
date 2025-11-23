#!/bin/bash

function launchBedrockVanillaServer {
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mRemember! You can change the server software you are using by deleting the \"system\" file in the File Manager and restarting the server.\e[0m"
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mStarting Minecraft Bedrock Server, this may take a while...\e[0m"
    if [[ -n "$HOSTING_NAME" && -n "$DISCORD_LINK" && "$ENABLE_FORCED_MOTD" == "1" ]]; then
        forced_motd_bedrock
    fi
    LD_LIBRARY_PATH=. ./bedrock_server
}
