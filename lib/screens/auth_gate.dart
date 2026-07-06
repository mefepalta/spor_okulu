import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/user_role_service.dart';
import '../widgets/app_splash_screen.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _canOpenDashboard(User user) async {
    // Oturum bilgisini tazelemeye çalış; ağ yavaş/erişilemezse uygulamanın
    // açılış ekranında sonsuza kadar asılı kalmaması için zaman aşımı koy ve
    // önbellekteki bilgilerle devam et.
    try {
      await user.reload().timeout(const Duration(seconds: 8));
    } catch (_) {
      // Yenileme başarısız oldu; elimizdeki mevcut kullanıcı bilgisini kullan.
    }

    final refreshedUser = AuthService().currentUser ?? user;
    final userRole = await UserRoleService().getCurrentUserRole();

    return refreshedUser.emailVerified ||
        userRole == 'admin' ||
        userRole == 'coach';
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppSplashScreen();
        }

        final user = snapshot.data;

        if (user == null) {
          return const LoginScreen();
        }

        return FutureBuilder<bool>(
          future: _canOpenDashboard(user),
          builder: (context, roleSnapshot) {
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return const AppSplashScreen();
            }

            if (roleSnapshot.data == true) {
              return const DashboardScreen();
            }

            return const LoginScreen();
          },
        );
      },
    );
  }
}
