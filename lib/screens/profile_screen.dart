import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  final String userRole;

  const ProfileScreen({super.key, required this.userRole});

  bool get isAdmin => userRole == 'admin';
  bool get isCoach => userRole == 'coach';

  String get roleLabel {
    if (isAdmin) {
      return 'Admin';
    }

    if (isCoach) {
      return 'Antrenör';
    }

    return 'Görüntüleyici';
  }

  String get roleDescription {
    if (isAdmin) {
      return 'Tüm kayıtları ekleyebilir, düzenleyebilir ve silebilir.';
    }

    if (isCoach) {
      return 'Yoklama ve duyuru kayıtlarını yönetebilir. Diğer kayıtları görüntüleyebilir.';
    }

    return 'Kayıtları görüntüleyebilir, ancak değişiklik yapamaz.';
  }

  IconData get roleIcon {
    if (isAdmin) {
      return Icons.admin_panel_settings;
    }

    if (isCoach) {
      return Icons.sports;
    }

    return Icons.person;
  }

  IconData get roleChipIcon {
    if (isAdmin) {
      return Icons.verified_user;
    }

    if (isCoach) {
      return Icons.sports;
    }

    return Icons.visibility;
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (!context.mounted) {
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final email = user?.email ?? 'Bilinmeyen kullanıcı';
    final isEmailVerified = user?.emailVerified ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.indigo.shade100,
                    child: Icon(roleIcon, size: 42, color: Colors.indigo),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    email,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    avatar: Icon(roleChipIcon, size: 18),
                    label: Text(roleLabel),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('E-posta'),
                  subtitle: Text(email),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(
                    isEmailVerified ? Icons.check_circle : Icons.error,
                    color: isEmailVerified ? Colors.green : Colors.orange,
                  ),
                  title: const Text('E-posta doğrulama'),
                  subtitle: Text(
                    isEmailVerified ? 'Doğrulandı' : 'Doğrulanmadı',
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.security),
                  title: const Text('Yetki'),
                  subtitle: Text(roleDescription),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {
              _logout(context);
            },
            icon: const Icon(Icons.logout),
            label: const Text('Çıkış Yap'),
          ),
        ],
      ),
    );
  }
}
