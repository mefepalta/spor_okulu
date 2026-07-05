import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/user_role_service.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _canOpenDashboard(User user) async {
    await user.reload();

    final refreshedUser = AuthService().currentUser;
    final userRole = await UserRoleService().getCurrentUserRole();

    return (refreshedUser?.emailVerified ?? user.emailVerified) ||
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
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;

        if (user == null) {
          return const LoginScreen();
        }

        return FutureBuilder<bool>(
          future: _canOpenDashboard(user),
          builder: (context, roleSnapshot) {
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
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
