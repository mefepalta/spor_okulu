import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/app_models.dart';
import '../routes/app_routes.dart';
import '../services/profile_service.dart';
import '../theme/app_colors.dart';
import '../widgets/wave_background.dart';
import 'edit_account_screen.dart';
import 'info_text_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String userRole;

  /// Veli hesabına bağlı çocuklar (varsa). Yalnızca gösterim amaçlı.
  final List<Student> children;

  const ProfileScreen({
    super.key,
    required this.userRole,
    this.children = const [],
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileService _profileService = ProfileService();

  UserProfile? _profile;
  bool _isLoading = true;

  bool get isAdmin => widget.userRole == 'admin';
  bool get isCoach => widget.userRole == 'coach';
  bool get isParent => widget.userRole == 'veli';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await _profileService.loadMyProfile();
      if (!mounted) {
        return;
      }
      setState(() {
        _profile = profile;
        _isLoading = false;
      });
    } catch (_) {
      // Yükleme başarısızsa Auth bilgisiyle asgari profil göster.
      final user = FirebaseAuth.instance.currentUser;
      if (!mounted) {
        return;
      }
      setState(() {
        _profile = UserProfile(
          uid: user?.uid ?? '',
          email: user?.email ?? '',
          role: widget.userRole,
        );
        _isLoading = false;
      });
    }
  }

  String get roleLabel {
    if (isAdmin) return 'Admin';
    if (isCoach) return 'Antrenör';
    if (isParent) return 'Veli';
    return 'Görüntüleyici';
  }

  String get roleDescription {
    if (isAdmin) {
      return 'Tüm kayıtları ekleyebilir, düzenleyebilir ve silebilir.';
    }
    if (isCoach) {
      return 'Yoklama ve duyuru kayıtlarını yönetebilir. Diğer kayıtları görüntüleyebilir.';
    }
    if (isParent) {
      return 'Çocuğunun performansını takip edebilir ve etkinliklere katılım cevabı verebilir.';
    }
    return 'Kayıtları görüntüleyebilir, ancak değişiklik yapamaz.';
  }

  IconData get roleIcon {
    if (isAdmin) return Icons.admin_panel_settings;
    if (isCoach) return Icons.sports;
    if (isParent) return Icons.family_restroom;
    return Icons.person;
  }

  IconData get roleChipIcon {
    if (isAdmin) return Icons.verified_user;
    if (isCoach) return Icons.sports;
    if (isParent) return Icons.family_restroom;
    return Icons.visibility;
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) {
      return;
    }
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  Future<void> _openEditAccount() async {
    final profile = _profile;
    if (profile == null) {
      return;
    }

    final updated = await Navigator.push<UserProfile>(
      context,
      MaterialPageRoute(
        builder: (context) => EditAccountScreen(profile: profile),
      ),
    );

    if (updated != null && mounted) {
      setState(() {
        _profile = updated;
      });
    }
  }

  void _openInfo(String title, List<String> paragraphs) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            InfoTextScreen(title: title, paragraphs: paragraphs),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WaveScaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildHeaderCard(),
                if (widget.children.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildChildrenCard(),
                ],
                if (isAdmin) ...[
                  const SizedBox(height: 12),
                  _buildRoleCard(),
                ],
                const SizedBox(height: 12),
                _buildMenuCard(),
              ],
            ),
    );
  }

  Widget _buildHeaderCard() {
    final profile = _profile;
    final email = profile?.email ?? '';
    final displayName = profile?.displayName ?? '';
    final phone = profile?.phone ?? '';
    final photoBase64 = profile?.photoBase64 ?? '';

    final avatarImage = photoBase64.isNotEmpty
        ? MemoryImage(base64Decode(photoBase64))
        : null;

    final title = displayName.isNotEmpty
        ? displayName
        : (email.isNotEmpty ? email : 'Kullanıcı');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              backgroundImage: avatarImage,
              child: avatarImage == null
                  ? Icon(roleIcon, size: 46, color: AppColors.primary)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            if (displayName.isNotEmpty && email.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                email,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
            if (phone.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                phone,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
            const SizedBox(height: 12),
            Chip(
              avatar: Icon(roleChipIcon, size: 18),
              label: Text(roleLabel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildrenCard() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              'Öğrencilerim',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          for (final child in widget.children)
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                child: const Icon(Icons.person, color: AppColors.primary),
              ),
              title: Text(child.name),
              subtitle: child.branch.isNotEmpty ? Text(child.branch) : null,
            ),
        ],
      ),
    );
  }

  Widget _buildRoleCard() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.security),
        title: const Text('Yetki'),
        subtitle: Text(roleDescription),
      ),
    );
  }

  Widget _buildMenuCard() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.manage_accounts),
            title: const Text('Hesabı Düzenle'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _openEditAccount,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: const Text('Bize Ulaşın'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openInfo(InfoPages.contactTitle, InfoPages.contact),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Kullanım Koşulları'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openInfo(InfoPages.termsTitle, InfoPages.terms),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Gizlilik Politikası'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openInfo(InfoPages.privacyTitle, InfoPages.privacy),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Çıkış Yap',
              style: TextStyle(color: Colors.red),
            ),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}
