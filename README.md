# Sports School Management

A Flutter-based sports school management application powered by Firebase.

This application is designed to manage students, coaches, training groups, attendance records, payments, and announcements. Admin users can add, edit, and delete records, while regular users can view the system in read-only mode.

## Features

- Firebase Authentication
- User registration
- Email verification
- Forgot password / password reset
- Admin and viewer role system
- Cloud Firestore database
- Student management
- Coach management
- Training group management
- Attendance records
- Payment records
- Announcement management
- Search functionality
- Reports screen
- Profile screen
- Android and iOS compatible Flutter structure
- Coach role with limited management permissions
- In-app announcement notifications using Firestore realtime updates

## Roles

### Admin

Admin users can:

- Add, edit, and delete students.
- Add, edit, and delete coaches.
- Manage training groups, attendance records, payments, and announcements.
- View reports.

### Viewer

Viewer users can:

- View existing records.
- View reports.
- They cannot add, edit, or delete records.

Newly registered users are automatically created with the `viewer` role.

## Technologies Used

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore
- Firebase Security Rules
- Material Design

## Project Structure

lib/
  constants/
  models/
  routes/
  screens/
  services/
  theme/
  utils/
  widgets/
Firebase Setup

To run this project with your own Firebase project:

Create a new project in Firebase Console.
Enable Email/Password sign-in under Authentication > Sign-in method.
Create a Cloud Firestore database.
Android app package name:
com.mefepalta.sporokulu
iOS bundle id:
com.mefepalta.sporokulu
Generate Firebase configuration using FlutterFire CLI:
flutterfire configure
Deploy Firestore security rules:
firebase deploy --only firestore:rules
Running the Project
flutter pub get
flutter analyze
flutter run
Android Release Build
flutter build apk --release

APK output:

build/app/outputs/flutter-apk/app-release.apk

For Google Play:

flutter build appbundle
iOS Note

Building and testing the iOS version requires macOS and Xcode.

On macOS:

flutter doctor
flutter pub get
flutter analyze
open ios/Runner.xcworkspace
flutter run
Security Note

Firestore data is not stored in this GitHub repository. Application data is stored in Firebase Cloud Firestore.

The following files should not be committed:

.env
serviceAccountKey.json
*.jks
*.keystore
android/key.properties
firebase-debug.log
build/
.dart_tool/
Status

The project has been tested on Android. iOS configuration is prepared, but iOS simulator or real device testing requires a macOS/Xcode environment.
