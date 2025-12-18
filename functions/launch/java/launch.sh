#!/bin/bash

function launchJavaServer {
    printout info "Checking if Java is up to date..."
    install_java
    postsetup_java
    optimize_server
    if [[ -n "$HOSTING_NAME" && -n "$DISCORD_LINK" && "$ENABLE_FORCED_MOTD" == "1" ]]; then
        forced_motd
    fi
    printout info "Remember! You can change the server software you are using by deleting the \"system\" file in the File Manager and restarting the server."
    printout info "Starting Minecraft Java Server, this may take a while..."
    PARSED="java ${FLAGS[*]} -Xms256M -Xmx${SERVER_MEMORY_REAL}M -jar server.jar nogui"
    printout info "Launching with: $PARSED"

	# shellcheck disable=SC2086
	exec env ${PARSED}
}

function launchVanillaServer {
    printout info "Checking if Java is up to date..."
    install_java
    postsetup_java
    if [[ "$AUTOMATIC_UPDATING" == "1" ]]; then
        update_server
    fi
    if [[ -n "$HOSTING_NAME" && -n "$DISCORD_LINK" && "$ENABLE_FORCED_MOTD" == "1" ]]; then
        forced_motd
    fi
    printout info "Remember! You can change the server software you are using by deleting the \"system\" file in the File Manager and restarting the server."
    printout info "Starting Vanilla Server, this may take a while..."
    PARSED="java ${FLAGS[*]} -Xms256M -Xmx${SERVER_MEMORY_REAL}M -jar server.jar nogui"
    printout info "Launching with: $PARSED"

	# shellcheck disable=SC2086
	exec env ${PARSED}
}
