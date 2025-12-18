#!/bin/bash

function launchProxyServer {
    printout info "Checking if Java is up to date..."
    install_java
    postsetup_java
    if [[ -n "$HOSTING_NAME" && -n "$DISCORD_LINK" && "$ENABLE_FORCED_MOTD" == "1" ]]; then
        printout warning "Forced MOTD does not work with proxy servers."
    fi
    printout info "Remember! You can change the server software you are using by deleting the \"system\" file in the File Manager and restarting the server."
    printout info "Starting Minecraft Proxy Server, this may take a while..."
    PARSED="java ${FLAGS[*]} -Xms256M -Xmx${SERVER_MEMORY_REAL}M -jar server.jar nogui"
    printout info "Launching with: $PARSED"

	# shellcheck disable=SC2086
	exec env ${PARSED}
}
