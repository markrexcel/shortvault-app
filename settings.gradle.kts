pluginManagement {
    repositories { google(); mavenCentral(); gradlePluginPortal() }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()                         // youtubedl-android 0.18.x is published here
        maven { url = uri("https://jitpack.io") }
    }
}
rootProject.name = "ShortVault"
include(":app")
