import 'package:flutter/material.dart';

import '../constants/app_roles.dart';
import '../models/app_models.dart';
import '../widgets/empty_state.dart';

/// Admin'in tüm kullanıcıların rolünü yönettiği ekran.
///
/// Kullanıcılar uygulamaya normal kayıt olur (rol 'viewer'). Admin buradan
/// herhangi bir hesabı admin / antrenör / veli / görüntüleyici yapabilir.
/// Veliye öğrenci ataması ayrı "Veliler" ekranından yapılır.
class UsersScreen extends StatefulWidget {
  final List<UserAccount> users;
  final String currentUserUid;
  final Future<void> Function(String uid, String role) onSetRole;

  const UsersScreen({
    super.key,
    required this.users,
    required this.currentUserUid,
    required this.onSetRole,
  });

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String _searchQuery = '';

  Future<void> _openChangeRoleDialog(UserAccount user) async {
    if (user.uid == widget.currentUserUid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kendi rolünü buradan değiştiremezsin.'),
        ),
      );
      return;
    }

    final selectedRole = await showDialog<String>(
      context: context,
      builder: (context) => _ChangeRoleDialog(user: user),
    );

    if (selectedRole == null || selectedRole == user.role) {
      return;
    }

    try {
      await widget.onSetRole(user.uid, selectedRole);

      if (!mounted) {
        return;
      }

      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${user.email} → ${AppRoleLabels.of(selectedRole)} olarak güncellendi.',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      final message = error is StateError
          ? error.message
          : 'Rol güncellenirken bir hata oluştu.';

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchQuery.trim().toLowerCase();
    final filteredUsers = query.isEmpty
        ? widget.users
        : widget.users
              .where((user) => user.email.toLowerCase().contains(query))
              .toList();

    // Admin > antrenör > veli > görüntüleyici sırasıyla, sonra e-postaya göre.
    final sortedUsers = [...filteredUsers]
      ..sort((a, b) {
        final rankCompare = _roleRank(a.role).compareTo(_roleRank(b.role));
        if (rankCompare != 0) {
          return rankCompare;
        }
        return a.email.toLowerCase().compareTo(b.email.toLowerCase());
      });

    return Scaffold(
      appBar: AppBar(title: const Text('Kullanıcılar')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'E-posta ara',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: widget.users.isEmpty
                ? const EmptyState(
                    icon: Icons.manage_accounts,
                    title: 'Kullanıcı yok',
                    message: 'Henüz kayıtlı kullanıcı bulunmuyor.',
                  )
                : sortedUsers.isEmpty
                ? const EmptyState(
                    icon: Icons.search_off,
                    title: 'Sonuç bulunamadı',
                    message: 'Arama metnini değiştirerek tekrar dene.',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: sortedUsers.length,
                    itemBuilder: (context, index) {
                      final user = sortedUsers[index];
                      final isSelf = user.uid == widget.currentUserUid;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          onTap: () => _openChangeRoleDialog(user),
                          leading: CircleAvatar(
                            backgroundColor: AppRoleLabels.color(user.role),
                            foregroundColor: Colors.white,
                            child: Icon(AppRoleLabels.icon(user.role)),
                          ),
                          title: Text(
                            user.email.isEmpty ? '(e-posta yok)' : user.email,
                          ),
                          subtitle: Text(
                            isSelf
                                ? '${AppRoleLabels.of(user.role)} • (sen)'
                                : AppRoleLabels.of(user.role),
                          ),
                          trailing: isSelf
                              ? null
                              : const Icon(Icons.chevron_right),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  int _roleRank(String role) {
    switch (role) {
      case AppRoles.admin:
        return 0;
      case AppRoles.coach:
        return 1;
      case AppRoles.parent:
        return 2;
      default:
        return 3;
    }
  }
}

/// Tek bir kullanıcının rolünü seçtiren diyalog.
class _ChangeRoleDialog extends StatefulWidget {
  final UserAccount user;

  const _ChangeRoleDialog({required this.user});

  @override
  State<_ChangeRoleDialog> createState() => _ChangeRoleDialogState();
}

class _ChangeRoleDialogState extends State<_ChangeRoleDialog> {
  late String _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = AppRoles.isValid(widget.user.role)
        ? widget.user.role
        : AppRoles.viewer;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rol Değiştir'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.user.email,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...AppRoles.all.map((role) {
            final isSelected = role == _selectedRole;
            return ListTile(
              onTap: () {
                setState(() {
                  _selectedRole = role;
                });
              },
              leading: Icon(
                AppRoleLabels.icon(role),
                color: AppRoleLabels.color(role),
              ),
              title: Text(AppRoleLabels.of(role)),
              trailing: isSelected
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.radio_button_unchecked,
                      color: Colors.grey),
              contentPadding: EdgeInsets.zero,
            );
          }),
          if (_selectedRole == AppRoles.parent)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'Öğrenci ataması "Veliler" ekranından yapılır.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Vazgeç'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _selectedRole),
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}

/// Rollerin Türkçe etiketleri, ikonları ve renkleri (tek yerde).
class AppRoleLabels {
  const AppRoleLabels._();

  static String of(String role) {
    switch (role) {
      case AppRoles.admin:
        return 'Yönetici';
      case AppRoles.coach:
        return 'Antrenör';
      case AppRoles.parent:
        return 'Veli';
      case AppRoles.viewer:
        return 'Görüntüleyici';
      default:
        return 'Bilinmeyen';
    }
  }

  static IconData icon(String role) {
    switch (role) {
      case AppRoles.admin:
        return Icons.admin_panel_settings;
      case AppRoles.coach:
        return Icons.sports;
      case AppRoles.parent:
        return Icons.family_restroom;
      default:
        return Icons.visibility;
    }
  }

  static Color color(String role) {
    switch (role) {
      case AppRoles.admin:
        return Colors.deepPurple;
      case AppRoles.coach:
        return Colors.teal;
      case AppRoles.parent:
        return Colors.indigo;
      default:
        return Colors.blueGrey;
    }
  }
}
