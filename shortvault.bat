@echo off 
title ShortVault - Quick Storage and Notes Manager 
:menu 
cls 
echo ======================================== 
echo               SHORTVAULT 
echo ======================================== 
echo 1. Add New Entry 
echo 2. View All Entries 
echo 3. Exit 
echo ======================================== 
set /p choice="Choose an option (1-3): " 
if "%%choice%%"=="1" goto add 
if "%%choice%%"=="2" goto view 
if "%%choice%%"=="3" exit 
goto menu 
:add 
set /p key="Enter Title/Key: " 
set /p val="Enter Data/Secret: " 
echo %%key%% = %%val%% >> "%%~dp0vault_data.txt" 
echo Entry saved successfully! 
pause 
goto menu 
:view 
cls 
echo ======================================== 
echo            SAVED VAULT ENTRIES 
echo ======================================== 
if exist "%%~dp0vault_data.txt" ( 
    type "%%~dp0vault_data.txt" 
) else ( 
    echo Vault is currently empty. 
) 
echo ======================================== 
pause 
goto menu 
