import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import '../widgets/wave_background.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../utils/validators.dart';
import '../widgets/branch_dropdown.dart';
import '../widgets/empty_state.dart';

class StudentsScreen extends StatefulWidget {
  final List<Student> students;
  final bool isAdmin;
  final Future<void> Function(Student student) onAddStudent;
  final Future<void> Function(int index) onDeleteStudent;
  final Future<void> Function(int index, Student updatedStudent)
  onUpdateStudent;

  const StudentsScreen({
    super.key,
    required this.students,
    required this.isAdmin,
    required this.onAddStudent,
    required this.onDeleteStudent,
    required this.onUpdateStudent,
  });

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  String _searchQuery = '';

  Future<void> _openAddStudentScreen() async {
    final newStudent = await Navigator.push<Student>(
      context,
      MaterialPageRoute(builder: (context) => const AddStudentScreen()),
    );

    if (newStudent == null) {
      return;
    }

    await widget.onAddStudent(newStudent);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _openStudentDetailScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailScreen(
          students: widget.students,
          index: index,
          isAdmin: widget.isAdmin,
          onUpdateStudent: widget.onUpdateStudent,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmDeleteStudent(int index) async {
    final student = widget.students[index];
    final l10n = AppLocalizations.of(context);

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context);
        return AlertDialog(
          title: Text(l10n.studentDeleteTitle),
          content: Text(l10n.studentDeleteConfirm(student.name)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(l10n.commonCancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                l10n.commonDelete,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    await widget.onDeleteStudent(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.studentDeleted)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filteredStudents = widget.students.where((student) {
      final query = _searchQuery.toLowerCase();

      return student.name.toLowerCase().contains(query) ||
          student.branch.toLowerCase().contains(query) ||
          student.parentPhone.toLowerCase().contains(query);
    }).toList();
    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.navStudents)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                labelText: l10n.studentsSearchHint,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: widget.students.isEmpty
                ? EmptyState(
                    icon: Icons.people,
                    title: l10n.studentsEmptyTitle,
                    message: widget.isAdmin
                        ? l10n.studentsEmptyAdmin
                        : l10n.studentsEmptyViewer,
                  )
                : filteredStudents.isEmpty
                ? EmptyState(
                    icon: Icons.search_off,
                    title: l10n.searchNoResults,
                    message: l10n.searchNoResultsBody,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = filteredStudents[index];
                      final originalIndex = widget.students.indexOf(student);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          onTap: () {
                            _openStudentDetailScreen(originalIndex);
                          },
                          leading: const CircleAvatar(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            child: Icon(Icons.person),
                          ),
                          title: Text(student.name),
                          subtitle: Text(
                            l10n.studentSubtitle(
                              student.branch,
                              student.age,
                              student.parentPhone,
                            ),
                          ),
                          isThreeLine: true,
                          trailing: widget.isAdmin
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _confirmDeleteStudent(originalIndex);
                                  },
                                )
                              : null,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton(
              onPressed: _openAddStudentScreen,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class StudentDetailScreen extends StatefulWidget {
  final List<Student> students;
  final int index;
  final bool isAdmin;
  final Future<void> Function(int index, Student updatedStudent)
  onUpdateStudent;

  const StudentDetailScreen({
    super.key,
    required this.students,
    required this.index,
    required this.isAdmin,
    required this.onUpdateStudent,
  });

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  Student get _student => widget.students[widget.index];

  Future<void> _openEditStudentScreen() async {
    final updatedStudent = await Navigator.push<Student>(
      context,
      MaterialPageRoute(
        builder: (context) => AddStudentScreen(student: _student),
      ),
    );

    if (updatedStudent == null) {
      return;
    }

    await widget.onUpdateStudent(widget.index, updatedStudent);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final student = _student;
    final l10n = AppLocalizations.of(context);

    return WaveScaffold(
      appBar: AppBar(
        title: Text(l10n.studentDetailTitle),
        actions: widget.isAdmin
            ? [
                IconButton(
                  onPressed: _openEditStudentScreen,
                  icon: const Icon(Icons.edit),
                ),
              ]
            : null,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(Icons.person, size: 64, color: AppColors.primary),
                  const SizedBox(height: 16),
                  Text(
                    student.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(student.branch),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(l10n.fieldFullName),
              subtitle: Text(student.name),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.cake),
              title: Text(l10n.fieldAge),
              subtitle: Text('${student.age}'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.sports_soccer),
              title: Text(l10n.fieldBranch),
              subtitle: Text(student.branch),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.phone),
              title: Text(l10n.fieldParentPhone),
              subtitle: Text(student.parentPhone),
            ),
          ),
          const SizedBox(height: 20),
          if (widget.isAdmin)
            ElevatedButton.icon(
              onPressed: _openEditStudentScreen,
              icon: const Icon(Icons.edit),
              label: Text(l10n.editStudent),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: Text(l10n.backToStudentList),
          ),
        ],
      ),
    );
  }
}

class AddStudentScreen extends StatefulWidget {
  final Student? student;

  const AddStudentScreen({super.key, this.student});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();

  String? _selectedBranch;

  @override
  void initState() {
    super.initState();

    final student = widget.student;

    if (student != null) {
      _nameController.text = student.name;
      _ageController.text = student.age.toString();
      _selectedBranch = student.branch;
      _parentPhoneController.text = student.parentPhone;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _parentPhoneController.dispose();
    super.dispose();
  }

  void _saveStudent() {
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    final student = Student(
      name: _nameController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      branch: (_selectedBranch ?? '').trim(),
      parentPhone: _parentPhoneController.text.trim(),
    );

    Navigator.pop(context, student);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.student != null;
    final l10n = AppLocalizations.of(context);

    return WaveScaffold(
      appBar: AppBar(
        title: Text(isEditing ? l10n.editStudent : l10n.addStudent),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.fieldFullName,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                  hintText: l10n.fullNameHint,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.fullNameEmpty;
                  }

                  if (value.trim().length < 3) {
                    return l10n.fullNameMinLength;
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                decoration: InputDecoration(
                  labelText: l10n.fieldAge,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.cake),
                  hintText: '12',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.ageEmpty;
                  }

                  final age = int.tryParse(value.trim());

                  if (age == null) {
                    return l10n.ageMustBeNumber;
                  }

                  if (age <= 0) {
                    return l10n.agePositive;
                  }

                  if (age > 99) {
                    return l10n.ageTooHigh;
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              BranchDropdownFormField(
                value: _selectedBranch,
                onChanged: (value) {
                  setState(() {
                    _selectedBranch = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _parentPhoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: InputDecoration(
                  labelText: l10n.fieldParentPhone,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.phone),
                  hintText: '05XXXXXXXXX',
                ),
                validator: phoneValidator(l10n),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveStudent,
                icon: const Icon(Icons.save),
                label: Text(isEditing ? l10n.saveChanges : l10n.saveStudent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
