import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants/app_constants.dart';
import 'firebase_options.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final firebaseSetupError = await _initializeFirebase();

  runApp(SporOkuluApp(firebaseSetupError: firebaseSetupError));
}

Future<Object?> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return null;
  } catch (error) {
    return error;
  }
}

class SporOkuluApp extends StatelessWidget {
  final Object? firebaseSetupError;

  const SporOkuluApp({super.key, this.firebaseSetupError});

  @override
  Widget build(BuildContext context) {
    if (firebaseSetupError != null) {
      return MaterialApp(
        title: AppConstants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: FirebaseSetupScreen(error: firebaseSetupError!),
      );
    }

    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}

class FirebaseSetupScreen extends StatelessWidget {
  final Object error;

  const FirebaseSetupScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 72, color: Colors.indigo),
              const SizedBox(height: 16),
              const Text(
                'Firebase ayarları bekleniyor',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Firebase Console projesini oluşturup flutterfire configure komutunu çalıştırdıktan sonra uygulama Firebase ile açılacak.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
