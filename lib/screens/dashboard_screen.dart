import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/wave_background.dart';

import '../constants/app_roles.dart';
import '../models/app_models.dart';
import '../routes/app_routes.dart';
import '../services/absence_alert_service.dart';
import '../services/auth_service.dart';
import '../services/ai_summary.dart';
import '../services/firestore_service.dart';
import '../services/parent_service.dart';
import '../services/reminders_service.dart';
import '../services/user_management_service.dart';
import '../services/user_role_service.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import '../widgets/summary_section.dart';
import 'announcements_screen.dart';
import 'attendance_screen.dart';
import 'child_attendance_screen.dart';
import 'club_finance_screen.dart';
import 'coaches_screen.dart';
import 'equipment_screen.dart';
import 'events_screen.dart';
import 'groups_screen.dart';
import 'leave_requests_screen.dart';
import 'notifications_screen.dart';
import 'parents_screen.dart';
import 'payments_screen.dart';
import 'performance_screen.dart';
import 'profile_screen.dart';
import 'reports_screen.dart';
import 'sports_screen.dart';
import 'sportekai_screen.dart';
import 'student_accounts_screen.dart';
import 'students_screen.dart';
import 'users_screen.dart';

part 'dashboard_handlers.dart';
part 'dashboard_chrome.dart';
part 'dashboard_bodies.dart';

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
  final RemindersService _remindersService = RemindersService();
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
  final List<LeaveRequest> _leaveRequests = [];
  final List<CashTransaction> _cashTransactions = [];
  final List<EquipmentItem> _equipment = [];
  final List<ParentAccount> _studentAccounts = [];
  List<String> _assignedStudentIds = const [];

  String _userRole = AppRoles.viewer;
  int _knownAnnouncementCount = 0;
  int _unreadAnnouncementCount = 0;

  /// Velinin bu cihazda henüz görmediği devamsızlık ("Gelmedi") sayısı.
  int _unreadAbsenceCount = 0;

  /// Kullanıcının bu cihazda tuttuğu kişisel hatırlatıcılar.
  final List<Reminder> _reminders = [];
  bool _hasStartedAnnouncementListener = false;
  bool _hasReceivedInitialAnnouncementSnapshot = false;
  bool _isLoading = true;
  String? _errorMessage;

  bool get _isAdmin => _userRole == AppRoles.admin;
  bool get _isCoach => _userRole == AppRoles.coach;
  bool get _isParent => _userRole == AppRoles.parent;
  bool get _isStudent => _userRole == AppRoles.student;

  /// Verisi kendi çocuğuna/kendisine scope'lu roller (veli + öğrenci). Bu
  /// roller "tüm öğrenciler" yerine yalnızca [_myChildren]'ı görür.
  bool get _isChildScoped => _isParent || _isStudent;

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

  /// Velinin/öğrencinin göreceği duyurular (hedef kitlesine göre süzülür).
  /// Personel yönetici olduğundan tüm duyuruları görür.
  List<Announcement> _visibleAnnouncements(List<Announcement> all) {
    if (_isParent) {
      return all
          .where(
            (announcement) => AnnouncementAudience.isVisibleToParent(
              announcement.targetAudience,
            ),
          )
          .toList();
    }
    if (_isStudent) {
      return all
          .where(
            (announcement) => AnnouncementAudience.isVisibleToStudent(
              announcement.targetAudience,
            ),
          )
          .toList();
    }
    return all;
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
      final isStudent = userRole == AppRoles.student;
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
      var loadedStudentAccounts = const <ParentAccount>[];
      var loadedUsers = const <UserAccount>[];
      var loadedLeaveRequests = const <LeaveRequest>[];
      var loadedCashTransactions = const <CashTransaction>[];
      var loadedEquipment = const <EquipmentItem>[];

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
        loadedLeaveRequests = uid == null
            ? const []
            : await _firestoreService.loadLeaveRequestsForParent(uid);
      } else if (isStudent) {
        // Öğrenci: yalnızca kendi (eşlenmiş) öğrenci kaydına scope'lu, salt
        // görüntüleme. Ödeme/mazeret/etkinlik cevabı yüklenmez (veli alanı).
        assignedStudentIds = await _userRoleService.getCurrentUserStudentIds();
        loadedStudents = await _firestoreService.loadStudentsByIds(
          assignedStudentIds,
        );
        loadedPerformance = await _firestoreService
            .loadPerformanceRecordsForStudents(assignedStudentIds);
        loadedAttendanceRecords = await _firestoreService
            .loadAttendanceForStudents(assignedStudentIds);
      } else if (isStaff) {
        loadedStudents = await _firestoreService.loadStudents();
        loadedCoaches = await _firestoreService.loadCoaches();
        loadedGroups = await _firestoreService.loadGroups();
        loadedAttendanceRecords = await _firestoreService
            .loadAttendanceRecords();
        loadedPerformance = await _firestoreService.loadPerformanceRecords();
        loadedResponses = await _firestoreService.loadEventResponses();
        loadedLeaveRequests = await _firestoreService.loadLeaveRequests();
        loadedEquipment = await _firestoreService.loadEquipment();

        // Ödemeleri yalnızca admin ve antrenör okuyabilir.
        if (isAdmin || isCoach) {
          loadedPayments = await _firestoreService.loadPayments();
        }

        // Veli/kullanıcı yönetimi ve kulüp kasası yalnızca admin içindir.
        if (isAdmin) {
          loadedParents = await _parentService.loadParents();
          loadedStudentAccounts = await _parentService.loadStudentAccounts();
          loadedUsers = await _userManagementService.loadUsers();
          loadedCashTransactions = await _firestoreService
              .loadCashTransactions();
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

        _studentAccounts
          ..clear()
          ..addAll(loadedStudentAccounts);

        _users
          ..clear()
          ..addAll(loadedUsers);

        _leaveRequests
          ..clear()
          ..addAll(loadedLeaveRequests);

        _cashTransactions
          ..clear()
          ..addAll(loadedCashTransactions);

        _equipment
          ..clear()
          ..addAll(loadedEquipment);

        _knownAnnouncementCount = _visibleAnnouncements(
          loadedAnnouncements,
        ).length;
        _isLoading = false;
        _errorMessage = null;
      });

      _startAnnouncementListener();
      _refreshAbsenceAlerts();
      _loadReminders();
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
              : _isStudent
              ? 'Spor Okulu - Öğrenci'
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

    if (_isStudent) {
      return _buildStudentBody(context);
    }

    return _buildStaffSummary(context);
  }
}

/// Yeni hızlı hatırlatıcı metni almak için basit dialog.
class _ReminderDialog extends StatefulWidget {
  const _ReminderDialog();

  @override
  State<_ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<_ReminderDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() => Navigator.pop(context, _controller.text);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Yeni Hatırlatıcı'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLines: 2,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          hintText: 'Örn: Salı günü malzeme siparişi ver',
        ),
        onSubmitted: (_) => _save(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Vazgeç'),
        ),
        FilledButton(onPressed: _save, child: const Text('Ekle')),
      ],
    );
  }
}
