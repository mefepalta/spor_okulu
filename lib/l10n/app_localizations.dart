import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ru'),
    Locale('tr'),
  ];

  /// No description provided for @commonCancel.
  ///
  /// In tr, this message translates to:
  /// **'Vazgeç'**
  String get commonCancel;

  /// No description provided for @commonClose.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get commonClose;

  /// No description provided for @commonOk.
  ///
  /// In tr, this message translates to:
  /// **'Tamam'**
  String get commonOk;

  /// No description provided for @commonResend.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Gönder'**
  String get commonResend;

  /// No description provided for @roleAdmin.
  ///
  /// In tr, this message translates to:
  /// **'Yönetici'**
  String get roleAdmin;

  /// No description provided for @roleCoach.
  ///
  /// In tr, this message translates to:
  /// **'Antrenör'**
  String get roleCoach;

  /// No description provided for @roleParent.
  ///
  /// In tr, this message translates to:
  /// **'Veli'**
  String get roleParent;

  /// No description provided for @roleStudent.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci'**
  String get roleStudent;

  /// No description provided for @roleViewer.
  ///
  /// In tr, this message translates to:
  /// **'Görüntüleyici'**
  String get roleViewer;

  /// No description provided for @roleUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Bilinmeyen'**
  String get roleUnknown;

  /// No description provided for @loginHeading.
  ///
  /// In tr, this message translates to:
  /// **'Spor Okulu Yönetimi'**
  String get loginHeading;

  /// No description provided for @emailLabel.
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In tr, this message translates to:
  /// **'example@sporokulu.com'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In tr, this message translates to:
  /// **'Şifre'**
  String get passwordLabel;

  /// No description provided for @loginButton.
  ///
  /// In tr, this message translates to:
  /// **'Giriş Yap'**
  String get loginButton;

  /// No description provided for @loginLoading.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yapılıyor...'**
  String get loginLoading;

  /// No description provided for @forgotPassword.
  ///
  /// In tr, this message translates to:
  /// **'Şifremi unuttum'**
  String get forgotPassword;

  /// No description provided for @noAccountRegister.
  ///
  /// In tr, this message translates to:
  /// **'Hesabın yok mu? Kayıt ol'**
  String get noAccountRegister;

  /// No description provided for @emailEmpty.
  ///
  /// In tr, this message translates to:
  /// **'E-posta boş bırakılamaz.'**
  String get emailEmpty;

  /// No description provided for @emailInvalid.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir e-posta gir.'**
  String get emailInvalid;

  /// No description provided for @passwordEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Şifre boş bırakılamaz.'**
  String get passwordEmpty;

  /// No description provided for @passwordMinLength.
  ///
  /// In tr, this message translates to:
  /// **'Şifre en az 6 karakter olmalıdır.'**
  String get passwordMinLength;

  /// No description provided for @emailNotVerifiedTitle.
  ///
  /// In tr, this message translates to:
  /// **'E-posta doğrulanmamış'**
  String get emailNotVerifiedTitle;

  /// No description provided for @emailNotVerifiedBody.
  ///
  /// In tr, this message translates to:
  /// **'Hesabını aktifleştirmek için e-postana gelen doğrulama linkine tıklamalısın. Link gelmediyse tekrar gönderebiliriz.'**
  String get emailNotVerifiedBody;

  /// No description provided for @verificationResent.
  ///
  /// In tr, this message translates to:
  /// **'Doğrulama e-postası tekrar gönderildi. Spam klasörünü de kontrol et.'**
  String get verificationResent;

  /// No description provided for @rejectedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Başvurun reddedildi'**
  String get rejectedTitle;

  /// No description provided for @rejectedBody.
  ///
  /// In tr, this message translates to:
  /// **'Rol başvurun yönetici tarafından reddedildi. Hesabın kapatılıyor.'**
  String get rejectedBody;

  /// No description provided for @resetPasswordNeedEmail.
  ///
  /// In tr, this message translates to:
  /// **'Şifre sıfırlamak için önce e-posta adresini yaz.'**
  String get resetPasswordNeedEmail;

  /// No description provided for @resetPasswordSent.
  ///
  /// In tr, this message translates to:
  /// **'Şifre sıfırlama bağlantısı e-posta adresine gönderildi.'**
  String get resetPasswordSent;

  /// No description provided for @resetPasswordError.
  ///
  /// In tr, this message translates to:
  /// **'Şifre sıfırlama sırasında bir hata oluştu.'**
  String get resetPasswordError;

  /// No description provided for @resetInvalidEmail.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir e-posta adresi gir.'**
  String get resetInvalidEmail;

  /// No description provided for @resetUserNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Bu e-posta adresiyle kayıtlı kullanıcı bulunamadı.'**
  String get resetUserNotFound;

  /// No description provided for @userNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı bulunamadı.'**
  String get userNotFound;

  /// No description provided for @loginCheckError.
  ///
  /// In tr, this message translates to:
  /// **'Giriş kontrolü sırasında bir hata oluştu: {error}'**
  String loginCheckError(Object error);

  /// No description provided for @authInvalidEmail.
  ///
  /// In tr, this message translates to:
  /// **'E-posta adresi geçersiz.'**
  String get authInvalidEmail;

  /// No description provided for @authUserDisabled.
  ///
  /// In tr, this message translates to:
  /// **'Bu kullanıcı hesabı pasif durumda.'**
  String get authUserDisabled;

  /// No description provided for @authWrongCredentials.
  ///
  /// In tr, this message translates to:
  /// **'E-posta veya Şifre hatalı.'**
  String get authWrongCredentials;

  /// No description provided for @authNetwork.
  ///
  /// In tr, this message translates to:
  /// **'İnternet bağlantısı kurulamadı. Bağlantıyı kontrol edip tekrar dene.'**
  String get authNetwork;

  /// No description provided for @authOperationNotAllowed.
  ///
  /// In tr, this message translates to:
  /// **'Firebase Console içinde Email/Password giriş yöntemi aktif değil.'**
  String get authOperationNotAllowed;

  /// No description provided for @authConfigNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Firebase Authentication yapılandırması bulunamadı. Firebase Console ayarlarını kontrol et.'**
  String get authConfigNotFound;

  /// No description provided for @authAppNotAuthorized.
  ///
  /// In tr, this message translates to:
  /// **'Bu Android uygulaması Firebase projesi için yetkili görünmüyor.'**
  String get authAppNotAuthorized;

  /// No description provided for @authInvalidApiKey.
  ///
  /// In tr, this message translates to:
  /// **'Firebase API anahtarı geçersiz görünüyor.'**
  String get authInvalidApiKey;

  /// No description provided for @authTooManyRequests.
  ///
  /// In tr, this message translates to:
  /// **'Çok fazla giriş denemesi yapıldı. Bir süre sonra tekrar dene.'**
  String get authTooManyRequests;

  /// No description provided for @authGenericWithCode.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yapılamadı. Hata kodu: {code}'**
  String authGenericWithCode(String code);

  /// No description provided for @registerTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt Ol'**
  String get registerTitle;

  /// No description provided for @registerHeading.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Hesap Oluştur'**
  String get registerHeading;

  /// No description provided for @firstNameLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ad'**
  String get firstNameLabel;

  /// No description provided for @lastNameLabel.
  ///
  /// In tr, this message translates to:
  /// **'Soyad'**
  String get lastNameLabel;

  /// No description provided for @passwordAgainLabel.
  ///
  /// In tr, this message translates to:
  /// **'Şifre Tekrar'**
  String get passwordAgainLabel;

  /// No description provided for @passwordAgainEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Şifre tekrarı boş bırakılamaz.'**
  String get passwordAgainEmpty;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In tr, this message translates to:
  /// **'Şifreler eşleşmiyor.'**
  String get passwordsDontMatch;

  /// No description provided for @accountType.
  ///
  /// In tr, this message translates to:
  /// **'Hesap türün'**
  String get accountType;

  /// No description provided for @selectionSentToAdmin.
  ///
  /// In tr, this message translates to:
  /// **'Seçimin yönetici onayına gönderilir.'**
  String get selectionSentToAdmin;

  /// No description provided for @registerButton.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt Ol'**
  String get registerButton;

  /// No description provided for @registerLoading.
  ///
  /// In tr, this message translates to:
  /// **'Kaydediliyor...'**
  String get registerLoading;

  /// No description provided for @requiredField.
  ///
  /// In tr, this message translates to:
  /// **'{label} boş bırakılamaz.'**
  String requiredField(String label);

  /// No description provided for @registerSuccess.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt oluşturuldu. Lütfen e-postana gelen doğrulama linkine tıkla. Rol başvurun yönetici onayına gönderildi.'**
  String get registerSuccess;

  /// No description provided for @registerGenericError.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt sırasında bir hata oluştu.'**
  String get registerGenericError;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In tr, this message translates to:
  /// **'Bu e-posta adresi zaten kullanılıyor.'**
  String get emailAlreadyInUse;

  /// No description provided for @passwordTooWeak.
  ///
  /// In tr, this message translates to:
  /// **'Şifre çok zayıf. En az 6 karakter kullan.'**
  String get passwordTooWeak;

  /// No description provided for @registerErrorWith.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt hatası: {error}'**
  String registerErrorWith(Object error);

  /// No description provided for @userNotCreated.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı oluşturulamadı.'**
  String get userNotCreated;

  /// No description provided for @roleRequestsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Rol Başvuruları'**
  String get roleRequestsTitle;

  /// No description provided for @noPendingRequests.
  ///
  /// In tr, this message translates to:
  /// **'Bekleyen başvuru yok'**
  String get noPendingRequests;

  /// No description provided for @noPendingRequestsBody.
  ///
  /// In tr, this message translates to:
  /// **'Yeni kayıtların rol başvuruları burada görünür.'**
  String get noPendingRequestsBody;

  /// No description provided for @approveTitle.
  ///
  /// In tr, this message translates to:
  /// **'Başvuruyu onayla'**
  String get approveTitle;

  /// No description provided for @approveConfirm.
  ///
  /// In tr, this message translates to:
  /// **'{name} → {role} olarak yükseltilecek. Onaylıyor musun?'**
  String approveConfirm(String name, String role);

  /// No description provided for @approveAction.
  ///
  /// In tr, this message translates to:
  /// **'Onayla'**
  String get approveAction;

  /// No description provided for @approvedSnack.
  ///
  /// In tr, this message translates to:
  /// **'{name} {role} oldu.'**
  String approvedSnack(String name, String role);

  /// No description provided for @rejectTitle.
  ///
  /// In tr, this message translates to:
  /// **'Başvuruyu reddet'**
  String get rejectTitle;

  /// No description provided for @rejectConfirm.
  ///
  /// In tr, this message translates to:
  /// **'{name} başvurusu reddedilecek ve hesabı silinecek. Bu işlem geri alınamaz. Devam edilsin mi?'**
  String rejectConfirm(String name);

  /// No description provided for @rejectAction.
  ///
  /// In tr, this message translates to:
  /// **'Reddet'**
  String get rejectAction;

  /// No description provided for @rejectedSnack.
  ///
  /// In tr, this message translates to:
  /// **'{name} başvurusu reddedildi.'**
  String rejectedSnack(String name);

  /// No description provided for @requestLabel.
  ///
  /// In tr, this message translates to:
  /// **'Talep: {role}'**
  String requestLabel(String role);

  /// No description provided for @genericOperationError.
  ///
  /// In tr, this message translates to:
  /// **'İşlem sırasında bir hata oluştu.'**
  String get genericOperationError;

  /// No description provided for @profileTitle.
  ///
  /// In tr, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// No description provided for @profileUserFallback.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı'**
  String get profileUserFallback;

  /// No description provided for @roleDescAdmin.
  ///
  /// In tr, this message translates to:
  /// **'Tüm kayıtları ekleyebilir, düzenleyebilir ve silebilir.'**
  String get roleDescAdmin;

  /// No description provided for @roleDescCoach.
  ///
  /// In tr, this message translates to:
  /// **'Yoklama ve duyuru kayıtlarını yönetebilir. Diğer kayıtları görüntüleyebilir.'**
  String get roleDescCoach;

  /// No description provided for @roleDescParent.
  ///
  /// In tr, this message translates to:
  /// **'Çocuğunun performansını takip edebilir ve etkinliklere katılım cevabı verebilir.'**
  String get roleDescParent;

  /// No description provided for @roleDescStudent.
  ///
  /// In tr, this message translates to:
  /// **'Kendi yoklama ve performans bilgisini görüntüleyebilir.'**
  String get roleDescStudent;

  /// No description provided for @roleDescViewer.
  ///
  /// In tr, this message translates to:
  /// **'Kayıtları görüntüleyebilir, ancak değişiklik yapamaz.'**
  String get roleDescViewer;

  /// No description provided for @childrenSectionStudent.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci Bilgim'**
  String get childrenSectionStudent;

  /// No description provided for @childrenSectionParent.
  ///
  /// In tr, this message translates to:
  /// **'Öğrencilerim'**
  String get childrenSectionParent;

  /// No description provided for @authorityTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yetki'**
  String get authorityTitle;

  /// No description provided for @appearanceTitle.
  ///
  /// In tr, this message translates to:
  /// **'Görünüm'**
  String get appearanceTitle;

  /// No description provided for @themeSystem.
  ///
  /// In tr, this message translates to:
  /// **'Sistem'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In tr, this message translates to:
  /// **'Aydınlık'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In tr, this message translates to:
  /// **'Karanlık'**
  String get themeDark;

  /// No description provided for @backgroundEffectTitle.
  ///
  /// In tr, this message translates to:
  /// **'Arka plan efekti'**
  String get backgroundEffectTitle;

  /// No description provided for @backgroundEffectDesc.
  ///
  /// In tr, this message translates to:
  /// **'Yüksek: dalga + partikül · Orta: yalnızca dalga · Düşük: sade zemin.'**
  String get backgroundEffectDesc;

  /// No description provided for @backgroundHigh.
  ///
  /// In tr, this message translates to:
  /// **'Yüksek'**
  String get backgroundHigh;

  /// No description provided for @backgroundMedium.
  ///
  /// In tr, this message translates to:
  /// **'Orta'**
  String get backgroundMedium;

  /// No description provided for @backgroundLow.
  ///
  /// In tr, this message translates to:
  /// **'Düşük'**
  String get backgroundLow;

  /// No description provided for @languageTitle.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get languageTitle;

  /// No description provided for @languageSystem.
  ///
  /// In tr, this message translates to:
  /// **'Sistem'**
  String get languageSystem;

  /// No description provided for @editAccount.
  ///
  /// In tr, this message translates to:
  /// **'Hesabı Düzenle'**
  String get editAccount;

  /// No description provided for @contactUs.
  ///
  /// In tr, this message translates to:
  /// **'Bize Ulaşın'**
  String get contactUs;

  /// No description provided for @whatsappSupport.
  ///
  /// In tr, this message translates to:
  /// **'WhatsApp Destek'**
  String get whatsappSupport;

  /// No description provided for @kvkkTitle.
  ///
  /// In tr, this message translates to:
  /// **'KVKK Aydınlatma Metni'**
  String get kvkkTitle;

  /// No description provided for @termsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kullanım Koşulları'**
  String get termsTitle;

  /// No description provided for @privacyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik Politikası'**
  String get privacyTitle;

  /// No description provided for @appVersionLabel.
  ///
  /// In tr, this message translates to:
  /// **'Uygulama Sürümü'**
  String get appVersionLabel;

  /// No description provided for @logout.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış Yap'**
  String get logout;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr', 'ru', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
