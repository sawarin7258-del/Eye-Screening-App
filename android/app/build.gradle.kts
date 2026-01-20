plugins {
    id("com.android.application")

    // ✅ ใช้ id ที่ถูกต้องตาม Kotlin DSL
    id("org.jetbrains.kotlin.android")

    // ✅ Google Services (Firebase)
    id("com.google.gms.google-services")

    // ✅ Flutter plugin (ต้องอยู่หลังสุด)
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.eye_screening_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.eye_screening_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // ใช้ debug key ไปก่อนสำหรับ flutter run
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:34.8.0"))

    // ✅ อย่างน้อยต้องมี 1 ตัว
    implementation("com.google.firebase:firebase-analytics")

    // ✅ Firebase Auth (สมัคร / login)
    implementation("com.google.firebase:firebase-auth")
}
