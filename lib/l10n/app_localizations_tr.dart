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

  @override
  String get commonAll => 'Tümü';

  @override
  String get commonAdd => 'Ekle';

  @override
  String get commonDelete => 'Sil';

  @override
  String get viewAction => 'Görüntüle';

  @override
  String get statusPaid => 'Ödendi';

  @override
  String get statusPending => 'Bekliyor';

  @override
  String get statusOverdue => 'Gecikti';

  @override
  String get leaveStatusPending => 'Beklemede';

  @override
  String get leaveStatusApproved => 'Onaylandı';

  @override
  String get leaveStatusRejected => 'Reddedildi';

  @override
  String get drawerMainPanel => 'Ana Panel';

  @override
  String get sectionRecords => 'Kayıtlar';

  @override
  String get sectionOperations => 'Operasyon';

  @override
  String get sectionClub => 'Kulüp';

  @override
  String get sectionGeneral => 'Genel';

  @override
  String get sectionMyChild => 'Çocuğum';

  @override
  String get sectionMe => 'Ben';

  @override
  String get navStudents => 'Öğrenciler';

  @override
  String get navCoaches => 'Antrenörler';

  @override
  String get navGroups => 'Gruplar';

  @override
  String get navParents => 'Veliler';

  @override
  String get navStudentAccounts => 'Öğrenci Hesapları';

  @override
  String get navAttendance => 'Yoklama';

  @override
  String get navLeaveRequests => 'Mazeretler';

  @override
  String get navPayments => 'Ödemeler';

  @override
  String get navPerformance => 'Performans';

  @override
  String get navEvents => 'Etkinlikler';

  @override
  String get navEquipment => 'Depo';

  @override
  String get navAnnouncements => 'Duyurular';

  @override
  String get navClubCash => 'Kulüp Kasası';

  @override
  String get navReports => 'Raporlar';

  @override
  String get navSports => 'Sporlar';

  @override
  String get navUsers => 'Kullanıcılar';

  @override
  String get navReportAbsence => 'Mazeret Bildir';

  @override
  String get navMyPerformance => 'Performansım';

  @override
  String get navMyAttendance => 'Yoklamam';

  @override
  String get notificationsTooltip => 'Bildirimler';

  @override
  String get notifCategoryAnnouncement => 'Duyuru';

  @override
  String get notifCategoryPayment => 'Ödeme';

  @override
  String get notifCategoryLeave => 'Mazeret';

  @override
  String get notifCategoryAbsence => 'Devamsızlık';

  @override
  String get leaveWaitingApproval => 'Onay bekliyor';

  @override
  String notifLeaveTitle(String name) {
    return '$name • mazeret';
  }

  @override
  String notifAbsenceTitle(String name) {
    return '$name gelmedi';
  }

  @override
  String errorLoadingData(Object error) {
    return 'Veriler yüklenirken bir hata oluştu: $error';
  }

  @override
  String get reminderDialogTitle => 'Yeni Hatırlatıcı';

  @override
  String get reminderDialogHint => 'Örn: Salı günü malzeme siparişi ver';

  @override
  String get newAnnouncementPublished => 'Yeni bir duyuru yayınlandı.';

  @override
  String newAnnouncementsPublished(int count) {
    return '$count yeni duyuru yayınlandı.';
  }

  @override
  String get remindersTitle => 'Hızlı Hatırlatıcılar';

  @override
  String get remindersEmpty => 'Henüz bir hatırlatıcı eklemediniz.';

  @override
  String get aiIntroParent =>
      'Çocuğunuzun güncel özetini biliyorum. Aşağıdakilerden birini seçebilir ya da kendi sorunuzu yazabilirsiniz.';

  @override
  String get aiIntroStudent =>
      'Güncel durumunu biliyorum. Aşağıdakilerden birini seçebilir ya da kendi sorunu yazabilirsin.';

  @override
  String get aiIntroStaff =>
      'Kulübünüzün güncel özetini biliyorum. Aşağıdakilerden birini seçebilir ya da kendi sorunu yazabilirsin.';

  @override
  String get viewerWelcomeSubtitle => 'Spor okuluna hoş geldin.';

  @override
  String get requestPendingTitle => 'Başvurun inceleniyor';

  @override
  String requestPendingMessage(String role) {
    return '$role olma başvurun yönetici onayında. Onaylandığında ilgili panoya erişebileceksin.';
  }

  @override
  String get requestApprovedTitle => 'Başvurun onaylandı';

  @override
  String get requestApprovedMessage =>
      'Yeni rolünü görmek için çıkış yapıp tekrar giriş yapman yeterli.';

  @override
  String get roleNotAssignedTitle => 'Rolün henüz atanmadı';

  @override
  String get roleNotAssignedMessage =>
      'Yönetici sana bir rol atadığında ilgili panoya erişeceksin.';

  @override
  String get greetingMorning => 'Günaydın';

  @override
  String get greetingAfternoon => 'İyi günler';

  @override
  String get greetingEvening => 'İyi akşamlar';

  @override
  String get studentGreetingSubtitle => 'Güncel durumun aşağıda.';

  @override
  String parentGreetingSubtitleOne(String name) {
    return '$name • güncel özet';
  }

  @override
  String get parentGreetingSubtitleMany =>
      'Çocuklarınızın güncel özeti aşağıda.';

  @override
  String get staffGreetingSubtitle => 'Kulübünüzün güncel özeti aşağıda.';

  @override
  String highlightOverdueDues(String amount) {
    return 'Geciken aidat: $amount';
  }

  @override
  String get highlightGreatAttendance => 'Katılımın çok iyi, böyle devam! 🎯';

  @override
  String get highlightWatchAttendance => 'Katılıma biraz dikkat edelim';

  @override
  String get highlightPlannedEvent => 'Planlı etkinlik var, kaçırma';

  @override
  String get highlightAllGood => 'Her şey yolunda görünüyor 👍';

  @override
  String highlightPaymentsPending(int count) {
    return '$count ödeme takip bekliyor';
  }

  @override
  String highlightLeavePending(int count) {
    return '$count mazeret onay bekliyor';
  }

  @override
  String get highlightNoPending => 'Bekleyen bir işin yok, harika 👍';

  @override
  String get statPerformance => 'Performans';

  @override
  String get statEvent => 'Etkinlik';

  @override
  String get statAnnouncement => 'Duyuru';

  @override
  String get statMyChild => 'Çocuğum';

  @override
  String get statStudent => 'Öğrenci';

  @override
  String get statCoach => 'Antrenör';

  @override
  String get statGroup => 'Grup';

  @override
  String noteNew(int count) {
    return '$count yeni';
  }

  @override
  String noteWaiting(int count) {
    return '$count bekliyor';
  }

  @override
  String get attendanceSummaryTitle => 'Yoklama Özeti';

  @override
  String get attendanceEmpty => 'Henüz yoklama kaydı yok.';

  @override
  String get metricLessons => 'Ders';

  @override
  String get metricRecords => 'Kayıt';

  @override
  String get metricPresent => 'Geldi';

  @override
  String get metricAbsent => 'Gelmedi';

  @override
  String get metricAttendanceRate => 'Katılım';

  @override
  String get absenceNoteOne => '1 yeni devamsızlık kaydı';

  @override
  String absenceNoteMany(int count) {
    return '$count yeni devamsızlık kaydı';
  }

  @override
  String get financeSummaryTitle => 'Finansal Özet';

  @override
  String get financeEmpty => 'Henüz ödeme kaydı yok.';

  @override
  String get metricCollected => 'Tahsil';

  @override
  String get metricPending => 'Bekleyen';

  @override
  String get metricOverdue => 'Geciken';

  @override
  String get clubCashTitle => 'Kulüp Kasası';

  @override
  String get ledgerAction => 'Defter';

  @override
  String get clubCashEmpty => 'Henüz kasa hareketi yok.';

  @override
  String get metricBalance => 'Kasa';

  @override
  String get metricIncome => 'Gelir';

  @override
  String get metricExpense => 'Gider';

  @override
  String unpaidDuesTitle(int count) {
    return 'Ödenmemiş Aidatlar ($count)';
  }

  @override
  String moreStudents(int count) {
    return '+$count öğrenci daha';
  }

  @override
  String get latestAnnouncementTitle => 'Son Duyuru';

  @override
  String get commonSave => 'Kaydet';

  @override
  String get commonEdit => 'Düzenle';

  @override
  String get saveChanges => 'Değişiklikleri Kaydet';

  @override
  String get searchNoResults => 'Sonuç bulunamadı';

  @override
  String get searchNoResultsBody => 'Arama metnini değiştirerek tekrar dene.';

  @override
  String get fieldFullName => 'Ad Soyad';

  @override
  String get fieldAge => 'Yaş';

  @override
  String get fieldBranch => 'Branş';

  @override
  String get fieldParentPhone => 'Veli Telefonu';

  @override
  String get studentsSearchHint => 'Öğrenci ara';

  @override
  String get studentsEmptyTitle => 'Henüz öğrenci yok';

  @override
  String get studentsEmptyAdmin =>
      'Yeni öğrenci eklemek için sağ alttaki + butonunu kullan.';

  @override
  String get studentsEmptyViewer =>
      'Henüz öğrenci kaydı yok. Admin öğrenci eklediğinde burada görünecek.';

  @override
  String studentSubtitle(String branch, int age, String phone) {
    return '$branch • $age yaş\nVeli: $phone';
  }

  @override
  String get studentDeleteTitle => 'Öğrenciyi Sil';

  @override
  String studentDeleteConfirm(String name) {
    return '$name adlı öğrenciyi silmek istediğine emin misin';
  }

  @override
  String get studentDeleted => 'Öğrenci silindi.';

  @override
  String get studentDetailTitle => 'Öğrenci Detayı';

  @override
  String get editStudent => 'Öğrenciyi Düzenle';

  @override
  String get backToStudentList => 'Öğrenci Listesine Dön';

  @override
  String get addStudent => 'Yeni Öğrenci Ekle';

  @override
  String get saveStudent => 'Öğrenciyi Kaydet';

  @override
  String get fullNameEmpty => 'Ad soyad boş bırakılamaz.';

  @override
  String get fullNameMinLength => 'Ad soyad en az 3 karakter olmalıdır.';

  @override
  String get ageEmpty => 'Yaş boş bırakılamaz.';

  @override
  String get ageMustBeNumber => 'Yaş sayı olmalıdır.';

  @override
  String get agePositive => 'Yaş 0\'dan büyük olmalıdır.';

  @override
  String get ageTooHigh => 'Yaş çok yüksek görünüyor.';

  @override
  String get fieldPhone => 'Telefon';

  @override
  String get branchEmpty => 'Branş boş bırakılamaz.';

  @override
  String get coachesSearchHint => 'Antrenör ara';

  @override
  String get coachesEmptyTitle => 'Henüz antrenör yok';

  @override
  String get coachesEmptyAdmin =>
      'Yeni antrenör eklemek için sağ alttaki + butonunu kullan.';

  @override
  String get coachesEmptyViewer =>
      'Henüz antrenör kaydı yok. Admin antrenör eklediğinde burada görünecek.';

  @override
  String coachSubtitle(String branch, String phone) {
    return '$branch • $phone';
  }

  @override
  String get coachDeleteTitle => 'Antrenörü Sil';

  @override
  String coachDeleteConfirm(String name) {
    return '$name adlı antrenörü silmek istediğine emin misin';
  }

  @override
  String get coachDeleted => 'Antrenör silindi.';

  @override
  String get coachDetailTitle => 'Antrenör Detayı';

  @override
  String get editCoach => 'Antrenörü Düzenle';

  @override
  String get backToCoachList => 'Antrenör Listesine Dön';

  @override
  String get addCoach => 'Yeni Antrenör Ekle';

  @override
  String get saveCoach => 'Antrenörü Kaydet';

  @override
  String get phoneEmpty => 'Telefon numarası boş bırakılamaz.';

  @override
  String get phoneFormat => 'Telefon 05XXXXXXXXX formatında olmalıdır.';

  @override
  String get timeEmpty => 'Saat boş bırakılamaz.';

  @override
  String get timeFormat => 'Saat 18:00 formatında olmalıdır.';

  @override
  String get dateEmpty => 'Tarih boş bırakılamaz.';

  @override
  String get dateFormat => 'Tarih 24.06.2026 formatında olmalı.';

  @override
  String get branchRequired => 'Branş seçilmelidir.';

  @override
  String get dayMonday => 'Pazartesi';

  @override
  String get dayTuesday => 'Salı';

  @override
  String get dayWednesday => 'Çarşamba';

  @override
  String get dayThursday => 'Perşembe';

  @override
  String get dayFriday => 'Cuma';

  @override
  String get daySaturday => 'Cumartesi';

  @override
  String get daySunday => 'Pazar';

  @override
  String get groupsSearchHint => 'Grup ara';

  @override
  String get groupsEmptyTitle => 'Henüz grup yok';

  @override
  String get groupsEmptyAdd =>
      'Yeni grup eklemek için sağ alttaki + butonunu kullan.';

  @override
  String get groupsEmptyNoCoach =>
      'Grup eklemek için önce en az bir antrenör ekle.';

  @override
  String get groupsEmptyViewer =>
      'Henüz grup kaydı yok. Admin grup eklediğinde burada görünecek.';

  @override
  String groupSubtitle(
    String branch,
    String schedule,
    String coach,
    int count,
    int capacity,
  ) {
    return '$branch • $schedule\nAntrenör: $coach • $count/$capacity öğrenci';
  }

  @override
  String get groupDeleteTitle => 'Grubu Sil';

  @override
  String groupDeleteConfirm(String name) {
    return '$name grubunu silmek istediğine emin misin';
  }

  @override
  String get groupDeleted => 'Grup silindi.';

  @override
  String get groupDetailTitle => 'Grup Detayı';

  @override
  String get unknownStudent => 'Bilinmeyen öğrenci';

  @override
  String get fieldGroupName => 'Grup Adı';

  @override
  String get fieldSchedule => 'Program';

  @override
  String get fieldCapacity => 'Kapasite';

  @override
  String get fieldDay => 'Gün';

  @override
  String get fieldTime => 'Saat';

  @override
  String capacityPeople(int count, int capacity) {
    return '$count/$capacity kişi';
  }

  @override
  String membersTitle(int count) {
    return 'Üyeler ($count)';
  }

  @override
  String get noMembersAssigned => 'Henüz öğrenci atanmadı.';

  @override
  String get editGroup => 'Grubu Düzenle';

  @override
  String get backToGroupList => 'Grup Listesine Dön';

  @override
  String get addGroup => 'Yeni Grup Ekle';

  @override
  String get saveGroup => 'Grubu Kaydet';

  @override
  String get groupsNeedCoach =>
      'Grup eklemek için önce en az bir antrenör eklemelisin.';

  @override
  String get groupNameEmpty => 'Grup adı boş bırakılamaz.';

  @override
  String get groupNameMinLength => 'Grup adı en az 2 karakter olmalıdır.';

  @override
  String get coachRequired => 'Antrenör seçmelisin.';

  @override
  String get dayRequired => 'Gün seçmelisin.';

  @override
  String get capacityEmpty => 'Kapasite boş bırakılamaz.';

  @override
  String get capacityMustBeNumber => 'Kapasite sayı olmalıdır.';

  @override
  String get capacityPositive => 'Kapasite 0\'dan büyük olmalıdır.';

  @override
  String get capacityMax => 'Kapasite 100\'den büyük olmamalıdır.';

  @override
  String get membersLabel => 'Üyeler';

  @override
  String get noStudentSelected => 'Öğrenci seçilmedi';

  @override
  String studentsSelected(int count) {
    return '$count öğrenci seçildi';
  }

  @override
  String get membersNeedStudents =>
      'Üye eklemek için önce öğrenci kaydı gerekir.';

  @override
  String get selectCoachFirst => 'Önce bir antrenör seçmelisin.';

  @override
  String studentsExceedCapacity(int count, int capacity) {
    return 'Seçilen öğrenci sayısı ($count) kapasiteyi ($capacity) aşıyor.';
  }

  @override
  String get selectMembersTitle => 'Üye Seç';

  @override
  String selectedCount(int count) {
    return '$count seçildi';
  }

  @override
  String selectedCountOf(int count, int capacity) {
    return '$count/$capacity seçildi';
  }

  @override
  String get capacityExceeded => 'Kapasite aşıldı';

  @override
  String get noStudentsTitle => 'Öğrenci yok';

  @override
  String get noStudentsBody => 'Önce öğrenci eklenmeli.';

  @override
  String studentBranchAge(String branch, int age) {
    return '$branch • $age yaş';
  }

  @override
  String get usersSearchHint => 'E-posta ara';

  @override
  String get usersEmptyTitle => 'Kullanıcı yok';

  @override
  String get usersEmptyBody => 'Henüz kayıtlı kullanıcı bulunmuyor.';

  @override
  String get noEmail => '(e-posta yok)';

  @override
  String get youLabel => '(sen)';

  @override
  String get cannotChangeOwnRole => 'Kendi rolünü buradan değiştiremezsin.';

  @override
  String get roleUpdateError => 'Rol güncellenirken bir hata oluştu.';

  @override
  String userRoleUpdated(String email, String role) {
    return '$email → $role olarak güncellendi.';
  }

  @override
  String get changeRoleTitle => 'Rol Değiştir';

  @override
  String get parentAssignHint =>
      'Öğrenci ataması \"Veliler\" ekranından yapılır.';

  @override
  String get studentAssignHint =>
      'Öğrenci eşleştirmesi \"Öğrenci Hesapları\" ekranından yapılır.';

  @override
  String get parentsEmptyTitle => 'Henüz veli yok';

  @override
  String get parentsEmptyBody =>
      'Veli eklemek için sağ alttaki + butonunu kullan. Velinin önce uygulamaya kayıt olması gerekir.';

  @override
  String get parentAdded => 'Veli eklendi.';

  @override
  String get parentAddError => 'Veli eklenirken bir hata oluştu.';

  @override
  String get removeParentTitle => 'Veliyi Kaldır';

  @override
  String removeParentConfirm(String email) {
    return '$email artık veli olmayacak ve öğrenci eşleşmeleri silinecek. Devam edilsin mi?';
  }

  @override
  String get removeAction => 'Kaldır';

  @override
  String get addParentTitle => 'Veli Ekle';

  @override
  String get addParentHint =>
      'Velinin uygulamaya kayıtlı e-posta adresini gir. Veli önce kendisi kayıt olmalıdır.';

  @override
  String get noStudentAssigned => 'Öğrenci atanmadı';

  @override
  String studentsAssigned(String names) {
    return 'Öğrenciler: $names';
  }

  @override
  String get assignStudentsTitle => 'Öğrenci Ata';

  @override
  String accountAssignHeader(String label, String email) {
    return '$label: $email';
  }

  @override
  String get studentAccountAdded => 'Öğrenci hesabı eklendi.';

  @override
  String get studentAccountAddError =>
      'Öğrenci hesabı eklenirken bir hata oluştu.';

  @override
  String get removeAccountTitle => 'Hesabı Kaldır';

  @override
  String removeAccountConfirm(String email) {
    return '$email artık öğrenci olmayacak ve öğrenci eşleşmesi silinecek. Devam edilsin mi?';
  }

  @override
  String get studentAccountsEmptyTitle => 'Henüz öğrenci hesabı yok';

  @override
  String get studentAccountsEmptyBody =>
      'Öğrenci hesabı eklemek için sağ alttaki + butonunu kullan. Öğrencinin önce uygulamaya kayıt olması gerekir.';

  @override
  String get studentNotLinked => 'Öğrenci eşleşmedi';

  @override
  String studentLinked(String name) {
    return 'Öğrenci: $name';
  }

  @override
  String get addStudentAccountTitle => 'Öğrenci Hesabı Ekle';

  @override
  String get addStudentAccountHint =>
      'Öğrencinin uygulamaya kayıtlı e-posta adresini gir. Öğrenci önce kendisi kayıt olmalıdır.';

  @override
  String get accountLabelStudent => 'Öğrenci hesabı';

  @override
  String photoPickError(Object error) {
    return 'Fotoğraf seçilemedi: $error';
  }

  @override
  String get profileUpdated => 'Profil güncellendi.';

  @override
  String profileSaveError(Object error) {
    return 'Kaydedilemedi: $error';
  }

  @override
  String get pickPhoto => 'Fotoğraf seç';

  @override
  String get removePhoto => 'Fotoğrafı kaldır';

  @override
  String get nameTooLong => 'Ad çok uzun.';

  @override
  String get phoneTooLong => 'Telefon çok uzun.';

  @override
  String get commonSaving => 'Kaydediliyor...';

  @override
  String get attendanceDeleteTitle => 'Yoklamayı Sil';

  @override
  String attendanceDeleteConfirm(String group, String date) {
    return '$group - $date yoklama kaydını silmek istediğine emin misin';
  }

  @override
  String get attendanceDeleted => 'Yoklama kaydı silindi.';

  @override
  String get attendanceEmptyTitle => 'Henüz yoklama kaydı yok';

  @override
  String get attendanceEmptyAdmin =>
      'Yeni yoklama kaydı eklemek için sağ alttaki + butonunu kullan.';

  @override
  String get attendanceEmptyNoGroup =>
      'Yoklama almak için önce en az bir grup ve öğrenci ekle.';

  @override
  String get attendanceEmptyViewer =>
      'Henüz yoklama kaydı yok. Admin yoklama eklediğinde burada görünecek.';

  @override
  String attendanceCountLine(int present, int absent) {
    return 'Geldi: $present • Gelmedi: $absent';
  }

  @override
  String get takeAttendanceTitle => 'Yoklama Al';

  @override
  String get editAttendanceTitle => 'Yoklamayı Düzenle';

  @override
  String get selectGroupFirst => 'Önce bir grup seçmelisin.';

  @override
  String get fieldGroup => 'Grup';

  @override
  String get groupRequired => 'Grup seçmelisin.';

  @override
  String get fieldDate => 'Tarih';

  @override
  String studentsCountTitle(int count) {
    return 'Öğrenciler ($count)';
  }

  @override
  String get groupNoStudentsTitle => 'Bu grupta öğrenci yok.';

  @override
  String get groupNoStudentsBody => 'Grup detayından öğrenci ekleyebilirsin.';

  @override
  String get saveAttendance => 'Yoklamayı Kaydet';

  @override
  String get attendanceNeedGroupStudent =>
      'Yoklama almak için önce en az bir grup ve öğrenci eklemelisin.';

  @override
  String get attendanceDetailTitle => 'Yoklama Detayı';

  @override
  String get presentStudentsTitle => 'Gelen Öğrenciler';

  @override
  String get noPresentStudents => 'Gelen öğrenci yok.';

  @override
  String get absentStudentsTitle => 'Gelmeyen Öğrenciler';

  @override
  String get noAbsentStudents => 'Gelmeyen öğrenci yok.';

  @override
  String get backToAttendanceList => 'Yoklama Listesine Dön';

  @override
  String get childAttendanceEmptyTitle => 'Yoklama kaydı yok';

  @override
  String get childAttendanceEmptyBody =>
      'Çocuğunuzun bulunduğu bir yoklama kaydı henüz oluşturulmadı.';

  @override
  String attendedOfLessons(int total, int present) {
    return '$total dersin $present tanesine geldi';
  }

  @override
  String percentValue(int percent) {
    return '%$percent';
  }

  @override
  String get paymentDeleteTitle => 'Ödemeyi Sil';

  @override
  String paymentDeleteConfirm(String name, String period) {
    return '$name - $period ödeme kaydını silmek istediğine emin misin';
  }

  @override
  String get paymentDeleted => 'Ödeme kaydı silindi.';

  @override
  String get periodLabel => 'Dönem:';

  @override
  String get allPeriods => 'Tüm dönemler';

  @override
  String get paymentsSearchHint => 'Ödeme ara';

  @override
  String get paymentsEmptyTitle => 'Henüz ödeme kaydı yok';

  @override
  String get paymentsEmptyAdmin =>
      'Yeni ödeme kaydı eklemek için sağ alttaki + butonunu kullan.';

  @override
  String get paymentsEmptyNoStudent =>
      'Ödeme eklemek için önce en az bir öğrenci ekle.';

  @override
  String get paymentsEmptyViewer =>
      'Henüz ödeme kaydı yok. Admin ödeme eklediğinde burada görünecek.';

  @override
  String paymentsNoStatusResults(String status) {
    return '\"$status\" durumunda kayıt yok. Farklı bir filtre veya \"Tümü\" seç.';
  }

  @override
  String get remindTooltip => 'Hatırlatma gönder';

  @override
  String get noParentPhone => 'Öğrencinin veli telefonu kayıtlı değil.';

  @override
  String get paymentCollectedLabel => 'Tahsil edilen';

  @override
  String recordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kayıt',
      one: '1 kayıt',
    );
    return '$_temp0';
  }

  @override
  String get paymentDetailTitle => 'Ödeme Detayı';

  @override
  String get fieldPeriod => 'Ay / Dönem';

  @override
  String get fieldAmount => 'Tutar';

  @override
  String get fieldStatus => 'Durum';

  @override
  String get fieldNote => 'Not';

  @override
  String get noNote => 'Not yok.';

  @override
  String get remindViaWhatsApp => 'WhatsApp ile Hatırlat';

  @override
  String get editPaymentTitle => 'Ödemeyi Düzenle';

  @override
  String get backToPaymentList => 'Ödeme Listesine Dön';

  @override
  String get addPaymentTitle => 'Yeni Ödeme Ekle';

  @override
  String get paymentNeedStudent =>
      'Ödeme eklemek için önce en az bir öğrenci eklemelisin.';

  @override
  String get studentRequired => 'Öğrenci seçmelisin.';

  @override
  String get periodEmpty => 'Ay / dönem boş bırakılamaz.';

  @override
  String get amountEmpty => 'Tutar boş bırakılamaz.';

  @override
  String get amountMustBeNumber => 'Tutar sayı olmalıdır.';

  @override
  String get amountPositive => 'Tutar 0\'dan büyük olmalıdır.';

  @override
  String get amountTooHigh => 'Tutar çok yüksek görünüyor.';

  @override
  String get statusRequired => 'Durum seçmelisin.';

  @override
  String get noteHint => 'İsteğe bağlı not';

  @override
  String get selectStudentFirst => 'Önce bir öğrenci seçmelisin.';

  @override
  String get savePayment => 'Ödemeyi Kaydet';

  @override
  String get leaveReported => 'Mazeret bildirildi.';

  @override
  String get leaveDeleteTitle => 'Mazereti sil';

  @override
  String get leaveDeleteConfirm =>
      'Bu mazeret talebini silmek istiyor musunuz?';

  @override
  String get newLeave => 'Yeni Mazeret';

  @override
  String get leaveEmptyTitle => 'Mazeret yok';

  @override
  String get leaveEmptyParent =>
      'Henüz bir mazeret bildirmediniz. Sağ alttaki butonla ekleyebilirsiniz.';

  @override
  String get leaveEmptyStaff => 'Henüz gönderilmiş bir mazeret talebi yok.';

  @override
  String get cancelLeaveAction => 'İptal Et';

  @override
  String get reasonRequired => 'Lütfen bir gerekçe yazın.';

  @override
  String dateWithValue(String date) {
    return 'Tarih: $date';
  }

  @override
  String get fieldReason => 'Gerekçe';

  @override
  String get reasonHint => 'Örn: Sağlık raporu, aile ziyareti...';

  @override
  String get sendAction => 'Gönder';

  @override
  String get performanceAnalysisTitle => 'Performans Analizi';

  @override
  String recordAddError(Object error) {
    return 'Kayıt eklenemedi: $error';
  }

  @override
  String recordDeleteError(Object error) {
    return 'Kayıt silinemedi: $error';
  }

  @override
  String get recordDeleteTitle => 'Kaydı Sil';

  @override
  String performanceDeleteConfirm(String date) {
    return '$date tarihli performans kaydını silmek istediğine emin misin?';
  }

  @override
  String get noStudentFound => 'Öğrenci bulunamadı';

  @override
  String get performanceEmptyManage =>
      'Performans girmek için önce öğrenci eklenmeli.';

  @override
  String get performanceEmptyParent =>
      'Hesabına henüz öğrenci atanmamış. Lütfen spor okulu yönetimiyle iletişime geç.';

  @override
  String get addPerformance => 'Performans Ekle';

  @override
  String get noPerformanceForStudent =>
      'Bu öğrenci için henüz performans kaydı yok.';

  @override
  String get comparisonByDate => 'Tarihlere Göre Karşılaştırma';

  @override
  String get recordsTitle => 'Kayıtlar';

  @override
  String get selectAction => 'Seç';

  @override
  String get scoresLabel => 'Puanlar (0-100)';

  @override
  String get metricJump => 'Sıçrama';

  @override
  String get metricSpeed => 'Sürat';

  @override
  String get metricEndurance => 'Dayanıklılık';

  @override
  String get metricFlexibility => 'Esneklik';

  @override
  String get metricBallControl => 'Top Hakimiyeti';

  @override
  String get announcementDeleteTitle => 'Duyuruyu Sil';

  @override
  String announcementDeleteConfirm(String title) {
    return '$title başlıklı duyuruyu silmek istediğine emin misin';
  }

  @override
  String get announcementDeleted => 'Duyuru silindi.';

  @override
  String get announcementsEmptyTitle => 'Henüz duyuru yok';

  @override
  String get announcementsEmptyAdmin =>
      'Yeni duyuru eklemek için sağ alttaki + butonunu kullan.';

  @override
  String get announcementsEmptyViewer =>
      'Henüz duyuru yok. Admin duyuru eklediğinde burada görünecek.';

  @override
  String get announcementDetailTitle => 'Duyuru Detayı';

  @override
  String get fieldTitle => 'Başlık';

  @override
  String get fieldTargetAudience => 'Hedef Kitle';

  @override
  String get editAnnouncementTitle => 'Duyuruyu Düzenle';

  @override
  String get backToAnnouncementList => 'Duyuru Listesine Dön';

  @override
  String get addAnnouncementTitle => 'Yeni Duyuru Ekle';

  @override
  String get titleHint => 'Antrenman saati değişikliği';

  @override
  String get titleEmpty => 'Başlık boş bırakılamaz.';

  @override
  String get titleMinLength => 'Başlık en az 3 karakter olmalıdır.';

  @override
  String get fieldContent => 'İçerik';

  @override
  String get contentHint => 'Duyuru içeriğini yaz...';

  @override
  String get contentEmpty => 'İçerik boş bırakılamaz.';

  @override
  String get contentMinLength => 'İçerik en az 10 karakter olmalıdır.';

  @override
  String get audienceRequired => 'Hedef kitle seçmelisin.';

  @override
  String get saveAnnouncement => 'Duyuruyu Kaydet';

  @override
  String get audienceEveryone => 'Herkes';

  @override
  String eventAddError(Object error) {
    return 'Etkinlik eklenemedi: $error';
  }

  @override
  String eventDeleteError(Object error) {
    return 'Etkinlik silinemedi: $error';
  }

  @override
  String get eventDeleteTitle => 'Etkinliği Sil';

  @override
  String eventDeleteConfirm(String title) {
    return '$title etkinliğini silmek istiyor musun?';
  }

  @override
  String get eventsEmptyTitle => 'Planlanan etkinlik yok';

  @override
  String get eventsEmptyManage =>
      'Yeni etkinlik eklemek için sağ alttaki + butonunu kullan.';

  @override
  String get eventsEmptyViewer =>
      'Antrenörler etkinlik planladığında burada görünecek.';

  @override
  String get addEvent => 'Etkinlik Ekle';

  @override
  String get selectAttendanceFirst => 'Lütfen önce katılım durumu seç.';

  @override
  String get responseAlreadySaved => 'Cevabın zaten kayıtlı.';

  @override
  String responseSendError(Object error) {
    return 'Cevap gönderilemedi: $error';
  }

  @override
  String get responseSent => 'Cevabın gönderildi.';

  @override
  String attendingCount(int count) {
    return 'Katılacak: $count';
  }

  @override
  String notAttendingCount(int count) {
    return 'Katılmayacak: $count';
  }

  @override
  String eventDateLabel(String date) {
    return 'Etkinlik Tarihi: $date';
  }

  @override
  String get willAttend => 'Katılacak';

  @override
  String get willNotAttend => 'Katılmayacak';

  @override
  String get sendingLabel => 'Gönderiliyor...';

  @override
  String get sentLabel => 'Gönderildi';

  @override
  String get addEventTitle => 'Yeni Etkinlik';

  @override
  String get fieldEventName => 'Etkinlik Adı';

  @override
  String get eventNameHint => 'Hazırlık Maçı';

  @override
  String get eventNameEmpty => 'Etkinlik adı boş bırakılamaz.';

  @override
  String get fieldDescriptionOptional => 'Açıklama (isteğe bağlı)';

  @override
  String get saveEvent => 'Etkinliği Kaydet';
}
