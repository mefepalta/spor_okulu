import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class TrainingGroup {
  final String name;
  final String branch;
  final String coachName;
  final String schedule;
  final int capacity;

  TrainingGroup({
    required this.name,
    required this.branch,
    required this.coachName,
    required this.schedule,
    required this.capacity,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'branch': branch,
      'coachName': coachName,
      'schedule': schedule,
      'capacity': capacity,
    };
  }

  factory TrainingGroup.fromJson(Map<String, dynamic> json) {
    return TrainingGroup(
      name: json['name'],
      branch: json['branch'],
      coachName: json['coachName'],
      schedule: json['schedule'],
      capacity: json['capacity'],
    );
  }
}

class AttendanceRecord {
  final String groupName;
  final String dateText;
  final List<String> presentStudentNames;
  final List<String> absentStudentNames;

  AttendanceRecord({
    required this.groupName,
    required this.dateText,
    required this.presentStudentNames,
    required this.absentStudentNames,
  });

  Map<String, dynamic> toJson() {
    return {
      'groupName': groupName,
      'dateText': dateText,
      'presentStudentNames': presentStudentNames,
      'absentStudentNames': absentStudentNames,
    };
  }

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      groupName: json['groupName'],
      dateText: json['dateText'],
      presentStudentNames: List<String>.from(json['presentStudentNames'] ?? []),
      absentStudentNames: List<String>.from(json['absentStudentNames'] ?? []),
    );
  }
}

class PaymentRecord {
  final String studentName;
  final String period;
  final int amount;
  final String status;
  final String dateText;
  final String note;

  PaymentRecord({
    required this.studentName,
    required this.period,
    required this.amount,
    required this.status,
    required this.dateText,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'studentName': studentName,
      'period': period,
      'amount': amount,
      'status': status,
      'dateText': dateText,
      'note': note,
    };
  }

  factory PaymentRecord.fromJson(Map<String, dynamic> json) {
    return PaymentRecord(
      studentName: json['studentName'],
      period: json['period'],
      amount: (json['amount'] as num).toInt(),
      status: json['status'],
      dateText: json['dateText'],
      note: json['note'] ?? '',
    );
  }
}

class Announcement {
  final String title;
  final String content;
  final String targetAudience;
  final String dateText;

  Announcement({
    required this.title,
    required this.content,
    required this.targetAudience,
    required this.dateText,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'targetAudience': targetAudience,
      'dateText': dateText,
    };
  }

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      title: json['title'],
      content: json['content'],
      targetAudience: json['targetAudience'],
      dateText: json['dateText'],
    );
  }
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Telefon numarası boş bırakılamaz.';
  }

  final phone = value.trim();
  final phoneRegExp = RegExp(r'^05[0-9]{9}$');

  if (!phoneRegExp.hasMatch(phone)) {
    return 'Telefon 05XXXXXXXXX formatında olmalıdır.';
  }

  return null;
}

String dropdownDayFromText(String value) {
  final normalizedDay = value
      .trim()
      .toLowerCase()
      .replaceAll('ı', 'i')
      .replaceAll('ğ', 'g')
      .replaceAll('ü', 'u')
      .replaceAll('ş', 's')
      .replaceAll('ö', 'o')
      .replaceAll('ç', 'c');

  switch (normalizedDay) {
    case 'pazartesi':
      return 'Pazartesi';
    case 'sali':
      return 'Sali';
    case 'carsamba':
      return 'Carsamba';
    case 'persembe':
      return 'Persembe';
    case 'cuma':
      return 'Cuma';
    case 'cumartesi':
      return 'Cumartesi';
    case 'pazar':
      return 'Pazar';
    default:
      return 'Pazartesi';
  }
}

String normalizeTime(String value) {
  final timeParts = value.split(':');
  final hour = int.parse(timeParts[0]);
  final minute = int.parse(timeParts[1]);

  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

String? validateTime(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Saat boş bırakılamaz.';
  }

  final time = value.trim();
  final timeParts = time.split(':');

  if (timeParts.length != 2) {
    return 'Saat formatı 18:00 şeklinde olmalı.';
  }

  final hour = int.tryParse(timeParts[0]);
  final minute = int.tryParse(timeParts[1]);

  if (hour == null || minute == null) {
    return 'Saat sadece rakamlardan oluşmalı.';
  }

  if (hour < 0 || hour > 23) {
    return 'Saat 00 ile 23 arasında olmalı.';
  }

  if (minute < 0 || minute > 59) {
    return 'Dakika 00 ile 59 arasında olmalı.';
  }

  return null;
}

String? validateDateText(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Tarih boş bırakılamaz.';
  }

  final date = value.trim();

  final dateRegExp = RegExp(
    r'^(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.[0-9]{4}$',
  );

  if (!dateRegExp.hasMatch(date)) {
    return 'Tarih 24.06.2026 formatında olmalı.';
  }

  return null;
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
  static const String _groupsKey = 'groups';
  static const String _attendanceKey = 'attendance_records';
  static const String _paymentsKey = 'payments';
  static const String _announcementsKey = 'announcements';

  final List<Student> _students = [];
  final List<Coach> _coaches = [];
  final List<TrainingGroup> _groups = [];
  final List<AttendanceRecord> _attendanceRecords = [];
  final List<PaymentRecord> _payments = [];
  final List<Announcement> _announcements = [];

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
    await _loadGroups();
    await _loadAttendanceRecords();
    await _loadPayments();
    await _loadAnnouncements();

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

  void _updateCoach(int index, Coach updatedCoach) {
    setState(() {
      _coaches[index] = updatedCoach;
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
          onUpdateCoach: _updateCoach,
        ),
      ),
    );
  }

  Future<void> _loadGroups() async {
    final prefs = await SharedPreferences.getInstance();
    final savedGroups = prefs.getStringList(_groupsKey);

    if (savedGroups == null) {
      _groups.addAll([
        TrainingGroup(
          name: 'Minikler Futbol A',
          branch: 'Futbol',
          coachName: 'Mehmet Kaya',
          schedule: 'Pazartesi 18:00',
          capacity: 20,
        ),
        TrainingGroup(
          name: 'Yıldızlar Basketbol',
          branch: 'Basketbol',
          coachName: 'Zeynep Arslan',
          schedule: 'Çarşamba 17:00',
          capacity: 16,
        ),
      ]);

      await _saveGroups();
    } else {
      final loadedGroups = savedGroups.map((groupJson) {
        final decodedJson = jsonDecode(groupJson) as Map<String, dynamic>;
        return TrainingGroup.fromJson(decodedJson);
      }).toList();

      _groups.addAll(loadedGroups);
    }
  }

  Future<void> _saveGroups() async {
    final prefs = await SharedPreferences.getInstance();

    final groupJsonList = _groups.map((group) {
      return jsonEncode(group.toJson());
    }).toList();

    await prefs.setStringList(_groupsKey, groupJsonList);
  }

  void _addGroup(TrainingGroup group) {
    setState(() {
      _groups.add(group);
    });

    _saveGroups();
  }

  void _deleteGroup(int index) {
    setState(() {
      _groups.removeAt(index);
    });

    _saveGroups();
  }

  void _updateGroup(int index, TrainingGroup updatedGroup) {
    setState(() {
      _groups[index] = updatedGroup;
    });

    _saveGroups();
  }

  void _openGroupsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupsScreen(
          groups: _groups,
          coaches: _coaches,
          onAddGroup: _addGroup,
          onDeleteGroup: _deleteGroup,
          onUpdateGroup: _updateGroup,
        ),
      ),
    );
  }

  Future<void> _loadAttendanceRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAttendanceRecords = prefs.getStringList(_attendanceKey);

    if (savedAttendanceRecords == null) {
      return;
    }

    final loadedAttendanceRecords = savedAttendanceRecords.map((recordJson) {
      final decodedJson = jsonDecode(recordJson) as Map<String, dynamic>;
      return AttendanceRecord.fromJson(decodedJson);
    }).toList();

    _attendanceRecords.addAll(loadedAttendanceRecords);
  }

  Future<void> _saveAttendanceRecords() async {
    final prefs = await SharedPreferences.getInstance();

    final attendanceJsonList = _attendanceRecords.map((record) {
      return jsonEncode(record.toJson());
    }).toList();

    await prefs.setStringList(_attendanceKey, attendanceJsonList);
  }

  void _addAttendanceRecord(AttendanceRecord record) {
    setState(() {
      _attendanceRecords.add(record);
    });

    _saveAttendanceRecords();
  }

  void _deleteAttendanceRecord(int index) {
    setState(() {
      _attendanceRecords.removeAt(index);
    });

    _saveAttendanceRecords();
  }

  void _updateAttendanceRecord(int index, AttendanceRecord updatedRecord) {
    setState(() {
      _attendanceRecords[index] = updatedRecord;
    });

    _saveAttendanceRecords();
  }

  void _openAttendanceScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendanceScreen(
          groups: _groups,
          students: _students,
          attendanceRecords: _attendanceRecords,
          onAddAttendanceRecord: _addAttendanceRecord,
          onDeleteAttendanceRecord: _deleteAttendanceRecord,
          onUpdateAttendanceRecord: _updateAttendanceRecord,
        ),
      ),
    );
  }

  Future<void> _loadPayments() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPayments = prefs.getStringList(_paymentsKey);

    if (savedPayments == null) {
      return;
    }

    final loadedPayments = savedPayments.map((paymentJson) {
      final decodedJson = jsonDecode(paymentJson) as Map<String, dynamic>;
      return PaymentRecord.fromJson(decodedJson);
    }).toList();

    _payments.addAll(loadedPayments);
  }

  Future<void> _savePayments() async {
    final prefs = await SharedPreferences.getInstance();

    final paymentJsonList = _payments.map((payment) {
      return jsonEncode(payment.toJson());
    }).toList();

    await prefs.setStringList(_paymentsKey, paymentJsonList);
  }

  Future<void> _addPayment(PaymentRecord payment) async {
    setState(() {
      _payments.add(payment);
    });

    await _savePayments();
  }

  Future<void> _deletePayment(int index) async {
    setState(() {
      _payments.removeAt(index);
    });

    await _savePayments();
  }

  Future<void> _updatePayment(int index, PaymentRecord updatedPayment) async {
    setState(() {
      _payments[index] = updatedPayment;
    });

    await _savePayments();
  }

  void _openPaymentsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentsScreen(
          students: _students,
          payments: _payments,
          onAddPayment: _addPayment,
          onDeletePayment: _deletePayment,
          onUpdatePayment: _updatePayment,
        ),
      ),
    );
  }

  Future<void> _loadAnnouncements() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAnnouncements = prefs.getStringList(_announcementsKey);

    if (savedAnnouncements == null) {
      return;
    }

    final loadedAnnouncements = savedAnnouncements.map((announcementJson) {
      final decodedJson = jsonDecode(announcementJson) as Map<String, dynamic>;
      return Announcement.fromJson(decodedJson);
    }).toList();

    _announcements.addAll(loadedAnnouncements);
  }

  Future<void> _saveAnnouncements() async {
    final prefs = await SharedPreferences.getInstance();

    final announcementJsonList = _announcements.map((announcement) {
      return jsonEncode(announcement.toJson());
    }).toList();

    await prefs.setStringList(_announcementsKey, announcementJsonList);
  }

  Future<void> _addAnnouncement(Announcement announcement) async {
    setState(() {
      _announcements.add(announcement);
    });

    await _saveAnnouncements();
  }

  Future<void> _deleteAnnouncement(int index) async {
    setState(() {
      _announcements.removeAt(index);
    });

    await _saveAnnouncements();
  }

  Future<void> _updateAnnouncement(
    int index,
    Announcement updatedAnnouncement,
  ) async {
    setState(() {
      _announcements[index] = updatedAnnouncement;
    });

    await _saveAnnouncements();
  }

  void _openAnnouncementsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnnouncementsScreen(
          announcements: _announcements,
          onAddAnnouncement: _addAnnouncement,
          onDeleteAnnouncement: _deleteAnnouncement,
          onUpdateAnnouncement: _updateAnnouncement,
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
            DashboardCard(
              icon: Icons.groups,
              title: 'Gruplar',
              subtitle: '${_groups.length} grup kayıtlı',
              onTap: () {
                _openGroupsScreen(context);
              },
            ),
            DashboardCard(
              icon: Icons.check_circle,
              title: 'Yoklama',
              subtitle: '${_attendanceRecords.length} yoklama kaydı',
              onTap: () {
                _openAttendanceScreen(context);
              },
            ),
            DashboardCard(
              icon: Icons.payment,
              title: 'Ödemeler',
              subtitle: '${_payments.length} ödeme kaydı',
              onTap: () {
                _openPaymentsScreen(context);
              },
            ),
            DashboardCard(
              icon: Icons.campaign,
              title: 'Duyurular',
              subtitle: '${_announcements.length} duyuru',
              onTap: () {
                _openAnnouncementsScreen(context);
              },
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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 11,
                decoration: const InputDecoration(
                  labelText: 'Veli Telefonu',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: '05551234567',
                  counterText: '',
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

class CoachesScreen extends StatefulWidget {
  final List<Coach> coaches;
  final ValueChanged<Coach> onAddCoach;
  final ValueChanged<int> onDeleteCoach;
  final void Function(int index, Coach updatedCoach) onUpdateCoach;

  const CoachesScreen({
    super.key,
    required this.coaches,
    required this.onAddCoach,
    required this.onDeleteCoach,
    required this.onUpdateCoach,
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

  Future<void> _openCoachDetailScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoachDetailScreen(
          coaches: widget.coaches,
          index: index,
          onUpdateCoach: widget.onUpdateCoach,
        ),
      ),
    );

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
                    onTap: () {
                      _openCoachDetailScreen(index);
                    },
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

class CoachDetailScreen extends StatefulWidget {
  final List<Coach> coaches;
  final int index;
  final void Function(int index, Coach updatedCoach) onUpdateCoach;

  const CoachDetailScreen({
    super.key,
    required this.coaches,
    required this.index,
    required this.onUpdateCoach,
  });

  @override
  State<CoachDetailScreen> createState() => _CoachDetailScreenState();
}

class _CoachDetailScreenState extends State<CoachDetailScreen> {
  Coach get _coach => widget.coaches[widget.index];

  Future<void> _openEditCoachScreen() async {
    final updatedCoach = await Navigator.push<Coach>(
      context,
      MaterialPageRoute(builder: (context) => AddCoachScreen(coach: _coach)),
    );

    if (updatedCoach == null) {
      return;
    }

    widget.onUpdateCoach(widget.index, updatedCoach);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final coach = _coach;

    return Scaffold(
      appBar: AppBar(
        title: Text(coach.name),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _openEditCoachScreen,
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
                        coach.name[0],
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      coach.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      coach.branch,
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
                leading: const Icon(Icons.sports),
                title: const Text('Branş'),
                subtitle: Text(coach.branch),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Telefon'),
                subtitle: Text(coach.phone),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _openEditCoachScreen,
              icon: const Icon(Icons.edit),
              label: const Text('Antrenörü Düzenle'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Antrenör Listesine Dön'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddCoachScreen extends StatefulWidget {
  final Coach? coach;

  const AddCoachScreen({super.key, this.coach});

  @override
  State<AddCoachScreen> createState() => _AddCoachScreenState();
}

class _AddCoachScreenState extends State<AddCoachScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final coach = widget.coach;

    if (coach != null) {
      _nameController.text = coach.name;
      _branchController.text = coach.branch;
      _phoneController.text = coach.phone;
    }
  }

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
    final isEditing = widget.coach != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Antrenörü Düzenle' : 'Yeni Antrenör Ekle'),
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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 11,
                decoration: const InputDecoration(
                  labelText: 'Telefon',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: '05551234567',
                  counterText: '',
                ),
                validator: validatePhoneNumber,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveCoach,
                icon: const Icon(Icons.save),
                label: Text(
                  isEditing ? 'Değişiklikleri Kaydet' : 'Antrenörü Kaydet',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupsScreen extends StatefulWidget {
  final List<TrainingGroup> groups;
  final List<Coach> coaches;
  final ValueChanged<TrainingGroup> onAddGroup;
  final ValueChanged<int> onDeleteGroup;
  final void Function(int index, TrainingGroup updatedGroup) onUpdateGroup;

  const GroupsScreen({
    super.key,
    required this.groups,
    required this.coaches,
    required this.onAddGroup,
    required this.onDeleteGroup,
    required this.onUpdateGroup,
  });

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  Future<void> _openAddGroupScreen() async {
    final newGroup = await Navigator.push<TrainingGroup>(
      context,
      MaterialPageRoute(
        builder: (context) => AddGroupScreen(coaches: widget.coaches),
      ),
    );

    if (newGroup == null) {
      return;
    }

    widget.onAddGroup(newGroup);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _openGroupDetailScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupDetailScreen(
          groups: widget.groups,
          coaches: widget.coaches,
          index: index,
          onUpdateGroup: widget.onUpdateGroup,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmDeleteGroup(int index) async {
    final group = widget.groups[index];

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Grubu Sil'),
          content: Text(
            '${group.name} adlı grubu silmek istediğine emin misin?',
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

    widget.onDeleteGroup(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${group.name} silindi.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gruplar / Takımlar'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: widget.groups.isEmpty
          ? const Center(child: Text('Henüz grup eklenmedi.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.groups.length,
              itemBuilder: (context, index) {
                final group = widget.groups[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () {
                      _openGroupDetailScreen(index);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      child: Text(group.name[0]),
                    ),
                    title: Text(group.name),
                    subtitle: Text(
                      '${group.branch} • ${group.coachName}\n${group.schedule} • Kontenjan: ${group.capacity}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDeleteGroup(index);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddGroupScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class GroupDetailScreen extends StatefulWidget {
  final List<TrainingGroup> groups;
  final List<Coach> coaches;
  final int index;
  final void Function(int index, TrainingGroup updatedGroup) onUpdateGroup;

  const GroupDetailScreen({
    super.key,
    required this.groups,
    required this.coaches,
    required this.index,
    required this.onUpdateGroup,
  });

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  TrainingGroup get _group => widget.groups[widget.index];

  Future<void> _openEditGroupScreen() async {
    final updatedGroup = await Navigator.push<TrainingGroup>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddGroupScreen(coaches: widget.coaches, group: _group),
      ),
    );

    if (updatedGroup == null) {
      return;
    }

    widget.onUpdateGroup(widget.index, updatedGroup);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final group = _group;

    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _openEditGroupScreen,
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
                        group.name[0],
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      group.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      group.branch,
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
                leading: const Icon(Icons.sports_soccer),
                title: const Text('Branş'),
                subtitle: Text(group.branch),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Antrenör'),
                subtitle: Text(group.coachName),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.schedule),
                title: const Text('Gün / Saat'),
                subtitle: Text(group.schedule),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.confirmation_number),
                title: const Text('Kontenjan'),
                subtitle: Text('${group.capacity} kişi'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _openEditGroupScreen,
              icon: const Icon(Icons.edit),
              label: const Text('Grubu Düzenle'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Grup Listesine Dön'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddGroupScreen extends StatefulWidget {
  final List<Coach> coaches;
  final TrainingGroup? group;

  const AddGroupScreen({super.key, required this.coaches, this.group});

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();

  final List<String> _days = const [
    'Pazartesi',
    'Sali',
    'Carsamba',
    'Persembe',
    'Cuma',
    'Cumartesi',
    'Pazar',
  ];

  String? _selectedDay;
  String? _selectedCoachName;

  @override
  void initState() {
    super.initState();

    _selectedDay = _days.first;

    final group = widget.group;

    if (group != null) {
      _nameController.text = group.name;
      _branchController.text = group.branch;
      _capacityController.text = group.capacity.toString();

      final scheduleParts = group.schedule.trim().split(RegExp(r'\s+'));

      if (scheduleParts.isNotEmpty) {
        _selectedDay = dropdownDayFromText(scheduleParts[0]);
      }

      if (scheduleParts.length >= 2) {
        _timeController.text = scheduleParts[1];
      } else {
        _timeController.text = '18:00';
      }

      final coachStillExists = widget.coaches.any((coach) {
        return coach.name == group.coachName;
      });

      if (coachStillExists) {
        _selectedCoachName = group.coachName;
      } else if (widget.coaches.isNotEmpty) {
        _selectedCoachName = widget.coaches.first.name;
      }
    } else {
      _timeController.text = '18:00';

      if (widget.coaches.isNotEmpty) {
        _selectedCoachName = widget.coaches.first.name;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _branchController.dispose();
    _timeController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  void _saveGroup() {
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    if (_selectedCoachName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Önce bir antrenör eklemelisin.')),
      );
      return;
    }

    final normalizedTime = normalizeTime(_timeController.text.trim());

    final group = TrainingGroup(
      name: _nameController.text.trim(),
      branch: _branchController.text.trim(),
      coachName: _selectedCoachName!,
      schedule: '$_selectedDay $normalizedTime',
      capacity: int.parse(_capacityController.text.trim()),
    );

    Navigator.pop(context, group);
  }

  @override
  Widget build(BuildContext context) {
    final hasCoaches = widget.coaches.isNotEmpty;
    final isEditing = widget.group != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Grubu Düzenle' : 'Yeni Grup Ekle'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: hasCoaches
            ? Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Grup Adı',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.groups),
                        hintText: 'Minikler Futbol A',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Grup adı boş bırakılamaz.';
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
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCoachName,
                      decoration: const InputDecoration(
                        labelText: 'Antrenör',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      items: widget.coaches.map((coach) {
                        return DropdownMenuItem<String>(
                          value: coach.name,
                          child: Text('${coach.name} - ${coach.branch}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCoachName = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Antrenör seçmelisin.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedDay,
                      decoration: const InputDecoration(
                        labelText: 'Gün',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      items: _days.map((day) {
                        return DropdownMenuItem<String>(
                          value: day,
                          child: Text(day),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDay = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Gün seçmelisin.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _timeController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: 'Saat',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.schedule),
                        hintText: '18:00',
                      ),
                      validator: validateTime,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _capacityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Kontenjan',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.confirmation_number),
                        hintText: '20',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Kontenjan boş bırakılamaz.';
                        }

                        final capacity = int.tryParse(value.trim());

                        if (capacity == null) {
                          return 'Kontenjan sayı olmalıdır.';
                        }

                        if (capacity <= 0) {
                          return 'Kontenjan 0’dan büyük olmalıdır.';
                        }

                        if (capacity > 100) {
                          return 'Kontenjan 100’den büyük olamaz.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _saveGroup,
                      icon: const Icon(Icons.save),
                      label: Text(
                        isEditing ? 'Değişiklikleri Kaydet' : 'Grubu Kaydet',
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: Text(
                  'Grup eklemek için önce en az bir antrenör eklemelisin.',
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  final List<TrainingGroup> groups;
  final List<Student> students;
  final List<AttendanceRecord> attendanceRecords;
  final ValueChanged<AttendanceRecord> onAddAttendanceRecord;
  final ValueChanged<int> onDeleteAttendanceRecord;
  final void Function(int index, AttendanceRecord updatedRecord)
  onUpdateAttendanceRecord;

  const AttendanceScreen({
    super.key,
    required this.groups,
    required this.students,
    required this.attendanceRecords,
    required this.onAddAttendanceRecord,
    required this.onDeleteAttendanceRecord,
    required this.onUpdateAttendanceRecord,
  });

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  Future<void> _openTakeAttendanceScreen() async {
    final record = await Navigator.push<AttendanceRecord>(
      context,
      MaterialPageRoute(
        builder: (context) => TakeAttendanceScreen(
          groups: widget.groups,
          students: widget.students,
        ),
      ),
    );

    if (record == null) {
      return;
    }

    widget.onAddAttendanceRecord(record);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmDeleteAttendanceRecord(int index) async {
    final record = widget.attendanceRecords[index];

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yoklamayı Sil'),
          content: Text(
            '${record.groupName} - ${record.dateText} yoklamasını silmek istediğine emin misin?',
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

    widget.onDeleteAttendanceRecord(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Yoklama kaydı silindi.')));
  }

  Future<void> _openAttendanceDetailScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendanceDetailScreen(
          attendanceRecords: widget.attendanceRecords,
          index: index,
          groups: widget.groups,
          students: widget.students,
          onUpdateAttendanceRecord: widget.onUpdateAttendanceRecord,
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
    final canTakeAttendance =
        widget.groups.isNotEmpty && widget.students.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoklama'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: widget.attendanceRecords.isEmpty
          ? Center(
              child: Text(
                canTakeAttendance
                    ? 'Henüz yoklama kaydı yok.'
                    : 'Yoklama almak için önce en az bir grup ve öğrenci olmalı.',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.attendanceRecords.length,
              itemBuilder: (context, index) {
                final record = widget.attendanceRecords[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.check),
                    ),
                    title: Text(record.groupName),
                    subtitle: Text(
                      '${record.dateText}\nGeldi: ${record.presentStudentNames.length} • Gelmedi: ${record.absentStudentNames.length}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDeleteAttendanceRecord(index);
                      },
                    ),
                    onTap: () {
                      _openAttendanceDetailScreen(index);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: canTakeAttendance
          ? FloatingActionButton(
              onPressed: _openTakeAttendanceScreen,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class TakeAttendanceScreen extends StatefulWidget {
  final List<TrainingGroup> groups;
  final List<Student> students;
  final AttendanceRecord? record;

  const TakeAttendanceScreen({
    super.key,
    required this.groups,
    required this.students,
    this.record,
  });

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  String? _selectedGroupName;
  final Map<String, bool> _attendanceStatus = {};

  @override
  void initState() {
    super.initState();

    final record = widget.record;

    if (record != null) {
      final groupStillExists = widget.groups.any((group) {
        return group.name == record.groupName;
      });

      if (groupStillExists) {
        _selectedGroupName = record.groupName;
      } else if (widget.groups.isNotEmpty) {
        _selectedGroupName = widget.groups.first.name;
      }

      _dateController.text = record.dateText;

      for (final student in widget.students) {
        _attendanceStatus[student.name] = record.presentStudentNames.contains(
          student.name,
        );
      }
    } else {
      if (widget.groups.isNotEmpty) {
        _selectedGroupName = widget.groups.first.name;
      }

      final now = DateTime.now();
      final day = now.day.toString().padLeft(2, '0');
      final month = now.month.toString().padLeft(2, '0');
      final year = now.year.toString();

      _dateController.text = '$day.$month.$year';

      for (final student in widget.students) {
        _attendanceStatus[student.name] = true;
      }
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _saveAttendance() {
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    if (_selectedGroupName == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Grup seçmelisin.')));
      return;
    }

    final presentStudentNames = <String>[];
    final absentStudentNames = <String>[];

    _attendanceStatus.forEach((studentName, isPresent) {
      if (isPresent) {
        presentStudentNames.add(studentName);
      } else {
        absentStudentNames.add(studentName);
      }
    });

    final record = AttendanceRecord(
      groupName: _selectedGroupName!,
      dateText: _dateController.text.trim(),
      presentStudentNames: presentStudentNames,
      absentStudentNames: absentStudentNames,
    );

    Navigator.pop(context, record);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.record == null ? 'Yoklama Al' : 'Yoklamayı Düzenle'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _selectedGroupName,
                    decoration: const InputDecoration(
                      labelText: 'Grup',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.groups),
                    ),
                    items: widget.groups.map((group) {
                      return DropdownMenuItem<String>(
                        value: group.name,
                        child: Text(group.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGroupName = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Grup seçmelisin.';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _dateController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: 'Tarih',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_today),
                      hintText: '24.06.2026',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Tarih boş bırakılamaz.';
                      }

                      final dateRegExp = RegExp(
                        r'^(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.[0-9]{4}$',
                      );

                      if (!dateRegExp.hasMatch(value.trim())) {
                        return 'Tarih 24.06.2026 formatında olmalı.';
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: widget.students.length,
                itemBuilder: (context, index) {
                  final student = widget.students[index];
                  final isPresent = _attendanceStatus[student.name] ?? true;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: CheckboxListTile(
                      value: isPresent,
                      onChanged: (value) {
                        setState(() {
                          _attendanceStatus[student.name] = value ?? false;
                        });
                      },
                      title: Text(student.name),
                      subtitle: Text('${student.age} yaş • ${student.branch}'),
                      secondary: CircleAvatar(
                        backgroundColor: isPresent ? Colors.green : Colors.red,
                        foregroundColor: Colors.white,
                        child: Icon(isPresent ? Icons.check : Icons.close),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: _saveAttendance,
                icon: const Icon(Icons.save),
                label: Text(
                  widget.record == null
                      ? 'Yoklamayı Kaydet'
                      : 'Değişiklikleri Kaydet',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceDetailScreen extends StatefulWidget {
  final List<AttendanceRecord> attendanceRecords;
  final int index;
  final List<TrainingGroup> groups;
  final List<Student> students;
  final void Function(int index, AttendanceRecord updatedRecord)
  onUpdateAttendanceRecord;

  const AttendanceDetailScreen({
    super.key,
    required this.attendanceRecords,
    required this.index,
    required this.groups,
    required this.students,
    required this.onUpdateAttendanceRecord,
  });

  @override
  State<AttendanceDetailScreen> createState() => _AttendanceDetailScreenState();
}

class _AttendanceDetailScreenState extends State<AttendanceDetailScreen> {
  AttendanceRecord get _record => widget.attendanceRecords[widget.index];

  Future<void> _openEditAttendanceScreen() async {
    final updatedRecord = await Navigator.push<AttendanceRecord>(
      context,
      MaterialPageRoute(
        builder: (context) => TakeAttendanceScreen(
          groups: widget.groups,
          students: widget.students,
          record: _record,
        ),
      ),
    );

    if (updatedRecord == null) {
      return;
    }

    widget.onUpdateAttendanceRecord(widget.index, updatedRecord);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final record = _record;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoklama Detayı'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _openEditAttendanceScreen,
            icon: const Icon(Icons.edit),
          ),
        ],
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
                  const Icon(
                    Icons.check_circle,
                    size: 64,
                    color: Colors.indigo,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    record.groupName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(record.dateText),
                  const SizedBox(height: 8),
                  Text(
                    'Geldi: ${record.presentStudentNames.length} • Gelmedi: ${record.absentStudentNames.length}',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _openEditAttendanceScreen,
            icon: const Icon(Icons.edit),
            label: const Text('Yoklamayı Düzenle'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Gelen Öğrenciler',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (record.presentStudentNames.isEmpty)
            const Card(child: ListTile(title: Text('Gelen öğrenci yok.')))
          else
            ...record.presentStudentNames.map((name) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.check, color: Colors.green),
                  title: Text(name),
                ),
              );
            }),
          const SizedBox(height: 16),
          const Text(
            'Gelmeyen Öğrenciler',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (record.absentStudentNames.isEmpty)
            const Card(child: ListTile(title: Text('Gelmeyen öğrenci yok.')))
          else
            ...record.absentStudentNames.map((name) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.close, color: Colors.red),
                  title: Text(name),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class PaymentsScreen extends StatefulWidget {
  final List<Student> students;
  final List<PaymentRecord> payments;
  final Future<void> Function(PaymentRecord payment) onAddPayment;
  final Future<void> Function(int index) onDeletePayment;
  final Future<void> Function(int index, PaymentRecord updatedPayment)
  onUpdatePayment;

  const PaymentsScreen({
    super.key,
    required this.students,
    required this.payments,
    required this.onAddPayment,
    required this.onDeletePayment,
    required this.onUpdatePayment,
  });

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  Color _statusColor(String status) {
    if (status == 'Ödendi') {
      return Colors.green;
    }

    if (status == 'Gecikti') {
      return Colors.red;
    }

    return Colors.orange;
  }

  Future<void> _openAddPaymentScreen() async {
    final newPayment = await Navigator.push<PaymentRecord>(
      context,
      MaterialPageRoute(
        builder: (context) => AddPaymentScreen(students: widget.students),
      ),
    );

    if (newPayment == null) {
      return;
    }

    await widget.onAddPayment(newPayment);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _openPaymentDetailScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentDetailScreen(
          payments: widget.payments,
          students: widget.students,
          index: index,
          onUpdatePayment: widget.onUpdatePayment,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmDeletePayment(int index) async {
    final payment = widget.payments[index];

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ödemeyi Sil'),
          content: Text(
            '${payment.studentName} - ${payment.period} ödeme kaydını silmek istediğine emin misin?',
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

    await widget.onDeletePayment(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Ödeme kaydı silindi.')));
  }

  @override
  Widget build(BuildContext context) {
    final canAddPayment = widget.students.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödemeler'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: widget.payments.isEmpty
          ? Center(
              child: Text(
                canAddPayment
                    ? 'Henüz ödeme kaydı yok.'
                    : 'Ödeme eklemek için önce en az bir öğrenci olmalı.',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.payments.length,
              itemBuilder: (context, index) {
                final payment = widget.payments[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () {
                      _openPaymentDetailScreen(index);
                    },
                    leading: CircleAvatar(
                      backgroundColor: _statusColor(payment.status),
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.payments),
                    ),
                    title: Text(payment.studentName),
                    subtitle: Text(
                      '${payment.period} • ${payment.amount} TL\n${payment.status} • ${payment.dateText}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDeletePayment(index);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: canAddPayment
          ? FloatingActionButton(
              onPressed: _openAddPaymentScreen,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class PaymentDetailScreen extends StatefulWidget {
  final List<PaymentRecord> payments;
  final List<Student> students;
  final int index;
  final Future<void> Function(int index, PaymentRecord updatedPayment)
  onUpdatePayment;

  const PaymentDetailScreen({
    super.key,
    required this.payments,
    required this.students,
    required this.index,
    required this.onUpdatePayment,
  });

  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  PaymentRecord get _payment => widget.payments[widget.index];

  Color _statusColor(String status) {
    if (status == 'Ödendi') {
      return Colors.green;
    }

    if (status == 'Gecikti') {
      return Colors.red;
    }

    return Colors.orange;
  }

  Future<void> _openEditPaymentScreen() async {
    final updatedPayment = await Navigator.push<PaymentRecord>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddPaymentScreen(students: widget.students, payment: _payment),
      ),
    );

    if (updatedPayment == null) {
      return;
    }

    await widget.onUpdatePayment(widget.index, updatedPayment);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final payment = _payment;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödeme Detayı'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _openEditPaymentScreen,
            icon: const Icon(Icons.edit),
          ),
        ],
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
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: _statusColor(payment.status),
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.payments, size: 36),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    payment.studentName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('${payment.period} • ${payment.amount} TL'),
                  const SizedBox(height: 8),
                  Text(
                    payment.status,
                    style: TextStyle(
                      color: _statusColor(payment.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Öğrenci'),
              subtitle: Text(payment.studentName),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Ay / Dönem'),
              subtitle: Text(payment.period),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Tutar'),
              subtitle: Text('${payment.amount} TL'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Durum'),
              subtitle: Text(payment.status),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Tarih'),
              subtitle: Text(payment.dateText),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.note),
              title: const Text('Not'),
              subtitle: Text(payment.note.isEmpty ? 'Not yok.' : payment.note),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _openEditPaymentScreen,
            icon: const Icon(Icons.edit),
            label: const Text('Ödemeyi Düzenle'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Ödeme Listesine Dön'),
          ),
        ],
      ),
    );
  }
}

class AddPaymentScreen extends StatefulWidget {
  final List<Student> students;
  final PaymentRecord? payment;

  const AddPaymentScreen({super.key, required this.students, this.payment});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _periodController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final List<String> _statuses = const ['Ödendi', 'Bekliyor', 'Gecikti'];

  String? _selectedStudentName;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();

    _selectedStatus = _statuses.first;

    final payment = widget.payment;

    if (payment != null) {
      _selectedStudentName = payment.studentName;
      _selectedStatus = payment.status;
      _periodController.text = payment.period;
      _amountController.text = payment.amount.toString();
      _dateController.text = payment.dateText;
      _noteController.text = payment.note;
    } else {
      if (widget.students.isNotEmpty) {
        _selectedStudentName = widget.students.first.name;
      }

      final now = DateTime.now();
      final day = now.day.toString().padLeft(2, '0');
      final month = now.month.toString().padLeft(2, '0');
      final year = now.year.toString();

      _dateController.text = '$day.$month.$year';
    }

    if (_selectedStudentName != null) {
      final studentStillExists = widget.students.any((student) {
        return student.name == _selectedStudentName;
      });

      if (!studentStillExists && widget.students.isNotEmpty) {
        _selectedStudentName = widget.students.first.name;
      }
    }
  }

  @override
  void dispose() {
    _periodController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _savePayment() {
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    if (_selectedStudentName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Önce bir öğrenci eklemelisin.')),
      );
      return;
    }

    final payment = PaymentRecord(
      studentName: _selectedStudentName!,
      period: _periodController.text.trim(),
      amount: int.parse(_amountController.text.trim()),
      status: _selectedStatus!,
      dateText: _dateController.text.trim(),
      note: _noteController.text.trim(),
    );

    Navigator.pop(context, payment);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.payment != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Ödemeyi Düzenle' : 'Yeni Ödeme Ekle'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: widget.students.isEmpty
            ? const Center(
                child: Text(
                  'Ödeme eklemek için önce en az bir öğrenci eklemelisin.',
                  textAlign: TextAlign.center,
                ),
              )
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: _selectedStudentName,
                      decoration: const InputDecoration(
                        labelText: 'Öğrenci',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      items: widget.students.map((student) {
                        return DropdownMenuItem<String>(
                          value: student.name,
                          child: Text(student.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStudentName = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Öğrenci seçmelisin.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _periodController,
                      decoration: const InputDecoration(
                        labelText: 'Ay / Dönem',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_month),
                        hintText: 'Haziran 2026',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Ay / dönem boş bırakılamaz.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Tutar',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                        hintText: '1500',
                        suffixText: 'TL',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Tutar boş bırakılamaz.';
                        }

                        final amount = int.tryParse(value.trim());

                        if (amount == null) {
                          return 'Tutar sayı olmalıdır.';
                        }

                        if (amount <= 0) {
                          return 'Tutar 0’dan büyük olmalıdır.';
                        }

                        if (amount > 100000) {
                          return 'Tutar çok yüksek görünüyor.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedStatus,
                      decoration: const InputDecoration(
                        labelText: 'Durum',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.info),
                      ),
                      items: _statuses.map((status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Durum seçmelisin.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _dateController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: 'Tarih',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.event),
                        hintText: '24.06.2026',
                      ),
                      validator: validateDateText,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _noteController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Not',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.note),
                        hintText: 'İsteğe bağlı not',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _savePayment,
                      icon: const Icon(Icons.save),
                      label: Text(
                        isEditing ? 'Değişiklikleri Kaydet' : 'Ödemeyi Kaydet',
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class AnnouncementsScreen extends StatefulWidget {
  final List<Announcement> announcements;
  final Future<void> Function(Announcement announcement) onAddAnnouncement;
  final Future<void> Function(int index) onDeleteAnnouncement;
  final Future<void> Function(int index, Announcement updatedAnnouncement)
  onUpdateAnnouncement;

  const AnnouncementsScreen({
    super.key,
    required this.announcements,
    required this.onAddAnnouncement,
    required this.onDeleteAnnouncement,
    required this.onUpdateAnnouncement,
  });

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  Future<void> _openAddAnnouncementScreen() async {
    final newAnnouncement = await Navigator.push<Announcement>(
      context,
      MaterialPageRoute(builder: (context) => const AddAnnouncementScreen()),
    );

    if (newAnnouncement == null) {
      return;
    }

    await widget.onAddAnnouncement(newAnnouncement);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _openAnnouncementDetailScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnnouncementDetailScreen(
          announcements: widget.announcements,
          index: index,
          onUpdateAnnouncement: widget.onUpdateAnnouncement,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmDeleteAnnouncement(int index) async {
    final announcement = widget.announcements[index];

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Duyuruyu Sil'),
          content: Text(
            '${announcement.title} başlıklı duyuruyu silmek istediğine emin misin?',
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

    await widget.onDeleteAnnouncement(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Duyuru silindi.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duyurular'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: widget.announcements.isEmpty
          ? const Center(child: Text('Henüz duyuru eklenmedi.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.announcements.length,
              itemBuilder: (context, index) {
                final announcement = widget.announcements[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () {
                      _openAnnouncementDetailScreen(index);
                    },
                    leading: const CircleAvatar(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.campaign),
                    ),
                    title: Text(announcement.title),
                    subtitle: Text(
                      '${announcement.targetAudience} • ${announcement.dateText}\n${announcement.content}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDeleteAnnouncement(index);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddAnnouncementScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AnnouncementDetailScreen extends StatefulWidget {
  final List<Announcement> announcements;
  final int index;
  final Future<void> Function(int index, Announcement updatedAnnouncement)
  onUpdateAnnouncement;

  const AnnouncementDetailScreen({
    super.key,
    required this.announcements,
    required this.index,
    required this.onUpdateAnnouncement,
  });

  @override
  State<AnnouncementDetailScreen> createState() =>
      _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  Announcement get _announcement => widget.announcements[widget.index];

  Future<void> _openEditAnnouncementScreen() async {
    final updatedAnnouncement = await Navigator.push<Announcement>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddAnnouncementScreen(announcement: _announcement),
      ),
    );

    if (updatedAnnouncement == null) {
      return;
    }

    await widget.onUpdateAnnouncement(widget.index, updatedAnnouncement);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final announcement = _announcement;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Duyuru Detayı'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _openEditAnnouncementScreen,
            icon: const Icon(Icons.edit),
          ),
        ],
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
                  const Icon(Icons.campaign, size: 64, color: Colors.indigo),
                  const SizedBox(height: 16),
                  Text(
                    announcement.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(announcement.targetAudience),
                  const SizedBox(height: 8),
                  Text(announcement.dateText),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.title),
              title: const Text('Başlık'),
              subtitle: Text(announcement.title),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Hedef Kitle'),
              subtitle: Text(announcement.targetAudience),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Tarih'),
              subtitle: Text(announcement.dateText),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                announcement.content,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _openEditAnnouncementScreen,
            icon: const Icon(Icons.edit),
            label: const Text('Duyuruyu Düzenle'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Duyuru Listesine Dön'),
          ),
        ],
      ),
    );
  }
}

class AddAnnouncementScreen extends StatefulWidget {
  final Announcement? announcement;

  const AddAnnouncementScreen({super.key, this.announcement});

  @override
  State<AddAnnouncementScreen> createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final List<String> _targetAudiences = const [
    'Herkes',
    'Ogrenciler',
    'Antrenorler',
    'Veliler',
  ];

  String? _selectedTargetAudience;

  @override
  void initState() {
    super.initState();

    _selectedTargetAudience = _targetAudiences.first;

    final announcement = widget.announcement;

    if (announcement != null) {
      _titleController.text = announcement.title;
      _contentController.text = announcement.content;
      _dateController.text = announcement.dateText;

      if (_targetAudiences.contains(announcement.targetAudience)) {
        _selectedTargetAudience = announcement.targetAudience;
      }
    } else {
      final now = DateTime.now();
      final day = now.day.toString().padLeft(2, '0');
      final month = now.month.toString().padLeft(2, '0');
      final year = now.year.toString();

      _dateController.text = '$day.$month.$year';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _saveAnnouncement() {
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    final announcement = Announcement(
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      targetAudience: _selectedTargetAudience!,
      dateText: _dateController.text.trim(),
    );

    Navigator.pop(context, announcement);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.announcement != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Duyuruyu Düzenle' : 'Yeni Duyuru Ekle'),
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
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Başlık',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                  hintText: 'Antrenman saati değişikliği',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Başlık boş bırakılamaz.';
                  }

                  if (value.trim().length < 3) {
                    return 'Başlık en az 3 karakter olmalıdır.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'İçerik',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.notes),
                  hintText: 'Duyuru içeriğini yaz...',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'İçerik boş bırakılamaz.';
                  }

                  if (value.trim().length < 10) {
                    return 'İçerik en az 10 karakter olmalıdır.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedTargetAudience,
                decoration: const InputDecoration(
                  labelText: 'Hedef Kitle',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.group),
                ),
                items: _targetAudiences.map((targetAudience) {
                  return DropdownMenuItem<String>(
                    value: targetAudience,
                    child: Text(targetAudience),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTargetAudience = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hedef kitle seçmelisin.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _dateController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Tarih',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.event),
                  hintText: '24.06.2026',
                ),
                validator: validateDateText,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveAnnouncement,
                icon: const Icon(Icons.save),
                label: Text(
                  isEditing ? 'Değişiklikleri Kaydet' : 'Duyuruyu Kaydet',
                ),
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
