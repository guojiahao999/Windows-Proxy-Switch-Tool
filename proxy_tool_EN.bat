@echo off
chcp 437 >nul
title Windows Proxy Control Tool

:: ==============================
:: Default Proxy Configuration (editable)
set proxy_ip=127.0.0.1
set proxy_port=7890
set proxy_server=%proxy_ip%:%proxy_port%
:: ==============================

:: Local network bypass
set proxy_override=localhost;127.*;10.*;172.16.*;172.17.*;172.18.*;172.19.*;172.20.*;172.21.*;172.22.*;172.23.*;172.24.*;172.25.*;172.26.*;172.27.*;172.28.*;172.29.*;172.30.*;172.31.*;192.168.*;

:: ==============================
:: Auto Administrator Permission
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:refresh

:: Read proxy switch
for /f "tokens=3" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable 2^>nul') do set status=%%i

:: Read current system proxy
set current_proxy=
for /f "tokens=3*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer 2^>nul') do set current_proxy=%%i

:: Determine proxy status
if "%status%"=="0x1" (
    set state=Enabled
) else (
    set state=Disabled
)

if "%current_proxy%"=="" (
    set current_proxy=Not Set
)

:menu
cls
echo =====================================
echo Current Proxy Status: %state%  (%current_proxy%)
echo =====================================
echo.
echo Default Proxy Configuration:
echo    IP Address: %proxy_ip%
echo    Port: %proxy_port%
echo    Proxy Address: %proxy_server%
echo.
echo Current System Proxy:
echo    %current_proxy%
echo.
echo Local Network Bypass List:
echo    %proxy_override%
echo.
echo =====================================
echo.
echo 1. Enable Proxy
echo 2. Disable Proxy
echo 3. Toggle Proxy
echo 4. Refresh Status
echo 0. Exit
echo.

set /p choice=Select an option:

if "%choice%"=="1" goto on
if "%choice%"=="2" goto off
if "%choice%"=="3" goto toggle
if "%choice%"=="4" goto refresh
if "%choice%"=="0" exit
goto menu

:on
echo.
echo Enabling system proxy...

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "%proxy_server%" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "%proxy_override%" /f >nul

echo Proxy Enabled
timeout /t 2 >nul
goto refresh

:off
echo.
echo Disabling system proxy...

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >nul

echo Proxy Disabled
timeout /t 2 >nul
goto refresh

:toggle
if "%status%"=="0x1" (
    goto off
) else (
    goto on
)
