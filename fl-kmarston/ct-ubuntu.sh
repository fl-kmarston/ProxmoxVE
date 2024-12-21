#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/fl-kmarston/ProxmoxVE/main/misc/build.func)

# bash -c "$(wget -qLO - https://github.com/fl-kmarston/ProxmoxVE/raw/fl-kmarston/fl-kmarston/ct-ubuntu.sh)"

# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://ubuntu.com/

# App Default Values
echo -e "Loading..."
APP="FOS"
var_version=${var_version:-24.04}
var_tags="os,km"
var_cpu="2"
var_ram="1024"
var_disk="2"
var_os="ubuntu"


# App Output & Base Settings
header_info "$APP"
base_settings

exit 0

# Core
variables
color
catch_errors

function update_script() {
    header_info
    check_container_storage
    check_container_resources
    if [[ ! -d /var ]]; then
        msg_error "No ${APP} Installation Found!"
        exit
    fi
    msg_info "Updating ${APP} LXC"
    apt-get update &>/dev/null
    apt-get -y upgrade &>/dev/null
    msg_ok "Updated ${APP} LXC"
    exit
}

echo "Starting..."
env
read -rp "Paused"
start
env
read -rp "Paused"

echo "Building Container..."
build_container
env
read -rp "Paused"

description

msg_ok "Completed Successfully!\n"
echo -e "${CREATING}${GN}${APP} setup has been successfully initialized!${CL}"
