#!/bin/bash

# 检查是否提供了开始时间和结束时间两个参数
if [[ $# -lt 2  ]]; then
    echo "必须提供开始时间和结束时间两个参数，例如：$0 2022-01-01 $(date +%Y-%m-%d)"
    exit 1
fi

# 设置一个“陷阱”，在脚本退出时自动调用 resetTime 函数
trap resetTime 0

# 将传入的日期参数转换为 Unix 时间戳
START_DAY=$(date -d "$1" "+%s")
END_DAY=$(date -d "$2" "+%s")

# ==============================================================================
# 自动化的时间恢复函数 (核心修改部分)
# ==============================================================================
resetTime() {
    echo "----------------------------------------"
    echo "正在准备恢复系统时间..."

    # 1. 检查 ntpdate 命令是否存在
    #    使用 command -v 检查命令，&> /dev/null 将所有输出重定向到空，我们只关心它的返回状态
    if ! command -v ntpdate &> /dev/null; then
        echo "未找到 'ntpdate' 命令，正在尝试自动安装..."
        
        # 2. 自动安装 ntpdate (适用于 Debian/Ubuntu 系统)
        #    -y 选项可以在安装过程中自动回答 'yes'
        sudo apt-get update
        sudo apt-get install -y ntpdate

        # 3. 再次检查安装是否成功
        if ! command -v ntpdate &> /dev/null; then
            echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            echo "!! 自动安装 'ntpdate' 失败。请检查您的网络或手动尝试。"
            echo "!! 手动安装命令: sudo apt-get install ntpdate"
            echo "!! 警告：系统时间可能仍不正确！当前错误时间：$(date)"
            echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            exit 1 # 安装失败，退出脚本以防造成更大问题
        else
             echo "'ntpdate' 安装成功。"
        fi
    fi

    # 4. 执行时间同步
    echo "正在使用 ntpdate 从 ntp.aliyun.com 同步时间..."
    sudo ntpdate ntp.aliyun.com

    # 5. 显示最终的正确时间以供验证
    echo "时间恢复操作完成。当前正确时间：$(date)"
    echo "----------------------------------------"
}

# 执行 Git 提交的主函数
modify() {
    echo "处理中……"
    while (( "${START_DAY}" <= "${END_DAY}" )); do
        cur_day=$(date -d "@${START_DAY}" +"%Y-%m-%d %H:%M:%S")
        START_DAY=$((${START_DAY}+86400))
        
        echo "修改系统时间到: $cur_day"
        sudo date -s "$cur_day"
        
        commit="${cur_day} https://github.com/hutaoee/Heat-map"
        
        echo $commit > log.txt
        
        git add .
        git commit --allow-empty -m "${commit}"
    done
    
    echo "处理完成！"
}

# 调用主函数开始执行
modify

exit 0