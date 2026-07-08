import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/app_info.dart';
import '../models/app_models.dart';
import '../routes/app_routes.dart';
import '../services/profile_service.dart';
import '../theme/app_colors.dart';
import '../theme/background_controller.dart';
import '../theme/theme_controller.dart';
import '../utils/launchers.dart';
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
  bool get isStudent => widget.userRole == 'ogrenci';

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
    if (isStudent) return 'Öğrenci';
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
    if (isStudent) {
      return 'Kendi yoklama ve performans bilgisini görüntüleyebilir.';
    }
    return 'Kayıtları görüntüleyebilir, ancak değişiklik yapamaz.';
  }

  IconData get roleIcon {
    if (isAdmin) return Icons.admin_panel_settings;
    if (isCoach) return Icons.sports;
    if (isParent) return Icons.family_restroom;
    if (isStudent) return Icons.school;
    return Icons.person;
  }

  IconData get roleChipIcon {
    if (isAdmin) return Icons.verified_user;
    if (isCoach) return Icons.sports;
    if (isParent) return Icons.family_restroom;
    if (isStudent) return Icons.school;
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

  Future<void> _openWhatsAppSupport() async {
    await launchWhatsApp(
      context,
      phone: AppInfo.supportPhone,
      message: 'Merhaba, spor okulu uygulaması hakkında destek almak istiyorum.',
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
                _buildAppearanceCard(),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              isStudent ? 'Öğrenci Bilgim' : 'Öğrencilerim',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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

  /// Aydınlık/karanlık/sistem tema tercihi. AppBar'dan buraya taşındı; tercih
  /// [ThemeController] ile kalıcıdır ve tüm uygulamaya anında uygulanır.
  Widget _buildAppearanceCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.brightness_6),
                SizedBox(width: 12),
                Text(
                  'Görünüm',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeController.instance.mode,
              builder: (context, mode, _) {
                return SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<ThemeMode>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: Icon(Icons.brightness_auto),
                        label: Text('Sistem'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: Icon(Icons.light_mode),
                        label: Text('Aydınlık'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: Icon(Icons.dark_mode),
                        label: Text('Karanlık'),
                      ),
                    ],
                    selected: {mode},
                    onSelectionChanged: (selection) {
                      ThemeController.instance.setMode(selection.first);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(Icons.auto_awesome),
                SizedBox(width: 12),
                Text(
                  'Arka plan efekti',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Yüksek: dalga + partikül · Orta: yalnızca dalga · Düşük: sade zemin.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<BackgroundLevel>(
              valueListenable: BackgroundController.instance.level,
              builder: (context, level, _) {
                return SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<BackgroundLevel>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(
                        value: BackgroundLevel.full,
                        icon: Icon(Icons.auto_awesome),
                        label: Text('Yüksek'),
                      ),
                      ButtonSegment(
                        value: BackgroundLevel.waves,
                        icon: Icon(Icons.waves),
                        label: Text('Orta'),
                      ),
                      ButtonSegment(
                        value: BackgroundLevel.none,
                        icon: Icon(Icons.block),
                        label: Text('Düşük'),
                      ),
                    ],
                    selected: {level},
                    onSelectionChanged: (selection) {
                      BackgroundController.instance.setLevel(selection.first);
                    },
                  ),
                );
              },
            ),
          ],
        ),
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
            leading: const Icon(Icons.chat, color: Color(0xFF25D366)),
            title: const Text('WhatsApp Destek'),
            trailing: const Icon(Icons.open_in_new, size: 18),
            onTap: _openWhatsAppSupport,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.gavel_outlined),
            title: const Text('KVKK Aydınlatma Metni'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openInfo(InfoPages.kvkkTitle, InfoPages.kvkk),
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
            leading: const Icon(Icons.info_outline),
            title: const Text('Uygulama Sürümü'),
            trailing: Text(
              'v${AppInfo.version}',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
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
