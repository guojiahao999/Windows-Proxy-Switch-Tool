# Windows Proxy Switch

![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Script](https://img.shields.io/badge/script-Batch-yellow)
![License](https://img.shields.io/badge/license-MIT-green)

一个轻量级的 **Windows 系统代理管理工具**，通过简单的 `.bat` 脚本即可快速开启、关闭或切换系统代理。

适用于需要频繁切换代理的开发者，例如使用 **Clash、V2Ray、Shadowsocks** 等本地代理工具的场景。

------

# 📖 中文说明

## ✨ 功能特点

- 🚀 一键开启 Windows 系统代理
- ❌ 一键关闭系统代理
- 🔁 一键切换代理状态
- 🔍 自动显示当前系统代理状态
- ⚙ 显示代理 IP 与端口信息
- 🛡 自动申请管理员权限
- 🌐 内置内网地址排除规则
- 📦 无需安装，下载即可使用

------

## 📂 项目结构

```
windows-proxy-switch
│
├─ proxy_tool_EN.bat
├─ proxy_tool_CN.bat
├─ README.md
└─ screenshots
   └─ preview.png
```

------

## 🚀 使用方法

### 1 下载项目

克隆仓库：

```bash
git clone https://github.com/guojiahao999/Windows-Proxy-Switch-Tool
```

或者直接下载 `.bat` 文件。

------

### 2 运行脚本

双击运行：

```
proxy_tool.bat
```

程序会显示代理控制菜单：

```
=====================================
当前代理状态: 已开启 (127.0.0.1:7890)
=====================================

1. 开启代理
2. 关闭代理
3. 一键切换
4. 刷新状态
0. 退出
```

------

## ⚙ 修改代理地址

打开脚本文件并修改以下配置：

```
set proxy_ip=127.0.0.1
set proxy_port=7890
```

例如：

```
127.0.0.1:10809
```

------

## 🌐 内网排除规则

默认排除以下地址，不经过代理：

```
localhost
127.*
10.*
172.16.* - 172.31.*
192.168.*
```

这样可以保证 **局域网资源正常访问**。

------

## ⚠ 注意事项

- 运行脚本时可能会请求 **管理员权限**
- 文件编码建议保持 **GBK / ANSI**
- 适用于 **本地代理环境**

------

# 🌍 English

## ✨ Features

- 🚀 Enable Windows system proxy instantly
- ❌ Disable proxy with one click
- 🔁 Toggle proxy status quickly
- 🔍 Display current proxy status
- ⚙ Show proxy IP and port information
- 🛡 Automatically request administrator privileges
- 🌐 Built-in LAN bypass rules
- 📦 No installation required

------

## 📂 Project Structure

```
windows-proxy-switch
│
├─ proxy_tool_EN.bat
├─ proxy_tool_CN.bat
├─ README.md
└─ screenshots
   └─ preview.png
```

------

## 🚀 Usage

### 1 Clone the Repository

```bash
git clone https://github.com/guojiahao999/Windows-Proxy-Switch-Tool
```

Or download the `.bat` scripts directly.

------

### 2 Run the Script

Double-click:

```
proxy_tool.bat
```

The interactive menu will appear:

```
=====================================
Current Proxy Status: Enabled (127.0.0.1:7890)
=====================================

1. Enable Proxy
2. Disable Proxy
3. Toggle Proxy
4. Refresh Status
0. Exit
```

------

## ⚙ Configuration

Modify the proxy settings inside the script:

```
set proxy_ip=127.0.0.1
set proxy_port=7890
```

Example:

```
127.0.0.1:10809
```

------

## 🌐 LAN Bypass

The script automatically excludes common internal networks:

```
localhost
127.*
10.*
172.16.* - 172.31.*
192.168.*
```

This ensures that **local network resources remain accessible**.

------

# 📄 License

This project is licensed under the **MIT License**.

------

# ⭐ Support

If this project helps you, please consider giving it a **Star ⭐** on GitHub.