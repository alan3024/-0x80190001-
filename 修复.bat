@echo off
:: 检查并获取管理员权限
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO 请以管理员身份运行此脚本...
    pause
    exit /b 1
)

ECHO 开始修复操作，请耐心等待...

:: 重置Winsock和IP配置
ECHO 正在重置网络设置...
netsh winsock reset
netsh int ip reset

:: 刷新DNS缓存
ECHO 正在刷新DNS缓存...
ipconfig /flushdns

:: 检查并修复系统文件
ECHO 正在检查系统文件完整性...
sfc /scannow

:: 修复系统镜像（若SFC无法解决）
ECHO 正在修复系统镜像...
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth

ECHO 修复操作已完成，请重启电脑后再尝试操作。
pause
