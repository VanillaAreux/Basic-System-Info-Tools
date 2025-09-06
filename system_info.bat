@echo off
setlocal enabledelayedexpansion
color 0A
title System Information Report

echo.
echo ===============================================
echo           DETAILED SYSTEM INFORMATION
echo ===============================================
echo.

:: Get current date and time
echo Report Generated: %date% %time%
echo.

:: ===============================================
:: OPERATING SYSTEM INFORMATION
:: ===============================================
echo [1] OPERATING SYSTEM INFORMATION
echo -----------------------------------------------
echo OS Name: 
systeminfo | findstr /C:"OS Name"
echo.
echo OS Version: 
systeminfo | findstr /C:"OS Version"
echo.
echo System Type: 
systeminfo | findstr /C:"System Type"
echo.
echo System Manufacturer: 
systeminfo | findstr /C:"System Manufacturer"
echo.
echo System Model: 
systeminfo | findstr /C:"System Model"
echo.
echo System Boot Time: 
systeminfo | findstr /C:"System Boot Time"
echo.
echo Time Zone: 
systeminfo | findstr /C:"Time Zone"
echo.

:: ===============================================
:: PROCESSOR INFORMATION
:: ===============================================
echo [2] PROCESSOR INFORMATION
echo -----------------------------------------------
echo Processor(s): 
systeminfo | findstr /C:"Processor(s)"
echo.

:: ===============================================
:: MEMORY INFORMATION
:: ===============================================
echo [3] MEMORY INFORMATION
echo -----------------------------------------------
echo Total Physical Memory: 
systeminfo | findstr /C:"Total Physical Memory"
echo.
echo Available Physical Memory: 
systeminfo | findstr /C:"Available Physical Memory"
echo.

:: ===============================================
:: STORAGE INFORMATION
:: ===============================================
echo [4] STORAGE INFORMATION
echo -----------------------------------------------
echo.
echo Drive Information:
wmic logicaldisk get size,freespace,caption,volumename,drivetype
echo.

:: ===============================================
:: NETWORK INFORMATION
:: ===============================================
echo [5] NETWORK INFORMATION
echo -----------------------------------------------
echo.
echo Network Adapters:
wmic path win32_networkadapter get name,netconnectionstatus,adaptertype
echo.
echo IP Configuration:
ipconfig /all
echo.

:: ===============================================
:: GRAPHICS INFORMATION
:: ===============================================
echo [6] GRAPHICS INFORMATION
echo -----------------------------------------------
echo.
echo Display Adapters:
wmic path win32_videocontroller get name,adapterram,driverversion
echo.

:: ===============================================
:: INSTALLED SOFTWARE
:: ===============================================
echo [7] INSTALLED SOFTWARE (Top 20)
echo -----------------------------------------------
echo.
wmic product get name,version,vendor | findstr /V "Name Version Vendor" | head -20
echo.

:: ===============================================
:: RUNNING SERVICES
:: ===============================================
echo [8] RUNNING SERVICES
echo -----------------------------------------------
echo.
sc query state= running | findstr "SERVICE_NAME"
echo.

:: ===============================================
:: STARTUP PROGRAMS
:: ===============================================
echo [9] STARTUP PROGRAMS
echo -----------------------------------------------
echo.
wmic startup get name,command,location
echo.

:: ===============================================
:: ENVIRONMENT VARIABLES
:: ===============================================
echo [10] ENVIRONMENT VARIABLES
echo -----------------------------------------------
echo.
echo PATH:
echo %PATH%
echo.
echo TEMP:
echo %TEMP%
echo.
echo USERPROFILE:
echo %USERPROFILE%
echo.

:: ===============================================
:: SYSTEM UPTIME
:: ===============================================
echo [11] SYSTEM UPTIME
echo -----------------------------------------------
echo.
for /f "tokens=*" %%i in ('systeminfo ^| findstr /C:"System Boot Time"') do echo %%i
echo.

:: ===============================================
:: COMPUTER NAME AND DOMAIN
:: ===============================================
echo [12] COMPUTER INFORMATION
echo -----------------------------------------------
echo.
echo Computer Name: %COMPUTERNAME%
echo User Name: %USERNAME%
echo Domain: %USERDOMAIN%
echo.

:: ===============================================
:: WINDOWS VERSION DETAILS
:: ===============================================
echo [13] WINDOWS VERSION DETAILS
echo -----------------------------------------------
echo.
ver
echo.
echo Windows Edition:
wmic os get caption
echo.

:: ===============================================
:: BIOS INFORMATION
:: ===============================================
echo [14] BIOS INFORMATION
echo -----------------------------------------------
echo.
wmic bios get manufacturer,name,version,releasedate
echo.

:: ===============================================
:: MOTHERBOARD INFORMATION
:: ===============================================
echo [15] MOTHERBOARD INFORMATION
echo -----------------------------------------------
echo.
wmic baseboard get manufacturer,product,version
echo.

:: ===============================================
:: POWER SUPPLY INFORMATION
:: ===============================================
echo [16] POWER SUPPLY INFORMATION
echo -----------------------------------------------
echo.
wmic path win32_battery get batterystatus,estimatedchargeremaining,estimatedruntime
echo.

:: ===============================================
:: SECURITY INFORMATION
:: ===============================================
echo [17] SECURITY INFORMATION
echo -----------------------------------------------
echo.
echo Windows Firewall Status:
netsh advfirewall show allprofiles state
echo.
echo Antivirus Information:
wmic /namespace:\\root\securitycenter2 path antivirusproduct get displayname,productstate
echo.

:: ===============================================
:: PERFORMANCE INFORMATION
:: ===============================================
echo [18] PERFORMANCE INFORMATION
echo -----------------------------------------------
echo.
echo CPU Usage:
wmic cpu get loadpercentage /value
echo.
echo Memory Usage:
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory /value
echo.

:: ===============================================
:: END OF REPORT
:: ===============================================
echo.
echo ===============================================
echo           END OF SYSTEM INFORMATION REPORT
echo ===============================================
echo.
echo Report completed at: %date% %time%
echo.
echo Press any key to exit...
pause >nul
