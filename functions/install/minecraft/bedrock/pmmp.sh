#!/bin/bash

function install_pmmp {
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mStarting installation of PocketMineMP...\e[0m"
    cd $HOME
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mRunning installation script from: get.pmmp.io\e[0m"
    curl -sL https://get.pmmp.io | bash -s -
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mSetting up server properties...\e[0m"
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mDownloading default PocketMineMP config...\e[0m"
    curl -o $HOME/server.properties https://files.aether.loners.software/files/server.pmmp.properties
    sed -i "s/HOSTING_NAME/$HOSTING_NAME/g" "$HOME/server.properties"
    sed -i "s|^server-port=.*|server-port=$SERVER_PORT|g" "$HOME/server.properties"
    if [[ -n "$HOSTING_NAME" && -n "$DISCORD_LINK" && "$ENABLE_FORCED_MOTD" == "1" ]]; then
        forced_motd
    fi
    create_config "pmmp"
    phar_bytes=$(stat -c%s PocketMine-MP.phar 2>/dev/null || stat -f%z PocketMine-MP.phar 2>/dev/null)
    phar_size=$(printf "%.2f MB" $((phar_bytes / 1000000)))
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mServer binary downloaded successfully (Size: $phar_size)\e[0m"
    launchPMMP
    exit
}
