#!/bin/bash

sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl --now enable docker

# 定义要添加的镜像源
NEW_MIRRORS='[
    "https://docker.1panel.live",
    "https://hub.rat.dev",
    "https://docker.1ms.run"
]'

# 系统级别配置文件路径
CONFIG_FILE="/etc/docker/daemon.json"

# ANSI 转义序列用于颜色输出
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的信息函数
print_green() {
  echo -e "${GREEN}$1${NC}"
}

print_red() {
  echo -e "${RED}$1${NC}"
}

print_blue() {
  echo -e "${BLUE}$1${NC}"
}

# 检查 jq 工具是否已安装
if ! command -v jq &> /dev/null; then
    print_red "jq 工具未找到，请先安装 jq: sudo apt-get install jq (Debian/Ubuntu) 或 sudo yum install jq (CentOS/RHEL)"
    exit 1
fi

# 检查配置文件是否存在
if [ -f "$CONFIG_FILE" ]; then
    print_blue "配置文件 $CONFIG_FILE 存在。"

    # 备份原始配置文件，并添加时间戳
    BACKUP_FILE="$CONFIG_FILE.bak.$(date +%Y%m%d%H%M%S)"
    cp "$CONFIG_FILE" "$BACKUP_FILE"
    print_green "已备份原始配置文件至 $BACKUP_FILE"

    # 读取现有配置
    existing_config=$(cat "$CONFIG_FILE")

    # 将新的镜像源合并到现有配置中
    updated_config=$(echo "$existing_config" | jq --argjson new_mirrors "$NEW_MIRRORS" '
        if has("registry-mirrors") then
            .registry-mirrors += $new_mirrors | unique
        else
            . + {registry-mirrors: $new_mirrors}
        end
    ')

    # 写入更新后的配置
    echo "$updated_config" | sudo tee "$CONFIG_FILE" > /dev/null
    print_green "已成功更新配置文件。"
else
    # 如果文件不存在，则创建新文件并写入镜像源
    NEW_CONFIG='{"registry-mirrors": '"$NEW_MIRRORS"'}'
    echo "$NEW_CONFIG" | sudo tee "$CONFIG_FILE" > /dev/null
    print_green "已创建新配置文件并添加镜像源。"
fi

# 重启 Docker 服务使更改生效
sudo systemctl restart docker
print_green "Docker 服务已重启。"