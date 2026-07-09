import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/app_info.dart';
import '../data/info_pages_l10n.dart';
import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../routes/app_routes.dart';
import '../services/profile_service.dart';
import '../theme/app_colors.dart';
import '../theme/background_controller.dart';
import '../theme/locale_controller.dart';
import '../theme/theme_controller.dart';
import '../utils/launchers.dart';
import '../utils/role_l10n.dart';
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

  String _roleDescription(AppLocalizations l10n) {
    if (isAdmin) return l10n.roleDescAdmin;
    if (isCoach) return l10n.roleDescCoach;
    if (isParent) return l10n.roleDescParent;
    if (isStudent) return l10n.roleDescStudent;
    return l10n.roleDescViewer;
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
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildHeaderCard(l10n),
                if (widget.children.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildChildrenCard(l10n),
                ],
                if (isAdmin) ...[
                  const SizedBox(height: 12),
                  _buildRoleCard(l10n),
                ],
                const SizedBox(height: 12),
                _buildAppearanceCard(l10n),
                const SizedBox(height: 12),
                _buildMenuCard(l10n),
              ],
            ),
    );
  }

  Widget _buildHeaderCard(AppLocalizations l10n) {
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
        : (email.isNotEmpty ? email : l10n.profileUserFallback);

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
              label: Text(localizedRole(l10n, widget.userRole)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildrenCard(AppLocalizations l10n) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              isStudent
                  ? l10n.childrenSectionStudent
                  : l10n.childrenSectionParent,
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

  Widget _buildRoleCard(AppLocalizations l10n) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.security),
        title: Text(l10n.authorityTitle),
        subtitle: Text(_roleDescription(l10n)),
      ),
    );
  }

  /// Tema, arka plan efekti ve dil tercihleri. Üçü de ilgili kontrolcüler
  /// aracılığıyla kalıcıdır ve tüm uygulamaya anında uygulanır.
  Widget _buildAppearanceCard(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.brightness_6),
                const SizedBox(width: 12),
                Text(
                  l10n.appearanceTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
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
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: const Icon(Icons.brightness_auto),
                        label: Text(l10n.themeSystem),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: const Icon(Icons.light_mode),
                        label: Text(l10n.themeLight),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: const Icon(Icons.dark_mode),
                        label: Text(l10n.themeDark),
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
            Row(
              children: [
                const Icon(Icons.auto_awesome),
                const SizedBox(width: 12),
                Text(
                  l10n.backgroundEffectTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              l10n.backgroundEffectDesc,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<BackgroundLevel>(
              valueListenable: BackgroundController.instance.level,
              builder: (context, level, _) {
                return SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<BackgroundLevel>(
                    showSelectedIcon: false,
                    segments: [
                      ButtonSegment(
                        value: BackgroundLevel.full,
                        icon: const Icon(Icons.auto_awesome),
                        label: Text(l10n.backgroundHigh),
                      ),
                      ButtonSegment(
                        value: BackgroundLevel.waves,
                        icon: const Icon(Icons.waves),
                        label: Text(l10n.backgroundMedium),
                      ),
                      ButtonSegment(
                        value: BackgroundLevel.none,
                        icon: const Icon(Icons.block),
                        label: Text(l10n.backgroundLow),
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
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.language),
                const SizedBox(width: 12),
                Text(
                  l10n.languageTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<Locale?>(
              valueListenable: LocaleController.instance.locale,
              builder: (context, current, _) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: LocaleController.options.map((option) {
                    final isSystem = option.locale == null;
                    final isSelected = isSystem
                        ? current == null
                        : current != null &&
                              current.languageCode == option.locale!.languageCode;
                    final label =
                        isSystem ? l10n.languageSystem : option.label;
                    return ChoiceChip(
                      label: Text(label),
                      selected: isSelected,
                      onSelected: (_) =>
                          LocaleController.instance.setLocale(option.locale),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(AppLocalizations l10n) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.manage_accounts),
            title: Text(l10n.editAccount),
            trailing: const Icon(Icons.chevron_right),
            onTap: _openEditAccount,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: Text(l10n.contactUs),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openInfo(
              l10n.contactUs,
              localizedInfoParagraphs('contact', Localizations.localeOf(context)),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.chat, color: Color(0xFF25D366)),
            title: Text(l10n.whatsappSupport),
            trailing: const Icon(Icons.open_in_new, size: 18),
            onTap: _openWhatsAppSupport,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.gavel_outlined),
            title: Text(l10n.kvkkTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openInfo(
              l10n.kvkkTitle,
              localizedInfoParagraphs('kvkk', Localizations.localeOf(context)),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(l10n.termsTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openInfo(
              l10n.termsTitle,
              localizedInfoParagraphs('terms', Localizations.localeOf(context)),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(l10n.privacyTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openInfo(
              l10n.privacyTitle,
              localizedInfoParagraphs('privacy', Localizations.localeOf(context)),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.appVersionLabel),
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
            title: Text(
              l10n.logout,
              style: const TextStyle(color: Colors.red),
            ),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}
