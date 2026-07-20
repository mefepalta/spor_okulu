import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Release imzalama bilgileri android/key.properties'ten okunur (bu dosya ve
// keystore git'e GİRMEZ). Dosya yoksa debug ile imzalanır; yani keystore
// oluşturulana kadar `flutter run --release` dahil hiçbir şey bozulmaz.
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.mefepalta.sporokulu"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // flutter_local_notifications için gerekli (eski API'lerde java.time vb.).
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.mefepalta.sporokulu"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            if (keystorePropertiesFile.exists()) {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = (keystoreProperties["storeFile"] as String?)?.let { file(it) }
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    buildTypes {
        release {
            // key.properties varsa release anahtarıyla imzala. Yoksa yerel
            // geliştirme kolaylığı için debug'a düşülür AMA aşağıdaki koruma
            // gerçek release PAKETLEMESİNİ engeller; böylece debug imzalı bir
            // "release" fark edilmeden dağıtılamaz (K-1).
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}

// K-1 koruması: key.properties yoksa release paketi (assemble/bundle/package
// *Release) üretimini durdur. Debug derlemeleri ve `flutter run` etkilenmez;
// yalnızca dağıtım çıktısı engellenir. Keystore hazır olduğunda otomatik geçer.
if (!keystorePropertiesFile.exists()) {
    gradle.taskGraph.whenReady {
        val packagingRelease = allTasks.any {
            val n = it.name.lowercase()
            (n.contains("assemble") || n.contains("bundle") || n.contains("package")) &&
                n.contains("release")
        }
        if (packagingRelease) {
            throw GradleException(
                "Release paketi imzalanamaz: android/key.properties bulunamadi. " +
                    "Dagitim anahtari (keystore) olusturup key.properties ekleyin " +
                    "(bkz. YAYIN.md). Aksi halde paket debug sertifikasiyla " +
                    "imzalanir ve magaza reddeder."
            )
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

dependencies {
    // flutter_local_notifications'ın istediği core library desugaring kütüphanesi.
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
