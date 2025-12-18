#!/bin/bash

function postsetup_java {
    if [[ "$AUTOMATIC_UPDATING" == "1" ]]; then
        printout info "Checking for server jar updates... if this takes too long, disable automatic updating in the startup tab"

        # Hash server jar file
        if [ -z "${HASH}" ]; then
            HASH=$(sha256sum server.jar | awk '{print $1}')
        fi

        # Check if hash is set
        if [ -n "${HASH}" ]; then
            API_RESPONSE=$(curl --connect-timeout 4 -s "https://mcjars.app/api/v1/build/$HASH")

            # Check if .success is true
            if [ "$(echo "$API_RESPONSE" | jq -r '.success')" = "true" ]; then
                if [ "$(echo "$API_RESPONSE" | jq -r '.build.id')" != "$(echo "$API_RESPONSE" | jq -r '.latest.id')" ]; then
                    printout info "New build found. Updating server..."

                    BUILD_ID=$(echo "$API_RESPONSE" | jq -r '.latest.id')
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
    fi

    if [ -f "eula.txt" ]; then
        # create server.properties
        touch server.properties
    fi

    if [ -f "server.properties" ]; then
        # set server-ip to 0.0.0.0
        if grep -q "server-ip=" server.properties; then
            sed -i 's/server-ip=.*/server-ip=0.0.0.0/' server.properties
        else
            echo "server-ip=0.0.0.0" >> server.properties
        fi

        # set server-port to SERVER_PORT
        if grep -q "server-port=" server.properties; then
            sed -i "s/server-port=.*/server-port=${SERVER_PORT}/" server.properties
        else
            echo "server-port=${SERVER_PORT}" >> server.properties
        fi

        # set query.enabled to true
        if grep -q "query.enabled=" server.properties; then
            sed -i "s/query.enabled=.*/query.enabled=true/" server.properties
        else
            echo "query.enabled=true" >> server.properties
        fi

        # set query.port to SERVER_PORT
        if grep -q "query.port=" server.properties; then
            sed -i "s/query.port=.*/query.port=${SERVER_PORT}/" server.properties
        else
            echo "query.port=${SERVER_PORT}" >> server.properties
        fi
    fi

    # settings.yml
    if [ -f "settings.yml" ]; then
        # set ip to 0.0.0.0
        if grep -q "ip" settings.yml; then
            sed -i "s/ip: .*/ip: '0.0.0.0'/" settings.yml
        fi

        # set port to SERVER_PORT
        if grep -q "port" settings.yml; then
            sed -i "s/port: .*/port: ${SERVER_PORT}/" settings.yml
        fi
    fi

    # velocity.toml
    if [ -f "velocity.toml" ]; then
        # set bind to 0.0.0.0:SERVER_PORT
        if grep -q "bind" velocity.toml; then
            sed -i "s/bind = .*/bind = \"0.0.0.0:${SERVER_PORT}\"/" velocity.toml
        else
            echo "bind = \"0.0.0.0:${SERVER_PORT}\"" >> velocity.toml
        fi
    fi

    # config.yml
    if [ -f "config.yml" ]; then
        # set query_port to SERVER_PORT
        if grep -q "query_port" config.yml; then
            sed -i "s/query_port: .*/query_port: ${SERVER_PORT}/" config.yml
        else
            echo "query_port: ${SERVER_PORT}" >> config.yml
        fi

        # set host to 0.0.0.0:SERVER_PORT
        if grep -q "host" config.yml; then
            sed -i "s/host: .*/host: 0.0.0.0:${SERVER_PORT}/" config.yml
        else
            echo "host: 0.0.0.0:${SERVER_PORT}" >> config.yml
        fi
    fi

    FLAGS=("-Dterminal.jline=false -Dterminal.ansi=true")

	# SIMD Operations are only for Java 16 - 21
	if [[ "$SIMD_OPERATIONS" == "1" ]]; then
		if [[ "$JAVA_VERSION" -ge 16 ]] && [[ "$JAVA_VERSION" -le 21 ]]; then
			FLAGS+=("--add-modules=jdk.incubator.vector")
		else
			printout warning "SIMD Operations are only available for Java 16 - 21, skipping..."
		fi
	fi

    if [[ "$ADDITIONAL_FLAGS" == "Aikar's Flags" ]]; then
		FLAGS+=("-XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true")
	elif [[ "$ADDITIONAL_FLAGS" == "Velocity Flags" ]]; then
		FLAGS+=("-XX:+ParallelRefProcEnabled -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:MaxInlineLevel=15")
	fi

    SERVER_MEMORY_REAL=$(($SERVER_MEMORY*$MAXIMUM_RAM/100))
}