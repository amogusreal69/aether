#!/bin/bash

function install_java {
    if [ -z "$JAVA_VERSION" ]; then
        echo -e "\e[1;31m[ERROR] \e[0;31mOops! You met an error that occurred while installing Java.\e[0m"
        echo -e "\e[1;31m[ERROR] \e[0;31mPlease specify the desired Java version using the JAVA_VERSION environment variable.\e[0m"
        echo -e "\e[1;34m[SOLUTION] \e[0;34mThis can be done by going to the Startup tab of your server and selecting a Java version from the dropdown menu.\e[0m"
        echo -e "\e[1;34m[SOLUTION] \e[0;34mIf you need further assistance, please contact support.\e[0m"
        exit 1
    fi
    if [ ! -d "$HOME/.sdkman" ]; then
        curl -s "https://get.sdkman.io" | bash >/dev/null 2>&1
    fi
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk update >/dev/null 2>&1
    sdk selfupdate
    case "$JAVA_VERSION" in
    8)
        JAVA_VERSION_S="8.0.472-tem"
        ;;
    11)
        JAVA_VERSION_S="11.0.29-tem"
        ;;
    17)
        JAVA_VERSION_S="17.0.17-tem"
        ;;
    21)
        JAVA_VERSION_S="21.0.9-tem"
        ;;
    23)
        JAVA_VERSION_S="23.0.2-tem"
        ;;
    24)
        JAVA_VERSION_S="24.0.2-tem"
        ;;
    25)
        JAVA_VERSION_S="25.0.1-tem"
        ;;
    *)
        echo -e "\e[1;31m[ERROR] \e[0;31mOops! You met an error that occurred while installing Java.\e[0m"
        echo -e "\e[1;31m[ERROR] \e[0;31mPlease specify the desired Java version using the JAVA_VERSION environment variable.\e[0m"
        echo -e "\e[1;34m[SOLUTION] \e[0;34mThis can be done by going to the Startup tab of your server and selecting a Java version from the dropdown menu.\e[0m"
        echo -e "\e[1;34m[SOLUTION] \e[0;34mIf you need further assistance, please contact support.\e[0m"
        exit 1
        ;;
    esac
    if [ -z "$JAVA_VERSION_S" ]; then
        clear
        display
        check_aether_updates
        echo -e "\e[1;31m[ERROR] \e[0;31mOops! You met an error that occurred while installing Java $JAVA_VERSION.\e[0m"
        echo -e "\e[1;31m[ERROR] \e[0;31mPlease report this issue to the support team and share this error message:\e[0m"
        echo -e "\e[1;31m[ERROR] \e[0;31mThe JAVA_VERSION_S variable is empty, which cannot continue the Java Installation section.\e[0m"
        exit 1
    fi
    if sdk current java | grep -q "$JAVA_VERSION"; then
    echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mJava $JAVA_VERSION is already installed.\e[0m"
    else
        echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mInstalling Java $JAVA_VERSION_S...\e[0m"
        if [ -n "$(sdk current java)" ]; then
            OLD_VERSION=$(sdk current java)
            echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mRemoving old Java version $OLD_VERSION...\e[0m"
            sdk uninstall java "$OLD_VERSION"
        fi
        sdk install java "$JAVA_VERSION_S"
        echo -e "\e[38;2;129;170;254m[INFO] \e[38;5;250mJava $JAVA_VERSION_S installed successfully.\e[0m"
    fi
    export JAVA_HOME="$HOME/.sdkman/candidates/java/$JAVA_VERSION_S"
    export PATH="$JAVA_HOME/bin:$PATH"
}
