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

  /// No description provided for @commonAll.
  ///
  /// In tr, this message translates to:
  /// **'Tümü'**
  String get commonAll;

  /// No description provided for @commonAdd.
  ///
  /// In tr, this message translates to:
  /// **'Ekle'**
  String get commonAdd;

  /// No description provided for @commonDelete.
  ///
  /// In tr, this message translates to:
  /// **'Sil'**
  String get commonDelete;

  /// No description provided for @viewAction.
  ///
  /// In tr, this message translates to:
  /// **'Görüntüle'**
  String get viewAction;

  /// No description provided for @statusPaid.
  ///
  /// In tr, this message translates to:
  /// **'Ödendi'**
  String get statusPaid;

  /// No description provided for @statusPending.
  ///
  /// In tr, this message translates to:
  /// **'Bekliyor'**
  String get statusPending;

  /// No description provided for @statusOverdue.
  ///
  /// In tr, this message translates to:
  /// **'Gecikti'**
  String get statusOverdue;

  /// No description provided for @leaveStatusPending.
  ///
  /// In tr, this message translates to:
  /// **'Beklemede'**
  String get leaveStatusPending;

  /// No description provided for @leaveStatusApproved.
  ///
  /// In tr, this message translates to:
  /// **'Onaylandı'**
  String get leaveStatusApproved;

  /// No description provided for @leaveStatusRejected.
  ///
  /// In tr, this message translates to:
  /// **'Reddedildi'**
  String get leaveStatusRejected;

  /// No description provided for @drawerMainPanel.
  ///
  /// In tr, this message translates to:
  /// **'Ana Panel'**
  String get drawerMainPanel;

  /// No description provided for @sectionRecords.
  ///
  /// In tr, this message translates to:
  /// **'Kayıtlar'**
  String get sectionRecords;

  /// No description provided for @sectionOperations.
  ///
  /// In tr, this message translates to:
  /// **'Operasyon'**
  String get sectionOperations;

  /// No description provided for @sectionClub.
  ///
  /// In tr, this message translates to:
  /// **'Kulüp'**
  String get sectionClub;

  /// No description provided for @sectionGeneral.
  ///
  /// In tr, this message translates to:
  /// **'Genel'**
  String get sectionGeneral;

  /// No description provided for @sectionMyChild.
  ///
  /// In tr, this message translates to:
  /// **'Çocuğum'**
  String get sectionMyChild;

  /// No description provided for @sectionMe.
  ///
  /// In tr, this message translates to:
  /// **'Ben'**
  String get sectionMe;

  /// No description provided for @navStudents.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenciler'**
  String get navStudents;

  /// No description provided for @navCoaches.
  ///
  /// In tr, this message translates to:
  /// **'Antrenörler'**
  String get navCoaches;

  /// No description provided for @navGroups.
  ///
  /// In tr, this message translates to:
  /// **'Gruplar'**
  String get navGroups;

  /// No description provided for @navParents.
  ///
  /// In tr, this message translates to:
  /// **'Veliler'**
  String get navParents;

  /// No description provided for @navStudentAccounts.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci Hesapları'**
  String get navStudentAccounts;

  /// No description provided for @navAttendance.
  ///
  /// In tr, this message translates to:
  /// **'Yoklama'**
  String get navAttendance;

  /// No description provided for @navLeaveRequests.
  ///
  /// In tr, this message translates to:
  /// **'Mazeretler'**
  String get navLeaveRequests;

  /// No description provided for @navPayments.
  ///
  /// In tr, this message translates to:
  /// **'Ödemeler'**
  String get navPayments;

  /// No description provided for @navPerformance.
  ///
  /// In tr, this message translates to:
  /// **'Performans'**
  String get navPerformance;

  /// No description provided for @navEvents.
  ///
  /// In tr, this message translates to:
  /// **'Etkinlikler'**
  String get navEvents;

  /// No description provided for @navEquipment.
  ///
  /// In tr, this message translates to:
  /// **'Depo'**
  String get navEquipment;

  /// No description provided for @navAnnouncements.
  ///
  /// In tr, this message translates to:
  /// **'Duyurular'**
  String get navAnnouncements;

  /// No description provided for @navClubCash.
  ///
  /// In tr, this message translates to:
  /// **'Kulüp Kasası'**
  String get navClubCash;

  /// No description provided for @navReports.
  ///
  /// In tr, this message translates to:
  /// **'Raporlar'**
  String get navReports;

  /// No description provided for @navSports.
  ///
  /// In tr, this message translates to:
  /// **'Sporlar'**
  String get navSports;

  /// No description provided for @navUsers.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcılar'**
  String get navUsers;

  /// No description provided for @navReportAbsence.
  ///
  /// In tr, this message translates to:
  /// **'Mazeret Bildir'**
  String get navReportAbsence;

  /// No description provided for @navMyPerformance.
  ///
  /// In tr, this message translates to:
  /// **'Performansım'**
  String get navMyPerformance;

  /// No description provided for @navMyAttendance.
  ///
  /// In tr, this message translates to:
  /// **'Yoklamam'**
  String get navMyAttendance;

  /// No description provided for @notificationsTooltip.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler'**
  String get notificationsTooltip;

  /// No description provided for @notifCategoryAnnouncement.
  ///
  /// In tr, this message translates to:
  /// **'Duyuru'**
  String get notifCategoryAnnouncement;

  /// No description provided for @notifCategoryPayment.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme'**
  String get notifCategoryPayment;

  /// No description provided for @notifCategoryLeave.
  ///
  /// In tr, this message translates to:
  /// **'Mazeret'**
  String get notifCategoryLeave;

  /// No description provided for @notifCategoryAbsence.
  ///
  /// In tr, this message translates to:
  /// **'Devamsızlık'**
  String get notifCategoryAbsence;

  /// No description provided for @leaveWaitingApproval.
  ///
  /// In tr, this message translates to:
  /// **'Onay bekliyor'**
  String get leaveWaitingApproval;

  /// No description provided for @notifLeaveTitle.
  ///
  /// In tr, this message translates to:
  /// **'{name} • mazeret'**
  String notifLeaveTitle(String name);

  /// No description provided for @notifAbsenceTitle.
  ///
  /// In tr, this message translates to:
  /// **'{name} gelmedi'**
  String notifAbsenceTitle(String name);

  /// No description provided for @errorLoadingData.
  ///
  /// In tr, this message translates to:
  /// **'Veriler yüklenirken bir hata oluştu: {error}'**
  String errorLoadingData(Object error);

  /// No description provided for @reminderDialogTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Hatırlatıcı'**
  String get reminderDialogTitle;

  /// No description provided for @reminderDialogHint.
  ///
  /// In tr, this message translates to:
  /// **'Örn: Salı günü malzeme siparişi ver'**
  String get reminderDialogHint;

  /// No description provided for @newAnnouncementPublished.
  ///
  /// In tr, this message translates to:
  /// **'Yeni bir duyuru yayınlandı.'**
  String get newAnnouncementPublished;

  /// No description provided for @newAnnouncementsPublished.
  ///
  /// In tr, this message translates to:
  /// **'{count} yeni duyuru yayınlandı.'**
  String newAnnouncementsPublished(int count);

  /// No description provided for @remindersTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hızlı Hatırlatıcılar'**
  String get remindersTitle;

  /// No description provided for @remindersEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Henüz bir hatırlatıcı eklemediniz.'**
  String get remindersEmpty;

  /// No description provided for @aiIntroParent.
  ///
  /// In tr, this message translates to:
  /// **'Çocuğunuzun güncel özetini biliyorum. Aşağıdakilerden birini seçebilir ya da kendi sorunuzu yazabilirsiniz.'**
  String get aiIntroParent;

  /// No description provided for @aiIntroStudent.
  ///
  /// In tr, this message translates to:
  /// **'Güncel durumunu biliyorum. Aşağıdakilerden birini seçebilir ya da kendi sorunu yazabilirsin.'**
  String get aiIntroStudent;

  /// No description provided for @aiIntroStaff.
  ///
  /// In tr, this message translates to:
  /// **'Kulübünüzün güncel özetini biliyorum. Aşağıdakilerden birini seçebilir ya da kendi sorunu yazabilirsin.'**
  String get aiIntroStaff;

  /// No description provided for @viewerWelcomeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Spor okuluna hoş geldin.'**
  String get viewerWelcomeSubtitle;

  /// No description provided for @requestPendingTitle.
  ///
  /// In tr, this message translates to:
  /// **'Başvurun inceleniyor'**
  String get requestPendingTitle;

  /// No description provided for @requestPendingMessage.
  ///
  /// In tr, this message translates to:
  /// **'{role} olma başvurun yönetici onayında. Onaylandığında ilgili panoya erişebileceksin.'**
  String requestPendingMessage(String role);

  /// No description provided for @requestApprovedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Başvurun onaylandı'**
  String get requestApprovedTitle;

  /// No description provided for @requestApprovedMessage.
  ///
  /// In tr, this message translates to:
  /// **'Yeni rolünü görmek için çıkış yapıp tekrar giriş yapman yeterli.'**
  String get requestApprovedMessage;

  /// No description provided for @roleNotAssignedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Rolün henüz atanmadı'**
  String get roleNotAssignedTitle;

  /// No description provided for @roleNotAssignedMessage.
  ///
  /// In tr, this message translates to:
  /// **'Yönetici sana bir rol atadığında ilgili panoya erişeceksin.'**
  String get roleNotAssignedMessage;

  /// No description provided for @greetingMorning.
  ///
  /// In tr, this message translates to:
  /// **'Günaydın'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In tr, this message translates to:
  /// **'İyi günler'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In tr, this message translates to:
  /// **'İyi akşamlar'**
  String get greetingEvening;

  /// No description provided for @studentGreetingSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Güncel durumun aşağıda.'**
  String get studentGreetingSubtitle;

  /// No description provided for @parentGreetingSubtitleOne.
  ///
  /// In tr, this message translates to:
  /// **'{name} • güncel özet'**
  String parentGreetingSubtitleOne(String name);

  /// No description provided for @parentGreetingSubtitleMany.
  ///
  /// In tr, this message translates to:
  /// **'Çocuklarınızın güncel özeti aşağıda.'**
  String get parentGreetingSubtitleMany;

  /// No description provided for @staffGreetingSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Kulübünüzün güncel özeti aşağıda.'**
  String get staffGreetingSubtitle;

  /// No description provided for @highlightOverdueDues.
  ///
  /// In tr, this message translates to:
  /// **'Geciken aidat: {amount}'**
  String highlightOverdueDues(String amount);

  /// No description provided for @highlightGreatAttendance.
  ///
  /// In tr, this message translates to:
  /// **'Katılımın çok iyi, böyle devam! 🎯'**
  String get highlightGreatAttendance;

  /// No description provided for @highlightWatchAttendance.
  ///
  /// In tr, this message translates to:
  /// **'Katılıma biraz dikkat edelim'**
  String get highlightWatchAttendance;

  /// No description provided for @highlightPlannedEvent.
  ///
  /// In tr, this message translates to:
  /// **'Planlı etkinlik var, kaçırma'**
  String get highlightPlannedEvent;

  /// No description provided for @highlightAllGood.
  ///
  /// In tr, this message translates to:
  /// **'Her şey yolunda görünüyor 👍'**
  String get highlightAllGood;

  /// No description provided for @highlightPaymentsPending.
  ///
  /// In tr, this message translates to:
  /// **'{count} ödeme takip bekliyor'**
  String highlightPaymentsPending(int count);

  /// No description provided for @highlightLeavePending.
  ///
  /// In tr, this message translates to:
  /// **'{count} mazeret onay bekliyor'**
  String highlightLeavePending(int count);

  /// No description provided for @highlightNoPending.
  ///
  /// In tr, this message translates to:
  /// **'Bekleyen bir işin yok, harika 👍'**
  String get highlightNoPending;

  /// No description provided for @statPerformance.
  ///
  /// In tr, this message translates to:
  /// **'Performans'**
  String get statPerformance;

  /// No description provided for @statEvent.
  ///
  /// In tr, this message translates to:
  /// **'Etkinlik'**
  String get statEvent;

  /// No description provided for @statAnnouncement.
  ///
  /// In tr, this message translates to:
  /// **'Duyuru'**
  String get statAnnouncement;

  /// No description provided for @statMyChild.
  ///
  /// In tr, this message translates to:
  /// **'Çocuğum'**
  String get statMyChild;

  /// No description provided for @statStudent.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci'**
  String get statStudent;

  /// No description provided for @statCoach.
  ///
  /// In tr, this message translates to:
  /// **'Antrenör'**
  String get statCoach;

  /// No description provided for @statGroup.
  ///
  /// In tr, this message translates to:
  /// **'Grup'**
  String get statGroup;

  /// No description provided for @noteNew.
  ///
  /// In tr, this message translates to:
  /// **'{count} yeni'**
  String noteNew(int count);

  /// No description provided for @noteWaiting.
  ///
  /// In tr, this message translates to:
  /// **'{count} bekliyor'**
  String noteWaiting(int count);

  /// No description provided for @attendanceSummaryTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yoklama Özeti'**
  String get attendanceSummaryTitle;

  /// No description provided for @attendanceEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Henüz yoklama kaydı yok.'**
  String get attendanceEmpty;

  /// No description provided for @metricLessons.
  ///
  /// In tr, this message translates to:
  /// **'Ders'**
  String get metricLessons;

  /// No description provided for @metricRecords.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt'**
  String get metricRecords;

  /// No description provided for @metricPresent.
  ///
  /// In tr, this message translates to:
  /// **'Geldi'**
  String get metricPresent;

  /// No description provided for @metricAbsent.
  ///
  /// In tr, this message translates to:
  /// **'Gelmedi'**
  String get metricAbsent;

  /// No description provided for @metricAttendanceRate.
  ///
  /// In tr, this message translates to:
  /// **'Katılım'**
  String get metricAttendanceRate;

  /// No description provided for @absenceNoteOne.
  ///
  /// In tr, this message translates to:
  /// **'1 yeni devamsızlık kaydı'**
  String get absenceNoteOne;

  /// No description provided for @absenceNoteMany.
  ///
  /// In tr, this message translates to:
  /// **'{count} yeni devamsızlık kaydı'**
  String absenceNoteMany(int count);

  /// No description provided for @financeSummaryTitle.
  ///
  /// In tr, this message translates to:
  /// **'Finansal Özet'**
  String get financeSummaryTitle;

  /// No description provided for @financeEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Henüz ödeme kaydı yok.'**
  String get financeEmpty;

  /// No description provided for @metricCollected.
  ///
  /// In tr, this message translates to:
  /// **'Tahsil'**
  String get metricCollected;

  /// No description provided for @metricPending.
  ///
  /// In tr, this message translates to:
  /// **'Bekleyen'**
  String get metricPending;

  /// No description provided for @metricOverdue.
  ///
  /// In tr, this message translates to:
  /// **'Geciken'**
  String get metricOverdue;

  /// No description provided for @clubCashTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kulüp Kasası'**
  String get clubCashTitle;

  /// No description provided for @ledgerAction.
  ///
  /// In tr, this message translates to:
  /// **'Defter'**
  String get ledgerAction;

  /// No description provided for @clubCashEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Henüz kasa hareketi yok.'**
  String get clubCashEmpty;

  /// No description provided for @metricBalance.
  ///
  /// In tr, this message translates to:
  /// **'Kasa'**
  String get metricBalance;

  /// No description provided for @metricIncome.
  ///
  /// In tr, this message translates to:
  /// **'Gelir'**
  String get metricIncome;

  /// No description provided for @metricExpense.
  ///
  /// In tr, this message translates to:
  /// **'Gider'**
  String get metricExpense;

  /// No description provided for @unpaidDuesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ödenmemiş Aidatlar ({count})'**
  String unpaidDuesTitle(int count);

  /// No description provided for @moreStudents.
  ///
  /// In tr, this message translates to:
  /// **'+{count} öğrenci daha'**
  String moreStudents(int count);

  /// No description provided for @latestAnnouncementTitle.
  ///
  /// In tr, this message translates to:
  /// **'Son Duyuru'**
  String get latestAnnouncementTitle;

  /// No description provided for @commonSave.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet'**
  String get commonSave;

  /// No description provided for @commonEdit.
  ///
  /// In tr, this message translates to:
  /// **'Düzenle'**
  String get commonEdit;

  /// No description provided for @saveChanges.
  ///
  /// In tr, this message translates to:
  /// **'Değişiklikleri Kaydet'**
  String get saveChanges;

  /// No description provided for @searchNoResults.
  ///
  /// In tr, this message translates to:
  /// **'Sonuç bulunamadı'**
  String get searchNoResults;

  /// No description provided for @searchNoResultsBody.
  ///
  /// In tr, this message translates to:
  /// **'Arama metnini değiştirerek tekrar dene.'**
  String get searchNoResultsBody;

  /// No description provided for @fieldFullName.
  ///
  /// In tr, this message translates to:
  /// **'Ad Soyad'**
  String get fieldFullName;

  /// No description provided for @fieldAge.
  ///
  /// In tr, this message translates to:
  /// **'Yaş'**
  String get fieldAge;

  /// No description provided for @fieldBranch.
  ///
  /// In tr, this message translates to:
  /// **'Branş'**
  String get fieldBranch;

  /// No description provided for @fieldParentPhone.
  ///
  /// In tr, this message translates to:
  /// **'Veli Telefonu'**
  String get fieldParentPhone;

  /// No description provided for @studentsSearchHint.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci ara'**
  String get studentsSearchHint;

  /// No description provided for @studentsEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz öğrenci yok'**
  String get studentsEmptyTitle;

  /// No description provided for @studentsEmptyAdmin.
  ///
  /// In tr, this message translates to:
  /// **'Yeni öğrenci eklemek için sağ alttaki + butonunu kullan.'**
  String get studentsEmptyAdmin;

  /// No description provided for @studentsEmptyViewer.
  ///
  /// In tr, this message translates to:
  /// **'Henüz öğrenci kaydı yok. Admin öğrenci eklediğinde burada görünecek.'**
  String get studentsEmptyViewer;

  /// No description provided for @studentSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'{branch} • {age} yaş\nVeli: {phone}'**
  String studentSubtitle(String branch, int age, String phone);

  /// No description provided for @studentDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenciyi Sil'**
  String get studentDeleteTitle;

  /// No description provided for @studentDeleteConfirm.
  ///
  /// In tr, this message translates to:
  /// **'{name} adlı öğrenciyi silmek istediğine emin misin'**
  String studentDeleteConfirm(String name);

  /// No description provided for @studentDeleted.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci silindi.'**
  String get studentDeleted;

  /// No description provided for @studentDetailTitle.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci Detayı'**
  String get studentDetailTitle;

  /// No description provided for @editStudent.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenciyi Düzenle'**
  String get editStudent;

  /// No description provided for @backToStudentList.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci Listesine Dön'**
  String get backToStudentList;

  /// No description provided for @addStudent.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Öğrenci Ekle'**
  String get addStudent;

  /// No description provided for @saveStudent.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenciyi Kaydet'**
  String get saveStudent;

  /// No description provided for @fullNameEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Ad soyad boş bırakılamaz.'**
  String get fullNameEmpty;

  /// No description provided for @fullNameMinLength.
  ///
  /// In tr, this message translates to:
  /// **'Ad soyad en az 3 karakter olmalıdır.'**
  String get fullNameMinLength;

  /// No description provided for @ageEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Yaş boş bırakılamaz.'**
  String get ageEmpty;

  /// No description provided for @ageMustBeNumber.
  ///
  /// In tr, this message translates to:
  /// **'Yaş sayı olmalıdır.'**
  String get ageMustBeNumber;

  /// No description provided for @agePositive.
  ///
  /// In tr, this message translates to:
  /// **'Yaş 0\'dan büyük olmalıdır.'**
  String get agePositive;

  /// No description provided for @ageTooHigh.
  ///
  /// In tr, this message translates to:
  /// **'Yaş çok yüksek görünüyor.'**
  String get ageTooHigh;

  /// No description provided for @fieldPhone.
  ///
  /// In tr, this message translates to:
  /// **'Telefon'**
  String get fieldPhone;

  /// No description provided for @branchEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Branş boş bırakılamaz.'**
  String get branchEmpty;

  /// No description provided for @coachesSearchHint.
  ///
  /// In tr, this message translates to:
  /// **'Antrenör ara'**
  String get coachesSearchHint;

  /// No description provided for @coachesEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz antrenör yok'**
  String get coachesEmptyTitle;

  /// No description provided for @coachesEmptyAdmin.
  ///
  /// In tr, this message translates to:
  /// **'Yeni antrenör eklemek için sağ alttaki + butonunu kullan.'**
  String get coachesEmptyAdmin;

  /// No description provided for @coachesEmptyViewer.
  ///
  /// In tr, this message translates to:
  /// **'Henüz antrenör kaydı yok. Admin antrenör eklediğinde burada görünecek.'**
  String get coachesEmptyViewer;

  /// No description provided for @coachSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'{branch} • {phone}'**
  String coachSubtitle(String branch, String phone);

  /// No description provided for @coachDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Antrenörü Sil'**
  String get coachDeleteTitle;

  /// No description provided for @coachDeleteConfirm.
  ///
  /// In tr, this message translates to:
  /// **'{name} adlı antrenörü silmek istediğine emin misin'**
  String coachDeleteConfirm(String name);

  /// No description provided for @coachDeleted.
  ///
  /// In tr, this message translates to:
  /// **'Antrenör silindi.'**
  String get coachDeleted;

  /// No description provided for @coachDetailTitle.
  ///
  /// In tr, this message translates to:
  /// **'Antrenör Detayı'**
  String get coachDetailTitle;

  /// No description provided for @editCoach.
  ///
  /// In tr, this message translates to:
  /// **'Antrenörü Düzenle'**
  String get editCoach;

  /// No description provided for @backToCoachList.
  ///
  /// In tr, this message translates to:
  /// **'Antrenör Listesine Dön'**
  String get backToCoachList;

  /// No description provided for @addCoach.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Antrenör Ekle'**
  String get addCoach;

  /// No description provided for @saveCoach.
  ///
  /// In tr, this message translates to:
  /// **'Antrenörü Kaydet'**
  String get saveCoach;

  /// No description provided for @phoneEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Telefon numarası boş bırakılamaz.'**
  String get phoneEmpty;

  /// No description provided for @phoneFormat.
  ///
  /// In tr, this message translates to:
  /// **'Telefon 05XXXXXXXXX formatında olmalıdır.'**
  String get phoneFormat;

  /// No description provided for @timeEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Saat boş bırakılamaz.'**
  String get timeEmpty;

  /// No description provided for @timeFormat.
  ///
  /// In tr, this message translates to:
  /// **'Saat 18:00 formatında olmalıdır.'**
  String get timeFormat;

  /// No description provided for @dateEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Tarih boş bırakılamaz.'**
  String get dateEmpty;

  /// No description provided for @dateFormat.
  ///
  /// In tr, this message translates to:
  /// **'Tarih 24.06.2026 formatında olmalı.'**
  String get dateFormat;

  /// No description provided for @branchRequired.
  ///
  /// In tr, this message translates to:
  /// **'Branş seçilmelidir.'**
  String get branchRequired;

  /// No description provided for @dayMonday.
  ///
  /// In tr, this message translates to:
  /// **'Pazartesi'**
  String get dayMonday;

  /// No description provided for @dayTuesday.
  ///
  /// In tr, this message translates to:
  /// **'Salı'**
  String get dayTuesday;

  /// No description provided for @dayWednesday.
  ///
  /// In tr, this message translates to:
  /// **'Çarşamba'**
  String get dayWednesday;

  /// No description provided for @dayThursday.
  ///
  /// In tr, this message translates to:
  /// **'Perşembe'**
  String get dayThursday;

  /// No description provided for @dayFriday.
  ///
  /// In tr, this message translates to:
  /// **'Cuma'**
  String get dayFriday;

  /// No description provided for @daySaturday.
  ///
  /// In tr, this message translates to:
  /// **'Cumartesi'**
  String get daySaturday;

  /// No description provided for @daySunday.
  ///
  /// In tr, this message translates to:
  /// **'Pazar'**
  String get daySunday;

  /// No description provided for @groupsSearchHint.
  ///
  /// In tr, this message translates to:
  /// **'Grup ara'**
  String get groupsSearchHint;

  /// No description provided for @groupsEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz grup yok'**
  String get groupsEmptyTitle;

  /// No description provided for @groupsEmptyAdd.
  ///
  /// In tr, this message translates to:
  /// **'Yeni grup eklemek için sağ alttaki + butonunu kullan.'**
  String get groupsEmptyAdd;

  /// No description provided for @groupsEmptyNoCoach.
  ///
  /// In tr, this message translates to:
  /// **'Grup eklemek için önce en az bir antrenör ekle.'**
  String get groupsEmptyNoCoach;

  /// No description provided for @groupsEmptyViewer.
  ///
  /// In tr, this message translates to:
  /// **'Henüz grup kaydı yok. Admin grup eklediğinde burada görünecek.'**
  String get groupsEmptyViewer;

  /// No description provided for @groupSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'{branch} • {schedule}\nAntrenör: {coach} • {count}/{capacity} öğrenci'**
  String groupSubtitle(
    String branch,
    String schedule,
    String coach,
    int count,
    int capacity,
  );

  /// No description provided for @groupDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Grubu Sil'**
  String get groupDeleteTitle;

  /// No description provided for @groupDeleteConfirm.
  ///
  /// In tr, this message translates to:
  /// **'{name} grubunu silmek istediğine emin misin'**
  String groupDeleteConfirm(String name);

  /// No description provided for @groupDeleted.
  ///
  /// In tr, this message translates to:
  /// **'Grup silindi.'**
  String get groupDeleted;

  /// No description provided for @groupDetailTitle.
  ///
  /// In tr, this message translates to:
  /// **'Grup Detayı'**
  String get groupDetailTitle;

  /// No description provided for @unknownStudent.
  ///
  /// In tr, this message translates to:
  /// **'Bilinmeyen öğrenci'**
  String get unknownStudent;

  /// No description provided for @fieldGroupName.
  ///
  /// In tr, this message translates to:
  /// **'Grup Adı'**
  String get fieldGroupName;

  /// No description provided for @fieldSchedule.
  ///
  /// In tr, this message translates to:
  /// **'Program'**
  String get fieldSchedule;

  /// No description provided for @fieldCapacity.
  ///
  /// In tr, this message translates to:
  /// **'Kapasite'**
  String get fieldCapacity;

  /// No description provided for @fieldDay.
  ///
  /// In tr, this message translates to:
  /// **'Gün'**
  String get fieldDay;

  /// No description provided for @fieldTime.
  ///
  /// In tr, this message translates to:
  /// **'Saat'**
  String get fieldTime;

  /// No description provided for @capacityPeople.
  ///
  /// In tr, this message translates to:
  /// **'{count}/{capacity} kişi'**
  String capacityPeople(int count, int capacity);

  /// No description provided for @membersTitle.
  ///
  /// In tr, this message translates to:
  /// **'Üyeler ({count})'**
  String membersTitle(int count);

  /// No description provided for @noMembersAssigned.
  ///
  /// In tr, this message translates to:
  /// **'Henüz öğrenci atanmadı.'**
  String get noMembersAssigned;

  /// No description provided for @editGroup.
  ///
  /// In tr, this message translates to:
  /// **'Grubu Düzenle'**
  String get editGroup;

  /// No description provided for @backToGroupList.
  ///
  /// In tr, this message translates to:
  /// **'Grup Listesine Dön'**
  String get backToGroupList;

  /// No description provided for @addGroup.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Grup Ekle'**
  String get addGroup;

  /// No description provided for @saveGroup.
  ///
  /// In tr, this message translates to:
  /// **'Grubu Kaydet'**
  String get saveGroup;

  /// No description provided for @groupsNeedCoach.
  ///
  /// In tr, this message translates to:
  /// **'Grup eklemek için önce en az bir antrenör eklemelisin.'**
  String get groupsNeedCoach;

  /// No description provided for @groupNameEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Grup adı boş bırakılamaz.'**
  String get groupNameEmpty;

  /// No description provided for @groupNameMinLength.
  ///
  /// In tr, this message translates to:
  /// **'Grup adı en az 2 karakter olmalıdır.'**
  String get groupNameMinLength;

  /// No description provided for @coachRequired.
  ///
  /// In tr, this message translates to:
  /// **'Antrenör seçmelisin.'**
  String get coachRequired;

  /// No description provided for @dayRequired.
  ///
  /// In tr, this message translates to:
  /// **'Gün seçmelisin.'**
  String get dayRequired;

  /// No description provided for @capacityEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Kapasite boş bırakılamaz.'**
  String get capacityEmpty;

  /// No description provided for @capacityMustBeNumber.
  ///
  /// In tr, this message translates to:
  /// **'Kapasite sayı olmalıdır.'**
  String get capacityMustBeNumber;

  /// No description provided for @capacityPositive.
  ///
  /// In tr, this message translates to:
  /// **'Kapasite 0\'dan büyük olmalıdır.'**
  String get capacityPositive;

  /// No description provided for @capacityMax.
  ///
  /// In tr, this message translates to:
  /// **'Kapasite 100\'den büyük olmamalıdır.'**
  String get capacityMax;

  /// No description provided for @membersLabel.
  ///
  /// In tr, this message translates to:
  /// **'Üyeler'**
  String get membersLabel;

  /// No description provided for @noStudentSelected.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci seçilmedi'**
  String get noStudentSelected;

  /// No description provided for @studentsSelected.
  ///
  /// In tr, this message translates to:
  /// **'{count} öğrenci seçildi'**
  String studentsSelected(int count);

  /// No description provided for @membersNeedStudents.
  ///
  /// In tr, this message translates to:
  /// **'Üye eklemek için önce öğrenci kaydı gerekir.'**
  String get membersNeedStudents;

  /// No description provided for @selectCoachFirst.
  ///
  /// In tr, this message translates to:
  /// **'Önce bir antrenör seçmelisin.'**
  String get selectCoachFirst;

  /// No description provided for @studentsExceedCapacity.
  ///
  /// In tr, this message translates to:
  /// **'Seçilen öğrenci sayısı ({count}) kapasiteyi ({capacity}) aşıyor.'**
  String studentsExceedCapacity(int count, int capacity);

  /// No description provided for @selectMembersTitle.
  ///
  /// In tr, this message translates to:
  /// **'Üye Seç'**
  String get selectMembersTitle;

  /// No description provided for @selectedCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} seçildi'**
  String selectedCount(int count);

  /// No description provided for @selectedCountOf.
  ///
  /// In tr, this message translates to:
  /// **'{count}/{capacity} seçildi'**
  String selectedCountOf(int count, int capacity);

  /// No description provided for @capacityExceeded.
  ///
  /// In tr, this message translates to:
  /// **'Kapasite aşıldı'**
  String get capacityExceeded;

  /// No description provided for @noStudentsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci yok'**
  String get noStudentsTitle;

  /// No description provided for @noStudentsBody.
  ///
  /// In tr, this message translates to:
  /// **'Önce öğrenci eklenmeli.'**
  String get noStudentsBody;

  /// No description provided for @studentBranchAge.
  ///
  /// In tr, this message translates to:
  /// **'{branch} • {age} yaş'**
  String studentBranchAge(String branch, int age);

  /// No description provided for @usersSearchHint.
  ///
  /// In tr, this message translates to:
  /// **'E-posta ara'**
  String get usersSearchHint;

  /// No description provided for @usersEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı yok'**
  String get usersEmptyTitle;

  /// No description provided for @usersEmptyBody.
  ///
  /// In tr, this message translates to:
  /// **'Henüz kayıtlı kullanıcı bulunmuyor.'**
  String get usersEmptyBody;

  /// No description provided for @noEmail.
  ///
  /// In tr, this message translates to:
  /// **'(e-posta yok)'**
  String get noEmail;

  /// No description provided for @youLabel.
  ///
  /// In tr, this message translates to:
  /// **'(sen)'**
  String get youLabel;

  /// No description provided for @cannotChangeOwnRole.
  ///
  /// In tr, this message translates to:
  /// **'Kendi rolünü buradan değiştiremezsin.'**
  String get cannotChangeOwnRole;

  /// No description provided for @roleUpdateError.
  ///
  /// In tr, this message translates to:
  /// **'Rol güncellenirken bir hata oluştu.'**
  String get roleUpdateError;

  /// No description provided for @userRoleUpdated.
  ///
  /// In tr, this message translates to:
  /// **'{email} → {role} olarak güncellendi.'**
  String userRoleUpdated(String email, String role);

  /// No description provided for @changeRoleTitle.
  ///
  /// In tr, this message translates to:
  /// **'Rol Değiştir'**
  String get changeRoleTitle;

  /// No description provided for @parentAssignHint.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci ataması \"Veliler\" ekranından yapılır.'**
  String get parentAssignHint;

  /// No description provided for @studentAssignHint.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci eşleştirmesi \"Öğrenci Hesapları\" ekranından yapılır.'**
  String get studentAssignHint;

  /// No description provided for @parentsEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz veli yok'**
  String get parentsEmptyTitle;

  /// No description provided for @parentsEmptyBody.
  ///
  /// In tr, this message translates to:
  /// **'Veli eklemek için sağ alttaki + butonunu kullan. Velinin önce uygulamaya kayıt olması gerekir.'**
  String get parentsEmptyBody;

  /// No description provided for @parentAdded.
  ///
  /// In tr, this message translates to:
  /// **'Veli eklendi.'**
  String get parentAdded;

  /// No description provided for @parentAddError.
  ///
  /// In tr, this message translates to:
  /// **'Veli eklenirken bir hata oluştu.'**
  String get parentAddError;

  /// No description provided for @removeParentTitle.
  ///
  /// In tr, this message translates to:
  /// **'Veliyi Kaldır'**
  String get removeParentTitle;

  /// No description provided for @removeParentConfirm.
  ///
  /// In tr, this message translates to:
  /// **'{email} artık veli olmayacak ve öğrenci eşleşmeleri silinecek. Devam edilsin mi?'**
  String removeParentConfirm(String email);

  /// No description provided for @removeAction.
  ///
  /// In tr, this message translates to:
  /// **'Kaldır'**
  String get removeAction;

  /// No description provided for @addParentTitle.
  ///
  /// In tr, this message translates to:
  /// **'Veli Ekle'**
  String get addParentTitle;

  /// No description provided for @addParentHint.
  ///
  /// In tr, this message translates to:
  /// **'Velinin uygulamaya kayıtlı e-posta adresini gir. Veli önce kendisi kayıt olmalıdır.'**
  String get addParentHint;

  /// No description provided for @noStudentAssigned.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci atanmadı'**
  String get noStudentAssigned;

  /// No description provided for @studentsAssigned.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenciler: {names}'**
  String studentsAssigned(String names);

  /// No description provided for @assignStudentsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci Ata'**
  String get assignStudentsTitle;

  /// No description provided for @accountAssignHeader.
  ///
  /// In tr, this message translates to:
  /// **'{label}: {email}'**
  String accountAssignHeader(String label, String email);
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
