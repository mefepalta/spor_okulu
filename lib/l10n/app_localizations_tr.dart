// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get commonCancel => 'Vazgeç';

  @override
  String get commonClose => 'Kapat';

  @override
  String get commonOk => 'Tamam';

  @override
  String get commonResend => 'Tekrar Gönder';

  @override
  String get roleAdmin => 'Yönetici';

  @override
  String get roleCoach => 'Antrenör';

  @override
  String get roleParent => 'Veli';

  @override
  String get roleStudent => 'Öğrenci';

  @override
  String get roleViewer => 'Görüntüleyici';

  @override
  String get roleUnknown => 'Bilinmeyen';

  @override
  String get loginHeading => 'Spor Okulu Yönetimi';

  @override
  String get emailLabel => 'E-posta';

  @override
  String get emailHint => 'example@sporokulu.com';

  @override
  String get passwordLabel => 'Şifre';

  @override
  String get loginButton => 'Giriş Yap';

  @override
  String get loginLoading => 'Giriş yapılıyor...';

  @override
  String get forgotPassword => 'Şifremi unuttum';

  @override
  String get noAccountRegister => 'Hesabın yok mu? Kayıt ol';

  @override
  String get emailEmpty => 'E-posta boş bırakılamaz.';

  @override
  String get emailInvalid => 'Geçerli bir e-posta gir.';

  @override
  String get passwordEmpty => 'Şifre boş bırakılamaz.';

  @override
  String get passwordMinLength => 'Şifre en az 6 karakter olmalıdır.';

  @override
  String get emailNotVerifiedTitle => 'E-posta doğrulanmamış';

  @override
  String get emailNotVerifiedBody =>
      'Hesabını aktifleştirmek için e-postana gelen doğrulama linkine tıklamalısın. Link gelmediyse tekrar gönderebiliriz.';

  @override
  String get verificationResent =>
      'Doğrulama e-postası tekrar gönderildi. Spam klasörünü de kontrol et.';

  @override
  String get rejectedTitle => 'Başvurun reddedildi';

  @override
  String get rejectedBody =>
      'Rol başvurun yönetici tarafından reddedildi. Hesabın kapatılıyor.';

  @override
  String get resetPasswordNeedEmail =>
      'Şifre sıfırlamak için önce e-posta adresini yaz.';

  @override
  String get resetPasswordSent =>
      'Şifre sıfırlama bağlantısı e-posta adresine gönderildi.';

  @override
  String get resetPasswordError => 'Şifre sıfırlama sırasında bir hata oluştu.';

  @override
  String get resetInvalidEmail => 'Geçerli bir e-posta adresi gir.';

  @override
  String get resetUserNotFound =>
      'Bu e-posta adresiyle kayıtlı kullanıcı bulunamadı.';

  @override
  String get userNotFound => 'Kullanıcı bulunamadı.';

  @override
  String loginCheckError(Object error) {
    return 'Giriş kontrolü sırasında bir hata oluştu: $error';
  }

  @override
  String get authInvalidEmail => 'E-posta adresi geçersiz.';

  @override
  String get authUserDisabled => 'Bu kullanıcı hesabı pasif durumda.';

  @override
  String get authWrongCredentials => 'E-posta veya Şifre hatalı.';

  @override
  String get authNetwork =>
      'İnternet bağlantısı kurulamadı. Bağlantıyı kontrol edip tekrar dene.';

  @override
  String get authOperationNotAllowed =>
      'Firebase Console içinde Email/Password giriş yöntemi aktif değil.';

  @override
  String get authConfigNotFound =>
      'Firebase Authentication yapılandırması bulunamadı. Firebase Console ayarlarını kontrol et.';

  @override
  String get authAppNotAuthorized =>
      'Bu Android uygulaması Firebase projesi için yetkili görünmüyor.';

  @override
  String get authInvalidApiKey => 'Firebase API anahtarı geçersiz görünüyor.';

  @override
  String get authTooManyRequests =>
      'Çok fazla giriş denemesi yapıldı. Bir süre sonra tekrar dene.';

  @override
  String authGenericWithCode(String code) {
    return 'Giriş yapılamadı. Hata kodu: $code';
  }

  @override
  String get registerTitle => 'Kayıt Ol';

  @override
  String get registerHeading => 'Yeni Hesap Oluştur';

  @override
  String get firstNameLabel => 'Ad';

  @override
  String get lastNameLabel => 'Soyad';

  @override
  String get passwordAgainLabel => 'Şifre Tekrar';

  @override
  String get passwordAgainEmpty => 'Şifre tekrarı boş bırakılamaz.';

  @override
  String get passwordsDontMatch => 'Şifreler eşleşmiyor.';

  @override
  String get accountType => 'Hesap türün';

  @override
  String get selectionSentToAdmin => 'Seçimin yönetici onayına gönderilir.';

  @override
  String get registerButton => 'Kayıt Ol';

  @override
  String get registerLoading => 'Kaydediliyor...';

  @override
  String requiredField(String label) {
    return '$label boş bırakılamaz.';
  }

  @override
  String get registerSuccess =>
      'Kayıt oluşturuldu. Lütfen e-postana gelen doğrulama linkine tıkla. Rol başvurun yönetici onayına gönderildi.';

  @override
  String get registerGenericError => 'Kayıt sırasında bir hata oluştu.';

  @override
  String get emailAlreadyInUse => 'Bu e-posta adresi zaten kullanılıyor.';

  @override
  String get passwordTooWeak => 'Şifre çok zayıf. En az 6 karakter kullan.';

  @override
  String registerErrorWith(Object error) {
    return 'Kayıt hatası: $error';
  }

  @override
  String get userNotCreated => 'Kullanıcı oluşturulamadı.';

  @override
  String get roleRequestsTitle => 'Rol Başvuruları';

  @override
  String get noPendingRequests => 'Bekleyen başvuru yok';

  @override
  String get noPendingRequestsBody =>
      'Yeni kayıtların rol başvuruları burada görünür.';

  @override
  String get approveTitle => 'Başvuruyu onayla';

  @override
  String approveConfirm(String name, String role) {
    return '$name → $role olarak yükseltilecek. Onaylıyor musun?';
  }

  @override
  String get approveAction => 'Onayla';

  @override
  String approvedSnack(String name, String role) {
    return '$name $role oldu.';
  }

  @override
  String get rejectTitle => 'Başvuruyu reddet';

  @override
  String rejectConfirm(String name) {
    return '$name başvurusu reddedilecek ve hesabı silinecek. Bu işlem geri alınamaz. Devam edilsin mi?';
  }

  @override
  String get rejectAction => 'Reddet';

  @override
  String rejectedSnack(String name) {
    return '$name başvurusu reddedildi.';
  }

  @override
  String requestLabel(String role) {
    return 'Talep: $role';
  }

  @override
  String get genericOperationError => 'İşlem sırasında bir hata oluştu.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileUserFallback => 'Kullanıcı';

  @override
  String get roleDescAdmin =>
      'Tüm kayıtları ekleyebilir, düzenleyebilir ve silebilir.';

  @override
  String get roleDescCoach =>
      'Yoklama ve duyuru kayıtlarını yönetebilir. Diğer kayıtları görüntüleyebilir.';

  @override
  String get roleDescParent =>
      'Çocuğunun performansını takip edebilir ve etkinliklere katılım cevabı verebilir.';

  @override
  String get roleDescStudent =>
      'Kendi yoklama ve performans bilgisini görüntüleyebilir.';

  @override
  String get roleDescViewer =>
      'Kayıtları görüntüleyebilir, ancak değişiklik yapamaz.';

  @override
  String get childrenSectionStudent => 'Öğrenci Bilgim';

  @override
  String get childrenSectionParent => 'Öğrencilerim';

  @override
  String get authorityTitle => 'Yetki';

  @override
  String get appearanceTitle => 'Görünüm';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Aydınlık';

  @override
  String get themeDark => 'Karanlık';

  @override
  String get backgroundEffectTitle => 'Arka plan efekti';

  @override
  String get backgroundEffectDesc =>
      'Yüksek: dalga + partikül · Orta: yalnızca dalga · Düşük: sade zemin.';

  @override
  String get backgroundHigh => 'Yüksek';

  @override
  String get backgroundMedium => 'Orta';

  @override
  String get backgroundLow => 'Düşük';

  @override
  String get languageTitle => 'Dil';

  @override
  String get languageSystem => 'Sistem';

  @override
  String get editAccount => 'Hesabı Düzenle';

  @override
  String get contactUs => 'Bize Ulaşın';

  @override
  String get whatsappSupport => 'WhatsApp Destek';

  @override
  String get kvkkTitle => 'KVKK Aydınlatma Metni';

  @override
  String get termsTitle => 'Kullanım Koşulları';

  @override
  String get privacyTitle => 'Gizlilik Politikası';

  @override
  String get appVersionLabel => 'Uygulama Sürümü';

  @override
  String get logout => 'Çıkış Yap';
}
