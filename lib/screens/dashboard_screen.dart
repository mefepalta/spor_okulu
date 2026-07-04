import 'package:flutter/material.dart';

import '../models/app_models.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/user_role_service.dart';
import '../widgets/dashboard_card.dart';
import 'announcements_screen.dart';
import 'attendance_screen.dart';
import 'coaches_screen.dart';
import 'groups_screen.dart';
import 'payments_screen.dart';
import 'reports_screen.dart';
import 'students_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  final UserRoleService _userRoleService = UserRoleService();

  final List<Student> _students = [];
  final List<Coach> _coaches = [];
  final List<TrainingGroup> _groups = [];
  final List<AttendanceRecord> _attendanceRecords = [];
  final List<PaymentRecord> _payments = [];
  final List<Announcement> _announcements = [];

  bool _isAdmin = false;
  bool _isLoading = true;
  String? _errorMessage;

  bool get _canManage => !_isLoading && _isAdmin;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    try {
      final isAdmin = await _userRoleService.isCurrentUserAdmin();
      final loadedStudents = await _firestoreService.loadStudents();
      final loadedCoaches = await _firestoreService.loadCoaches();
      final loadedGroups = await _firestoreService.loadGroups();
      final loadedAttendanceRecords = await _firestoreService
          .loadAttendanceRecords();
      final loadedPayments = await _firestoreService.loadPayments();
      final loadedAnnouncements = await _firestoreService.loadAnnouncements();

      if (!mounted) {
        return;
      }

      setState(() {
        _isAdmin = isAdmin;

        _students
          ..clear()
          ..addAll(loadedStudents);

        _coaches
          ..clear()
          ..addAll(loadedCoaches);

        _groups
          ..clear()
          ..addAll(loadedGroups);

        _attendanceRecords
          ..clear()
          ..addAll(loadedAttendanceRecords);

        _payments
          ..clear()
          ..addAll(loadedPayments);

        _announcements
          ..clear()
          ..addAll(loadedAnnouncements);

        _isLoading = false;
        _errorMessage = null;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _errorMessage = 'Veriler yüklenirken bir hata oluştu: $error';
      });
    }
  }

  Future<void> _addStudent(Student student) async {
    final savedStudent = await _firestoreService.addStudent(student);

    setState(() {
      _students.add(savedStudent);
    });
  }

  Future<void> _deleteStudent(int index) async {
    await _firestoreService.deleteStudent(_students[index].id);

    setState(() {
      _students.removeAt(index);
    });
  }

  Future<void> _updateStudent(int index, Student updatedStudent) async {
    final studentWithId = updatedStudent.copyWith(id: _students[index].id);
    await _firestoreService.updateStudent(studentWithId);

    setState(() {
      _students[index] = studentWithId;
    });
  }

  void _openStudentsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentsScreen(
          students: _students,
          isAdmin: _canManage,
          onAddStudent: _addStudent,
          onDeleteStudent: _deleteStudent,
          onUpdateStudent: _updateStudent,
        ),
      ),
    );
  }

  Future<void> _addCoach(Coach coach) async {
    final savedCoach = await _firestoreService.addCoach(coach);

    setState(() {
      _coaches.add(savedCoach);
    });
  }

  Future<void> _deleteCoach(int index) async {
    await _firestoreService.deleteCoach(_coaches[index].id);

    setState(() {
      _coaches.removeAt(index);
    });
  }

  Future<void> _updateCoach(int index, Coach updatedCoach) async {
    final coachWithId = updatedCoach.copyWith(id: _coaches[index].id);
    await _firestoreService.updateCoach(coachWithId);

    setState(() {
      _coaches[index] = coachWithId;
    });
  }

  void _openCoachesScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoachesScreen(
          coaches: _coaches,
          isAdmin: _canManage,
          onAddCoach: _addCoach,
          onDeleteCoach: _deleteCoach,
          onUpdateCoach: _updateCoach,
        ),
      ),
    );
  }

  Future<void> _addGroup(TrainingGroup group) async {
    final savedGroup = await _firestoreService.addGroup(group);

    setState(() {
      _groups.add(savedGroup);
    });
  }

  Future<void> _deleteGroup(int index) async {
    await _firestoreService.deleteGroup(_groups[index].id);

    setState(() {
      _groups.removeAt(index);
    });
  }

  Future<void> _updateGroup(int index, TrainingGroup updatedGroup) async {
    final groupWithId = updatedGroup.copyWith(id: _groups[index].id);
    await _firestoreService.updateGroup(groupWithId);

    setState(() {
      _groups[index] = groupWithId;
    });
  }

  void _openGroupsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupsScreen(
          groups: _groups,
          coaches: _coaches,
          isAdmin: _canManage,
          onAddGroup: _addGroup,
          onDeleteGroup: _deleteGroup,
          onUpdateGroup: _updateGroup,
        ),
      ),
    );
  }

  Future<void> _addAttendanceRecord(AttendanceRecord record) async {
    final savedRecord = await _firestoreService.addAttendanceRecord(record);

    setState(() {
      _attendanceRecords.add(savedRecord);
    });
  }

  Future<void> _deleteAttendanceRecord(int index) async {
    await _firestoreService.deleteAttendanceRecord(
      _attendanceRecords[index].id,
    );

    setState(() {
      _attendanceRecords.removeAt(index);
    });
  }

  Future<void> _updateAttendanceRecord(
    int index,
    AttendanceRecord updatedRecord,
  ) async {
    final recordWithId = updatedRecord.copyWith(
      id: _attendanceRecords[index].id,
    );
    await _firestoreService.updateAttendanceRecord(recordWithId);

    setState(() {
      _attendanceRecords[index] = recordWithId;
    });
  }

  void _openAttendanceScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendanceScreen(
          groups: _groups,
          students: _students,
          attendanceRecords: _attendanceRecords,
          isAdmin: _canManage,
          onAddAttendanceRecord: _addAttendanceRecord,
          onDeleteAttendanceRecord: _deleteAttendanceRecord,
          onUpdateAttendanceRecord: _updateAttendanceRecord,
        ),
      ),
    );
  }

  Future<void> _addPayment(PaymentRecord payment) async {
    final savedPayment = await _firestoreService.addPayment(payment);

    setState(() {
      _payments.add(savedPayment);
    });
  }

  Future<void> _deletePayment(int index) async {
    await _firestoreService.deletePayment(_payments[index].id);

    setState(() {
      _payments.removeAt(index);
    });
  }

  Future<void> _updatePayment(int index, PaymentRecord updatedPayment) async {
    final paymentWithId = updatedPayment.copyWith(id: _payments[index].id);
    await _firestoreService.updatePayment(paymentWithId);

    setState(() {
      _payments[index] = paymentWithId;
    });
  }

  void _openPaymentsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentsScreen(
          students: _students,
          payments: _payments,
          isAdmin: _canManage,
          onAddPayment: _addPayment,
          onDeletePayment: _deletePayment,
          onUpdatePayment: _updatePayment,
        ),
      ),
    );
  }

  Future<void> _addAnnouncement(Announcement announcement) async {
    final savedAnnouncement = await _firestoreService.addAnnouncement(
      announcement,
    );

    setState(() {
      _announcements.add(savedAnnouncement);
    });
  }

  Future<void> _deleteAnnouncement(int index) async {
    await _firestoreService.deleteAnnouncement(_announcements[index].id);

    setState(() {
      _announcements.removeAt(index);
    });
  }

  Future<void> _updateAnnouncement(
    int index,
    Announcement updatedAnnouncement,
  ) async {
    final announcementWithId = updatedAnnouncement.copyWith(
      id: _announcements[index].id,
    );
    await _firestoreService.updateAnnouncement(announcementWithId);

    setState(() {
      _announcements[index] = announcementWithId;
    });
  }

  void _openAnnouncementsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnnouncementsScreen(
          announcements: _announcements,
          isAdmin: _canManage,
          onAddAnnouncement: _addAnnouncement,
          onDeleteAnnouncement: _deleteAnnouncement,
          onUpdateAnnouncement: _updateAnnouncement,
        ),
      ),
    );
  }

  void _openReportsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportsScreen(
          students: _students,
          coaches: _coaches,
          groups: _groups,
          attendanceRecords: _attendanceRecords,
          payments: _payments,
          announcements: _announcements,
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await _authService.signOut();

    if (!context.mounted) {
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = _isAdmin
        ? 'Spor Okulu Yönetimi'
        : 'Spor Okulu Yönetimi - Görüntüleme';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(_errorMessage!, textAlign: TextAlign.center),
        ),
      );
    }

    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        DashboardCard(
          icon: Icons.people,
          title: 'Öğrenciler',
          subtitle: '${_students.length} öğrenci',
          onTap: () {
            _openStudentsScreen(context);
          },
        ),
        DashboardCard(
          icon: Icons.sports,
          title: 'Antrenörler',
          subtitle: '${_coaches.length} antrenör',
          onTap: () {
            _openCoachesScreen(context);
          },
        ),
        DashboardCard(
          icon: Icons.groups,
          title: 'Gruplar',
          subtitle: '${_groups.length} grup',
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
        DashboardCard(
          icon: Icons.analytics,
          title: 'Raporlar',
          subtitle: 'Genel özet',
          onTap: () {
            _openReportsScreen(context);
          },
        ),
      ],
    );
  }
}
