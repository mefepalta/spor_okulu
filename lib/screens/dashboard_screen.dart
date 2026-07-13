import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../widgets/wave_background.dart';

import '../constants/app_roles.dart';
import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../routes/app_routes.dart';
import '../services/absence_alert_service.dart';
import '../services/auth_service.dart';
import '../services/ai_summary.dart';
import '../services/firestore_service.dart';
import '../services/parent_service.dart';
import '../services/profile_service.dart';
import '../services/reminders_service.dart';
import '../services/schedule_service.dart';
import '../services/streak_service.dart';
import '../services/user_management_service.dart';
import '../services/user_role_service.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import '../utils/period_l10n.dart';
import '../utils/role_l10n.dart';
import '../utils/status_l10n.dart';
import '../utils/streak.dart';
import '../widgets/summary_section.dart';
import 'announcements_screen.dart';
import 'attendance_screen.dart';
import 'child_attendance_screen.dart';
import 'club_chat_screen.dart';
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
import 'schedule_screen.dart';
import 'social_share_screen.dart';
import 'role_requests_screen.dart';
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
  final ProfileService _profileService = ProfileService();
  final ScheduleService _scheduleService = ScheduleService();
  final StreakService _streakService = StreakService();
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
  final List<ScheduleEntry> _scheduleEntries = [];
  final List<ParentAccount> _studentAccounts = [];
  List<String> _assignedStudentIds = const [];

  String _userRole = AppRoles.viewer;

  /// Sol menü başlığındaki profil kartı için: giriş yapan kullanıcının ad-soyadı
  /// ve base64 avatarı (yoksa boş). Tüm rollerde doldurulur.
  String _myDisplayName = '';
  String _myPhotoBase64 = '';

  /// Viewer (rolü bekleyen/belirsiz) kullanıcının karşılama panosu için: ad,
  /// talep edilen rol ve başvuru durumu. Yalnızca viewer dalında doldurulur.
  String _viewerName = '';
  String _requestedRole = '';
  String _requestStatus = '';

  /// Kullanıcının güncel günlük giriş serisi (0 = seri yok / kaydedilmedi).
  int _currentStreak = 0;

  int _knownAnnouncementCount = 0;
  int _unreadAnnouncementCount = 0;

  /// Velinin bu cihazda henüz görmediği devamsızlık ("Gelmedi") sayısı.
  int _unreadAbsenceCount = 0;

  /// Kullanıcının bu cihazda tuttuğu kişisel hatırlatıcılar.
  final List<Reminder> _reminders = [];
  bool _hasStartedAnnouncementListener = false;
  bool _hasReceivedInitialAnnouncementSnapshot = false;
  bool _isLoading = true;
  Object? _errorMessage;

  bool get _isAdmin => _userRole == AppRoles.admin;
  bool get _isCoach => _userRole == AppRoles.coach;
  bool get _isParent => _userRole == AppRoles.parent;
  bool get _isStudent => _userRole == AppRoles.student;
  bool get _isViewer => _userRole == AppRoles.viewer;

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
    // Viewer (rolü bekleyen) yalnızca "Herkes" hedefli genel duyuruları görür.
    if (_isViewer) {
      return all
          .where(
            (announcement) =>
                announcement.targetAudience == AnnouncementAudience.everyone,
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
      // Viewer artık personel değil: yalnızca genel içerik (duyuru/etkinlik)
      // görür, özel kulüp verisini yüklemez.
      final isStaff = isAdmin || isCoach;

      // Herkesin (veliler dahil) okuyabildiği koleksiyonlar.
      final loadedAnnouncements = await _firestoreService.loadAnnouncements();
      final loadedEvents = await _firestoreService.loadEvents();

      // Sol menü başlığındaki profil kartı için (ad + avatar) — tüm roller.
      final myProfile = await _profileService.loadMyProfile();

      // Günlük giriş serisi (streak): viewer hariç onaylı üyelerde işlenir.
      final streak = isViewer ? 0 : await _streakService.recordVisit();

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
      var loadedSchedule = const <ScheduleEntry>[];
      UserAccount? viewerAccount;

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
        loadedSchedule = await _scheduleService.loadEntries();

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
      } else if (isViewer) {
        // Viewer: yalnızca karşılama panosu için kendi hesabını okur
        // (ad + başvuru durumu). Özel koleksiyon yüklenmez.
        viewerAccount = await _userRoleService.getCurrentUserAccount();
      }

      if (!mounted) {
        return;
      }

      setState(() {
        _userRole = userRole;
        _assignedStudentIds = assignedStudentIds;
        _myDisplayName = myProfile?.displayName ?? '';
        _myPhotoBase64 = myProfile?.photoBase64 ?? '';
        _currentStreak = streak;
        _viewerName = viewerAccount?.displayName ?? '';
        _requestedRole = viewerAccount?.requestedRole ?? '';
        _requestStatus = viewerAccount?.requestStatus ?? '';

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

        _scheduleEntries
          ..clear()
          ..addAll(loadedSchedule);

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
        _errorMessage = error;
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

        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              newCount == 1
                  ? l10n.newAnnouncementPublished
                  : l10n.newAnnouncementsPublished(newCount),
            ),
            action: SnackBarAction(
              label: l10n.viewAction,
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
    final l10n = AppLocalizations.of(context);
    const brand = 'Spor Okulu';
    final title = _isAdmin
        ? brand
        : '$brand - ${localizedRole(l10n, _userRole)}';
    return WaveScaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          // SporTekAi kısayolu (menüde gömülü kalmasın diye). Viewer'da yok —
          // erişim sol menüyle aynı.
          if (!_isViewer)
            IconButton(
              tooltip: 'SporTekAi',
              onPressed: () => _openSporTekAiScreen(context),
              icon: const Icon(Icons.auto_awesome),
            ),
          _buildNotificationsAction(context),
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
      final l10n = AppLocalizations.of(context);
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            l10n.errorLoadingData(_errorMessage!),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_isParent) {
      return _buildParentBody(context);
    }

    if (_isStudent) {
      return _buildStudentBody(context);
    }

    if (_isViewer) {
      return _buildViewerBody(context);
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
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.reminderDialogTitle),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLines: 2,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: l10n.reminderDialogHint,
        ),
        onSubmitted: (_) => _save(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(onPressed: _save, child: Text(l10n.commonAdd)),
      ],
    );
  }
}
