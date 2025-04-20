#!/bin/bash

# 定义要添加的内容
content="
dtparam=cooling_fan=on
dtparam=fan_temp0=36000,fan_temp0_hyst=2000,fan_temp0_speed=90
dtparam=fan_temp1=40000,fan_temp1_hyst=3000,fan_temp1_speed=150
dtparam=fan_temp2=52000,fan_temp2_hyst=4000,fan_temp2_speed=200
dtparam=fan_temp3=58000,fan_temp3_hyst=5000,fan_temp3_speed=255
"

# 将定义的内容追加到文件末尾
echo "$content" | sudo tee -a /boot/firmware/config.txt > /dev/null
echo "内容已成功添加到 /boot/firmware/config.txt"