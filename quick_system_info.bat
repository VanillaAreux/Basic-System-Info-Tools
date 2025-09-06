@echo off
color 0E
title Quick System Information

echo.
echo ===============================================
echo           QUICK SYSTEM INFORMATION
echo ===============================================
echo.

echo Computer Name: %COMPUTERNAME%
echo User: %USERNAME%
echo Domain: %USERDOMAIN%
echo.

echo Windows Version:
ver
echo.

echo System Information:
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"System Manufacturer" /C:"System Model" /C:"Total Physical Memory" /C:"Available Physical Memory"
echo.

echo Processor:
systeminfo | findstr /C:"Processor(s)"
echo.

echo Drive Information:
wmic logicaldisk get size,freespace,caption,volumename
echo.

echo Network Adapters:
ipconfig | findstr /C:"Ethernet adapter" /C:"Wireless LAN adapter" /C:"IPv4 Address"
echo.

echo Running Services Count:
sc query state= running | find /C "SERVICE_NAME"
echo.

echo System Boot Time:
systeminfo | findstr /C:"System Boot Time"
echo.

echo ===============================================
echo.
echo Press any key to exit...
pause >nul
