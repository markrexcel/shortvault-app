@echo off
echo Creating your upload key for ShortVault.
echo You will be asked to CHOOSE a password. Make it long and unique, write it down, never share it.
echo.
keytool -genkeypair -v -storetype PKCS12 -keystore upload-keystore.jks -alias upload -keyalg RSA -keysize 2048 -validity 10000 -dname "CN=ShortVault, OU=Dev, O=ShortVault, L=City, ST=State, C=PH"
if errorlevel 1 (
  echo.
  echo keytool was not found. Open the terminal inside Android Studio, or add the JDK bin folder to PATH.
) else (
  echo.
  echo Done. Now copy keystore.properties.example to keystore.properties and type your password into it.
)
pause
