#!/bin/bash

function create_config() {
    local type="$1"
    cat <<EOF >system/multiegg.yml
# DO NOT MODIFY OR DELETE THIS FILE! This contains everything for the script to know what software are you using. Modifying or deleting this file may result of making your server unbootable. Period.
software:
  type: $type
EOF
}
