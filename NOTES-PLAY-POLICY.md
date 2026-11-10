# Read before you publish
(Facebook/Meta, Instagram, TikTok and YouTube terms all restrict downloading; the same applies to Facebook Reels.)
1. Google Play (Intellectual Property + Deceptive Behavior policies): apps that let users download videos from YouTube,
   TikTok or Instagram are not allowed on Google Play, and "no watermark" removal makes it worse. Expect rejection or
   removal, and possibly a developer-account strike. This project is fine to build and sideload/test; do not assume it can be
   sold on Play. Other options: your own website APK, or stores with different rules.
2. Platform terms: downloading is against the terms of YouTube/TikTok/Instagram unless the creator allows it.
   The app shows a "use responsibly" notice on first launch; keep it.
3. Billing library must be 8.x or newer (6.1.0 from the original spec is rejected by Play). Included: 8.0.0.
4. Meta Audience Network: you need your own Placement IDs (see README). Meta only lets you register an app in Monetization
   Manager if it has a live Google Play / App Store listing, so placeholder IDs will not serve real ads.
5. Engine updates: yt-dlp breaks when sites change. The app self-updates the yt-dlp binary at runtime (needs internet).
6. Instagram: private posts and login-required content cannot be downloaded (no cookie login is built in).

## Extra points (watermark, ads, payments)
- The "ShortVault Free" watermark and the trial/free/pro tiers are normal business choices, but they do NOT change the Play
  policy problem above: the app's core function is what Google reviews.
- Meta Audience Network: ad networks (Meta included) can refuse or disable monetization for apps that facilitate copyright
  infringement or break other platforms' terms, and that can affect the rest of your Meta Business account. Safer: use a
  separate business account for this app, or build with ads off (`shortvault.ads=false` in gradle.properties).
- Google Play Billing only works for apps installed from Google Play. If you distribute the APK yourself, the Pro purchase
  (shortvault_pro_299) will not work. You would need your own licence/payment flow (PayPal/GCash + licence key), which is not
  built in.
- If a store or platform asks you to remove the app, comply; do not try to hide what the app does.
