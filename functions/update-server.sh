#!/bin/bash
# based from https://github.com/mcjars/pterodactyl-yolks

function update_server {
    printout info "Checking for server jar updates... if this takes too long, disable automatic updating in the startup tab"

	# Hash server jar file
	if [ -z "${HASH}" ]; then
		HASH=$(sha256sum server.jar | awk '{print $1}')
	fi

	# Check if hash is set
	if [ -n "${HASH}" ]; then
		API_RESPONSE=$(curl --connect-timeout 4 -s "https://mcjars.app/api/v1/build/$HASH")

		# Check if .success is true
		if [ "$(echo $API_RESPONSE | jq -r '.success')" = "true" ]; then
			if [ "$(echo $API_RESPONSE | jq -r '.build.id')" != "$(echo $API_RESPONSE | jq -r '.latest.id')" ]; then
				printout info "New build found. Updating server..."

				BUILD_ID=$(echo $API_RESPONSE | jq -r '.latest.id')
				bash <(curl -s "https://mcjars.app/api/v1/script/$BUILD_ID/bash?echo=false")

                jar_bytes=$(stat -c%s server.jar 2>/dev/null || stat -f%z server.jar 2>/dev/null)
                jar_size=$(printf "%.2f MB" $((jar_bytes / 1000000)))
				printout info "Server has been updated (Size: $jar_size)"
			else
				printout info "Server is up to date"
			fi
		else
			printout info "Could not check for updates. Skipping update check."
		fi
	else
		printout info "Could not find hash. Skipping update check."
	fi
}