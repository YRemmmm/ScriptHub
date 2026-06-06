#!/bin/bash

sudo systemctl stop packagekit.service
sudo sed 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list -i
sudo apt update -y