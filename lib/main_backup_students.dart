import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const SporOkuluApp());
}

class SporOkuluApp extends StatelessWidget {
  const SporOkuluApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spor Okulu Yönetimi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

class Student {
  final String name;
  final int age;
  final String branch;
  final String parentPhone;

  Student({
    required this.name,
    required this.age,
    required this.branch,
    required this.parentPhone,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'branch': branch,
      'parentPhone': parentPhone,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      age: json['age'],
      branch: json['branch'],
      parentPhone: json['parentPhone'],
    );
  }
}

class Coach {
  final String name;
  final String branch;
  final String phone;

  Coach({required this.name, required this.branch, required this.phone});

  Map<String, dynamic> toJson() {
    return {'name': name, 'branch': branch, 'phone': phone};
  }

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      name: json['name'],
      branch: json['branch'],
      phone: json['phone'],
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email == 'admin@sporokulu.com' && password == '123456') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-posta veya şifre hatalı.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.sports_soccer,
                        size: 72,
                        color: Colors.indigo,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Spor Okulu Yönetimi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Yönetici giriş ekranı',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
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
                            return 'Geçerli bir e-posta giriniz.';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Şifre',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Şifre boş bırakılamaz.';
                          }

                          if (value.length < 6) {
                            return 'Şifre en az 6 karakter olmalıdır.';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _login,
                        child: const Text('Giriş Yap'),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Demo giriş: admin@sporokulu.com / 123456',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const String _studentsKey = 'students';
  static const String _coachesKey = 'coaches';

  final List<Student> _students = [];
  final List<Coach> _coaches = [];

  bool _isLoadingStudents = true;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final savedStudents = prefs.getStringList(_studentsKey);

    if (savedStudents == null) {
      _students.addAll([
        Student(
          name: 'Ali Yılmaz',
          age: 10,
          branch: 'Futbol',
          parentPhone: '0555 111 22 33',
        ),
        Student(
          name: 'Ayşe Demir',
          age: 12,
          branch: 'Basketbol',
          parentPhone: '0555 444 55 66',
        ),
      ]);

      await _saveStudents();
    } else {
      final loadedStudents = savedStudents.map((studentJson) {
        final decodedJson = jsonDecode(studentJson) as Map<String, dynamic>;
        return Student.fromJson(decodedJson);
      }).toList();

      _students.addAll(loadedStudents);
    }

    await _loadCoaches();

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoadingStudents = false;
    });
  }

  Future<void> _saveStudents() async {
    final prefs = await SharedPreferences.getInstance();

    final studentJsonList = _students.map((student) {
      return jsonEncode(student.toJson());
    }).toList();

    await prefs.setStringList(_studentsKey, studentJsonList);
  }

  Future<void> _loadCoaches() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCoaches = prefs.getStringList(_coachesKey);

    if (savedCoaches == null) {
      _coaches.addAll([
        Coach(name: 'Mehmet Kaya', branch: 'Futbol', phone: '0555 222 33 44'),
        Coach(
          name: 'Zeynep Arslan',
          branch: 'Basketbol',
          phone: '0555 777 88 99',
        ),
      ]);

      await _saveCoaches();
    } else {
      final loadedCoaches = savedCoaches.map((coachJson) {
        final decodedJson = jsonDecode(coachJson) as Map<String, dynamic>;
        return Coach.fromJson(decodedJson);
      }).toList();

      _coaches.addAll(loadedCoaches);
    }
  }

  Future<void> _saveCoaches() async {
    final prefs = await SharedPreferences.getInstance();

    final coachJsonList = _coaches.map((coach) {
      return jsonEncode(coach.toJson());
    }).toList();

    await prefs.setStringList(_coachesKey, coachJsonList);
  }

  void _addCoach(Coach coach) {
    setState(() {
      _coaches.add(coach);
    });

    _saveCoaches();
  }

  void _deleteCoach(int index) {
    setState(() {
      _coaches.removeAt(index);
    });

    _saveCoaches();
  }

  void _openCoachesScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoachesScreen(
          coaches: _coaches,
          onAddCoach: _addCoach,
          onDeleteCoach: _deleteCoach,
        ),
      ),
    );
  }

  void _addStudent(Student student) {
    setState(() {
      _students.add(student);
    });

    _saveStudents();
  }

  void _deleteStudent(int index) {
    setState(() {
      _students.removeAt(index);
    });

    _saveStudents();
  }

  void _updateStudent(int index, Student updatedStudent) {
    setState(() {
      _students[index] = updatedStudent;
    });

    _saveStudents();
  }

  void _openStudentsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentsScreen(
          students: _students,
          onAddStudent: _addStudent,
          onDeleteStudent: _deleteStudent,
          onUpdateStudent: _updateStudent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingStudents) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Kontrol Paneli'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontrol Paneli'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            DashboardCard(
              icon: Icons.people,
              title: 'Öğrenciler',
              subtitle: '${_students.length} öğrenci kayıtlı',
              onTap: () {
                _openStudentsScreen(context);
              },
            ),
            DashboardCard(
              icon: Icons.sports,
              title: 'Antrenörler',
              subtitle: '${_coaches.length} antrenör kayıtlı',
              onTap: () {
                _openCoachesScreen(context);
              },
            ),
            const DashboardCard(
              icon: Icons.groups,
              title: 'Gruplar',
              subtitle: 'Sınıf / takım yönetimi',
            ),
            const DashboardCard(
              icon: Icons.check_circle,
              title: 'Yoklama',
              subtitle: 'Ders katılımı',
            ),
            const DashboardCard(
              icon: Icons.payment,
              title: 'Ödemeler',
              subtitle: 'Aidat takibi',
            ),
            const DashboardCard(
              icon: Icons.campaign,
              title: 'Duyurular',
              subtitle: 'Bildirimler',
            ),
          ],
        ),
      ),
    );
  }
}

class StudentsScreen extends StatefulWidget {
  final List<Student> students;
  final ValueChanged<Student> onAddStudent;
  final ValueChanged<int> onDeleteStudent;
  final void Function(int index, Student updatedStudent) onUpdateStudent;

  const StudentsScreen({
    super.key,
    required this.students,
    required this.onAddStudent,
    required this.onDeleteStudent,
    required this.onUpdateStudent,
  });

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  Future<void> _openAddStudentScreen() async {
    final newStudent = await Navigator.push<Student>(
      context,
      MaterialPageRoute(builder: (context) => const AddStudentScreen()),
    );

    if (newStudent == null) {
      return;
    }

    widget.onAddStudent(newStudent);

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
            '${student.name} adlı öğrenciyi silmek istediğine emin misin?',
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

    widget.onDeleteStudent(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${student.name} silindi.')));
  }

  Future<void> _openStudentDetailScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailScreen(
          students: widget.students,
          index: index,
          onUpdateStudent: widget.onUpdateStudent,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğrenciler'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: widget.students.isEmpty
          ? const Center(child: Text('Henüz öğrenci eklenmedi.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.students.length,
              itemBuilder: (context, index) {
                final student = widget.students[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () {
                      _openStudentDetailScreen(index);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      child: Text(student.name[0]),
                    ),
                    title: Text(student.name),
                    subtitle: Text(
                      '${student.age} yaş • ${student.branch}\nVeli Tel: ${student.parentPhone}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDeleteStudent(index);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddStudentScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StudentDetailScreen extends StatefulWidget {
  final List<Student> students;
  final int index;
  final void Function(int index, Student updatedStudent) onUpdateStudent;

  const StudentDetailScreen({
    super.key,
    required this.students,
    required this.index,
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

    widget.onUpdateStudent(widget.index, updatedStudent);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final student = _student;

    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _openEditStudentScreen,
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      child: Text(
                        student.name[0],
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
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
                    Text(
                      student.branch,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Öğrenciyi Düzenle' : 'Yeni Öğrenci Ekle'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
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
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ad soyad boş bırakılamaz.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Yaş',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Yaş boş bırakılamaz.';
                  }

                  final age = int.tryParse(value.trim());

                  if (age == null) {
                    return 'Yaş sayı olmalıdır.';
                  }

                  if (age < 4 || age > 18) {
                    return 'Yaş 4 ile 18 arasında olmalıdır.';
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
                  hintText: 'Futbol, basketbol, voleybol...',
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
                decoration: const InputDecoration(
                  labelText: 'Veli Telefonu',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veli telefonu boş bırakılamaz.';
                  }

                  if (value.trim().length < 10) {
                    return 'Telefon numarası çok kısa.';
                  }

                  return null;
                },
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

class CoachesScreen extends StatefulWidget {
  final List<Coach> coaches;
  final ValueChanged<Coach> onAddCoach;
  final ValueChanged<int> onDeleteCoach;

  const CoachesScreen({
    super.key,
    required this.coaches,
    required this.onAddCoach,
    required this.onDeleteCoach,
  });

  @override
  State<CoachesScreen> createState() => _CoachesScreenState();
}

class _CoachesScreenState extends State<CoachesScreen> {
  Future<void> _openAddCoachScreen() async {
    final newCoach = await Navigator.push<Coach>(
      context,
      MaterialPageRoute(builder: (context) => const AddCoachScreen()),
    );

    if (newCoach == null) {
      return;
    }

    widget.onAddCoach(newCoach);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmDeleteCoach(int index) async {
    final coach = widget.coaches[index];

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Antrenörü Sil'),
          content: Text(
            '${coach.name} adlı antrenörü silmek istediğine emin misin?',
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

    widget.onDeleteCoach(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${coach.name} silindi.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antrenörler'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: widget.coaches.isEmpty
          ? const Center(child: Text('Henüz antrenör eklenmedi.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.coaches.length,
              itemBuilder: (context, index) {
                final coach = widget.coaches[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      child: Text(coach.name[0]),
                    ),
                    title: Text(coach.name),
                    subtitle: Text('${coach.branch}\nTelefon: ${coach.phone}'),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDeleteCoach(index);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddCoachScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddCoachScreen extends StatefulWidget {
  const AddCoachScreen({super.key});

  @override
  State<AddCoachScreen> createState() => _AddCoachScreenState();
}

class _AddCoachScreenState extends State<AddCoachScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _branchController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveCoach() {
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    final coach = Coach(
      name: _nameController.text.trim(),
      branch: _branchController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    Navigator.pop(context, coach);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Antrenör Ekle'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
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
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ad soyad boş bırakılamaz.';
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
                  prefixIcon: Icon(Icons.sports),
                  hintText: 'Futbol, basketbol, voleybol...',
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
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Telefon',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Telefon boş bırakılamaz.';
                  }

                  if (value.trim().length < 10) {
                    return 'Telefon numarası çok kısa.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveCoach,
                icon: const Icon(Icons.save),
                label: const Text('Antrenörü Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.indigo),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
