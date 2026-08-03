plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.demo_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.demo_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "client"

    productFlavors {
        create("clientA") {
            dimension = "client"
            applicationIdSuffix = ".clienta"
            versionNameSuffix = "-clienta"
        }
        create("clientB") {
            dimension = "client"
            applicationIdSuffix = ".clientb"
            versionNameSuffix = "-clientb"
        }
        create("clientC") {
            dimension = "client"
            applicationIdSuffix = ".clientc"
            versionNameSuffix = "-clientc"
        }
        create("clientD") {
            dimension = "client"
            applicationIdSuffix = ".clientd"
            versionNameSuffix = "-clientd"
        }
        create("clientE") {
            dimension = "client"
            applicationIdSuffix = ".cliente"
            versionNameSuffix = "-cliente"
        }
        create("clientF") {
            dimension = "client"
            applicationIdSuffix = ".clientf"
            versionNameSuffix = "-clientf"
        }
        create("clientG") {
            dimension = "client"
            applicationIdSuffix = ".clientg"
            versionNameSuffix = "-clientg"
        }
        create("clientH") {
            dimension = "client"
            applicationIdSuffix = ".clienth"
            versionNameSuffix = "-clienth"
        }
        create("clientI") {
            dimension = "client"
            applicationIdSuffix = ".clienti"
            versionNameSuffix = "-clienti"
        }
        create("clientJ") {
            dimension = "client"
            applicationIdSuffix = ".clientj"
            versionNameSuffix = "-clientj"
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
