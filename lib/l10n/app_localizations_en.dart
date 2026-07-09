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

  @override
  String get fieldPhone => 'Phone';

  @override
  String get branchEmpty => 'Branch cannot be empty.';

  @override
  String get coachesSearchHint => 'Search coaches';

  @override
  String get coachesEmptyTitle => 'No coaches yet';

  @override
  String get coachesEmptyAdmin =>
      'Use the + button at the bottom right to add a new coach.';

  @override
  String get coachesEmptyViewer =>
      'No coach records yet. They\'ll appear here once an admin adds a coach.';

  @override
  String coachSubtitle(String branch, String phone) {
    return '$branch • $phone';
  }

  @override
  String get coachDeleteTitle => 'Delete Coach';

  @override
  String coachDeleteConfirm(String name) {
    return 'Are you sure you want to delete $name';
  }

  @override
  String get coachDeleted => 'Coach deleted.';

  @override
  String get coachDetailTitle => 'Coach Details';

  @override
  String get editCoach => 'Edit Coach';

  @override
  String get backToCoachList => 'Back to Coach List';

  @override
  String get addCoach => 'Add New Coach';

  @override
  String get saveCoach => 'Save Coach';

  @override
  String get phoneEmpty => 'Phone number cannot be empty.';

  @override
  String get phoneFormat => 'Phone must be in the format 05XXXXXXXXX.';

  @override
  String get timeEmpty => 'Time cannot be empty.';

  @override
  String get timeFormat => 'Time must be in the format 18:00.';

  @override
  String get dateEmpty => 'Date cannot be empty.';

  @override
  String get dateFormat => 'Date must be in the format 24.06.2026.';

  @override
  String get branchRequired => 'A branch must be selected.';

  @override
  String get dayMonday => 'Monday';

  @override
  String get dayTuesday => 'Tuesday';

  @override
  String get dayWednesday => 'Wednesday';

  @override
  String get dayThursday => 'Thursday';

  @override
  String get dayFriday => 'Friday';

  @override
  String get daySaturday => 'Saturday';

  @override
  String get daySunday => 'Sunday';

  @override
  String get groupsSearchHint => 'Search groups';

  @override
  String get groupsEmptyTitle => 'No groups yet';

  @override
  String get groupsEmptyAdd =>
      'Use the + button at the bottom right to add a new group.';

  @override
  String get groupsEmptyNoCoach =>
      'Add at least one coach first to create a group.';

  @override
  String get groupsEmptyViewer =>
      'No group records yet. They\'ll appear here once an admin adds a group.';

  @override
  String groupSubtitle(
    String branch,
    String schedule,
    String coach,
    int count,
    int capacity,
  ) {
    return '$branch • $schedule\nCoach: $coach • $count/$capacity students';
  }

  @override
  String get groupDeleteTitle => 'Delete Group';

  @override
  String groupDeleteConfirm(String name) {
    return 'Are you sure you want to delete the group $name';
  }

  @override
  String get groupDeleted => 'Group deleted.';

  @override
  String get groupDetailTitle => 'Group Details';

  @override
  String get unknownStudent => 'Unknown student';

  @override
  String get fieldGroupName => 'Group Name';

  @override
  String get fieldSchedule => 'Schedule';

  @override
  String get fieldCapacity => 'Capacity';

  @override
  String get fieldDay => 'Day';

  @override
  String get fieldTime => 'Time';

  @override
  String capacityPeople(int count, int capacity) {
    return '$count/$capacity people';
  }

  @override
  String membersTitle(int count) {
    return 'Members ($count)';
  }

  @override
  String get noMembersAssigned => 'No students assigned yet.';

  @override
  String get editGroup => 'Edit Group';

  @override
  String get backToGroupList => 'Back to Group List';

  @override
  String get addGroup => 'Add New Group';

  @override
  String get saveGroup => 'Save Group';

  @override
  String get groupsNeedCoach =>
      'You must add at least one coach first to create a group.';

  @override
  String get groupNameEmpty => 'Group name cannot be empty.';

  @override
  String get groupNameMinLength => 'Group name must be at least 2 characters.';

  @override
  String get coachRequired => 'You must select a coach.';

  @override
  String get dayRequired => 'You must select a day.';

  @override
  String get capacityEmpty => 'Capacity cannot be empty.';

  @override
  String get capacityMustBeNumber => 'Capacity must be a number.';

  @override
  String get capacityPositive => 'Capacity must be greater than 0.';

  @override
  String get capacityMax => 'Capacity must not exceed 100.';

  @override
  String get membersLabel => 'Members';

  @override
  String get noStudentSelected => 'No students selected';

  @override
  String studentsSelected(int count) {
    return '$count students selected';
  }

  @override
  String get membersNeedStudents =>
      'Student records are required first to add members.';

  @override
  String get selectCoachFirst => 'You must select a coach first.';

  @override
  String studentsExceedCapacity(int count, int capacity) {
    return 'The number of selected students ($count) exceeds the capacity ($capacity).';
  }

  @override
  String get selectMembersTitle => 'Select Members';

  @override
  String selectedCount(int count) {
    return '$count selected';
  }

  @override
  String selectedCountOf(int count, int capacity) {
    return '$count/$capacity selected';
  }

  @override
  String get capacityExceeded => 'Capacity exceeded';

  @override
  String get noStudentsTitle => 'No students';

  @override
  String get noStudentsBody => 'Students must be added first.';

  @override
  String studentBranchAge(String branch, int age) {
    return '$branch • age $age';
  }

  @override
  String get usersSearchHint => 'Search email';

  @override
  String get usersEmptyTitle => 'No users';

  @override
  String get usersEmptyBody => 'No registered users yet.';

  @override
  String get noEmail => '(no email)';

  @override
  String get youLabel => '(you)';

  @override
  String get cannotChangeOwnRole => 'You can\'t change your own role here.';

  @override
  String get roleUpdateError => 'An error occurred while updating the role.';

  @override
  String userRoleUpdated(String email, String role) {
    return '$email → updated to $role.';
  }

  @override
  String get changeRoleTitle => 'Change Role';

  @override
  String get parentAssignHint =>
      'Student assignment is done from the \"Parents\" screen.';

  @override
  String get studentAssignHint =>
      'Student matching is done from the \"Student Accounts\" screen.';

  @override
  String get parentsEmptyTitle => 'No parents yet';

  @override
  String get parentsEmptyBody =>
      'Use the + button at the bottom right to add a parent. The parent must register in the app first.';

  @override
  String get parentAdded => 'Parent added.';

  @override
  String get parentAddError => 'An error occurred while adding the parent.';

  @override
  String get removeParentTitle => 'Remove Parent';

  @override
  String removeParentConfirm(String email) {
    return '$email will no longer be a parent and student assignments will be removed. Continue?';
  }

  @override
  String get removeAction => 'Remove';

  @override
  String get addParentTitle => 'Add Parent';

  @override
  String get addParentHint =>
      'Enter the parent\'s email address registered in the app. The parent must register first.';

  @override
  String get noStudentAssigned => 'No student assigned';

  @override
  String studentsAssigned(String names) {
    return 'Students: $names';
  }

  @override
  String get assignStudentsTitle => 'Assign Students';

  @override
  String accountAssignHeader(String label, String email) {
    return '$label: $email';
  }

  @override
  String get studentAccountAdded => 'Student account added.';

  @override
  String get studentAccountAddError =>
      'An error occurred while adding the student account.';

  @override
  String get removeAccountTitle => 'Remove Account';

  @override
  String removeAccountConfirm(String email) {
    return '$email will no longer be a student and the student link will be removed. Continue?';
  }

  @override
  String get studentAccountsEmptyTitle => 'No student accounts yet';

  @override
  String get studentAccountsEmptyBody =>
      'Use the + button at the bottom right to add a student account. The student must register in the app first.';

  @override
  String get studentNotLinked => 'No student linked';

  @override
  String studentLinked(String name) {
    return 'Student: $name';
  }

  @override
  String get addStudentAccountTitle => 'Add Student Account';

  @override
  String get addStudentAccountHint =>
      'Enter the student\'s email address registered in the app. The student must register first.';

  @override
  String get accountLabelStudent => 'Student account';

  @override
  String photoPickError(Object error) {
    return 'Couldn\'t pick photo: $error';
  }

  @override
  String get profileUpdated => 'Profile updated.';

  @override
  String profileSaveError(Object error) {
    return 'Couldn\'t save: $error';
  }

  @override
  String get pickPhoto => 'Choose photo';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get nameTooLong => 'Name is too long.';

  @override
  String get phoneTooLong => 'Phone number is too long.';

  @override
  String get commonSaving => 'Saving...';

  @override
  String get attendanceDeleteTitle => 'Delete Attendance';

  @override
  String attendanceDeleteConfirm(String group, String date) {
    return 'Are you sure you want to delete the $group - $date attendance record';
  }

  @override
  String get attendanceDeleted => 'Attendance record deleted.';

  @override
  String get attendanceEmptyTitle => 'No attendance records yet';

  @override
  String get attendanceEmptyAdmin =>
      'Use the + button at the bottom right to add a new attendance record.';

  @override
  String get attendanceEmptyNoGroup =>
      'To take attendance, first add at least one group and student.';

  @override
  String get attendanceEmptyViewer =>
      'No attendance records yet. They will appear here once the admin adds attendance.';

  @override
  String attendanceCountLine(int present, int absent) {
    return 'Present: $present • Absent: $absent';
  }

  @override
  String get takeAttendanceTitle => 'Take Attendance';

  @override
  String get editAttendanceTitle => 'Edit Attendance';

  @override
  String get selectGroupFirst => 'Select a group first.';

  @override
  String get fieldGroup => 'Group';

  @override
  String get groupRequired => 'You must select a group.';

  @override
  String get fieldDate => 'Date';

  @override
  String studentsCountTitle(int count) {
    return 'Students ($count)';
  }

  @override
  String get groupNoStudentsTitle => 'No students in this group.';

  @override
  String get groupNoStudentsBody =>
      'You can add students from the group details.';

  @override
  String get saveAttendance => 'Save Attendance';

  @override
  String get attendanceNeedGroupStudent =>
      'To take attendance, you must first add at least one group and student.';

  @override
  String get attendanceDetailTitle => 'Attendance Detail';

  @override
  String get presentStudentsTitle => 'Present Students';

  @override
  String get noPresentStudents => 'No present students.';

  @override
  String get absentStudentsTitle => 'Absent Students';

  @override
  String get noAbsentStudents => 'No absent students.';

  @override
  String get backToAttendanceList => 'Back to Attendance List';

  @override
  String get childAttendanceEmptyTitle => 'No attendance records';

  @override
  String get childAttendanceEmptyBody =>
      'No attendance record including your child has been created yet.';

  @override
  String attendedOfLessons(int total, int present) {
    return 'Attended $present of $total lessons';
  }

  @override
  String percentValue(int percent) {
    return '$percent%';
  }

  @override
  String get paymentDeleteTitle => 'Delete Payment';

  @override
  String paymentDeleteConfirm(String name, String period) {
    return 'Are you sure you want to delete the $name - $period payment record';
  }

  @override
  String get paymentDeleted => 'Payment record deleted.';

  @override
  String get periodLabel => 'Period:';

  @override
  String get allPeriods => 'All periods';

  @override
  String get paymentsSearchHint => 'Search payments';

  @override
  String get paymentsEmptyTitle => 'No payment records yet';

  @override
  String get paymentsEmptyAdmin =>
      'Use the + button at the bottom right to add a new payment record.';

  @override
  String get paymentsEmptyNoStudent =>
      'To add a payment, first add at least one student.';

  @override
  String get paymentsEmptyViewer =>
      'No payment records yet. They will appear here once the admin adds a payment.';

  @override
  String paymentsNoStatusResults(String status) {
    return 'No records with \"$status\" status. Choose a different filter or \"All\".';
  }

  @override
  String get remindTooltip => 'Send reminder';

  @override
  String get noParentPhone =>
      'The student\'s parent phone number is not saved.';

  @override
  String get paymentCollectedLabel => 'Collected';

  @override
  String recordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count records',
      one: '1 record',
    );
    return '$_temp0';
  }

  @override
  String get paymentDetailTitle => 'Payment Detail';

  @override
  String get fieldPeriod => 'Month / Period';

  @override
  String get fieldAmount => 'Amount';

  @override
  String get fieldStatus => 'Status';

  @override
  String get fieldNote => 'Note';

  @override
  String get noNote => 'No note.';

  @override
  String get remindViaWhatsApp => 'Remind via WhatsApp';

  @override
  String get editPaymentTitle => 'Edit Payment';

  @override
  String get backToPaymentList => 'Back to Payment List';

  @override
  String get addPaymentTitle => 'Add New Payment';

  @override
  String get paymentNeedStudent =>
      'To add a payment, you must first add at least one student.';

  @override
  String get studentRequired => 'You must select a student.';

  @override
  String get periodEmpty => 'Month / period cannot be empty.';

  @override
  String get amountEmpty => 'Amount cannot be empty.';

  @override
  String get amountMustBeNumber => 'Amount must be a number.';

  @override
  String get amountPositive => 'Amount must be greater than 0.';

  @override
  String get amountTooHigh => 'Amount seems too high.';

  @override
  String get statusRequired => 'You must select a status.';

  @override
  String get noteHint => 'Optional note';

  @override
  String get selectStudentFirst => 'Select a student first.';

  @override
  String get savePayment => 'Save Payment';

  @override
  String get leaveReported => 'Leave request submitted.';

  @override
  String get leaveDeleteTitle => 'Delete leave request';

  @override
  String get leaveDeleteConfirm => 'Do you want to delete this leave request?';

  @override
  String get newLeave => 'New Leave Request';

  @override
  String get leaveEmptyTitle => 'No leave requests';

  @override
  String get leaveEmptyParent =>
      'You haven\'t submitted any leave requests yet. Use the button at the bottom right to add one.';

  @override
  String get leaveEmptyStaff => 'No leave requests have been submitted yet.';

  @override
  String get cancelLeaveAction => 'Cancel';

  @override
  String get reasonRequired => 'Please write a reason.';

  @override
  String dateWithValue(String date) {
    return 'Date: $date';
  }

  @override
  String get fieldReason => 'Reason';

  @override
  String get reasonHint => 'e.g. Medical report, family visit...';

  @override
  String get sendAction => 'Send';

  @override
  String get performanceAnalysisTitle => 'Performance Analysis';

  @override
  String recordAddError(Object error) {
    return 'Couldn\'t add record: $error';
  }

  @override
  String recordDeleteError(Object error) {
    return 'Couldn\'t delete record: $error';
  }

  @override
  String get recordDeleteTitle => 'Delete Record';

  @override
  String performanceDeleteConfirm(String date) {
    return 'Are you sure you want to delete the performance record dated $date?';
  }

  @override
  String get noStudentFound => 'No student found';

  @override
  String get performanceEmptyManage =>
      'To enter performance, a student must be added first.';

  @override
  String get performanceEmptyParent =>
      'No student has been assigned to your account yet. Please contact the sports school management.';

  @override
  String get addPerformance => 'Add Performance';

  @override
  String get noPerformanceForStudent =>
      'No performance record for this student yet.';

  @override
  String get comparisonByDate => 'Comparison by Date';

  @override
  String get recordsTitle => 'Records';

  @override
  String get selectAction => 'Select';

  @override
  String get scoresLabel => 'Scores (0-100)';

  @override
  String get metricJump => 'Jump';

  @override
  String get metricSpeed => 'Speed';

  @override
  String get metricEndurance => 'Endurance';

  @override
  String get metricFlexibility => 'Flexibility';

  @override
  String get metricBallControl => 'Ball Control';

  @override
  String get announcementDeleteTitle => 'Delete Announcement';

  @override
  String announcementDeleteConfirm(String title) {
    return 'Are you sure you want to delete the announcement titled $title';
  }

  @override
  String get announcementDeleted => 'Announcement deleted.';

  @override
  String get announcementsEmptyTitle => 'No announcements yet';

  @override
  String get announcementsEmptyAdmin =>
      'Use the + button at the bottom right to add a new announcement.';

  @override
  String get announcementsEmptyViewer =>
      'No announcements yet. They will appear here once the admin adds an announcement.';

  @override
  String get announcementDetailTitle => 'Announcement Detail';

  @override
  String get fieldTitle => 'Title';

  @override
  String get fieldTargetAudience => 'Target Audience';

  @override
  String get editAnnouncementTitle => 'Edit Announcement';

  @override
  String get backToAnnouncementList => 'Back to Announcement List';

  @override
  String get addAnnouncementTitle => 'Add New Announcement';

  @override
  String get titleHint => 'Training time change';

  @override
  String get titleEmpty => 'Title cannot be empty.';

  @override
  String get titleMinLength => 'Title must be at least 3 characters.';

  @override
  String get fieldContent => 'Content';

  @override
  String get contentHint => 'Write the announcement content...';

  @override
  String get contentEmpty => 'Content cannot be empty.';

  @override
  String get contentMinLength => 'Content must be at least 10 characters.';

  @override
  String get audienceRequired => 'You must select a target audience.';

  @override
  String get saveAnnouncement => 'Save Announcement';

  @override
  String get audienceEveryone => 'Everyone';

  @override
  String eventAddError(Object error) {
    return 'Couldn\'t add event: $error';
  }

  @override
  String eventDeleteError(Object error) {
    return 'Couldn\'t delete event: $error';
  }

  @override
  String get eventDeleteTitle => 'Delete Event';

  @override
  String eventDeleteConfirm(String title) {
    return 'Do you want to delete the event $title?';
  }

  @override
  String get eventsEmptyTitle => 'No planned events';

  @override
  String get eventsEmptyManage =>
      'Use the + button at the bottom right to add a new event.';

  @override
  String get eventsEmptyViewer =>
      'Events will appear here once coaches plan them.';

  @override
  String get addEvent => 'Add Event';

  @override
  String get selectAttendanceFirst => 'Please select attendance status first.';

  @override
  String get responseAlreadySaved => 'Your response is already saved.';

  @override
  String responseSendError(Object error) {
    return 'Couldn\'t send response: $error';
  }

  @override
  String get responseSent => 'Your response has been sent.';

  @override
  String attendingCount(int count) {
    return 'Attending: $count';
  }

  @override
  String notAttendingCount(int count) {
    return 'Not attending: $count';
  }

  @override
  String eventDateLabel(String date) {
    return 'Event date: $date';
  }

  @override
  String get willAttend => 'Attending';

  @override
  String get willNotAttend => 'Not attending';

  @override
  String get sendingLabel => 'Sending...';

  @override
  String get sentLabel => 'Sent';

  @override
  String get addEventTitle => 'New Event';

  @override
  String get fieldEventName => 'Event Name';

  @override
  String get eventNameHint => 'Friendly match';

  @override
  String get eventNameEmpty => 'Event name cannot be empty.';

  @override
  String get fieldDescriptionOptional => 'Description (optional)';

  @override
  String get saveEvent => 'Save Event';

  @override
  String get cashDeleteTitle => 'Delete entry';

  @override
  String cashDeleteConfirm(String title) {
    return 'Do you want to delete the \"$title\" entry?';
  }

  @override
  String get newCashEntry => 'New Entry';

  @override
  String get cashEmptyTitle => 'Cash box is empty';

  @override
  String get cashEmptyBody =>
      'No income/expense records yet. Add the first entry with the button at the bottom right.';

  @override
  String get currentBalance => 'Current Balance';

  @override
  String get totalIncome => 'Total Income';

  @override
  String get totalExpense => 'Total Expense';

  @override
  String get titleRequired => 'Please write a title.';

  @override
  String get amountInvalid => 'Please enter a valid amount.';

  @override
  String get cashTitleHint => 'e.g. March dues, hall rent...';

  @override
  String get fieldAmountCurrency => 'Amount (₺)';

  @override
  String get fieldCategory => 'Category';

  @override
  String get fieldNoteOptional => 'Note (optional)';

  @override
  String get equipmentDeleteTitle => 'Delete item';

  @override
  String equipmentDeleteConfirm(String name) {
    return 'Do you want to delete the \"$name\" record?';
  }

  @override
  String get newEquipment => 'New Item';

  @override
  String get equipmentEmptyTitle => 'Storage is empty';

  @override
  String get equipmentEmptyManage =>
      'No items yet. Add the first record with the button at the bottom right.';

  @override
  String get equipmentEmptyViewer => 'No items have been added to storage yet.';

  @override
  String get noResultTitle => 'No results';

  @override
  String get noResultInCategory => 'No items in this category.';

  @override
  String get equipmentSummaryTitle => 'Storage Summary';

  @override
  String get metricVariety => 'Types';

  @override
  String get metricTotalQuantity => 'Total Quantity';

  @override
  String get metricAttention => 'Attention';

  @override
  String assignedPrefix(String who) {
    return 'Assigned: $who';
  }

  @override
  String get editEquipment => 'Edit Item';

  @override
  String get fieldEquipmentName => 'Item name';

  @override
  String get equipmentNameHint => 'e.g. Football, jersey...';

  @override
  String get equipmentNameRequired => 'Please write the item name.';

  @override
  String get quantityMustBePositive => 'Quantity must be greater than 0.';

  @override
  String get fieldQuantity => 'Quantity';

  @override
  String get fieldAssignedOptional => 'Assigned to (optional)';

  @override
  String get assignedHint => 'Who / where';

  @override
  String get conditionGood => 'Good';

  @override
  String get conditionMaintenance => 'In maintenance';

  @override
  String get conditionWorn => 'Worn';

  @override
  String get generalSummary => 'General Summary';

  @override
  String get paymentSummary => 'Payment Summary';

  @override
  String get paidPayments => 'Paid payments';

  @override
  String get pendingPayments => 'Pending payments';

  @override
  String get statusComment => 'Status Overview';

  @override
  String get reportsNoData =>
      'Not enough data yet. As student, group and payment records are added, a general status summary will appear here.';

  @override
  String reportsSummary(
    int students,
    int coaches,
    int groups,
    int payments,
    int paid,
    int pending,
  ) {
    return 'The system has $students students, $coaches coaches and $groups groups. Of $payments total payment records, $paid are paid and $pending are pending.';
  }
}
