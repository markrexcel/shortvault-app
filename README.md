# ShortVault Pro  (v2: Reels, Shorts AND long videos)
Kotlin 2.3.0 · Jetpack Compose (Material 3) · yt-dlp (youtubedl-android 0.18.1) + FFmpeg · Play Billing 8 · Meta Audience Network ads · Media3 ExoPlayer

Build:  gradlew.bat assembleDebug   (APK)   |   gradlew.bat bundleRelease   (AAB, needs keystore.properties)
Needs JDK 17, Android SDK Platform 36, local.properties with sdk.dir=...

Pro product (Play Console > One-time products): ID `shortvault_pro_299`, price ₱299 / $4.99.
Meta ads: create 4 placements (Banner, Interstitial, Rewarded Video, Native) in Meta Monetization Manager and paste the
Placement IDs at the top of app/build.gradle.kts. Debug builds run Meta test mode. See CHANGES-v2.md.

How it works: the engine downloads the newest yt-dlp on first run and once a day (TikTok/Instagram change often).
Files are fetched to app cache, then saved with MediaStore: video -> Movies/ShortVault, audio -> Music/ShortVault,
"Save to Gallery" -> DCIM/ShortVault.

IMPORTANT - Google Play: downloading YouTube/TikTok/Instagram videos is against those platforms' terms and Google Play's
policies. Apps like this are routinely rejected or removed from Google Play. See NOTES-PLAY-POLICY.md.
