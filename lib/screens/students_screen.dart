import 'package:flutter/material.dart';

import '../widgets/wave_background.dart';
import 'package:flutter/services.dart';

import '../models/app_models.dart';
import '../utils/validators.dart';
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

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Öğrenciyi Sil'),
          content: Text(
            '${student.name} adlı öğrenciyi silmek istediğine emin misin',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Vazgeç'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Sil', style: TextStyle(color: Colors.red)),
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
    ).showSnackBar(const SnackBar(content: Text('Öğrenci silindi.')));
  }

  @override
  Widget build(BuildContext context) {
    final filteredStudents = widget.students.where((student) {
      final query = _searchQuery.toLowerCase();

      return student.name.toLowerCase().contains(query) ||
          student.branch.toLowerCase().contains(query) ||
          student.parentPhone.toLowerCase().contains(query);
    }).toList();
    return WaveScaffold(
      appBar: AppBar(title: const Text('Öğrenciler')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Öğrenci ara',
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
            child: widget.students.isEmpty
                ? EmptyState(
                    icon: Icons.people,
                    title: 'Henüz öğrenci yok',
                    message: widget.isAdmin
                        ? 'Yeni öğrenci eklemek için sağ alttaki + butonunu kullan.'
                        : 'Henüz öğrenci kaydı yok. Admin öğrenci eklediçinde burada görünecek.',
                  )
                : filteredStudents.isEmpty
                ? const EmptyState(
                    icon: Icons.search_off,
                    title: 'Sonuç bulunamadı',
                    message: 'Arama metnini değiştirerek tekrar dene.',
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
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            child: Icon(Icons.person),
                          ),
                          title: Text(student.name),
                          subtitle: Text(
                            '${student.branch} • ${student.age} yaş\n'
                            'Veli: ${student.parentPhone}',
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

    return WaveScaffold(
      appBar: AppBar(
        title: const Text('Öğrenci Detayı'),
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
                  const Icon(Icons.person, size: 64, color: Colors.indigo),
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
              title: const Text('Ad Soyad'),
              subtitle: Text(student.name),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.cake),
              title: const Text('Yaş'),
              subtitle: Text('${student.age}'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.sports_soccer),
              title: const Text('Branş'),
              subtitle: Text(student.branch),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Veli Telefonu'),
              subtitle: Text(student.parentPhone),
            ),
          ),
          const SizedBox(height: 20),
          if (widget.isAdmin)
            ElevatedButton.icon(
              onPressed: _openEditStudentScreen,
              icon: const Icon(Icons.edit),
              label: const Text('Öğrenciyi Düzenle'),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Öğrenci Listesine Dön'),
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
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final student = widget.student;

    if (student != null) {
      _nameController.text = student.name;
      _ageController.text = student.age.toString();
      _branchController.text = student.branch;
      _parentPhoneController.text = student.parentPhone;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _branchController.dispose();
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
      branch: _branchController.text.trim(),
      parentPhone: _parentPhoneController.text.trim(),
    );

    Navigator.pop(context, student);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.student != null;

    return WaveScaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Öğrenciyi Düzenle' : 'Yeni Öğrenci Ekle'),
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
                decoration: const InputDecoration(
                  labelText: 'Ad Soyad',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Mehmet Ali Yılmaz',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ad soyad boş bırakılamaz.';
                  }

                  if (value.trim().length < 3) {
                    return 'Ad soyad en az 3 karakter olmalıdır.';
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
                decoration: const InputDecoration(
                  labelText: 'Yaş',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                  hintText: '12',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Yaş boş bırakılamaz.';
                  }

                  final age = int.tryParse(value.trim());

                  if (age == null) {
                    return 'Yaş sayı olmalıdır.';
                  }

                  if (age <= 0) {
                    return 'Yaş 0’dan büyük olmalıdır.';
                  }

                  if (age > 99) {
                    return 'Yaş çok yüksek görünüyor.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _branchController,
                decoration: const InputDecoration(
                  labelText: 'Branş',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.sports_soccer),
                  hintText: 'Futbol',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Branş boş bırakılamaz.';
                  }

                  return null;
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
                decoration: const InputDecoration(
                  labelText: 'Veli Telefonu',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: '05XXXXXXXXX',
                ),
                validator: validatePhoneNumber,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveStudent,
                icon: const Icon(Icons.save),
                label: Text(
                  isEditing ? 'Değişiklikleri Kaydet' : 'Öğrenciyi Kaydet',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
