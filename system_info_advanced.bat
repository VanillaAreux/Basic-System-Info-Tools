@echo off
setlocal enabledelayedexpansion
color 0B
title Advanced System Information Report

:: Create output directory if it doesn't exist
if not exist "%USERPROFILE%\SystemReports" mkdir "%USERPROFILE%\SystemReports"

:: Set output file with timestamp
set "timestamp=%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "timestamp=%timestamp: =0%"
set "outputfile=%USERPROFILE%\SystemReports\system_info_%timestamp%.txt"

echo.
echo ===============================================
echo       ADVANCED SYSTEM INFORMATION REPORT
echo ===============================================
echo.
echo Report will be saved to: %outputfile%
echo.
echo Generating report... Please wait...
echo.

:: Start logging to file
(
echo ===============================================
echo       ADVANCED SYSTEM INFORMATION REPORT
echo ===============================================
echo.
echo Report Generated: %date% %time%
echo Computer: %COMPUTERNAME%
echo User: %USERNAME%
echo.
echo ===============================================
echo.

:: ===============================================
:: SYSTEM OVERVIEW
:: ===============================================
echo [1] SYSTEM OVERVIEW
echo -----------------------------------------------
echo.
echo Computer Name: %COMPUTERNAME%
echo User Name: %USERNAME%
echo Domain: %USERDOMAIN%
echo.
echo Windows Version:
ver
echo.
echo Windows Edition:
wmic os get caption
echo.

:: ===============================================
:: HARDWARE INFORMATION
:: ===============================================
echo [2] HARDWARE INFORMATION
echo -----------------------------------------------
echo.
echo System Manufacturer: 
systeminfo | findstr /C:"System Manufacturer"
echo.
echo System Model: 
systeminfo | findstr /C:"System Model"
echo.
echo System Type: 
systeminfo | findstr /C:"System Type"
echo.
echo BIOS Information:
wmic bios get manufacturer,name,version,releasedate,serialnumber
echo.
echo Motherboard Information:
wmic baseboard get manufacturer,product,version,serialnumber
echo.

:: ===============================================
:: PROCESSOR INFORMATION
:: ===============================================
echo [3] PROCESSOR INFORMATION
echo -----------------------------------------------
echo.
echo Processor Details:
wmic cpu get name,numberofcores,numberoflogicalprocessors,maxclockspeed,currentclockspeed
echo.
echo Processor Usage:
wmic cpu get loadpercentage /value
echo.

:: ===============================================
:: MEMORY INFORMATION
:: ===============================================
echo [4] MEMORY INFORMATION
echo -----------------------------------------------
echo.
echo Physical Memory:
wmic computersystem get TotalPhysicalMemory
echo.
echo Memory Details:
wmic memorychip get capacity,speed,manufacturer,partnumber,serialnumber
echo.
echo Memory Usage:
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory /value
echo.

:: ===============================================
:: STORAGE INFORMATION
:: ===============================================
echo [5] STORAGE INFORMATION
echo -----------------------------------------------
echo.
echo Logical Drives:
wmic logicaldisk get size,freespace,caption,volumename,drivetype,filesystem
echo.
echo Physical Disks:
wmic diskdrive get model,size,interfacetype,serialnumber
echo.

:: ===============================================
:: GRAPHICS INFORMATION
:: ===============================================
echo [6] GRAPHICS INFORMATION
echo -----------------------------------------------
echo.
echo Display Adapters:
wmic path win32_videocontroller get name,adapterram,driverversion,driverversion
echo.
echo Monitor Information:
wmic path win32_desktopmonitor get name,screenwidth,screenheight
echo.

:: ===============================================
:: NETWORK INFORMATION
:: ===============================================
echo [7] NETWORK INFORMATION
echo -----------------------------------------------
echo.
echo Network Adapters:
wmic path win32_networkadapter get name,netconnectionstatus,adaptertype,macaddress
echo.
echo IP Configuration:
ipconfig /all
echo.
echo Active Network Connections:
netstat -an
echo.

:: ===============================================
:: INSTALLED SOFTWARE
:: ===============================================
echo [8] INSTALLED SOFTWARE
echo -----------------------------------------------
echo.
echo Installed Programs:
wmic product get name,version,vendor,installdate
echo.

:: ===============================================
:: SERVICES AND PROCESSES
:: ===============================================
echo [9] SERVICES AND PROCESSES
echo -----------------------------------------------
echo.
echo Running Services:
sc query state= running
echo.
echo Top 10 Processes by CPU Usage:
wmic process get name,processid,percentprocessortime,workingsetsize | sort /r /+3
echo.

:: ===============================================
:: STARTUP PROGRAMS
:: ===============================================
echo [10] STARTUP PROGRAMS
echo -----------------------------------------------
echo.
echo Startup Programs:
wmic startup get name,command,location,user
echo.

:: ===============================================
:: SECURITY INFORMATION
:: ===============================================
echo [11] SECURITY INFORMATION
echo -----------------------------------------------
echo.
echo Windows Firewall Status:
netsh advfirewall show allprofiles state
echo.
echo Antivirus Information:
wmic /namespace:\\root\securitycenter2 path antivirusproduct get displayname,productstate
echo.
echo Windows Update Status:
wmic qfe get hotfixid,installedon,description
echo.

:: ===============================================
:: ENVIRONMENT VARIABLES
:: ===============================================
echo [12] ENVIRONMENT VARIABLES
echo -----------------------------------------------
echo.
echo System Environment Variables:
set
echo.

:: ===============================================
:: SYSTEM UPTIME AND PERFORMANCE
:: ===============================================
echo [13] SYSTEM UPTIME AND PERFORMANCE
echo -----------------------------------------------
echo.
echo System Boot Time: 
systeminfo | findstr /C:"System Boot Time"
echo.
echo System Uptime:
wmic os get lastbootuptime
echo.
echo Performance Counters:
wmic cpu get loadpercentage /value
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory /value
echo.

:: ===============================================
:: POWER MANAGEMENT
:: ===============================================
echo [14] POWER MANAGEMENT
echo -----------------------------------------------
echo.
echo Power Plan:
powercfg /query
echo.
echo Battery Information:
wmic path win32_battery get batterystatus,estimatedchargeremaining,estimatedruntime
echo.

:: ===============================================
:: USB DEVICES
:: ===============================================
echo [15] USB DEVICES
echo -----------------------------------------------
echo.
echo USB Devices:
wmic path win32_usbhub get deviceid,description
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

) > "%outputfile%"

echo.
echo ===============================================
echo           REPORT GENERATION COMPLETE
echo ===============================================
echo.
echo Report saved to: %outputfile%
echo.
echo Opening report in notepad...
start notepad "%outputfile%"
echo.
echo Press any key to exit...
pause >nul
