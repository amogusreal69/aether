#!/bin/bash

function launchJavaServer {
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mChecking if Java is up to date...\e[0m"
    install_java
    optimize_server
    if [[ -n "$HOSTING_NAME" && -n "$DISCORD_LINK" && "$ENABLE_FORCED_MOTD" == "1" ]]; then
        forced_motd
    fi
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mRemember! You can change the server software you are using by deleting the \"system\" file in the File Manager and restarting the server.\e[0m"
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mStarting Minecraft Java Server, this may take a while...\e[0m"
    java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true $STARTUP_ARGUMENT -jar server.jar nogui
}
