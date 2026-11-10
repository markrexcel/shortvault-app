# ShortVault v2: what changed

## 1. Long video downloads (not only Reels / Shorts)
- Works for YouTube (long videos, not just Shorts), Facebook videos, Instagram Reels/videos, TikTok.
- New quality picker: **Original (best) · 1080p · 720p · 480p · MP3**. Free plan: 720p / 480p / MP3. 1080p + Original are Pro (or unlocked once per rewarded ad).
- **Foreground download service** (`DownloadService.kt`): long downloads keep running when you switch apps or turn the screen off (before, Android could kill them).
- More retries for flaky connections, 1 GB free-space check, half-downloaded files are deleted when a download fails or is canceled.
- Durations over 1 hour show as h:mm:ss, ETA shows minutes/hours.
- The "ShortVault Free" watermark (a full re-encode) is skipped for videos longer than 5 minutes: re-encoding a long video would take forever. Tune it with `PlanConfig.WATERMARK_MAX_SEC`.

## 2. Meta Audience Network ads (replaces AdMob)
All in `MetaAds.kt`:
| Format       | Where it runs |
|--------------|---------------|
| Banner       | bottom bar, always visible for free/trial users |
| Interstitial | the moment a download starts (Download / Download now / shared link). Capped to one per 45 s. Preloaded in the background. |
| Rewarded     | "Free rewards" card + upgrade sheet: watch a video, get **+2 downloads today** or **1 HD download** |
| Native       | under the video card / downloads while fetching + downloading, and in the Library |
Pro users never see ads (`Pro.limits.ads`). `shortvault.ads=false` in gradle.properties builds with no ads.

### YOU must do this for real ads (I cannot do it for you)
1. Meta Business Suite -> Monetization Manager -> add your app -> create 4 placements: Banner, Interstitial, Rewarded Video, Native.
2. Paste the 4 Placement IDs at the top of `app/build.gradle.kts` (`META_*_RELEASE`, and `META_*_DEBUG` if you want test ads in debug).
3. Debug builds turn on Meta test mode automatically. Release builds do not.
Note: Meta only lets you register an app that already has a live Play Store (or App Store) listing. Until your IDs exist, ads will not load (the app itself still works; failed ad loads are ignored and retried).

## 3. Not done / be aware
- I could not compile or run this here (no Android SDK / network in my sandbox). Build it with `gradlew.bat assembleDebug` and send me any compiler error: I will fix it.
- EU/UK consent: the old Google consent form (UMP) was removed with AdMob. If you ship to the EU/UK add a consent flow for Meta.
