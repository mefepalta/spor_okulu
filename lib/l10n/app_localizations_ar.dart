// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get commonOk => 'حسناً';

  @override
  String get commonResend => 'إعادة الإرسال';

  @override
  String get roleAdmin => 'المدير';

  @override
  String get roleCoach => 'المدرب';

  @override
  String get roleParent => 'ولي الأمر';

  @override
  String get roleStudent => 'الطالب';

  @override
  String get roleViewer => 'مشاهد';

  @override
  String get roleUnknown => 'غير معروف';

  @override
  String get loginHeading => 'إدارة مدرسة الرياضة';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get emailHint => 'example@sporokulu.com';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get loginLoading => 'جارٍ تسجيل الدخول...';

  @override
  String get forgotPassword => 'نسيت كلمة المرور';

  @override
  String get noAccountRegister => 'ليس لديك حساب؟ سجّل الآن';

  @override
  String get emailEmpty => 'لا يمكن ترك البريد الإلكتروني فارغاً.';

  @override
  String get emailInvalid => 'أدخل بريداً إلكترونياً صحيحاً.';

  @override
  String get passwordEmpty => 'لا يمكن ترك كلمة المرور فارغة.';

  @override
  String get passwordMinLength =>
      'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.';

  @override
  String get emailNotVerifiedTitle => 'البريد الإلكتروني غير مُوثَّق';

  @override
  String get emailNotVerifiedBody =>
      'لتفعيل حسابك، انقر على رابط التحقق المُرسَل إلى بريدك الإلكتروني. إذا لم يصلك، يمكننا إعادة إرساله.';

  @override
  String get verificationResent =>
      'تمت إعادة إرسال بريد التحقق. تحقق من مجلد الرسائل غير المرغوب فيها أيضاً.';

  @override
  String get rejectedTitle => 'تم رفض طلبك';

  @override
  String get rejectedBody =>
      'تم رفض طلب دورك من قبل أحد المديرين. يتم إغلاق حسابك.';

  @override
  String get resetPasswordNeedEmail =>
      'أدخل عنوان بريدك الإلكتروني أولاً لإعادة تعيين كلمة المرور.';

  @override
  String get resetPasswordSent =>
      'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.';

  @override
  String get resetPasswordError => 'حدث خطأ أثناء إعادة تعيين كلمة المرور.';

  @override
  String get resetInvalidEmail => 'أدخل عنوان بريد إلكتروني صحيح.';

  @override
  String get resetUserNotFound =>
      'لا يوجد مستخدم مسجَّل بهذا البريد الإلكتروني.';

  @override
  String get userNotFound => 'لم يتم العثور على المستخدم.';

  @override
  String loginCheckError(Object error) {
    return 'حدث خطأ أثناء التحقق من تسجيل الدخول: $error';
  }

  @override
  String get authInvalidEmail => 'عنوان البريد الإلكتروني غير صالح.';

  @override
  String get authUserDisabled => 'حساب هذا المستخدم معطَّل.';

  @override
  String get authWrongCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get authNetwork =>
      'تعذّر الاتصال بالإنترنت. تحقق من اتصالك وحاول مجدداً.';

  @override
  String get authOperationNotAllowed =>
      'تسجيل الدخول بالبريد الإلكتروني/كلمة المرور غير مُفعَّل في Firebase Console.';

  @override
  String get authConfigNotFound =>
      'لم يتم العثور على إعدادات Firebase Authentication. تحقق من إعدادات Firebase Console.';

  @override
  String get authAppNotAuthorized =>
      'لا يبدو أن تطبيق Android هذا مُصرَّح له بمشروع Firebase.';

  @override
  String get authInvalidApiKey => 'يبدو أن مفتاح Firebase API غير صالح.';

  @override
  String get authTooManyRequests =>
      'عدد كبير من محاولات تسجيل الدخول. حاول مرة أخرى لاحقاً.';

  @override
  String authGenericWithCode(String code) {
    return 'فشل تسجيل الدخول. رمز الخطأ: $code';
  }

  @override
  String get registerTitle => 'التسجيل';

  @override
  String get registerHeading => 'إنشاء حساب جديد';

  @override
  String get firstNameLabel => 'الاسم';

  @override
  String get lastNameLabel => 'اسم العائلة';

  @override
  String get passwordAgainLabel => 'تأكيد كلمة المرور';

  @override
  String get passwordAgainEmpty => 'لا يمكن ترك تأكيد كلمة المرور فارغاً.';

  @override
  String get passwordsDontMatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get accountType => 'نوع حسابك';

  @override
  String get selectionSentToAdmin => 'سيُرسَل اختيارك لموافقة المدير.';

  @override
  String get registerButton => 'التسجيل';

  @override
  String get registerLoading => 'جارٍ الحفظ...';

  @override
  String requiredField(String label) {
    return 'لا يمكن ترك $label فارغاً.';
  }

  @override
  String get registerSuccess =>
      'تم إنشاء الحساب. يُرجى النقر على رابط التحقق المُرسَل إلى بريدك الإلكتروني. تم إرسال طلب دورك لموافقة المدير.';

  @override
  String get registerGenericError => 'حدث خطأ أثناء التسجيل.';

  @override
  String get emailAlreadyInUse => 'هذا البريد الإلكتروني مُستخدَم بالفعل.';

  @override
  String get passwordTooWeak =>
      'كلمة المرور ضعيفة جداً. استخدم 6 أحرف على الأقل.';

  @override
  String registerErrorWith(Object error) {
    return 'خطأ في التسجيل: $error';
  }

  @override
  String get userNotCreated => 'تعذّر إنشاء المستخدم.';

  @override
  String get roleRequestsTitle => 'طلبات الأدوار';

  @override
  String get noPendingRequests => 'لا توجد طلبات معلّقة';

  @override
  String get noPendingRequestsBody =>
      'تظهر هنا طلبات الأدوار من التسجيلات الجديدة.';

  @override
  String get approveTitle => 'الموافقة على الطلب';

  @override
  String approveConfirm(String name, String role) {
    return 'سيتم ترقية $name إلى $role. هل توافق؟';
  }

  @override
  String get approveAction => 'موافقة';

  @override
  String approvedSnack(String name, String role) {
    return 'أصبح $name الآن $role.';
  }

  @override
  String get rejectTitle => 'رفض الطلب';

  @override
  String rejectConfirm(String name) {
    return 'سيتم رفض طلب $name وحذف الحساب. لا يمكن التراجع عن هذا. هل تريد المتابعة؟';
  }

  @override
  String get rejectAction => 'رفض';

  @override
  String rejectedSnack(String name) {
    return 'تم رفض طلب $name.';
  }

  @override
  String requestLabel(String role) {
    return 'الطلب: $role';
  }

  @override
  String get genericOperationError => 'حدث خطأ أثناء العملية.';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get profileUserFallback => 'المستخدم';

  @override
  String get roleDescAdmin => 'يمكنه إضافة جميع السجلات وتعديلها وحذفها.';

  @override
  String get roleDescCoach =>
      'يمكنه إدارة سجلات الحضور والإعلانات. ويمكنه عرض السجلات الأخرى.';

  @override
  String get roleDescParent =>
      'يمكنه متابعة أداء طفله والرد على المشاركة في الفعاليات.';

  @override
  String get roleDescStudent => 'يمكنه عرض معلومات حضوره وأدائه الخاصة.';

  @override
  String get roleDescViewer => 'يمكنه عرض السجلات لكن لا يمكنه إجراء تغييرات.';

  @override
  String get childrenSectionStudent => 'معلومات الطالب الخاصة بي';

  @override
  String get childrenSectionParent => 'طلابي';

  @override
  String get authorityTitle => 'الصلاحية';

  @override
  String get appearanceTitle => 'المظهر';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get backgroundEffectTitle => 'تأثير الخلفية';

  @override
  String get backgroundEffectDesc =>
      'مرتفع: موجات + جزيئات · متوسط: موجات فقط · منخفض: خلفية سادة.';

  @override
  String get backgroundHigh => 'مرتفع';

  @override
  String get backgroundMedium => 'متوسط';

  @override
  String get backgroundLow => 'منخفض';

  @override
  String get languageTitle => 'اللغة';

  @override
  String get languageSystem => 'النظام';

  @override
  String get editAccount => 'تعديل الحساب';

  @override
  String get contactUs => 'تواصل معنا';

  @override
  String get whatsappSupport => 'دعم واتساب';

  @override
  String get kvkkTitle => 'إشعار حماية البيانات الشخصية';

  @override
  String get termsTitle => 'شروط الاستخدام';

  @override
  String get privacyTitle => 'سياسة الخصوصية';

  @override
  String get appVersionLabel => 'إصدار التطبيق';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get commonAll => 'الكل';

  @override
  String get commonAdd => 'إضافة';

  @override
  String get commonDelete => 'حذف';

  @override
  String get viewAction => 'عرض';

  @override
  String get statusPaid => 'مدفوع';

  @override
  String get statusPending => 'قيد الانتظار';

  @override
  String get statusOverdue => 'متأخر';

  @override
  String get leaveStatusPending => 'قيد الانتظار';

  @override
  String get leaveStatusApproved => 'مقبول';

  @override
  String get leaveStatusRejected => 'مرفوض';

  @override
  String get drawerMainPanel => 'اللوحة الرئيسية';

  @override
  String get sectionRecords => 'السجلات';

  @override
  String get sectionOperations => 'العمليات';

  @override
  String get sectionClub => 'النادي';

  @override
  String get sectionGeneral => 'عام';

  @override
  String get sectionMyChild => 'طفلي';

  @override
  String get sectionMe => 'أنا';

  @override
  String get navStudents => 'الطلاب';

  @override
  String get navCoaches => 'المدربون';

  @override
  String get navGroups => 'المجموعات';

  @override
  String get navParents => 'أولياء الأمور';

  @override
  String get navStudentAccounts => 'حسابات الطلاب';

  @override
  String get navAttendance => 'الحضور';

  @override
  String get navLeaveRequests => 'طلبات الغياب';

  @override
  String get navPayments => 'المدفوعات';

  @override
  String get navPerformance => 'الأداء';

  @override
  String get navEvents => 'الفعاليات';

  @override
  String get navEquipment => 'المخزن';

  @override
  String get navAnnouncements => 'الإعلانات';

  @override
  String get navClubCash => 'صندوق النادي';

  @override
  String get navReports => 'التقارير';

  @override
  String get navSports => 'الرياضات';

  @override
  String get navUsers => 'المستخدمون';

  @override
  String get navReportAbsence => 'الإبلاغ عن غياب';

  @override
  String get navMyPerformance => 'أدائي';

  @override
  String get navMyAttendance => 'حضوري';

  @override
  String get notificationsTooltip => 'الإشعارات';

  @override
  String get notifCategoryAnnouncement => 'إعلان';

  @override
  String get notifCategoryPayment => 'دفعة';

  @override
  String get notifCategoryLeave => 'غياب';

  @override
  String get notifCategoryAbsence => 'غياب';

  @override
  String get leaveWaitingApproval => 'بانتظار الموافقة';

  @override
  String notifLeaveTitle(String name) {
    return '$name • غياب';
  }

  @override
  String notifAbsenceTitle(String name) {
    return '$name لم يحضر';
  }

  @override
  String errorLoadingData(Object error) {
    return 'حدث خطأ أثناء تحميل البيانات: $error';
  }

  @override
  String get reminderDialogTitle => 'تذكير جديد';

  @override
  String get reminderDialogHint => 'مثال: اطلب المستلزمات يوم الثلاثاء';

  @override
  String get newAnnouncementPublished => 'تم نشر إعلان جديد.';

  @override
  String newAnnouncementsPublished(int count) {
    return 'تم نشر $count إعلانات جديدة.';
  }

  @override
  String get remindersTitle => 'تذكيرات سريعة';

  @override
  String get remindersEmpty => 'لم تُضِف أي تذكير بعد.';

  @override
  String get aiIntroParent =>
      'أعرف الملخص الحالي لطفلك. يمكنك اختيار أحد الخيارات أدناه أو كتابة سؤالك الخاص.';

  @override
  String get aiIntroStudent =>
      'أعرف وضعك الحالي. يمكنك اختيار أحد الخيارات أدناه أو كتابة سؤالك الخاص.';

  @override
  String get aiIntroStaff =>
      'أعرف الملخص الحالي لناديك. يمكنك اختيار أحد الخيارات أدناه أو كتابة سؤالك الخاص.';

  @override
  String get viewerWelcomeSubtitle => 'مرحباً بك في مدرسة الرياضة.';

  @override
  String get requestPendingTitle => 'طلبك قيد المراجعة';

  @override
  String requestPendingMessage(String role) {
    return 'طلبك لتصبح $role بانتظار موافقة المدير. بمجرد الموافقة، ستتمكن من الوصول إلى اللوحة المعنية.';
  }

  @override
  String get requestApprovedTitle => 'تمت الموافقة على طلبك';

  @override
  String get requestApprovedMessage =>
      'فقط سجّل الخروج ثم عُد لتسجيل الدخول لرؤية دورك الجديد.';

  @override
  String get roleNotAssignedTitle => 'لم يتم تعيين دورك بعد';

  @override
  String get roleNotAssignedMessage =>
      'عندما يعيّن لك المدير دوراً، ستصل إلى اللوحة المعنية.';

  @override
  String get greetingMorning => 'صباح الخير';

  @override
  String get greetingAfternoon => 'طاب يومك';

  @override
  String get greetingEvening => 'مساء الخير';

  @override
  String get studentGreetingSubtitle => 'وضعك الحالي في الأسفل.';

  @override
  String parentGreetingSubtitleOne(String name) {
    return '$name • ملخص حالي';
  }

  @override
  String get parentGreetingSubtitleMany => 'الملخص الحالي لأطفالك في الأسفل.';

  @override
  String get staffGreetingSubtitle => 'الملخص الحالي لناديك في الأسفل.';

  @override
  String highlightOverdueDues(String amount) {
    return 'رسوم متأخرة: $amount';
  }

  @override
  String get highlightGreatAttendance => 'حضورك ممتاز، واصل هكذا! 🎯';

  @override
  String get highlightWatchAttendance => 'لننتبه قليلاً للحضور';

  @override
  String get highlightPlannedEvent => 'هناك فعالية مُخطَّطة، لا تفوّتها';

  @override
  String get highlightAllGood => 'يبدو كل شيء على ما يُرام 👍';

  @override
  String highlightPaymentsPending(int count) {
    return '$count مدفوعات بانتظار المتابعة';
  }

  @override
  String highlightLeavePending(int count) {
    return '$count طلبات غياب بانتظار الموافقة';
  }

  @override
  String get highlightNoPending => 'لا توجد مهام معلّقة لديك، رائع 👍';

  @override
  String get statPerformance => 'الأداء';

  @override
  String get statEvent => 'فعالية';

  @override
  String get statAnnouncement => 'إعلان';

  @override
  String get statMyChild => 'طفلي';

  @override
  String get statStudent => 'طالب';

  @override
  String get statCoach => 'مدرب';

  @override
  String get statGroup => 'مجموعة';

  @override
  String noteNew(int count) {
    return '$count جديد';
  }

  @override
  String noteWaiting(int count) {
    return '$count قيد الانتظار';
  }

  @override
  String get attendanceSummaryTitle => 'ملخص الحضور';

  @override
  String get attendanceEmpty => 'لا توجد سجلات حضور بعد.';

  @override
  String get metricLessons => 'حصص';

  @override
  String get metricRecords => 'سجلات';

  @override
  String get metricPresent => 'حاضر';

  @override
  String get metricAbsent => 'غائب';

  @override
  String get metricAttendanceRate => 'الحضور';

  @override
  String get absenceNoteOne => 'سجل غياب جديد واحد';

  @override
  String absenceNoteMany(int count) {
    return '$count سجلات غياب جديدة';
  }

  @override
  String get financeSummaryTitle => 'الملخص المالي';

  @override
  String get financeEmpty => 'لا توجد سجلات مدفوعات بعد.';

  @override
  String get metricCollected => 'محصَّل';

  @override
  String get metricPending => 'معلّق';

  @override
  String get metricOverdue => 'متأخر';

  @override
  String get clubCashTitle => 'صندوق النادي';

  @override
  String get ledgerAction => 'الدفتر';

  @override
  String get clubCashEmpty => 'لا توجد حركات صندوق بعد.';

  @override
  String get metricBalance => 'الرصيد';

  @override
  String get metricIncome => 'الدخل';

  @override
  String get metricExpense => 'المصروف';

  @override
  String unpaidDuesTitle(int count) {
    return 'رسوم غير مدفوعة ($count)';
  }

  @override
  String moreStudents(int count) {
    return '+$count طلاب آخرون';
  }

  @override
  String get latestAnnouncementTitle => 'أحدث إعلان';

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonEdit => 'تعديل';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get searchNoResults => 'لا توجد نتائج';

  @override
  String get searchNoResultsBody => 'جرّب تغيير نص البحث.';

  @override
  String get fieldFullName => 'الاسم الكامل';

  @override
  String get fieldAge => 'العمر';

  @override
  String get fieldBranch => 'الفرع';

  @override
  String get fieldParentPhone => 'هاتف ولي الأمر';

  @override
  String get studentsSearchHint => 'ابحث عن طالب';

  @override
  String get studentsEmptyTitle => 'لا يوجد طلاب بعد';

  @override
  String get studentsEmptyAdmin =>
      'استخدم زر + في أسفل اليمين لإضافة طالب جديد.';

  @override
  String get studentsEmptyViewer =>
      'لا توجد سجلات طلاب بعد. ستظهر هنا عندما يضيف المدير طالباً.';

  @override
  String studentSubtitle(String branch, int age, String phone) {
    return '$branch • $age سنة\nولي الأمر: $phone';
  }

  @override
  String get studentDeleteTitle => 'حذف الطالب';

  @override
  String studentDeleteConfirm(String name) {
    return 'هل أنت متأكد من حذف الطالب $name';
  }

  @override
  String get studentDeleted => 'تم حذف الطالب.';

  @override
  String get studentDetailTitle => 'تفاصيل الطالب';

  @override
  String get editStudent => 'تعديل الطالب';

  @override
  String get backToStudentList => 'العودة إلى قائمة الطلاب';

  @override
  String get addStudent => 'إضافة طالب جديد';

  @override
  String get saveStudent => 'حفظ الطالب';

  @override
  String get fullNameEmpty => 'لا يمكن ترك الاسم الكامل فارغاً.';

  @override
  String get fullNameMinLength =>
      'يجب أن يتكون الاسم الكامل من 3 أحرف على الأقل.';

  @override
  String get ageEmpty => 'لا يمكن ترك العمر فارغاً.';

  @override
  String get ageMustBeNumber => 'يجب أن يكون العمر رقماً.';

  @override
  String get agePositive => 'يجب أن يكون العمر أكبر من 0.';

  @override
  String get ageTooHigh => 'يبدو العمر مرتفعاً جداً.';

  @override
  String get fieldPhone => 'الهاتف';

  @override
  String get branchEmpty => 'لا يمكن ترك الفرع فارغاً.';

  @override
  String get coachesSearchHint => 'ابحث عن مدرب';

  @override
  String get coachesEmptyTitle => 'لا يوجد مدربون بعد';

  @override
  String get coachesEmptyAdmin =>
      'استخدم زر + في أسفل اليمين لإضافة مدرب جديد.';

  @override
  String get coachesEmptyViewer =>
      'لا توجد سجلات مدربين بعد. ستظهر هنا عندما يضيف المدير مدرباً.';

  @override
  String coachSubtitle(String branch, String phone) {
    return '$branch • $phone';
  }

  @override
  String get coachDeleteTitle => 'حذف المدرب';

  @override
  String coachDeleteConfirm(String name) {
    return 'هل أنت متأكد من حذف المدرب $name';
  }

  @override
  String get coachDeleted => 'تم حذف المدرب.';

  @override
  String get coachDetailTitle => 'تفاصيل المدرب';

  @override
  String get editCoach => 'تعديل المدرب';

  @override
  String get backToCoachList => 'العودة إلى قائمة المدربين';

  @override
  String get addCoach => 'إضافة مدرب جديد';

  @override
  String get saveCoach => 'حفظ المدرب';

  @override
  String get phoneEmpty => 'لا يمكن ترك رقم الهاتف فارغاً.';

  @override
  String get phoneFormat => 'يجب أن يكون الهاتف بصيغة 05XXXXXXXXX.';

  @override
  String get timeEmpty => 'لا يمكن ترك الوقت فارغاً.';

  @override
  String get timeFormat => 'يجب أن يكون الوقت بصيغة 18:00.';

  @override
  String get dateEmpty => 'لا يمكن ترك التاريخ فارغاً.';

  @override
  String get dateFormat => 'يجب أن يكون التاريخ بصيغة 24.06.2026.';

  @override
  String get branchRequired => 'يجب اختيار فرع.';

  @override
  String get dayMonday => 'الاثنين';

  @override
  String get dayTuesday => 'الثلاثاء';

  @override
  String get dayWednesday => 'الأربعاء';

  @override
  String get dayThursday => 'الخميس';

  @override
  String get dayFriday => 'الجمعة';

  @override
  String get daySaturday => 'السبت';

  @override
  String get daySunday => 'الأحد';

  @override
  String get dayShortMon => 'إثن';

  @override
  String get dayShortTue => 'ثلا';

  @override
  String get dayShortWed => 'أرب';

  @override
  String get dayShortThu => 'خمي';

  @override
  String get dayShortFri => 'جمع';

  @override
  String get dayShortSat => 'سبت';

  @override
  String get dayShortSun => 'أحد';

  @override
  String get groupsSearchHint => 'ابحث عن مجموعة';

  @override
  String get groupsEmptyTitle => 'لا توجد مجموعات بعد';

  @override
  String get groupsEmptyAdd =>
      'استخدم زر + في أسفل اليمين لإضافة مجموعة جديدة.';

  @override
  String get groupsEmptyNoCoach =>
      'أضف مدرباً واحداً على الأقل أولاً لإنشاء مجموعة.';

  @override
  String get groupsEmptyViewer =>
      'لا توجد سجلات مجموعات بعد. ستظهر هنا عندما يضيف المدير مجموعة.';

  @override
  String groupSubtitle(String branch, String coach, int count, int capacity) {
    return '$branch\nالمدرب: $coach • $count/$capacity طلاب';
  }

  @override
  String get groupDeleteTitle => 'حذف المجموعة';

  @override
  String groupDeleteConfirm(String name) {
    return 'هل أنت متأكد من حذف المجموعة $name';
  }

  @override
  String get groupDeleted => 'تم حذف المجموعة.';

  @override
  String get groupDetailTitle => 'تفاصيل المجموعة';

  @override
  String get unknownStudent => 'طالب غير معروف';

  @override
  String get fieldGroupName => 'اسم المجموعة';

  @override
  String get fieldSchedule => 'الجدول';

  @override
  String get fieldCapacity => 'السعة';

  @override
  String get fieldDay => 'اليوم';

  @override
  String get fieldTime => 'الوقت';

  @override
  String capacityPeople(int count, int capacity) {
    return '$count/$capacity شخص';
  }

  @override
  String membersTitle(int count) {
    return 'الأعضاء ($count)';
  }

  @override
  String get noMembersAssigned => 'لم يتم تعيين طلاب بعد.';

  @override
  String get editGroup => 'تعديل المجموعة';

  @override
  String get backToGroupList => 'العودة إلى قائمة المجموعات';

  @override
  String get addGroup => 'إضافة مجموعة جديدة';

  @override
  String get saveGroup => 'حفظ المجموعة';

  @override
  String get groupsNeedCoach =>
      'يجب أن تضيف مدرباً واحداً على الأقل أولاً لإنشاء مجموعة.';

  @override
  String get groupNameEmpty => 'لا يمكن ترك اسم المجموعة فارغاً.';

  @override
  String get groupNameMinLength =>
      'يجب أن يتكون اسم المجموعة من حرفين على الأقل.';

  @override
  String get coachRequired => 'يجب اختيار مدرب.';

  @override
  String get dayRequired => 'يجب اختيار يوم.';

  @override
  String get capacityEmpty => 'لا يمكن ترك السعة فارغة.';

  @override
  String get capacityMustBeNumber => 'يجب أن تكون السعة رقماً.';

  @override
  String get capacityPositive => 'يجب أن تكون السعة أكبر من 0.';

  @override
  String get capacityMax => 'يجب ألا تتجاوز السعة 100.';

  @override
  String get membersLabel => 'الأعضاء';

  @override
  String get noStudentSelected => 'لم يتم اختيار طلاب';

  @override
  String studentsSelected(int count) {
    return 'تم اختيار $count طلاب';
  }

  @override
  String get membersNeedStudents => 'يجب توفر سجلات طلاب أولاً لإضافة أعضاء.';

  @override
  String get selectCoachFirst => 'يجب اختيار مدرب أولاً.';

  @override
  String studentsExceedCapacity(int count, int capacity) {
    return 'عدد الطلاب المختارين ($count) يتجاوز السعة ($capacity).';
  }

  @override
  String get selectMembersTitle => 'اختيار الأعضاء';

  @override
  String selectedCount(int count) {
    return 'تم اختيار $count';
  }

  @override
  String selectedCountOf(int count, int capacity) {
    return 'تم اختيار $count/$capacity';
  }

  @override
  String get capacityExceeded => 'تم تجاوز السعة';

  @override
  String get noStudentsTitle => 'لا يوجد طلاب';

  @override
  String get noStudentsBody => 'يجب إضافة طلاب أولاً.';

  @override
  String studentBranchAge(String branch, int age) {
    return '$branch • $age سنة';
  }

  @override
  String get usersSearchHint => 'ابحث بالبريد الإلكتروني';

  @override
  String get usersEmptyTitle => 'لا يوجد مستخدمون';

  @override
  String get usersEmptyBody => 'لا يوجد مستخدمون مسجَّلون بعد.';

  @override
  String get noEmail => '(لا يوجد بريد إلكتروني)';

  @override
  String get youLabel => '(أنت)';

  @override
  String get cannotChangeOwnRole => 'لا يمكنك تغيير دورك الخاص من هنا.';

  @override
  String get roleUpdateError => 'حدث خطأ أثناء تحديث الدور.';

  @override
  String userRoleUpdated(String email, String role) {
    return '$email ← تم التحديث إلى $role.';
  }

  @override
  String get changeRoleTitle => 'تغيير الدور';

  @override
  String get parentAssignHint => 'يتم تعيين الطلاب من شاشة \"أولياء الأمور\".';

  @override
  String get studentAssignHint => 'يتم ربط الطلاب من شاشة \"حسابات الطلاب\".';

  @override
  String get parentsEmptyTitle => 'لا يوجد أولياء أمور بعد';

  @override
  String get parentsEmptyBody =>
      'استخدم زر + في أسفل اليمين لإضافة ولي أمر. يجب أن يسجّل ولي الأمر في التطبيق أولاً.';

  @override
  String get parentAdded => 'تمت إضافة ولي الأمر.';

  @override
  String get parentAddError => 'حدث خطأ أثناء إضافة ولي الأمر.';

  @override
  String get removeParentTitle => 'إزالة ولي الأمر';

  @override
  String removeParentConfirm(String email) {
    return 'لن يكون $email ولي أمر بعد الآن وستُزال روابط الطلاب. هل تريد المتابعة؟';
  }

  @override
  String get removeAction => 'إزالة';

  @override
  String get addParentTitle => 'إضافة ولي أمر';

  @override
  String get addParentHint =>
      'أدخل عنوان البريد الإلكتروني لولي الأمر المسجَّل في التطبيق. يجب أن يسجّل ولي الأمر أولاً.';

  @override
  String get noStudentAssigned => 'لم يتم تعيين طالب';

  @override
  String studentsAssigned(String names) {
    return 'الطلاب: $names';
  }

  @override
  String get assignStudentsTitle => 'تعيين الطلاب';

  @override
  String accountAssignHeader(String label, String email) {
    return '$label: $email';
  }

  @override
  String get studentAccountAdded => 'تمت إضافة حساب الطالب.';

  @override
  String get studentAccountAddError => 'حدث خطأ أثناء إضافة حساب الطالب.';

  @override
  String get removeAccountTitle => 'إزالة الحساب';

  @override
  String removeAccountConfirm(String email) {
    return 'لن يكون $email طالباً بعد الآن وسيُزال ربط الطالب. هل تريد المتابعة؟';
  }

  @override
  String get studentAccountsEmptyTitle => 'لا توجد حسابات طلاب بعد';

  @override
  String get studentAccountsEmptyBody =>
      'استخدم زر + في أسفل اليمين لإضافة حساب طالب. يجب أن يسجّل الطالب في التطبيق أولاً.';

  @override
  String get studentNotLinked => 'لا يوجد طالب مرتبط';

  @override
  String studentLinked(String name) {
    return 'الطالب: $name';
  }

  @override
  String get addStudentAccountTitle => 'إضافة حساب طالب';

  @override
  String get addStudentAccountHint =>
      'أدخل عنوان البريد الإلكتروني للطالب المسجَّل في التطبيق. يجب أن يسجّل الطالب أولاً.';

  @override
  String get accountLabelStudent => 'حساب الطالب';

  @override
  String photoPickError(Object error) {
    return 'تعذّر اختيار الصورة: $error';
  }

  @override
  String get profileUpdated => 'تم تحديث الملف الشخصي.';

  @override
  String profileSaveError(Object error) {
    return 'تعذّر الحفظ: $error';
  }

  @override
  String get pickPhoto => 'اختيار صورة';

  @override
  String get removePhoto => 'إزالة الصورة';

  @override
  String get nameTooLong => 'الاسم طويل جداً.';

  @override
  String get phoneTooLong => 'رقم الهاتف طويل جداً.';

  @override
  String get commonSaving => 'جارٍ الحفظ...';

  @override
  String get attendanceDeleteTitle => 'حذف الحضور';

  @override
  String attendanceDeleteConfirm(String group, String date) {
    return 'هل أنت متأكد من حذف سجل حضور $group - $date';
  }

  @override
  String get attendanceDeleted => 'تم حذف سجل الحضور.';

  @override
  String get attendanceEmptyTitle => 'لا توجد سجلات حضور بعد';

  @override
  String get attendanceEmptyAdmin =>
      'استخدم زر + في أسفل اليمين لإضافة سجل حضور جديد.';

  @override
  String get attendanceEmptyNoGroup =>
      'لأخذ الحضور، أضف مجموعة وطالباً واحداً على الأقل أولاً.';

  @override
  String get attendanceEmptyViewer =>
      'لا توجد سجلات حضور بعد. ستظهر هنا عندما يضيف المدير الحضور.';

  @override
  String attendanceCountLine(int present, int absent) {
    return 'حاضر: $present • غائب: $absent';
  }

  @override
  String get takeAttendanceTitle => 'أخذ الحضور';

  @override
  String get editAttendanceTitle => 'تعديل الحضور';

  @override
  String get selectGroupFirst => 'اختر مجموعة أولاً.';

  @override
  String get fieldGroup => 'المجموعة';

  @override
  String get groupRequired => 'يجب اختيار مجموعة.';

  @override
  String get fieldDate => 'التاريخ';

  @override
  String studentsCountTitle(int count) {
    return 'الطلاب ($count)';
  }

  @override
  String get groupNoStudentsTitle => 'لا يوجد طلاب في هذه المجموعة.';

  @override
  String get groupNoStudentsBody => 'يمكنك إضافة طلاب من تفاصيل المجموعة.';

  @override
  String get saveAttendance => 'حفظ الحضور';

  @override
  String get attendanceNeedGroupStudent =>
      'لأخذ الحضور، يجب أن تضيف مجموعة وطالباً واحداً على الأقل أولاً.';

  @override
  String get attendanceDetailTitle => 'تفاصيل الحضور';

  @override
  String get presentStudentsTitle => 'الطلاب الحاضرون';

  @override
  String get noPresentStudents => 'لا يوجد طلاب حاضرون.';

  @override
  String get absentStudentsTitle => 'الطلاب الغائبون';

  @override
  String get noAbsentStudents => 'لا يوجد طلاب غائبون.';

  @override
  String get backToAttendanceList => 'العودة إلى قائمة الحضور';

  @override
  String get childAttendanceEmptyTitle => 'لا توجد سجلات حضور';

  @override
  String get childAttendanceEmptyBody =>
      'لم يتم إنشاء أي سجل حضور يتضمن طفلك بعد.';

  @override
  String attendedOfLessons(int total, int present) {
    return 'حضر $present من $total حصص';
  }

  @override
  String percentValue(int percent) {
    return '$percent%';
  }

  @override
  String get paymentDeleteTitle => 'حذف الدفعة';

  @override
  String paymentDeleteConfirm(String name, String period) {
    return 'هل أنت متأكد من حذف سجل دفعة $name - $period';
  }

  @override
  String get paymentDeleted => 'تم حذف سجل الدفعة.';

  @override
  String get periodLabel => 'الفترة:';

  @override
  String get allPeriods => 'كل الفترات';

  @override
  String get paymentsSearchHint => 'ابحث عن دفعة';

  @override
  String get paymentsEmptyTitle => 'لا توجد سجلات مدفوعات بعد';

  @override
  String get paymentsEmptyAdmin =>
      'استخدم زر + في أسفل اليمين لإضافة سجل دفعة جديد.';

  @override
  String get paymentsEmptyNoStudent =>
      'لإضافة دفعة، أضف طالباً واحداً على الأقل أولاً.';

  @override
  String get paymentsEmptyViewer =>
      'لا توجد سجلات مدفوعات بعد. ستظهر هنا عندما يضيف المدير دفعة.';

  @override
  String paymentsNoStatusResults(String status) {
    return 'لا توجد سجلات بحالة \"$status\". اختر مرشحاً آخر أو \"الكل\".';
  }

  @override
  String get remindTooltip => 'إرسال تذكير';

  @override
  String get noParentPhone => 'رقم هاتف ولي أمر الطالب غير محفوظ.';

  @override
  String get paymentCollectedLabel => 'المحصَّل';

  @override
  String recordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سجلات',
      one: 'سجل واحد',
    );
    return '$_temp0';
  }

  @override
  String get paymentDetailTitle => 'تفاصيل الدفعة';

  @override
  String get fieldPeriod => 'الشهر / الفترة';

  @override
  String get fieldAmount => 'المبلغ';

  @override
  String get fieldStatus => 'الحالة';

  @override
  String get fieldNote => 'ملاحظة';

  @override
  String get noNote => 'لا توجد ملاحظة.';

  @override
  String get remindViaWhatsApp => 'تذكير عبر واتساب';

  @override
  String get editPaymentTitle => 'تعديل الدفعة';

  @override
  String get backToPaymentList => 'العودة إلى قائمة المدفوعات';

  @override
  String get addPaymentTitle => 'إضافة دفعة جديدة';

  @override
  String get paymentNeedStudent =>
      'لإضافة دفعة، يجب أن تضيف طالباً واحداً على الأقل أولاً.';

  @override
  String get studentRequired => 'يجب اختيار طالب.';

  @override
  String get periodEmpty => 'لا يمكن ترك الشهر / الفترة فارغاً.';

  @override
  String get amountEmpty => 'لا يمكن ترك المبلغ فارغاً.';

  @override
  String get amountMustBeNumber => 'يجب أن يكون المبلغ رقماً.';

  @override
  String get amountPositive => 'يجب أن يكون المبلغ أكبر من 0.';

  @override
  String get amountTooHigh => 'يبدو المبلغ مرتفعاً جداً.';

  @override
  String get statusRequired => 'يجب اختيار حالة.';

  @override
  String get noteHint => 'ملاحظة اختيارية';

  @override
  String get selectStudentFirst => 'اختر طالباً أولاً.';

  @override
  String get savePayment => 'حفظ الدفعة';

  @override
  String get leaveReported => 'تم إرسال طلب الغياب.';

  @override
  String get leaveDeleteTitle => 'حذف طلب الغياب';

  @override
  String get leaveDeleteConfirm => 'هل تريد حذف طلب الغياب هذا؟';

  @override
  String get newLeave => 'طلب غياب جديد';

  @override
  String get leaveEmptyTitle => 'لا توجد طلبات غياب';

  @override
  String get leaveEmptyParent =>
      'لم ترسل أي طلب غياب بعد. استخدم الزر في أسفل اليمين لإضافة طلب.';

  @override
  String get leaveEmptyStaff => 'لم يتم إرسال أي طلبات غياب بعد.';

  @override
  String get cancelLeaveAction => 'إلغاء';

  @override
  String get reasonRequired => 'يُرجى كتابة سبب.';

  @override
  String dateWithValue(String date) {
    return 'التاريخ: $date';
  }

  @override
  String get fieldReason => 'السبب';

  @override
  String get reasonHint => 'مثال: تقرير طبي، زيارة عائلية...';

  @override
  String get sendAction => 'إرسال';

  @override
  String get performanceAnalysisTitle => 'تحليل الأداء';

  @override
  String recordAddError(Object error) {
    return 'تعذّرت إضافة السجل: $error';
  }

  @override
  String recordDeleteError(Object error) {
    return 'تعذّر حذف السجل: $error';
  }

  @override
  String get recordDeleteTitle => 'حذف السجل';

  @override
  String performanceDeleteConfirm(String date) {
    return 'هل أنت متأكد من حذف سجل الأداء بتاريخ $date؟';
  }

  @override
  String get noStudentFound => 'لم يتم العثور على طالب';

  @override
  String get performanceEmptyManage => 'لإدخال الأداء، يجب إضافة طالب أولاً.';

  @override
  String get performanceEmptyParent =>
      'لم يتم تعيين أي طالب لحسابك بعد. يُرجى التواصل مع إدارة مدرسة الرياضة.';

  @override
  String get addPerformance => 'إضافة أداء';

  @override
  String get noPerformanceForStudent => 'لا يوجد سجل أداء لهذا الطالب بعد.';

  @override
  String get comparisonByDate => 'المقارنة حسب التاريخ';

  @override
  String get recordsTitle => 'السجلات';

  @override
  String get selectAction => 'اختيار';

  @override
  String get scoresLabel => 'الدرجات (0-100)';

  @override
  String get metricJump => 'القفز';

  @override
  String get metricSpeed => 'السرعة';

  @override
  String get metricEndurance => 'التحمل';

  @override
  String get metricFlexibility => 'المرونة';

  @override
  String get metricBallControl => 'التحكم بالكرة';

  @override
  String get announcementDeleteTitle => 'حذف الإعلان';

  @override
  String announcementDeleteConfirm(String title) {
    return 'هل أنت متأكد من حذف الإعلان بعنوان $title';
  }

  @override
  String get announcementDeleted => 'تم حذف الإعلان.';

  @override
  String get announcementsEmptyTitle => 'لا توجد إعلانات بعد';

  @override
  String get announcementsEmptyAdmin =>
      'استخدم زر + في أسفل اليمين لإضافة إعلان جديد.';

  @override
  String get announcementsEmptyViewer =>
      'لا توجد إعلانات بعد. ستظهر هنا عندما يضيف المدير إعلاناً.';

  @override
  String get announcementDetailTitle => 'تفاصيل الإعلان';

  @override
  String get fieldTitle => 'العنوان';

  @override
  String get fieldTargetAudience => 'الجمهور المستهدف';

  @override
  String get editAnnouncementTitle => 'تعديل الإعلان';

  @override
  String get backToAnnouncementList => 'العودة إلى قائمة الإعلانات';

  @override
  String get addAnnouncementTitle => 'إضافة إعلان جديد';

  @override
  String get titleHint => 'تغيير وقت التدريب';

  @override
  String get titleEmpty => 'لا يمكن ترك العنوان فارغاً.';

  @override
  String get titleMinLength => 'يجب أن يتكون العنوان من 3 أحرف على الأقل.';

  @override
  String get fieldContent => 'المحتوى';

  @override
  String get contentHint => 'اكتب محتوى الإعلان...';

  @override
  String get contentEmpty => 'لا يمكن ترك المحتوى فارغاً.';

  @override
  String get contentMinLength => 'يجب أن يتكون المحتوى من 10 أحرف على الأقل.';

  @override
  String get audienceRequired => 'يجب اختيار جمهور مستهدف.';

  @override
  String get saveAnnouncement => 'حفظ الإعلان';

  @override
  String get audienceEveryone => 'الجميع';

  @override
  String eventAddError(Object error) {
    return 'تعذّرت إضافة الفعالية: $error';
  }

  @override
  String eventDeleteError(Object error) {
    return 'تعذّر حذف الفعالية: $error';
  }

  @override
  String get eventDeleteTitle => 'حذف الفعالية';

  @override
  String eventDeleteConfirm(String title) {
    return 'هل تريد حذف الفعالية $title؟';
  }

  @override
  String get eventsEmptyTitle => 'لا توجد فعاليات مُخطَّطة';

  @override
  String get eventsEmptyManage =>
      'استخدم زر + في أسفل اليمين لإضافة فعالية جديدة.';

  @override
  String get eventsEmptyViewer =>
      'ستظهر الفعاليات هنا عندما يخطط لها المدربون.';

  @override
  String get addEvent => 'إضافة فعالية';

  @override
  String get selectAttendanceFirst => 'يُرجى اختيار حالة المشاركة أولاً.';

  @override
  String get responseAlreadySaved => 'ردك محفوظ بالفعل.';

  @override
  String responseSendError(Object error) {
    return 'تعذّر إرسال الرد: $error';
  }

  @override
  String get responseSent => 'تم إرسال ردك.';

  @override
  String attendingCount(int count) {
    return 'سيحضر: $count';
  }

  @override
  String notAttendingCount(int count) {
    return 'لن يحضر: $count';
  }

  @override
  String eventDateLabel(String date) {
    return 'تاريخ الفعالية: $date';
  }

  @override
  String get willAttend => 'سيحضر';

  @override
  String get willNotAttend => 'لن يحضر';

  @override
  String get sendingLabel => 'جارٍ الإرسال...';

  @override
  String get sentLabel => 'تم الإرسال';

  @override
  String get addEventTitle => 'فعالية جديدة';

  @override
  String get fieldEventName => 'اسم الفعالية';

  @override
  String get eventNameHint => 'مباراة ودية';

  @override
  String get eventNameEmpty => 'لا يمكن ترك اسم الفعالية فارغاً.';

  @override
  String get fieldDescriptionOptional => 'الوصف (اختياري)';

  @override
  String get saveEvent => 'حفظ الفعالية';

  @override
  String get cashDeleteTitle => 'حذف السجل';

  @override
  String cashDeleteConfirm(String title) {
    return 'هل تريد حذف السجل \"$title\"؟';
  }

  @override
  String get newCashEntry => 'سجل جديد';

  @override
  String get cashEmptyTitle => 'الصندوق فارغ';

  @override
  String get cashEmptyBody =>
      'لا توجد سجلات دخل/مصروف بعد. أضف أول سجل بالزر في أسفل اليمين.';

  @override
  String get currentBalance => 'الرصيد الحالي';

  @override
  String get totalIncome => 'إجمالي الدخل';

  @override
  String get totalExpense => 'إجمالي المصروف';

  @override
  String get titleRequired => 'يُرجى كتابة عنوان.';

  @override
  String get amountInvalid => 'يُرجى إدخال مبلغ صحيح.';

  @override
  String get cashTitleHint => 'مثال: رسوم مارس، إيجار الصالة...';

  @override
  String get fieldAmountCurrency => 'المبلغ (₺)';

  @override
  String get fieldCategory => 'الفئة';

  @override
  String get fieldNoteOptional => 'ملاحظة (اختياري)';

  @override
  String get equipmentDeleteTitle => 'حذف العنصر';

  @override
  String equipmentDeleteConfirm(String name) {
    return 'هل تريد حذف السجل \"$name\"؟';
  }

  @override
  String get newEquipment => 'عنصر جديد';

  @override
  String get equipmentEmptyTitle => 'المخزن فارغ';

  @override
  String get equipmentEmptyManage =>
      'لا توجد عناصر بعد. أضف أول سجل بالزر في أسفل اليمين.';

  @override
  String get equipmentEmptyViewer => 'لم تتم إضافة أي عناصر إلى المخزن بعد.';

  @override
  String get noResultTitle => 'لا توجد نتائج';

  @override
  String get noResultInCategory => 'لا توجد عناصر في هذه الفئة.';

  @override
  String get equipmentSummaryTitle => 'ملخص المخزن';

  @override
  String get metricVariety => 'الأنواع';

  @override
  String get metricTotalQuantity => 'الكمية الإجمالية';

  @override
  String get metricAttention => 'انتباه';

  @override
  String assignedPrefix(String who) {
    return 'العهدة: $who';
  }

  @override
  String get editEquipment => 'تعديل العنصر';

  @override
  String get fieldEquipmentName => 'اسم العنصر';

  @override
  String get equipmentNameHint => 'مثال: كرة قدم، قميص...';

  @override
  String get equipmentNameRequired => 'يُرجى كتابة اسم العنصر.';

  @override
  String get quantityMustBePositive => 'يجب أن تكون الكمية أكبر من 0.';

  @override
  String get fieldQuantity => 'الكمية';

  @override
  String get fieldAssignedOptional => 'العهدة (اختياري)';

  @override
  String get assignedHint => 'لدى من / أين';

  @override
  String get conditionGood => 'سليم';

  @override
  String get conditionMaintenance => 'قيد الصيانة';

  @override
  String get conditionWorn => 'مُهترئ';

  @override
  String get generalSummary => 'ملخص عام';

  @override
  String get paymentSummary => 'ملخص المدفوعات';

  @override
  String get paidPayments => 'المدفوعات المسدَّدة';

  @override
  String get pendingPayments => 'المدفوعات المعلّقة';

  @override
  String get statusComment => 'نظرة عامة على الحالة';

  @override
  String get reportsNoData =>
      'لا توجد بيانات كافية بعد. مع إضافة سجلات الطلاب والمجموعات والمدفوعات، سيظهر هنا ملخص عام للحالة.';

  @override
  String reportsSummary(
    int students,
    int coaches,
    int groups,
    int payments,
    int paid,
    int pending,
  ) {
    return 'يضم النظام $students طلاب و$coaches مدربين و$groups مجموعات. من إجمالي $payments سجل مدفوعات، $paid مسدَّدة و$pending معلّقة.';
  }

  @override
  String get notificationsEmptyTitle => 'لا توجد إشعارات';

  @override
  String get notificationsEmptyBody => 'لا توجد إشعارات لعرضها الآن.';

  @override
  String get noRecordsTitle => 'لا توجد سجلات';

  @override
  String get noNotificationsInCategory => 'لا توجد إشعارات في هذه الفئة.';

  @override
  String get aiStaffSuggestion1 => 'لخّص هذا الشهر';

  @override
  String get aiStaffSuggestion2 => 'على ماذا يجب أن أنتبه؟';

  @override
  String get aiStaffSuggestion3 =>
      'اكتب مسودة رسالة قصيرة لولي أمر بشأن الغياب';

  @override
  String get aiStaffSuggestion4 => 'أعطِ 3 نصائح لتحسين التحصيل';

  @override
  String get aiParentSuggestion1 => 'لخّص حالة طفلي';

  @override
  String get aiParentSuggestion2 => 'كيف هو وضع الحضور؟';

  @override
  String get aiParentSuggestion3 => 'اشرح حالة الدفع الخاصة بي';

  @override
  String get aiParentSuggestion4 => 'بماذا تنصح لتطوره؟';

  @override
  String get aiStudentSuggestion1 => 'لخّص حالتي';

  @override
  String get aiStudentSuggestion2 => 'كيف هو حضوري؟';

  @override
  String get aiStudentSuggestion3 => 'علّق على أدائي';

  @override
  String get aiStudentSuggestion4 => 'بماذا تنصح للتحسن؟';

  @override
  String get sportekaiNotReadyTitle => 'SporTekAi غير جاهز بعد';

  @override
  String get sportekaiNotReadyBody =>
      'لاستخدام مساعد الذكاء الاصطناعي، يجب تحديد عنوان Cloudflare Worker (SPORTEKAI_ENDPOINT). الإعداد: cloudflare/README.md';

  @override
  String get sportekaiGreeting => 'مرحباً! أنا SporTekAi ✨';

  @override
  String get sportekaiHint => 'اسأل SporTekAi...';

  @override
  String get aiResponseLanguage => 'العربية';

  @override
  String get videoOpenError => 'تعذّر فتح الفيديو.';

  @override
  String get watchIntroVideo => 'شاهد الفيديو التعريفي';

  @override
  String get youtubeHowToPlay => 'كيفية اللعب';

  @override
  String get fullNameHint => 'محمد أحمد';

  @override
  String get monthJanuary => 'يناير';

  @override
  String get monthFebruary => 'فبراير';

  @override
  String get monthMarch => 'مارس';

  @override
  String get monthApril => 'أبريل';

  @override
  String get monthMay => 'مايو';

  @override
  String get monthJune => 'يونيو';

  @override
  String get monthJuly => 'يوليو';

  @override
  String get monthAugust => 'أغسطس';

  @override
  String get monthSeptember => 'سبتمبر';

  @override
  String get monthOctober => 'أكتوبر';

  @override
  String get monthNovember => 'نوفمبر';

  @override
  String get monthDecember => 'ديسمبر';

  @override
  String get chatTitle => 'دردشة النادي';

  @override
  String get chatHint => 'اكتب رسالة…';

  @override
  String get chatEmptyTitle => 'لا توجد رسائل بعد';

  @override
  String get chatEmptyBody => 'كن أول من يرسل رسالة.';

  @override
  String get chatLoadError => 'تعذّر تحميل الدردشة. قد لا تملك صلاحية الوصول.';

  @override
  String get chatEditTitle => 'تعديل الرسالة';

  @override
  String get chatDeleteTitle => 'حذف الرسالة';

  @override
  String get chatDeleteConfirm => 'هل تريد حذف هذه الرسالة؟';

  @override
  String get chatEdited => 'مُعدَّلة';

  @override
  String get scheduleTitle => 'جدول الحصص';

  @override
  String get scheduleViewDay => 'يومي';

  @override
  String get scheduleViewWeek => 'أسبوعي';

  @override
  String get scheduleTodayLabel => 'اليوم';

  @override
  String get todayLessonsTitle => 'حصص اليوم';

  @override
  String get todayNoLessons => 'لا حصص اليوم.';

  @override
  String get scheduleTakeAttendance => 'أخذ الحضور';

  @override
  String get scheduleConflictTitle => 'تعارض';

  @override
  String get scheduleConflictBody => 'توجد حصة متداخلة في هذا الوقت:';

  @override
  String get scheduleSaveAnyway => 'احفظ على أي حال';

  @override
  String get scheduleAddTitle => 'إضافة حصة';

  @override
  String get scheduleEditTitle => 'تعديل الحصة';

  @override
  String get scheduleEmptyTitle => 'الجدول فارغ';

  @override
  String get scheduleEmptyBody => 'لم تتم إضافة حصص بعد.';

  @override
  String get scheduleEmptyBodyManage => 'أضف أول حصة بزر +.';

  @override
  String get scheduleNoLesson => 'لا توجد حصص';

  @override
  String get scheduleDayLabel => 'اليوم';

  @override
  String get scheduleStartLabel => 'البداية';

  @override
  String get scheduleEndLabel => 'النهاية';

  @override
  String get scheduleGroupLabel => 'المجموعة';

  @override
  String get scheduleCoachLabel => 'المدرب';

  @override
  String get scheduleDeleteTitle => 'حذف الحصة';

  @override
  String get scheduleDeleteConfirm => 'هل تريد حذف هذه الحصة؟';

  @override
  String get scheduleNeedsGroupCoach => 'أضف مجموعة ومدرباً أولاً.';

  @override
  String get scheduleLoadError => 'تعذّر تحميل الجدول.';
}
