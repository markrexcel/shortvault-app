# Signing the release (ShortVault)
1. Double-click `make-keystore.bat` (or run the same keytool command). It asks you to choose a password.
   - Use a NEW long password. Do not reuse "YourPassword123" or any password you have pasted in a chat or email.
   - Keep the key for ShortVault separate from your other apps' keys.
2. Copy `keystore.properties.example` to `keystore.properties` and type the same password on both lines.
   `storeFile=upload-keystore.jks` is relative to this folder (no C:\ path needed).
3. Build the Play bundle: `gradlew.bat clean bundleRelease`
   Output: `app\build\outputs\bundle\release\app-release.aab`
4. Back up `upload-keystore.jks` + the password. If you lose it you can't update the app (with Play App Signing, Google can reset an UPLOAD key, but not the app's real key).
Both files are already in .gitignore.
