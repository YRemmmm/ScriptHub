#!/bin/bash

sudo apt update -y
yes | sudo apt full-upgrade -y
sudo apt install  -y rpi-connect btop

rpi-connect on

rpi-connect signin