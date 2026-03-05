@echo off
chcp 936 >nul
title Windows系统代理控制工具

:: ==============================
:: 默认代理配置（可修改）
set proxy_ip=127.0.0.1
set proxy_port=7890
set proxy_server=%proxy_ip%:%proxy_port%
:: ==============================

:: 内网排除
set proxy_override=localhost;127.*;10.*;172.16.*;172.17.*;172.18.*;172.19.*;172.20.*;172.21.*;172.22.*;172.23.*;172.24.*;172.25.*;172.26.*;172.27.*;172.28.*;172.29.*;172.30.*;172.31.*;192.168.*;

:: ==============================
:: 自动管理员权限
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:refresh

:: 读取代理开关
for /f "tokens=3" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable 2^>nul') do set status=%%i

:: 读取当前系统代理
set current_proxy=
for /f "tokens=3*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer 2^>nul') do set current_proxy=%%i

:: 判断代理状态
if "%status%"=="0x1" (
    set state=已开启
) else (
    set state=未开启
)

if "%current_proxy%"=="" (
    set current_proxy=未设置
)

:menu
cls
echo =====================================
echo 当前代理状态: %state%  (%current_proxy%)
echo =====================================
echo.
echo 脚本默认代理配置:
echo    IP地址: %proxy_ip%
echo    端口: %proxy_port%
echo    代理地址: %proxy_server%
echo.
echo 当前系统代理:
echo    %current_proxy%
echo.
echo 内网排除列表:
echo    %proxy_override%
echo.
echo =====================================
echo.
echo 1. 开启代理
echo 2. 关闭代理
echo 3. 一键切换
echo 4. 刷新状态
echo 0. 退出
echo.

set /p choice=请选择操作:

if "%choice%"=="1" goto on
if "%choice%"=="2" goto off
if "%choice%"=="3" goto toggle
if "%choice%"=="4" goto refresh
if "%choice%"=="0" exit
goto menu

:on
echo.
echo 正在开启系统代理...

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "%proxy_server%" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "%proxy_override%" /f >nul

echo 代理已开启
timeout /t 2 >nul
goto refresh

:off
echo.
echo 正在关闭系统代理...

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >nul

echo 代理已关闭
timeout /t 2 >nul
goto refresh

:toggle
if "%status%"=="0x1" (
    goto off
) else (
    goto on
)