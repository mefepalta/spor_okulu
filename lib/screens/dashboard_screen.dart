import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/wave_background.dart';

import '../constants/app_roles.dart';
import '../models/app_models.dart';
import '../routes/app_routes.dart';
import '../services/absence_alert_service.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/parent_service.dart';
import '../services/user_management_service.dart';
import '../services/user_role_service.dart';
import '../theme/app_colors.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/summary_section.dart';
import 'announcements_screen.dart';
import 'attendance_screen.dart';
import 'child_attendance_screen.dart';
import 'coaches_screen.dart';
import 'events_screen.dart';
import 'groups_screen.dart';
import 'parents_screen.dart';
import 'payments_screen.dart';
import 'performance_screen.dart';
import 'profile_screen.dart';
import 'reports_screen.dart';
import 'sports_screen.dart';
import 'students_screen.dart';
import 'users_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  final UserRoleService _userRoleService = UserRoleService();
  final ParentService _parentService = ParentService();
  final UserManagementService _userManagementService = UserManagementService();
  final AbsenceAlertService _absenceAlertService = AbsenceAlertService();
  StreamSubscription<List<Announcement>>? _announcementSubscription;

  final List<Student> _students = [];
  final List<Coach> _coaches = [];
  final List<TrainingGroup> _groups = [];
  final List<AttendanceRecord> _attendanceRecords = [];
  final List<PaymentRecord> _payments = [];
  final List<Announcement> _announcements = [];
  final List<PerformanceRecord> _performanceRecords = [];
  final List<PlannedEvent> _events = [];
  final List<EventResponse> _eventResponses = [];
  final List<ParentAccount> _parents = [];
  final List<UserAccount> _users = [];
  List<String> _assignedStudentIds = const [];

  String _userRole = AppRoles.viewer;
  int _knownAnnouncementCount = 0;
  int _unreadAnnouncementCount = 0;

  /// Velinin bu cihazda henüz görmediği devamsızlık ("Gelmedi") sayısı.
  int _unreadAbsenceCount = 0;
  bool _hasStartedAnnouncementListener = false;
  bool _hasReceivedInitialAnnouncementSnapshot = false;
  bool _isLoading = true;
  String? _errorMessage;

  bool get _isAdmin => _userRole == AppRoles.admin;
  bool get _isCoach => _userRole == AppRoles.coach;
  bool get _isParent => _userRole == AppRoles.parent;

  bool get _canManageCore => _isAdmin;
  bool get _canManageGroups => _isAdmin || _isCoach;
  bool get _canViewPayments => _isAdmin || _isCoach;
  bool get _canManageAttendance => _isAdmin || _isCoach;
  bool get _canManageAnnouncements => _isAdmin || _isCoach;
  bool get _canManagePerformance => _isAdmin || _isCoach;
  bool get _canManageEvents => _isAdmin || _isCoach;

  /// Veli hesabına atanmış öğrenciler.
  List<Student> get _myChildren {
    return _students
        .where((student) => _assignedStudentIds.contains(student.id))
        .toList();
  }

  /// Giriş yapan velinin verdiği katılım cevapları.
  List<EventResponse> get _myEventResponses {
    final uid = _authService.currentUser?.uid;
    if (uid == null) {
      return const [];
    }
    return _eventResponses
        .where((response) => response.parentUid == uid)
        .toList();
  }

  /// Velinin göreceği duyurular (Herkes veya Veliler hedefli). Diğer roller
  /// yönetici olduğundan tüm duyuruları görür.
  List<Announcement> _visibleAnnouncements(List<Announcement> all) {
    if (!_isParent) {
      return all;
    }
    return all
        .where(
          (announcement) =>
              AnnouncementAudience.isVisibleToParent(announcement.targetAudience),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  @override
  void dispose() {
    _announcementSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadAllData() async {
    try {
      final userRole = await _userRoleService.getCurrentUserRole();
      final isAdmin = userRole == AppRoles.admin;
      final isCoach = userRole == AppRoles.coach;
      final isParent = userRole == AppRoles.parent;
      final isViewer = userRole == AppRoles.viewer;
      final isStaff = isAdmin || isCoach || isViewer;

      // Herkesin (veliler dahil) okuyabildiği koleksiyonlar.
      final loadedAnnouncements = await _firestoreService.loadAnnouncements();
      final loadedEvents = await _firestoreService.loadEvents();

      // Rol bazlı yükleme: her rol yalnızca yetkili olduğu veriyi çeker.
      // Böylece veli/görüntüleyici, başkalarının hassas verisini indirmez ve
      // Firestore kurallarıyla uyumlu kalır.
      var loadedStudents = const <Student>[];
      var loadedCoaches = const <Coach>[];
      var loadedGroups = const <TrainingGroup>[];
      var loadedAttendanceRecords = const <AttendanceRecord>[];
      var loadedPayments = const <PaymentRecord>[];
      var loadedPerformance = const <PerformanceRecord>[];
      var loadedResponses = const <EventResponse>[];
      var assignedStudentIds = const <String>[];
      var loadedParents = const <ParentAccount>[];
      var loadedUsers = const <UserAccount>[];

      if (isParent) {
        assignedStudentIds = await _userRoleService.getCurrentUserStudentIds();
        loadedStudents = await _firestoreService.loadStudentsByIds(
          assignedStudentIds,
        );
        loadedPerformance = await _firestoreService
            .loadPerformanceRecordsForStudents(assignedStudentIds);
        loadedPayments = await _firestoreService.loadPaymentsForStudents(
          assignedStudentIds,
        );
        loadedAttendanceRecords = await _firestoreService
            .loadAttendanceForStudents(assignedStudentIds);

        final uid = _authService.currentUser?.uid;
        loadedResponses = uid == null
            ? const []
            : await _firestoreService.loadEventResponsesForParent(uid);
      } else if (isStaff) {
        loadedStudents = await _firestoreService.loadStudents();
        loadedCoaches = await _firestoreService.loadCoaches();
        loadedGroups = await _firestoreService.loadGroups();
        loadedAttendanceRecords = await _firestoreService
            .loadAttendanceRecords();
        loadedPerformance = await _firestoreService.loadPerformanceRecords();
        loadedResponses = await _firestoreService.loadEventResponses();

        // Ödemeleri yalnızca admin ve antrenör okuyabilir.
        if (isAdmin || isCoach) {
          loadedPayments = await _firestoreService.loadPayments();
        }

        // Veli ve kullanıcı yönetimi yalnızca admin içindir.
        if (isAdmin) {
          loadedParents = await _parentService.loadParents();
          loadedUsers = await _userManagementService.loadUsers();
        }
      }

      if (!mounted) {
        return;
      }

      setState(() {
        _userRole = userRole;
        _assignedStudentIds = assignedStudentIds;

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

        _performanceRecords
          ..clear()
          ..addAll(loadedPerformance);

        _events
          ..clear()
          ..addAll(loadedEvents);

        _eventResponses
          ..clear()
          ..addAll(loadedResponses);

        _parents
          ..clear()
          ..addAll(loadedParents);

        _users
          ..clear()
          ..addAll(loadedUsers);

        _knownAnnouncementCount =
            _visibleAnnouncements(loadedAnnouncements).length;
        _isLoading = false;
        _errorMessage = null;
      });

      _startAnnouncementListener();
      _refreshAbsenceAlerts();
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

  void _startAnnouncementListener() {
    if (_hasStartedAnnouncementListener) {
      return;
    }

    _hasStartedAnnouncementListener = true;

    _announcementSubscription = _firestoreService.watchAnnouncements().listen((
      announcements,
    ) {
      if (!mounted) {
        return;
      }

      // Badge/bildirim yalnızca role görünür duyurulara göre hesaplanır;
      // liste tam olarak saklanır (yönetici ekranı hepsini gösterir).
      final currentCount = _visibleAnnouncements(announcements).length;

      if (!_hasReceivedInitialAnnouncementSnapshot) {
        setState(() {
          _hasReceivedInitialAnnouncementSnapshot = true;
          _knownAnnouncementCount = currentCount;
          _announcements
            ..clear()
            ..addAll(announcements);
        });
        return;
      }

      if (currentCount > _knownAnnouncementCount) {
        final newCount = currentCount - _knownAnnouncementCount;

        setState(() {
          _knownAnnouncementCount = currentCount;
          _unreadAnnouncementCount += newCount;
          _announcements
            ..clear()
            ..addAll(announcements);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              newCount == 1
                  ? 'Yeni bir duyuru yayınlandı.'
                  : '$newCount yeni duyuru yayınlandı.',
            ),
            action: SnackBarAction(
              label: 'Görüntüle',
              onPressed: () {
                _openAnnouncementsScreen(context);
              },
            ),
          ),
        );

        return;
      }

      setState(() {
        _knownAnnouncementCount = currentCount;
        _announcements
          ..clear()
          ..addAll(announcements);
      });
    });
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
          isAdmin: _canManageCore,
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
          isAdmin: _canManageCore,
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
          students: _students,
          canManage: _canManageGroups,
          canDelete: _canManageCore,
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
          isAdmin: _canManageAttendance,
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
          isAdmin: _canManageCore,
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
    setState(() {
      _unreadAnnouncementCount = 0;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnnouncementsScreen(
          announcements: _visibleAnnouncements(_announcements),
          isAdmin: _canManageAnnouncements,
          onAddAnnouncement: _addAnnouncement,
          onDeleteAnnouncement: _deleteAnnouncement,
          onUpdateAnnouncement: _updateAnnouncement,
        ),
      ),
    );
  }

  // --- Performans ---

  Future<void> _addPerformanceRecord(PerformanceRecord record) async {
    final savedRecord = await _firestoreService.addPerformanceRecord(record);

    setState(() {
      _performanceRecords.add(savedRecord);
    });
  }

  Future<void> _deletePerformanceRecord(String id) async {
    await _firestoreService.deletePerformanceRecord(id);

    setState(() {
      _performanceRecords.removeWhere((record) => record.id == id);
    });
  }

  void _openPerformanceScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PerformanceScreen(
          students: _isParent ? _myChildren : _students,
          records: _performanceRecords,
          canManage: _canManagePerformance,
          onAddRecord: _addPerformanceRecord,
          onDeleteRecord: _deletePerformanceRecord,
        ),
      ),
    );
  }

  // --- Etkinlikler ---

  Future<void> _addEvent(PlannedEvent event) async {
    final savedEvent = await _firestoreService.addEvent(event);

    setState(() {
      _events.add(savedEvent);
    });
  }

  Future<void> _deleteEvent(String id) async {
    await _firestoreService.deleteEvent(id);

    setState(() {
      _events.removeWhere((event) => event.id == id);
    });
  }

  Future<void> _respondToEvent(EventResponse response) async {
    final savedResponse = await _firestoreService.setEventResponse(response);

    setState(() {
      _eventResponses.removeWhere((item) => item.id == savedResponse.id);
      _eventResponses.add(savedResponse);
    });
  }

  void _openEventsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventsScreen(
          events: _events,
          responses: _isParent ? _myEventResponses : _eventResponses,
          children: _isParent ? _myChildren : const [],
          currentUserUid: _authService.currentUser?.uid ?? '',
          canManage: _canManageEvents,
          onAddEvent: _addEvent,
          onDeleteEvent: _deleteEvent,
          onRespond: _respondToEvent,
        ),
      ),
    );
  }

  // --- Veliler ---

  Future<void> _reloadParents() async {
    final parents = await _parentService.loadParents();

    if (!mounted) {
      return;
    }

    setState(() {
      _parents
        ..clear()
        ..addAll(parents);
    });
  }

  Future<void> _addParent(String email) async {
    await _parentService.promoteToParentByEmail(email);
    await _reloadParents();
  }

  Future<void> _assignStudentsToParent(
    String uid,
    List<String> studentIds,
  ) async {
    await _parentService.setAssignedStudents(uid, studentIds);
    await _reloadParents();
  }

  Future<void> _removeParent(String uid) async {
    await _parentService.removeParent(uid);
    await _reloadParents();
  }

  void _openParentsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParentsScreen(
          parents: _parents,
          students: _students,
          onAddParent: _addParent,
          onAssignStudents: _assignStudentsToParent,
          onRemoveParent: _removeParent,
        ),
      ),
    );
  }

  // --- Kullanıcılar / Roller ---

  Future<void> _reloadUsersAndParents() async {
    final users = await _userManagementService.loadUsers();
    final parents = await _parentService.loadParents();

    if (!mounted) {
      return;
    }

    setState(() {
      _users
        ..clear()
        ..addAll(users);
      _parents
        ..clear()
        ..addAll(parents);
    });
  }

  Future<void> _setUserRole(String uid, String role) async {
    await _userManagementService.setRole(uid, role);
    await _reloadUsersAndParents();
  }

  void _openUsersScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UsersScreen(
          users: _users,
          currentUserUid: _authService.currentUser?.uid ?? '',
          onSetRole: _setUserRole,
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

  /// Velinin çocuğuna ait okunmamış devamsızlık sayısını yeniden hesaplar.
  ///
  /// Uyarılar yüklü yoklama kayıtlarından türetilir; "görüldü" durumu cihazda
  /// tutulur (bkz. [AbsenceAlertService]).
  Future<void> _refreshAbsenceAlerts() async {
    if (!_isParent) {
      return;
    }
    final uid = _authService.currentUser?.uid;
    if (uid == null) {
      return;
    }
    final count = await _absenceAlertService.unreadCount(
      userId: uid,
      records: _attendanceRecords,
      children: _myChildren,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _unreadAbsenceCount = count;
    });
  }

  /// Velinin çocuğunun yoklama geçmişi (salt-okunur, çocuğa özel).
  Future<void> _openChildAttendanceScreen(BuildContext context) async {
    // Ekran açılınca mevcut devamsızlıklar "görüldü" sayılır ve rozet sıfırlanır.
    final uid = _authService.currentUser?.uid;
    if (uid != null) {
      await _absenceAlertService.markAllSeen(
        userId: uid,
        records: _attendanceRecords,
        children: _myChildren,
      );
      if (mounted) {
        setState(() {
          _unreadAbsenceCount = 0;
        });
      }
    }

    if (!context.mounted) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChildAttendanceScreen(
          children: _myChildren,
          records: _attendanceRecords,
        ),
      ),
    );
  }

  void _openSportsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SportsScreen()),
    );
  }

  void _openProfileScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          userRole: _userRole,
          children: _isParent ? _myChildren : const [],
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

  // --- Sol menü (Drawer) ---

  /// Sol üstteki ☰ menüsü. Tüm gezinme hedeflerini role göre gruplayarak
  /// listeler; böylece Ana Panel yalnızca öne çıkan kartları taşır.
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _isParent
                  ? _parentDrawerItems(context)
                  : _staffDrawerItems(context),
            ),
          ),
          const Divider(height: 1),
          _drawerTile(
            icon: Icons.account_circle,
            label: 'Profil',
            onTap: () {
              Navigator.pop(context);
              _openProfileScreen(context);
            },
          ),
          _drawerTile(
            icon: Icons.logout,
            label: 'Çıkış Yap',
            color: Colors.red,
            onTap: () {
              Navigator.pop(context);
              _logout(context);
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    final roleLabel = _isAdmin
        ? 'Yönetici'
        : _isCoach
        ? 'Antrenör'
        : _isParent
        ? 'Veli'
        : 'Görüntüleyici';
    final email = _authService.currentUser?.email ?? '';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.mid],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white24,
            child: Icon(Icons.sports_soccer, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 12),
          const Text(
            'Spor Okulu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            email.isNotEmpty ? '$roleLabel • $email' : roleLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  /// Menüde bir bölüm başlığı (ör. "KAYITLAR").
  Widget _drawerSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _drawerTile({
    required IconData icon,
    required String label,
    Color? color,
    VoidCallback? onTap,
  }) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: color),
      title: Text(
        label,
        style: color != null ? TextStyle(color: color) : null,
      ),
      onTap: onTap,
    );
  }

  /// Bir gezinme hedefini açar: önce menüyü kapatır, sonra ekranı iter.
  Widget _drawerNav(IconData icon, String label, void Function(BuildContext) open) {
    return _drawerTile(
      icon: icon,
      label: label,
      onTap: () {
        Navigator.pop(context);
        open(context);
      },
    );
  }

  List<Widget> _staffDrawerItems(BuildContext context) {
    return [
      _drawerSection('Kayıtlar'),
      _drawerNav(Icons.people, 'Öğrenciler', _openStudentsScreen),
      _drawerNav(Icons.sports, 'Antrenörler', _openCoachesScreen),
      _drawerNav(Icons.groups, 'Gruplar', _openGroupsScreen),
      if (_isAdmin) _drawerNav(Icons.family_restroom, 'Veliler', _openParentsScreen),
      _drawerSection('Operasyon'),
      _drawerNav(Icons.check_circle, 'Yoklama', _openAttendanceScreen),
      if (_canViewPayments) _drawerNav(Icons.payment, 'Ödemeler', _openPaymentsScreen),
      if (_canManagePerformance)
        _drawerNav(Icons.query_stats, 'Performans', _openPerformanceScreen),
      if (_canManageEvents)
        _drawerNav(Icons.event_available, 'Etkinlikler', _openEventsScreen),
      _drawerNav(Icons.campaign, 'Duyurular', _openAnnouncementsScreen),
      _drawerSection('Genel'),
      _drawerNav(Icons.analytics, 'Raporlar', _openReportsScreen),
      _drawerNav(Icons.sports_soccer, 'Sporlar', _openSportsScreen),
      if (_isAdmin)
        _drawerNav(Icons.manage_accounts, 'Kullanıcılar', _openUsersScreen),
    ];
  }

  List<Widget> _parentDrawerItems(BuildContext context) {
    return [
      _drawerSection('Çocuğum'),
      _drawerNav(Icons.query_stats, 'Performans', _openPerformanceScreen),
      _drawerNav(Icons.check_circle, 'Yoklama', _openChildAttendanceScreen),
      _drawerNav(Icons.event_available, 'Etkinlikler', _openEventsScreen),
      _drawerNav(Icons.payment, 'Ödemeler', _openPaymentsScreen),
      _drawerSection('Genel'),
      _drawerNav(Icons.campaign, 'Duyurular', _openAnnouncementsScreen),
      _drawerNav(Icons.sports_soccer, 'Sporlar', _openSportsScreen),
    ];
  }

  /// AppBar'ın sağ üstündeki duyuru çanı: okunmamış duyuru sayısını rozetle
  /// gösterir, dokununca duyurular ekranını açar ve rozeti sıfırlar.
  Widget _buildNotificationsAction(BuildContext context) {
    final hasUnread = _unreadAnnouncementCount > 0;

    return Badge(
      isLabelVisible: hasUnread,
      offset: const Offset(-6, 6),
      label: Text(
        _unreadAnnouncementCount > 99 ? '99+' : '$_unreadAnnouncementCount',
      ),
      child: IconButton(
        tooltip: 'Duyurular',
        onPressed: () {
          _openAnnouncementsScreen(context);
        },
        icon: Icon(
          hasUnread ? Icons.notifications_active : Icons.notifications_outlined,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WaveScaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text(
          _isAdmin
              ? 'Spor Okulu'
              : _isCoach
              ? 'Spor Okulu - Antrenör'
              : _isParent
              ? 'Spor Okulu - Veli'
              : 'Spor Okulu - Görüntüleme',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          _buildNotificationsAction(context),
          IconButton(
            onPressed: () {
              _openProfileScreen(context);
            },
            icon: const Icon(Icons.account_circle),
          ),
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

    if (_isParent) {
      return _buildParentBody(context);
    }

    return _buildStaffSummary(context);
  }

  /// Veli panosu: Performans/Etkinlikler ve Yoklama/Ödemeler ikişerli satırlar,
  /// altta tam genişlikte Duyurular kartı.
  Widget _buildParentBody(BuildContext context) {
    final childCount = _myChildren.length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SizedBox(
          height: 170,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: DashboardCard(
                  icon: Icons.query_stats,
                  title: 'Performans',
                  subtitle: childCount == 1
                      ? '1 öğrenci'
                      : '$childCount öğrenci',
                  onTap: () {
                    _openPerformanceScreen(context);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DashboardCard(
                  icon: Icons.event_available,
                  title: 'Etkinlikler',
                  subtitle: '${_events.length} etkinlik',
                  onTap: () {
                    _openEventsScreen(context);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 170,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: DashboardCard(
                  icon: Icons.check_circle,
                  title: 'Yoklama',
                  subtitle: _unreadAbsenceCount > 0
                      ? _unreadAbsenceCount == 1
                            ? '${_attendanceRecords.length} kayıt • 1 yeni devamsızlık'
                            : '${_attendanceRecords.length} kayıt • $_unreadAbsenceCount yeni devamsızlık'
                      : '${_attendanceRecords.length} kayıt',
                  badgeCount: _unreadAbsenceCount,
                  onTap: () {
                    _openChildAttendanceScreen(context);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DashboardCard(
                  icon: Icons.payment,
                  title: 'Ödemeler',
                  subtitle: '${_payments.length} kayıt',
                  onTap: () {
                    _openPaymentsScreen(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Admin / antrenör / görüntüleyici panosu: gezinme kartları yerine mevcut
  /// veriden türetilen özetler. Ayrıntılara ☰ menüden erişilir.
  Widget _buildStaffSummary(BuildContext context) {
    final sections = <Widget>[
      _buildGreeting(),
      const SizedBox(height: 16),
      _buildStatTilesRow(context),
      const SizedBox(height: 12),
      _buildAttendanceSummarySection(context),
    ];

    if (_canViewPayments) {
      sections.add(_buildFinanceSummarySection(context));
      final unpaidSection = _buildUnpaidSection(context);
      if (unpaidSection != null) {
        sections.add(unpaidSection);
      }
    }

    final announcementSection = _buildLatestAnnouncementSection(context);
    if (announcementSection != null) {
      sections.add(announcementSection);
    }

    return ListView(padding: const EdgeInsets.all(16), children: sections);
  }

  Widget _buildGreeting() {
    final label = _isAdmin
        ? 'Yönetici'
        : _isCoach
        ? 'Antrenör'
        : 'Görüntüleyici';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'İyi günler, $label 👋',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Kulübünüzün güncel özeti aşağıda.',
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
        ),
      ],
    );
  }

  Widget _buildStatTilesRow(BuildContext context) {
    // IntrinsicHeight: dikey ListView içinde Row'a sınırlı yükseklik verir;
    // böylece stretch tüm kutucukları en uzun olana eşitler (taşma hatası olmaz).
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StatTile(
              icon: Icons.people,
              value: '${_students.length}',
              label: 'Öğrenci',
              accent: Colors.green,
              onTap: () => _openStudentsScreen(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatTile(
              icon: Icons.sports,
              value: '${_coaches.length}',
              label: 'Antrenör',
              accent: Colors.orange,
              onTap: () => _openCoachesScreen(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatTile(
              icon: Icons.groups,
              value: '${_groups.length}',
              label: 'Grup',
              accent: AppColors.primary,
              onTap: () => _openGroupsScreen(context),
            ),
          ),
        ],
      ),
    );
  }

  int _presentCountOf(AttendanceRecord record) =>
      record.presentStudentIds.isNotEmpty
      ? record.presentStudentIds.length
      : record.presentStudentNames.length;

  int _absentCountOf(AttendanceRecord record) =>
      record.absentStudentIds.isNotEmpty
      ? record.absentStudentIds.length
      : record.absentStudentNames.length;

  Widget _buildAttendanceSummarySection(BuildContext context) {
    final recordCount = _attendanceRecords.length;
    var present = 0;
    var absent = 0;
    for (final record in _attendanceRecords) {
      present += _presentCountOf(record);
      absent += _absentCountOf(record);
    }
    final total = present + absent;
    final rate = total == 0 ? 0 : (present / total * 100).round();
    final rateColor = rate >= 80
        ? Colors.green
        : rate >= 50
        ? Colors.orange
        : Colors.red;

    return SummarySection(
      icon: Icons.check_circle,
      title: 'Yoklama Özeti',
      iconColor: Colors.green,
      actionLabel: 'Tümü',
      onAction: () => _openAttendanceScreen(context),
      child: recordCount == 0
          ? _emptyHint('Henüz yoklama kaydı yok.')
          : SummaryMetricsRow(
              metrics: [
                SummaryMetric(
                  value: '$recordCount',
                  label: 'Kayıt',
                  color: AppColors.primary,
                ),
                SummaryMetric(
                  value: '$present',
                  label: 'Geldi',
                  color: Colors.green,
                ),
                SummaryMetric(
                  value: '$absent',
                  label: 'Gelmedi',
                  color: Colors.red,
                ),
                SummaryMetric(
                  value: '%$rate',
                  label: 'Katılım',
                  color: rateColor,
                ),
              ],
            ),
    );
  }

  int _sumPaymentsFor(String status) => _payments
      .where((payment) => payment.status == status)
      .fold(0, (sum, payment) => sum + payment.amount);

  Widget _buildFinanceSummarySection(BuildContext context) {
    return SummarySection(
      icon: Icons.account_balance_wallet,
      title: 'Finansal Özet',
      iconColor: AppColors.primary,
      actionLabel: 'Ödemeler',
      onAction: () => _openPaymentsScreen(context),
      child: _payments.isEmpty
          ? _emptyHint('Henüz ödeme kaydı yok.')
          : SummaryMetricsRow(
              metrics: [
                SummaryMetric(
                  value: _formatTl(_sumPaymentsFor('Ödendi')),
                  label: 'Tahsil',
                  color: Colors.green,
                ),
                SummaryMetric(
                  value: _formatTl(_sumPaymentsFor('Bekliyor')),
                  label: 'Bekleyen',
                  color: Colors.orange,
                ),
                SummaryMetric(
                  value: _formatTl(_sumPaymentsFor('Gecikti')),
                  label: 'Geciken',
                  color: Colors.red,
                ),
              ],
            ),
    );
  }

  /// Ödenmemiş (Bekliyor/Gecikti) aidatların kısa listesi. Hiç yoksa `null`
  /// döner (bölüm gösterilmez).
  Widget? _buildUnpaidSection(BuildContext context) {
    final unpaid = _payments
        .where((payment) => payment.status != 'Ödendi')
        .toList();
    if (unpaid.isEmpty) {
      return null;
    }

    const maxRows = 4;
    final shown = unpaid.take(maxRows).toList();
    final remaining = unpaid.length - shown.length;

    return SummarySection(
      icon: Icons.warning_amber_rounded,
      title: 'Ödenmemiş Aidatlar (${unpaid.length})',
      iconColor: Colors.red,
      actionLabel: 'Tümü',
      onAction: () => _openPaymentsScreen(context),
      child: Column(
        children: [
          for (final payment in shown) _unpaidRow(payment),
          if (remaining > 0)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '+$remaining öğrenci daha',
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _unpaidRow(PaymentRecord payment) {
    final isOverdue = payment.status == 'Gecikti';
    final statusColor = isOverdue ? Colors.red : Colors.orange;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.studentName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (payment.period.isNotEmpty)
                  Text(
                    payment.period,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (payment.amount > 0) ...[
            Text(
              _formatTl(payment.amount),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 10),
          ],
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              payment.status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// En son duyurunun kısa önizlemesi. Görünür duyuru yoksa `null` döner.
  Widget? _buildLatestAnnouncementSection(BuildContext context) {
    final visible = _visibleAnnouncements(_announcements);
    if (visible.isEmpty) {
      return null;
    }
    final latest = visible.first;

    return SummarySection(
      icon: Icons.campaign,
      title: 'Son Duyuru',
      iconColor: AppColors.primary,
      actionLabel: 'Tümü',
      onAction: () => _openAnnouncementsScreen(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            latest.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            latest.content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyHint(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
      ),
    );
  }

  /// Tam sayı kuruşsuz TL tutarını binlik ayraçla biçimler (ör. 12.500 ₺).
  String _formatTl(int amount) {
    final digits = amount.abs().toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(digits[i]);
    }
    return '${amount < 0 ? '-' : ''}$buffer ₺';
  }
}
