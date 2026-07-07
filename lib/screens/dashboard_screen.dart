import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/wave_background.dart';

import '../constants/app_roles.dart';
import '../data/sports_data.dart';
import '../models/app_models.dart';
import '../routes/app_routes.dart';
import '../services/absence_alert_service.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/parent_service.dart';
import '../services/user_management_service.dart';
import '../services/user_role_service.dart';
import '../theme/theme_controller.dart';
import '../widgets/dashboard_card.dart';
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

  @override
  Widget build(BuildContext context) {
    return WaveScaffold(
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
          IconButton(
            tooltip: 'Aydınlık / karanlık mod',
            onPressed: () {
              ThemeController.instance.toggle(Theme.of(context).brightness);
            },
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
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

    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.9,
      children: _buildStaffCards(),
    );
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
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: DashboardCard(
            icon: Icons.campaign,
            title: 'Duyurular',
            subtitle:
                '${_visibleAnnouncements(_announcements).length} duyuru',
            onTap: () {
              _openAnnouncementsScreen(context);
            },
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: DashboardCard(
            icon: Icons.sports_soccer,
            title: 'Sporlar',
            subtitle: '${sportsCatalog.length} spor',
            onTap: () {
              _openSportsScreen(context);
            },
          ),
        ),
      ],
    );
  }

  /// Admin / antrenör / görüntüleyici panosu.
  List<Widget> _buildStaffCards() {
    return [
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
      // Ödemeler yalnızca admin ve antrenöre görünür (finansal veri).
      if (_canViewPayments)
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
        subtitle: _unreadAnnouncementCount > 0
            ? '${_announcements.length} duyuru - $_unreadAnnouncementCount yeni'
            : '${_announcements.length} duyuru',
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
      DashboardCard(
        icon: Icons.sports_soccer,
        title: 'Sporlar',
        subtitle: '${sportsCatalog.length} spor',
        onTap: () {
          _openSportsScreen(context);
        },
      ),
      // Performans girişi yalnızca antrenör ve admin için.
      if (_canManagePerformance)
        DashboardCard(
          icon: Icons.query_stats,
          title: 'Performans',
          subtitle: '${_performanceRecords.length} kayıt',
          onTap: () {
            _openPerformanceScreen(context);
          },
        ),
      // Etkinlik yönetimi yalnızca antrenör ve admin için.
      if (_canManageEvents)
        DashboardCard(
          icon: Icons.event_available,
          title: 'Etkinlikler',
          subtitle: '${_events.length} etkinlik',
          onTap: () {
            _openEventsScreen(context);
          },
        ),
      // Veli yönetim kartı yalnızca admin için görünür (viewer göremez).
      if (_isAdmin)
        DashboardCard(
          icon: Icons.family_restroom,
          title: 'Veliler',
          subtitle: '${_parents.length} veli',
          onTap: () {
            _openParentsScreen(context);
          },
        ),
      // Kullanıcı/rol yönetimi yalnızca admin için.
      if (_isAdmin)
        DashboardCard(
          icon: Icons.manage_accounts,
          title: 'Kullanıcılar',
          subtitle: '${_users.length} kullanıcı',
          onTap: () {
            _openUsersScreen(context);
          },
        ),
    ];
  }
}
