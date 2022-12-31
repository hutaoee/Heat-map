# 一键填充 Contribution Heatmap 🟩

![效果图](https://raw.githubusercontent.com/hutaoee/Tu-api/refs/heads/main/logo/github.png)

这是一个 Shell 脚本工具，可以通过在指定日期范围内自动生成 Git 提交记录，来快速“点亮”你的 GitHub 个人主页贡献图（Heatmap）。

> [!WARNING]
> **请注意**：本项目仅用于学习和美观展示目的。它生成的提交历史并不代表实际的工作量。请勿将其用于伪造工作证明或欺骗他人。

## ✨ 特性

- **高度自定义**：自由设置需要填充贡献记录的开始和结束日期。
- **一键执行**：只需一条命令，即可在本地生成全部提交记录。
- **简单易用**：步骤清晰，只需基础的 Git 和命令行知识。

## 🚀 使用指南

请严格按照以下步骤操作，将脚本生成的历史记录推送到**你自己的新仓库**。

### 第 1 步：准备本地仓库

首先，将本项目克隆到你的电脑上，并清理掉原有的 Git 历史，以便初始化为你自己的仓库。

```bash
# 1. 克隆项目
git clone https://github.com/hutaoee/Heat-map.git

# 2. 进入项目目录
cd Heat-map/

# 3. 删除原作者的Git历史
rm -rf .git/

# 4. 初始化为你自己的新仓库
git init
```

### 第 2 步：配置你的 Git 身份

设置你的 Git 用户名和邮箱，确保提交记录能正确关联到你的 GitHub 账户。

```bash
# 将 "你的GitHub用户名" 和 "你的邮箱" 替换成你自己的信息
git config --global user.name "用户名hutaoee"
git config --global user.email "邮箱@gmail.com"
```

### 第 3 步：执行脚本以生成提交历史

授予脚本执行权限，并运行它来生成指定日期范围内的提交记录。

```bash
# 1. 检查文件是否存在：确认当前目录下确实有 hutao.sh 文件
ls
# 1. 授予脚本执行权限
sudo chmod +x hutao.sh
# 3. 执行脚本，并传入开始和结束日期
# 格式: ./hutao.sh YYYY-MM-DD YYYY-MM-DD
sudo ./hutao.sh 2023-01-01 2025-06-07
```

脚本将开始自动创建提交，请耐心等待其执行完成。

### 第 4 步：推送到你的 GitHub 仓库

现在，本地仓库已经包含了满满的提交历史。你需要将它推送到 GitHub。

1.  **在 GitHub 上创建一个全新的、空的仓库**。
    > [!IMPORTANT]
    > 创建仓库时，**不要**勾选初始化任何文件（如 `README`, `.gitignore` 或 `license`）。

2.  **将本地仓库与远程仓库关联，并推送**。

```bash
# 1. 关联远程仓库 (请将 URL 替换成你自己的新仓库地址)
git remote add origin https://github.com/你的用户名/你的新仓库名.git

# 2. 将当前分支重命名为 main (或 master)
git branch -M master

# 3. 将所有本地提交推送到 GitHub
git push -u origin master
```

### 第 5 步：身份验证 (使用个人访问令牌)
```bash
Username for 'https://github.com':用户名hutaoee
Password for 'https://hutaoee@github.com':密码password
```
当命令行提示你输入密码时，**不能使用你的 GitHub 登录密码**。你需要使用 **Personal Access Token (个人访问令牌)**。

**如何获取个人访问令牌 (PAT):**

1.  登录 GitHub，进入 **Settings** (设置)。
2.  在左侧菜单最下方，点击 **Developer settings** (开发者设置)。
3.  选择 **Personal access tokens** -> **Tokens (classic)**。
4.  点击 **Generate new token** (生成新令牌)。
5.  **Note (备注)**: 给令牌起一个描述性的名字（例如 "Heatmap-Script-Token"）。
6.  **Expiration (过期时间)**: 按需设置一个过期时间。
7.  **Select scopes (选择权限)**: **必须勾选 `repo`**，这将授予令牌对仓库的完全控制权。
8.  点击页面底部的 **Generate token** (生成令牌) 按钮。
9.  **立即复制生成的令牌字符串！** 这个令牌只会显示一次。
10. 回到你的命令行，当提示输入密码时，**粘贴你刚刚复制的个人访问令牌**即可。

完成以上所有步骤后，刷新你的 GitHub 个人主页，你将看到一片漂亮的绿色！

## 🙏 致谢

本项目基于 [hutaoee/Heat-map](https://github.com/hutaoee/Heat-map) 仓库。感谢原作者的分享。
