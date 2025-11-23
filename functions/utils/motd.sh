#!/bin/bash

function forced_motd {
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mUpdating MOTD, this feature may not work...\e[0m"
    sed -i "s|^motd=.*|motd=$(printf '%s' "Join $HOSTING_NAME for free server discord.gg/$DISCORD_LINK" | sed 's/[&/\]/\\&/g')|g" server.properties
}

function forced_motd_bedrock {
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mUpdating MOTD, this feature may not work...\e[0m"
    sed -i 's|^server-name=.*|server-name="Join '"$HOSTING_NAME"' for free server discord.gg/'"$DISCORD_LINK"'"|g' server.properties
}
