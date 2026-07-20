# Yayın ve Kurulum Rehberi — Spor Okulu

Bu belge, uygulamayı ilk kez kuran/yayınlayan kişi için **kod dışı** zorunlu
adımları içerir. (Denetim raporundaki K-1 ve O-3 bulgularına karşılık gelir.)

---

## 1. İlk yönetici hesabı oluşturma (O-3)

Güvenlik gereği **her yeni kullanıcı yetkisiz (`viewer`) rolde** oluşturulur ve
rol talebi bir yöneticinin onayına düşer. Rol atamasını yalnızca mevcut bir
yönetici yapabilir. Dolayısıyla sistemde **henüz hiç yönetici yokken** ilk
yönetici elle tanımlanmalıdır:

1. Uygulamadan normal şekilde **kayıt ol** (e-posta + parola). Bu hesap `viewer`
   olarak oluşur.
2. [Firebase Console](https://console.firebase.google.com) → proje
   **`mefe-spor-okulu-2026`** → **Firestore Database**.
3. `users` koleksiyonunda kendi kullanıcı belgeni bul (belge kimliği = Auth
   UID; Authentication sekmesinden e-postanla eşleştirebilirsin).
4. Belgede `role` alanını **`admin`** yap. (Varsa `roleRequestStatus` alanını
   `approved` yapabilirsin; zorunlu değil.)
5. Uygulamada **çıkış yapıp tekrar giriş** yap — artık yönetici yetkilerine
   sahipsin ve diğer başvuruları uygulama içinden onaylayabilirsin.

> Sonraki tüm yönetici/antrenör atamaları uygulama içinden yapılır; Console'a
> yalnızca bu ilk hesap için gerek vardır.

---

## 2. Dağıtım anahtarı (keystore) ve imzalı paket (K-1)

Release paketi **dağıtım anahtarıyla** imzalanmalıdır. Anahtar yoksa proje,
release paketlemesini bilinçli olarak **durdurur** (debug imzalı "release"
üretilmesini önlemek için). Adımlar:

### 2.1. Anahtar üretimi

```bash
keytool -genkey -v -keystore sporokulu-release.jks \
        -keyalg RSA -keysize 2048 -validity 10000 -alias sporokulu
```

Sorulan parolaları **güvenli bir yerde sakla** (parola yöneticisi vb.).

> ⚠️ **Anahtar deposu veya parola kaybolursa uygulama bir daha güncellenemez.**
> `.jks` dosyasını ve parolaları yedekle. Google **Play App Signing**'i
> etkinleştirmen şiddetle önerilir (imza anahtarını Google saklar, sen yükleme
> anahtarını korursun).

### 2.2. `android/key.properties` (bu dosya git'e GİRMEZ — .gitignore'da)

```properties
storeFile=C:/mutlak/yol/sporokulu-release.jks
storePassword=****
keyAlias=sporokulu
keyPassword=****
```

### 2.3. İmzalı paket üretimi (APK değil **AAB**)

```bash
flutter build appbundle --release
```

### 2.4. Doğrulama — çıktıda "Android Debug" **GÖRÜLMEMELİ**

```bash
keytool -printcert -jarfile build/app/outputs/bundle/release/app-release.aab
```

`CN = Android Debug` görüyorsan imza yanlıştır; `key.properties` yolunu/parolayı
kontrol et.

---

## 3. Yayın öncesi kontrol listesi

- [ ] Dağıtım anahtarı üretildi ve güvenli biçimde yedeklendi (K-1)
- [ ] İmza doğrulandı; çıktıda debug sertifikası yok (K-1)
- [ ] AAB formatında paket üretildi (K-1)
- [ ] İlk yönetici hesabı tanımlandı (O-3)
- [ ] SporTekAi Worker kimlik doğrulaması ile korunuyor + Groq anahtarı yenilendi (K-2)
- [ ] Firestore kuralları güncel sürümle deploy edildi (O-1 dahil)
- [ ] Hesap silme akışı uygulama içinde çalışıyor + web sayfası yayında (K-4)
- [ ] Gizlilik politikası / KVKK metni hukukçu onaylı ve yayında (K-5)
- [ ] Google Play Veri Güvenliği + Apple gizlilik formları dolduruldu (K-5)
- [ ] Gerçek destek iletişim bilgileri girildi (O-4)
- [ ] Kullanılmayan izinler kaldırıldı (O-2 ✓)
- [ ] (iOS) Push entitlement + APNs anahtarı — Mac/Apple hesabı gerektirir (K-3)
