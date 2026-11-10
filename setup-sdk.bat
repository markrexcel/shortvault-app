@echo off
setlocal
rem One-time fix: accept Android SDK licences and install what this project needs.
set "SDK=C:\Android\Sdk"
if not "%~1"=="" set "SDK=%~1"
set "SM=%SDK%\cmdline-tools\latest\bin\sdkmanager.bat"

if not exist "%SM%" goto nosm

if "%JAVA_HOME%"=="" if exist "C:\Program Files\Android\Android Studio\jbr" set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"

echo Accepting Android SDK licences...
(for /l %%i in (1,1,40) do @echo y) | call "%SM%" --sdk_root="%SDK%" --licenses

echo.
echo Installing SDK Platform 36 and Build-Tools 35.0.0 ...
call "%SM%" --sdk_root="%SDK%" "platform-tools" "platforms;android-36" "build-tools;35.0.0"

if not exist local.properties (
  set "SDKF=%SDK:\=/%"
  >local.properties echo sdk.dir=%SDKF%
  echo Created local.properties
)

echo.
echo Done. Now run:  gradlew.bat assembleDebug
pause
exit /b 0

:nosm
echo sdkmanager was not found at:
echo   %SM%
echo.
echo Fix: open Android Studio, then Settings, Languages and Frameworks, Android SDK, SDK Tools tab.
echo Tick "Android SDK Command-line Tools - latest", click Apply, then run this file again.
pause
exit /b 1
