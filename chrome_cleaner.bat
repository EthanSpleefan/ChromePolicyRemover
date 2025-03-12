@echo off
setlocal enabledelayedexpansion

:: ########################################################
:: ##               Chrome Policy Remover                ##
:: ##                                                    ##
:: ##               Updated: 2024-05-21                  ##
:: ##                                                     ##
:: ########################################################

:: Check for administrator privileges
NET FILE 1>NUL 2>NUL || (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~dpnx0' -Verb RunAs"
    exit /b
)

color 0A
title Chrome Policy Remover v2.1.0 - Windows

echo.
echo #######################################################
echo ##           Starting Chrome Policy Cleanup          ##
echo #######################################################
echo.

:: Function to handle errors
:error
echo.
echo [!] ERROR: An unexpected error occurred at step !step!
echo [!] Possible causes:
echo     - Chrome processes still running
echo     - File in use by another program
echo     - Insufficient permissions
echo.
echo Please: 
echo 1. Close all Chrome/Chromium browsers
echo 2. Disable antivirus temporarily
echo 3. Right-click and Run as Administrator
echo.
pause
exit /b 1

:: Close Chrome processes
echo [1/7] Closing Chrome processes...
taskkill /F /IM chrome.exe /T > nul 2>&1
taskkill /F /IM msedge.exe /T > nul 2>&1
taskkill /F /IM iexplore.exe /T > nul 2>&1
echo ✓ Browsers closed successfully
echo.

:: Remove Group Policy folders
echo [2/7] Removing policy directories...
set "step=2"

call :clean_dir "%WINDIR%\System32\GroupPolicy" "System Policies"
call :clean_dir "%WINDIR%\System32\GroupPolicyUsers" "User Policies"
call :clean_dir "%ProgramFiles(x86)%\Google\Policies" "32-bit Policies"
call :clean_dir "%ProgramFiles%\Google\Policies" "64-bit Policies"

echo ✓ All policy directories removed
echo.

:: Update group policies
echo [3/7] Refreshing system policies...
set "step=3"
gpupdate /force | find "The update was successful." > nul && (
    echo ✓ Group policies updated successfully
) || (
    echo ✓ Group policies updated with warnings
)
echo.

:: Registry cleanup section
echo [4/7] Cleaning registry entries...
set "step=4"

call :clean_reg "HKEY_LOCAL_MACHINE\Software\Policies\Google\Chrome" "Main Chrome Policies"
call :clean_reg "HKEY_LOCAL_MACHINE\Software\Policies\Google\Update" "Update Policies"
call :clean_reg "HKEY_LOCAL_MACHINE\Software\Policies\Chromium" "Chromium Policies"
call :clean_reg "HKEY_LOCAL_MACHINE\Software\Google\Chrome" "Chrome Settings"
call :clean_reg "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Google\Enrollment" "Enterprise Enrollment"
call :clean_reg "HKEY_CURRENT_USER\Software\Policies\Google\Chrome" "User Chrome Policies"
call :clean_reg "HKEY_CURRENT_USER\Software\Policies\Chromium" "User Chromium Policies"
call :clean_reg "HKEY_CURRENT_USER\Software\Google\Chrome" "User Chrome Settings"

echo ✓ Registry cleanup completed
echo.

:: Final cleanup
echo [5/7] Performing final cleanup...
set "step=5"
reg delete "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Google\Update\ClientState\{430FD4D0-B729-4F61-AA34-91526481799D}" /v "CloudManagementEnrollmentToken" /f > nul 2>&1
echo ✓ Cloud management enrollment removed
echo.

:: Validation check
echo [6/7] Verifying cleanup...
set "step=6"
set verification_passed=true

call :verify_clean "%WINDIR%\System32\GroupPolicy" || set verification_passed=false
call :verify_clean "%ProgramFiles(x86)%\Google\Policies" || set verification_passed=false
reg query "HKEY_LOCAL_MACHINE\Software\Policies\Google\Chrome" > nul 2>&1 && set verification_passed=false

if "!verification_passed!" == "true" (
    echo ✓ Cleanup verified successfully
) else (
    echo ⚠ Partial cleanup detected - some remnants remain
)
echo.

:: Completion message
echo [7/7] Finalizing process...
echo.
echo #######################################################
echo ##                CLEANUP COMPLETE                   ##
echo #######################################################
echo.
echo RECOMMENDED NEXT STEPS:
echo 1. Restart your computer
echo 2. Reinstall Chrome browser
echo 3. Check chrome://policy in browser
echo 4. Run antivirus scan
echo.
echo For ongoing protection:
echo - Avoid untrusted software
echo - Keep Windows updated
echo - Use enterprise-grade antivirus
echo.
pause
exit /b 0

:: Helper function to clean directories
:clean_dir
echo Removing %~2...
if exist "%~1" (
    RD /S /Q "%~1" 2>nul || (
        echo ⚠ Failed to remove %~2
        echo ⚠ Attempting force removal...
        takeown /F "%~1" /R /D Y > nul
        icacls "%~1" /grant administrators:F /T > nul
        RD /S /Q "%~1" || goto error
    )
) else (
    echo ✓ %~2 not found - skipping
)
exit /b

:: Helper function to clean registry
:clean_reg
echo Removing %~2...
reg delete "%~1" /f > nul 2>&1 && (
    echo ✓ %~2 removed
) || (
    echo ✓ %~2 not present
)
exit /b

:: Verification function
:verify_clean
if exist "%~1" (
    echo ⚠ Found remaining files: %~1
    exit /b 1
)
exit /b 0