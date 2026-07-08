import 'package:flutter/material.dart';

import '../widgets/wave_background.dart';

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
    return 'Bilinmeyen öğrenci';
  }

  Future<void> _openAddDialog() async {
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
        const SnackBar(content: Text('Öğrenci hesabı eklendi.')),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      final message = error is StateError
          ? error.message
          : 'Öğrenci hesabı eklenirken bir hata oluştu.';

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
          accountLabel: 'Öğrenci hesabı',
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
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hesabı Kaldır'),
          content: Text(
            '${account.email} artık öğrenci olmayacak ve öğrenci eşleşmesi '
            'silinecek. Devam edilsin mi?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Vazgeç'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                'Kaldır',
                style: TextStyle(color: Colors.red),
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
    return WaveScaffold(
      appBar: AppBar(title: const Text('Öğrenci Hesapları')),
      body: widget.accounts.isEmpty
          ? const EmptyState(
              icon: Icons.school,
              title: 'Henüz öğrenci hesabı yok',
              message: 'Öğrenci hesabı eklemek için sağ alttaki + butonunu '
                  'kullan. Öğrencinin önce uygulamaya kayıt olması gerekir.',
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
                          ? 'Öğrenci eşleşmedi'
                          : 'Öğrenci: $linkedName',
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
    return AlertDialog(
      title: const Text('Öğrenci Hesabı Ekle'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Öğrencinin uygulamaya kayıtlı e-posta adresini gir. Öğrenci '
              'önce kendisi kayıt olmalıdır.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              onFieldSubmitted: (_) => _submit(),
              decoration: const InputDecoration(
                labelText: 'E-posta',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'E-posta boş bırakılamaz.';
                }
                if (!value.contains('@')) {
                  return 'Geçerli bir e-posta gir.';
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
          child: const Text('Vazgeç'),
        ),
        TextButton(
          onPressed: _submit,
          child: const Text('Ekle'),
        ),
      ],
    );
  }
}
