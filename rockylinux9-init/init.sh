#!/bin/bash

# 定义存放.sh文件的目录
SCRIPT_DIR="src"

# 检查目录是否存在
if [ ! -d "$SCRIPT_DIR" ]; then
  echo "目录 $SCRIPT_DIR 不存在"
  exit 1
fi

# 查找并列出所有要执行的.sh文件
echo "找到以下脚本文件:"
find "$SCRIPT_DIR" -name "*.sh" | sort

# 遍历并执行目录中的所有.sh文件，按名称排序
for SCRIPT in $(find "$SCRIPT_DIR" -name "*.sh" | sort); do
  if [ -f "$SCRIPT" ]; then # 确保是文件
    # 使用绿色文本输出正在执行的脚本路径
    echo -e "\033[0;32m正在执行: $SCRIPT\033[0m"
    bash "$SCRIPT" # 或者直接 ./"$SCRIPT" 如果文件已有执行权限且包含正确的shebang行
    EXIT_STATUS=$? # 获取上一条命令的退出状态
    if [ $EXIT_STATUS -ne 0 ]; then
      # 使用红色文本输出错误信息（可选）
      echo -e "\033[0;31m执行失败: $SCRIPT (退出状态: $EXIT_STATUS)\033[0m"
      # 继续执行下一个脚本，不中断整个过程
    fi
  else
    echo "忽略非文件项: $SCRIPT"
  fi
done

# 使用蓝色文本输出完成信息（可选）
echo -e "\033[0;34m所有脚本已按顺序尝试执行完毕\033[0m"