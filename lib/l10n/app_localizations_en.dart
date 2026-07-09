// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClose => 'Close';

  @override
  String get commonOk => 'OK';

  @override
  String get commonResend => 'Resend';

  @override
  String get roleAdmin => 'Administrator';

  @override
  String get roleCoach => 'Coach';

  @override
  String get roleParent => 'Parent';

  @override
  String get roleStudent => 'Student';

  @override
  String get roleViewer => 'Viewer';

  @override
  String get roleUnknown => 'Unknown';

  @override
  String get loginHeading => 'Sports School Management';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'example@sporokulu.com';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Sign In';

  @override
  String get loginLoading => 'Signing in...';

  @override
  String get forgotPassword => 'Forgot my password';

  @override
  String get noAccountRegister => 'Don\'t have an account? Sign up';

  @override
  String get emailEmpty => 'Email cannot be empty.';

  @override
  String get emailInvalid => 'Enter a valid email.';

  @override
  String get passwordEmpty => 'Password cannot be empty.';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters.';

  @override
  String get emailNotVerifiedTitle => 'Email not verified';

  @override
  String get emailNotVerifiedBody =>
      'To activate your account, tap the verification link sent to your email. If it hasn\'t arrived, we can send it again.';

  @override
  String get verificationResent =>
      'Verification email sent again. Check your spam folder too.';

  @override
  String get rejectedTitle => 'Your application was rejected';

  @override
  String get rejectedBody =>
      'Your role application was rejected by an administrator. Your account is being closed.';

  @override
  String get resetPasswordNeedEmail =>
      'Enter your email address first to reset your password.';

  @override
  String get resetPasswordSent =>
      'A password reset link has been sent to your email address.';

  @override
  String get resetPasswordError =>
      'An error occurred while resetting the password.';

  @override
  String get resetInvalidEmail => 'Enter a valid email address.';

  @override
  String get resetUserNotFound =>
      'No user is registered with this email address.';

  @override
  String get userNotFound => 'User not found.';

  @override
  String loginCheckError(Object error) {
    return 'An error occurred during the sign-in check: $error';
  }

  @override
  String get authInvalidEmail => 'The email address is invalid.';

  @override
  String get authUserDisabled => 'This user account is disabled.';

  @override
  String get authWrongCredentials => 'Incorrect email or password.';

  @override
  String get authNetwork =>
      'Could not connect to the internet. Check your connection and try again.';

  @override
  String get authOperationNotAllowed =>
      'Email/Password sign-in is not enabled in the Firebase Console.';

  @override
  String get authConfigNotFound =>
      'Firebase Authentication configuration not found. Check your Firebase Console settings.';

  @override
  String get authAppNotAuthorized =>
      'This Android app does not appear to be authorized for the Firebase project.';

  @override
  String get authInvalidApiKey => 'The Firebase API key appears to be invalid.';

  @override
  String get authTooManyRequests =>
      'Too many sign-in attempts. Please try again later.';

  @override
  String authGenericWithCode(String code) {
    return 'Sign-in failed. Error code: $code';
  }

  @override
  String get registerTitle => 'Sign Up';

  @override
  String get registerHeading => 'Create a New Account';

  @override
  String get firstNameLabel => 'First name';

  @override
  String get lastNameLabel => 'Last name';

  @override
  String get passwordAgainLabel => 'Confirm Password';

  @override
  String get passwordAgainEmpty => 'Password confirmation cannot be empty.';

  @override
  String get passwordsDontMatch => 'Passwords do not match.';

  @override
  String get accountType => 'Your account type';

  @override
  String get selectionSentToAdmin =>
      'Your selection will be sent for administrator approval.';

  @override
  String get registerButton => 'Sign Up';

  @override
  String get registerLoading => 'Saving...';

  @override
  String requiredField(String label) {
    return '$label cannot be empty.';
  }

  @override
  String get registerSuccess =>
      'Account created. Please tap the verification link sent to your email. Your role application has been sent for administrator approval.';

  @override
  String get registerGenericError => 'An error occurred during registration.';

  @override
  String get emailAlreadyInUse => 'This email address is already in use.';

  @override
  String get passwordTooWeak =>
      'Password is too weak. Use at least 6 characters.';

  @override
  String registerErrorWith(Object error) {
    return 'Registration error: $error';
  }

  @override
  String get userNotCreated => 'User could not be created.';

  @override
  String get roleRequestsTitle => 'Role Applications';

  @override
  String get noPendingRequests => 'No pending applications';

  @override
  String get noPendingRequestsBody =>
      'Role applications from new registrations appear here.';

  @override
  String get approveTitle => 'Approve application';

  @override
  String approveConfirm(String name, String role) {
    return '$name will be promoted to $role. Do you approve?';
  }

  @override
  String get approveAction => 'Approve';

  @override
  String approvedSnack(String name, String role) {
    return '$name is now $role.';
  }

  @override
  String get rejectTitle => 'Reject application';

  @override
  String rejectConfirm(String name) {
    return '$name\'s application will be rejected and the account deleted. This cannot be undone. Continue?';
  }

  @override
  String get rejectAction => 'Reject';

  @override
  String rejectedSnack(String name) {
    return '$name\'s application was rejected.';
  }

  @override
  String requestLabel(String role) {
    return 'Request: $role';
  }

  @override
  String get genericOperationError => 'An error occurred during the operation.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileUserFallback => 'User';

  @override
  String get roleDescAdmin => 'Can add, edit, and delete all records.';

  @override
  String get roleDescCoach =>
      'Can manage attendance and announcement records. Can view other records.';

  @override
  String get roleDescParent =>
      'Can track their child\'s performance and respond to event participation.';

  @override
  String get roleDescStudent =>
      'Can view their own attendance and performance information.';

  @override
  String get roleDescViewer => 'Can view records but cannot make changes.';

  @override
  String get childrenSectionStudent => 'My Student Info';

  @override
  String get childrenSectionParent => 'My Students';

  @override
  String get authorityTitle => 'Authority';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get backgroundEffectTitle => 'Background effect';

  @override
  String get backgroundEffectDesc =>
      'High: waves + particles · Medium: waves only · Low: plain background.';

  @override
  String get backgroundHigh => 'High';

  @override
  String get backgroundMedium => 'Medium';

  @override
  String get backgroundLow => 'Low';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageSystem => 'System';

  @override
  String get editAccount => 'Edit Account';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get whatsappSupport => 'WhatsApp Support';

  @override
  String get kvkkTitle => 'Personal Data Protection Notice';

  @override
  String get termsTitle => 'Terms of Use';

  @override
  String get privacyTitle => 'Privacy Policy';

  @override
  String get appVersionLabel => 'App Version';

  @override
  String get logout => 'Log Out';

  @override
  String get commonAll => 'All';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonDelete => 'Delete';

  @override
  String get viewAction => 'View';

  @override
  String get statusPaid => 'Paid';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusOverdue => 'Overdue';

  @override
  String get leaveStatusPending => 'Pending';

  @override
  String get leaveStatusApproved => 'Approved';

  @override
  String get leaveStatusRejected => 'Rejected';

  @override
  String get drawerMainPanel => 'Main Panel';

  @override
  String get sectionRecords => 'Records';

  @override
  String get sectionOperations => 'Operations';

  @override
  String get sectionClub => 'Club';

  @override
  String get sectionGeneral => 'General';

  @override
  String get sectionMyChild => 'My Child';

  @override
  String get sectionMe => 'Me';

  @override
  String get navStudents => 'Students';

  @override
  String get navCoaches => 'Coaches';

  @override
  String get navGroups => 'Groups';

  @override
  String get navParents => 'Parents';

  @override
  String get navStudentAccounts => 'Student Accounts';

  @override
  String get navAttendance => 'Attendance';

  @override
  String get navLeaveRequests => 'Leave Requests';

  @override
  String get navPayments => 'Payments';

  @override
  String get navPerformance => 'Performance';

  @override
  String get navEvents => 'Events';

  @override
  String get navEquipment => 'Inventory';

  @override
  String get navAnnouncements => 'Announcements';

  @override
  String get navClubCash => 'Club Cash';

  @override
  String get navReports => 'Reports';

  @override
  String get navSports => 'Sports';

  @override
  String get navUsers => 'Users';

  @override
  String get navReportAbsence => 'Report Absence';

  @override
  String get navMyPerformance => 'My Performance';

  @override
  String get navMyAttendance => 'My Attendance';

  @override
  String get notificationsTooltip => 'Notifications';

  @override
  String get notifCategoryAnnouncement => 'Announcement';

  @override
  String get notifCategoryPayment => 'Payment';

  @override
  String get notifCategoryLeave => 'Leave';

  @override
  String get notifCategoryAbsence => 'Absence';

  @override
  String get leaveWaitingApproval => 'Awaiting approval';

  @override
  String notifLeaveTitle(String name) {
    return '$name • leave';
  }

  @override
  String notifAbsenceTitle(String name) {
    return '$name was absent';
  }

  @override
  String errorLoadingData(Object error) {
    return 'An error occurred while loading data: $error';
  }

  @override
  String get reminderDialogTitle => 'New Reminder';

  @override
  String get reminderDialogHint => 'E.g. Order supplies on Tuesday';

  @override
  String get newAnnouncementPublished => 'A new announcement was published.';

  @override
  String newAnnouncementsPublished(int count) {
    return '$count new announcements were published.';
  }

  @override
  String get remindersTitle => 'Quick Reminders';

  @override
  String get remindersEmpty => 'You haven\'t added any reminders yet.';

  @override
  String get aiIntroParent =>
      'I know your child\'s current summary. You can pick one of the options below or type your own question.';

  @override
  String get aiIntroStudent =>
      'I know your current status. You can pick one of the options below or type your own question.';

  @override
  String get aiIntroStaff =>
      'I know your club\'s current summary. You can pick one of the options below or type your own question.';

  @override
  String get viewerWelcomeSubtitle => 'Welcome to the sports school.';

  @override
  String get requestPendingTitle => 'Your application is under review';

  @override
  String requestPendingMessage(String role) {
    return 'Your application to become $role is awaiting administrator approval. Once approved, you\'ll be able to access the relevant panel.';
  }

  @override
  String get requestApprovedTitle => 'Your application was approved';

  @override
  String get requestApprovedMessage =>
      'Just log out and log back in to see your new role.';

  @override
  String get roleNotAssignedTitle => 'Your role hasn\'t been assigned yet';

  @override
  String get roleNotAssignedMessage =>
      'When an administrator assigns you a role, you\'ll access the relevant panel.';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get studentGreetingSubtitle => 'Your current status is below.';

  @override
  String parentGreetingSubtitleOne(String name) {
    return '$name • current summary';
  }

  @override
  String get parentGreetingSubtitleMany =>
      'Your children\'s current summary is below.';

  @override
  String get staffGreetingSubtitle => 'Your club\'s current summary is below.';

  @override
  String highlightOverdueDues(String amount) {
    return 'Overdue dues: $amount';
  }

  @override
  String get highlightGreatAttendance =>
      'Your attendance is great, keep it up! 🎯';

  @override
  String get highlightWatchAttendance => 'Let\'s watch attendance a bit';

  @override
  String get highlightPlannedEvent =>
      'There\'s a planned event, don\'t miss it';

  @override
  String get highlightAllGood => 'Everything looks fine 👍';

  @override
  String highlightPaymentsPending(int count) {
    return '$count payments awaiting follow-up';
  }

  @override
  String highlightLeavePending(int count) {
    return '$count leave requests awaiting approval';
  }

  @override
  String get highlightNoPending => 'You have no pending tasks, great 👍';

  @override
  String get statPerformance => 'Performance';

  @override
  String get statEvent => 'Event';

  @override
  String get statAnnouncement => 'Announcement';

  @override
  String get statMyChild => 'My Child';

  @override
  String get statStudent => 'Student';

  @override
  String get statCoach => 'Coach';

  @override
  String get statGroup => 'Group';

  @override
  String noteNew(int count) {
    return '$count new';
  }

  @override
  String noteWaiting(int count) {
    return '$count pending';
  }

  @override
  String get attendanceSummaryTitle => 'Attendance Summary';

  @override
  String get attendanceEmpty => 'No attendance records yet.';

  @override
  String get metricLessons => 'Lessons';

  @override
  String get metricRecords => 'Records';

  @override
  String get metricPresent => 'Present';

  @override
  String get metricAbsent => 'Absent';

  @override
  String get metricAttendanceRate => 'Attendance';

  @override
  String get absenceNoteOne => '1 new absence record';

  @override
  String absenceNoteMany(int count) {
    return '$count new absence records';
  }

  @override
  String get financeSummaryTitle => 'Financial Summary';

  @override
  String get financeEmpty => 'No payment records yet.';

  @override
  String get metricCollected => 'Collected';

  @override
  String get metricPending => 'Pending';

  @override
  String get metricOverdue => 'Overdue';

  @override
  String get clubCashTitle => 'Club Cash';

  @override
  String get ledgerAction => 'Ledger';

  @override
  String get clubCashEmpty => 'No cash transactions yet.';

  @override
  String get metricBalance => 'Balance';

  @override
  String get metricIncome => 'Income';

  @override
  String get metricExpense => 'Expense';

  @override
  String unpaidDuesTitle(int count) {
    return 'Unpaid Dues ($count)';
  }

  @override
  String moreStudents(int count) {
    return '+$count more students';
  }

  @override
  String get latestAnnouncementTitle => 'Latest Announcement';

  @override
  String get commonSave => 'Save';

  @override
  String get commonEdit => 'Edit';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get searchNoResults => 'No results found';

  @override
  String get searchNoResultsBody => 'Try changing the search text.';

  @override
  String get fieldFullName => 'Full Name';

  @override
  String get fieldAge => 'Age';

  @override
  String get fieldBranch => 'Branch';

  @override
  String get fieldParentPhone => 'Parent Phone';

  @override
  String get studentsSearchHint => 'Search students';

  @override
  String get studentsEmptyTitle => 'No students yet';

  @override
  String get studentsEmptyAdmin =>
      'Use the + button at the bottom right to add a new student.';

  @override
  String get studentsEmptyViewer =>
      'No student records yet. They\'ll appear here once an admin adds a student.';

  @override
  String studentSubtitle(String branch, int age, String phone) {
    return '$branch • age $age\nParent: $phone';
  }

  @override
  String get studentDeleteTitle => 'Delete Student';

  @override
  String studentDeleteConfirm(String name) {
    return 'Are you sure you want to delete $name';
  }

  @override
  String get studentDeleted => 'Student deleted.';

  @override
  String get studentDetailTitle => 'Student Details';

  @override
  String get editStudent => 'Edit Student';

  @override
  String get backToStudentList => 'Back to Student List';

  @override
  String get addStudent => 'Add New Student';

  @override
  String get saveStudent => 'Save Student';

  @override
  String get fullNameEmpty => 'Full name cannot be empty.';

  @override
  String get fullNameMinLength => 'Full name must be at least 3 characters.';

  @override
  String get ageEmpty => 'Age cannot be empty.';

  @override
  String get ageMustBeNumber => 'Age must be a number.';

  @override
  String get agePositive => 'Age must be greater than 0.';

  @override
  String get ageTooHigh => 'Age seems too high.';
}
