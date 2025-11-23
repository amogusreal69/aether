#!/bin/bash

function install_bedrock {
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mStarting installation of Vanilla Bedrock Server...\e[0m"
    # Minecraft CDN Akamai blocks script user-agents
    RANDVERSION=$(echo $((1 + $RANDOM % 4000)))
    if [ -z "${BEDROCK_VERSION}" ] || [ "${BEDROCK_VERSION}" == "latest" ]; then
        echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mDownloading latest Bedrock Server\e[0m"
        DOWNLOAD_URL="https://mcjarfiles.com/api/get-latest-jar/bedrock/latest/linux"
    else
        echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mGrabbing URL of ${BEDROCK_VERSION} Bedrock Server\e[0m"
        DOWNLOAD_URL="https://mcjarfiles.com/api/get-jar/bedrock/latest/linux/${BEDROCK_VERSION}"
    fi
    
    if [ -z "$DOWNLOAD_URL" ]; then
        echo -e "\e[91m[ERROR] \e[31mFailed to determine Bedrock Server download URL.\e[0m"
        exit 1
    fi
    
    DOWNLOAD_FILE=server.zip # Retrieve archive name
    rm -rf *.bak versions.html.gz
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mDownloading Vanilla Bedrock Server\e[0m"
    if ! curl -fSL -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$RANDVERSION.212 Safari/537.36" \
        -H "Accept-Language: en" \
        -o "$DOWNLOAD_FILE" "$DOWNLOAD_URL"; then
        echo -e "\e[91m[ERROR] \e[31mFailed to download Bedrock server from $DOWNLOAD_URL.\e[0m"
        echo -e "\e[91m[ERROR] \e[31mPlease check the version number and try again. It could maybe also be a internet problem. This script will now exit.\e[0m"
        exit 1
    fi
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mUnpacking server files...\e[0m"
    unzip -qo "$DOWNLOAD_FILE"
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mCleaning up after install...\e[0m"
    rm -f "$DOWNLOAD_FILE"
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mRestoring backup config files - on first install there will be file not found errors which you can ignore.\e[0m"
    cp -rf server.properties.bak server.properties 2>/dev/null
    cp -rf permissions.json.bak permissions.json 2>/dev/null
    cp -rf allowlist.json.bak allowlist.json 2>/dev/null
    sed -i "s|^server-port=.*|server-port=$SERVER_PORT|g" server.properties
    if [[ -n "$HOSTING_NAME" && -n "$DISCORD_LINK" && "$ENABLE_FORCED_MOTD" == "1" ]]; then
        forced_motd_bedrock
    fi
    rm -rf *.bak *.txt
    chmod +x bedrock_server
    bin_bytes=$(stat -c%s bedrock_server 2>/dev/null || stat -f%z bedrock_server 2>/dev/null)
    bin_size=$(printf "%.2f MB" $((bin_bytes / 1000000)))
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mServer binary downloaded successfully (Size: $bin_size)\e[0m"
    create_config "mc_bedrock_vanilla"
    launchBedrockVanillaServer
    exit
}
