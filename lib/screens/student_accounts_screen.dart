import 'package:flutter/material.dart';

import '../widgets/wave_background.dart';

import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../widgets/empty_state.dart';
import 'parents_screen.dart';

/// Admin'in öğrenci hesaplarını yönettiği ekran.
///
/// Öğrenci, uygulamaya normal kayıt olduktan sonra admin buradan e-postasıyla
/// bulup 'öğrenci' rolüne yükseltir ve hesabı kendi öğrenci kaydına eşler.
/// Öğrenci hesabı yalnızca tek bir öğrenciye eşlenir; veri modeli veliyle aynı
/// olduğundan ([ParentAccount] + `studentIds`) mevcut atama ekranı yeniden
/// kullanılır ([AssignStudentsScreen] tek seçim modu).
class StudentAccountsScreen extends StatefulWidget {
  final List<ParentAccount> accounts;
  final List<Student> students;
  final Future<void> Function(String email) onAddAccount;
  final Future<void> Function(String uid, List<String> studentIds)
  onAssignStudent;
  final Future<void> Function(String uid) onRemoveAccount;

  const StudentAccountsScreen({
    super.key,
    required this.accounts,
    required this.students,
    required this.onAddAccount,
    required this.onAssignStudent,
    required this.onRemoveAccount,
  });

  @override
  State<StudentAccountsScreen> createState() => _StudentAccountsScreenState();
}

class _StudentAccountsScreenState extends State<StudentAccountsScreen> {
  String _studentName(String studentId) {
    for (final student in widget.students) {
      if (student.id == studentId) {
        return student.name;
      }
    }
    return AppLocalizations.of(context).unknownStudent;
  }

  Future<void> _openAddDialog() async {
    final l10n = AppLocalizations.of(context);
    final email = await showDialog<String>(
      context: context,
      builder: (context) => const _AddStudentAccountDialog(),
    );

    if (email == null) {
      return;
    }

    try {
      await widget.onAddAccount(email);

      if (!mounted) {
        return;
      }

      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.studentAccountAdded)),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      final message = error is StateError
          ? error.message
          : l10n.studentAccountAddError;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _openAssignStudent(ParentAccount account) async {
    final selected = await Navigator.push<List<String>>(
      context,
      MaterialPageRoute(
        builder: (context) => AssignStudentsScreen(
          parent: account,
          students: widget.students,
          singleSelect: true,
          accountLabel: AppLocalizations.of(context).accountLabelStudent,
        ),
      ),
    );

    if (selected == null) {
      return;
    }

    await widget.onAssignStudent(account.uid, selected);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmRemove(ParentAccount account) async {
    final l10n = AppLocalizations.of(context);
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.removeAccountTitle),
          content: Text(l10n.removeAccountConfirm(account.email)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.commonCancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                l10n.removeAction,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (shouldRemove != true) {
      return;
    }

    await widget.onRemoveAccount(account.uid);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.navStudentAccounts)),
      body: widget.accounts.isEmpty
          ? EmptyState(
              icon: Icons.school,
              title: l10n.studentAccountsEmptyTitle,
              message: l10n.studentAccountsEmptyBody,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.accounts.length,
              itemBuilder: (context, index) {
                final account = widget.accounts[index];
                final linkedName = account.studentIds.isEmpty
                    ? null
                    : _studentName(account.studentIds.first);

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () => _openAssignStudent(account),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.school),
                    ),
                    title: Text(account.email),
                    subtitle: Text(
                      linkedName == null
                          ? l10n.studentNotLinked
                          : l10n.studentLinked(linkedName),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.person_remove, color: Colors.red),
                      onPressed: () => _confirmRemove(account),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// E-posta ile öğrenci hesabı ekleme diyaloğu.
class _AddStudentAccountDialog extends StatefulWidget {
  const _AddStudentAccountDialog();

  @override
  State<_AddStudentAccountDialog> createState() =>
      _AddStudentAccountDialogState();
}

class _AddStudentAccountDialogState extends State<_AddStudentAccountDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.addStudentAccountTitle),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.addStudentAccountHint,
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              onFieldSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: l10n.emailLabel,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.emailEmpty;
                }
                if (!value.contains('@')) {
                  return l10n.emailInvalid;
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        TextButton(
          onPressed: _submit,
          child: Text(l10n.commonAdd),
        ),
      ],
    );
  }
}
