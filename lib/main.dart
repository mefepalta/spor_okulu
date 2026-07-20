import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'theme/app_colors.dart';

import 'constants/app_constants.dart';
import 'constants/app_info.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'routes/app_routes.dart';
import 'screens/auth_gate.dart';
import 'theme/app_theme.dart';
import 'theme/background_controller.dart';
import 'theme/locale_controller.dart';
import 'theme/theme_controller.dart';
import 'widgets/app_splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Sürüm numarasını paketten yükle (pubspec ile elle senkron yerine tek kaynak).
  await AppInfo.load();

  runApp(const SporOkuluApp());
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

Widget _limitedTextScaleBuilder(BuildContext context, Widget? child) {
  final mediaQuery = MediaQuery.of(context);

  return MediaQuery(
    data: mediaQuery.copyWith(
      textScaler: mediaQuery.textScaler.clamp(
        minScaleFactor: 0.9,
        maxScaleFactor: 1.15,
      ),
    ),
    child: child ?? const SizedBox.shrink(),
  );
}

class SporOkuluApp extends StatefulWidget {
  const SporOkuluApp({super.key});

  @override
  State<SporOkuluApp> createState() => _SporOkuluAppState();
}

class _SporOkuluAppState extends State<SporOkuluApp> {
  @override
  void initState() {
    super.initState();
    // Kayıtlı aydınlık/karanlık tercihini yükle (yoksa cihaz ayarını kullanır).
    ThemeController.instance.load();
    // Kayıtlı arka plan efekti seviyesini yükle (yoksa yüksek ile başlar).
    BackgroundController.instance.load();
    // Kayıtlı dil tercihini yükle (yoksa cihaz dilini izler).
    LocaleController.instance.load();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance.mode,
      builder: (context, themeMode, _) {
        return ValueListenableBuilder<Locale?>(
          valueListenable: LocaleController.instance.locale,
          builder: (context, locale, _) {
            return MaterialApp(
              title: AppConstants.appTitle,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              // Seçili dil; null ise cihaz dili desteklenenlerle eşleştirilir
              // (eşleşmezse ilk desteklenen dil olan Türkçe kullanılır).
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              // Cihaz/seçili dil desteklenenlerle dil koduna göre eşleştirilir;
              // eşleşme yoksa Türkçe'ye düşülür.
              localeResolutionCallback: (preferred, supported) {
                if (preferred != null) {
                  for (final option in supported) {
                    if (option.languageCode == preferred.languageCode) {
                      return option;
                    }
                  }
                }
                return const Locale('tr');
              },
              initialRoute: AppRoutes.login,
              routes: AppRoutes.routes,
              builder: _limitedTextScaleBuilder,
            );
          },
        );
      },
    );
  }
}

/// Uygulama açılışında Firebase'i başlatır. Hazır olana kadar açılış
/// görselini, hata olursa kurulum ekranını, başarılıysa oturum akışını gösterir.
///
/// Firebase yalnızca bir kez başlatılsın diye future statik tutulur; böylece
/// çıkış yapıp bu route'a geri dönüldüğünde tekrar başlatma denenmez.
class AppBootstrap extends StatefulWidget {
  const AppBootstrap({super.key});

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  static Future<Object?>? _firebaseSetup;

  @override
  void initState() {
    super.initState();
    _firebaseSetup ??= _initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object?>(
      future: _firebaseSetup,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const AppSplashScreen();
        }

        final firebaseSetupError = snapshot.data;

        if (firebaseSetupError != null) {
          return FirebaseSetupScreen(error: firebaseSetupError);
        }

        return const AuthGate();
      },
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
              const Icon(Icons.cloud_off, size: 72, color: AppColors.primary),
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
