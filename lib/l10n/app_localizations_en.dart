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
}
