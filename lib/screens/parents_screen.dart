import 'package:flutter/material.dart';

import '../widgets/wave_background.dart';

import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../theme/app_colors.dart';
import '../widgets/empty_state.dart';

/// Admin'in velileri yönettiği ekran.
///
/// Veli, uygulamaya normal kayıt olduktan sonra admin buradan e-postasıyla
/// bulup 'veli' rolüne yükseltir ve ona öğrenci(ler) atar.
class ParentsScreen extends StatefulWidget {
  final List<ParentAccount> parents;
  final List<Student> students;
  final Future<void> Function(String email) onAddParent;
  final Future<void> Function(String uid, List<String> studentIds)
  onAssignStudents;
  final Future<void> Function(String uid) onRemoveParent;

  const ParentsScreen({
    super.key,
    required this.parents,
    required this.students,
    required this.onAddParent,
    required this.onAssignStudents,
    required this.onRemoveParent,
  });

  @override
  State<ParentsScreen> createState() => _ParentsScreenState();
}

class _ParentsScreenState extends State<ParentsScreen> {
  String _studentName(String studentId) {
    for (final student in widget.students) {
      if (student.id == studentId) {
        return student.name;
      }
    }
    return AppLocalizations.of(context).unknownStudent;
  }

  Future<void> _openAddParentDialog() async {
    final l10n = AppLocalizations.of(context);
    final email = await showDialog<String>(
      context: context,
      builder: (context) => const _AddParentDialog(),
    );

    if (email == null) {
      return;
    }

    try {
      await widget.onAddParent(email);

      if (!mounted) {
        return;
      }

      setState(() {});
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.parentAdded)));
    } catch (error) {
      if (!mounted) {
        return;
      }

      final message = error is StateError
          ? error.message
          : l10n.parentAddError;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _openAssignStudents(ParentAccount parent) async {
    final selected = await Navigator.push<List<String>>(
      context,
      MaterialPageRoute(
        builder: (context) => AssignStudentsScreen(
          parent: parent,
          students: widget.students,
          accountLabel: AppLocalizations.of(context).roleParent,
        ),
      ),
    );

    if (selected == null) {
      return;
    }

    await widget.onAssignStudents(parent.uid, selected);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmRemoveParent(ParentAccount parent) async {
    final l10n = AppLocalizations.of(context);
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.removeParentTitle),
          content: Text(l10n.removeParentConfirm(parent.email)),
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

    await widget.onRemoveParent(parent.uid);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.navParents)),
      body: widget.parents.isEmpty
          ? EmptyState(
              icon: Icons.family_restroom,
              title: l10n.parentsEmptyTitle,
              message: l10n.parentsEmptyBody,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.parents.length,
              itemBuilder: (context, index) {
                final parent = widget.parents[index];
                final childNames = parent.studentIds
                    .map(_studentName)
                    .join(', ');

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () => _openAssignStudents(parent),
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.family_restroom),
                    ),
                    title: Text(parent.email),
                    subtitle: Text(
                      parent.studentIds.isEmpty
                          ? l10n.noStudentAssigned
                          : l10n.studentsAssigned(childNames),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.person_remove, color: Colors.red),
                      onPressed: () => _confirmRemoveParent(parent),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddParentDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// E-posta ile veli ekleme diyaloğu.
///
/// Controller'ı kendi State'inde tuttuğu için diyalog kapanış animasyonu
/// bitene kadar yaşar ve ancak tamamen kaldırıldığında dispose edilir.
/// (Controller'ı `showDialog` dönüşünde manuel dispose etmek, animasyon
/// sürerken "used after being disposed" hatasına yol açıyordu.)
class _AddParentDialog extends StatefulWidget {
  const _AddParentDialog();

  @override
  State<_AddParentDialog> createState() => _AddParentDialogState();
}

class _AddParentDialogState extends State<_AddParentDialog> {
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
      title: Text(l10n.addParentTitle),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.addParentHint,
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
        TextButton(onPressed: _submit, child: Text(l10n.commonAdd)),
      ],
    );
  }
}

/// Bir veliye/öğrenciye öğrenci atama ekranı.
///
/// Veli için çoklu seçim (birden fazla çocuk), öğrenci hesabı için tek seçim
/// ([singleSelect] = true; hesap yalnızca kendi öğrenci kaydına eşlenir).
class AssignStudentsScreen extends StatefulWidget {
  final ParentAccount parent;
  final List<Student> students;

  /// true ise yalnızca tek öğrenci seçilebilir (öğrenci hesabı eşleştirmesi).
  final bool singleSelect;

  /// Başlıkta gösterilen hesap etiketi ("Veli" / "Öğrenci").
  final String accountLabel;

  const AssignStudentsScreen({
    super.key,
    required this.parent,
    required this.students,
    this.singleSelect = false,
    this.accountLabel = 'Veli',
  });

  @override
  State<AssignStudentsScreen> createState() => _AssignStudentsScreenState();
}

class _AssignStudentsScreenState extends State<AssignStudentsScreen> {
  late final Set<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = {...widget.parent.studentIds};
  }

  void _toggle(String studentId, bool checked) {
    setState(() {
      if (widget.singleSelect) {
        // Tek seçim: yeni seçim öncekini değiştirir.
        _selected
          ..clear()
          ..add(studentId);
        return;
      }
      if (checked) {
        _selected.add(studentId);
      } else {
        _selected.remove(studentId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(
        title: Text(l10n.assignStudentsTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, _selected.toList()),
            child: Text(
              l10n.commonSave,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: widget.students.isEmpty
          ? EmptyState(
              icon: Icons.people_outline,
              title: l10n.noStudentsTitle,
              message: l10n.noStudentsBody,
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    l10n.accountAssignHeader(
                      widget.accountLabel,
                      widget.parent.email,
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ...widget.students.map((student) {
                  final selected = _selected.contains(student.id);
                  final subtitle = Text(
                    l10n.studentBranchAge(student.branch, student.age),
                  );
                  if (widget.singleSelect) {
                    // Tek seçim: radyo görünümlü ListTile (deprecation'sız).
                    return ListTile(
                      onTap: () => _toggle(student.id, true),
                      title: Text(student.name),
                      subtitle: subtitle,
                      trailing: Icon(
                        selected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: selected ? AppColors.primary : Colors.grey,
                      ),
                    );
                  }
                  return CheckboxListTile(
                    value: selected,
                    title: Text(student.name),
                    subtitle: subtitle,
                    onChanged: (checked) =>
                        _toggle(student.id, checked == true),
                  );
                }),
              ],
            ),
    );
  }
}
