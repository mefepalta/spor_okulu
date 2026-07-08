part of 'dashboard_screen.dart';

// setState, State alt sınıfının kendi extension'ında çağrılıyor (aynı kütüphane,
// State üzerinde tanımlı extension). Bu bağlamda protected kullanım güvenli.
// ignore_for_file: invalid_use_of_protected_member

extension _DashboardHandlers on _DashboardScreenState {
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
          students: _isChildScoped ? _myChildren : _students,
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

  // --- Hızlı hatırlatıcılar (cihazda, kişisel) ---

  Future<void> _loadReminders() async {
    final uid = _authService.currentUser?.uid;
    if (uid == null) {
      return;
    }
    final loaded = await _remindersService.load(uid);
    if (!mounted) {
      return;
    }
    setState(() {
      _reminders
        ..clear()
        ..addAll(loaded);
    });
  }

  Future<void> _addReminder() async {
    final uid = _authService.currentUser?.uid;
    if (uid == null) {
      return;
    }

    final text = await showDialog<String>(
      context: context,
      builder: (context) => const _ReminderDialog(),
    );
    if (text == null || text.trim().isEmpty) {
      return;
    }

    final reminder = Reminder(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: text.trim(),
    );
    final updated = await _remindersService.add(uid, reminder);
    if (!mounted) {
      return;
    }
    setState(() {
      _reminders
        ..clear()
        ..addAll(updated);
    });
  }

  Future<void> _deleteReminder(String id) async {
    final uid = _authService.currentUser?.uid;
    if (uid == null) {
      return;
    }
    final updated = await _remindersService.remove(uid, id);
    if (!mounted) {
      return;
    }
    setState(() {
      _reminders
        ..clear()
        ..addAll(updated);
    });
  }

  Widget _buildRemindersSection(BuildContext context) {
    return SummarySection(
      icon: Icons.checklist,
      title: 'Hızlı Hatırlatıcılar',
      iconColor: AppColors.primary,
      actionLabel: 'Ekle',
      onAction: _addReminder,
      child: _reminders.isEmpty
          ? _emptyHint('Henüz bir hatırlatıcı eklemediniz.')
          : Column(
              children: [
                for (final reminder in _reminders)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2, right: 10),
                          child: Icon(Icons.radio_button_unchecked, size: 18),
                        ),
                        Expanded(child: Text(reminder.text)),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          tooltip: 'Sil',
                          onPressed: () => _deleteReminder(reminder.id),
                          icon: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }

  // --- Mazeret / izin ---

  Future<LeaveRequest> _addLeaveRequest(LeaveRequest request) async {
    final saved = await _firestoreService.addLeaveRequest(request);
    setState(() {
      _leaveRequests.insert(0, saved);
    });
    return saved;
  }

  Future<void> _updateLeaveStatus(String id, String status) async {
    await _firestoreService.updateLeaveRequestStatus(id, status);
    final index = _leaveRequests.indexWhere((r) => r.id == id);
    if (index != -1) {
      setState(() {
        _leaveRequests[index] = _leaveRequests[index].copyWith(status: status);
      });
    }
  }

  Future<void> _deleteLeaveRequest(String id) async {
    await _firestoreService.deleteLeaveRequest(id);
    setState(() {
      _leaveRequests.removeWhere((r) => r.id == id);
    });
  }

  void _openLeaveRequestsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LeaveRequestsScreen(
          requests: _leaveRequests,
          children: _isParent ? _myChildren : const [],
          isParent: _isParent,
          canManage: _canManageAttendance,
          currentUserUid: _authService.currentUser?.uid ?? '',
          onAdd: _addLeaveRequest,
          onUpdateStatus: _updateLeaveStatus,
          onDelete: _deleteLeaveRequest,
        ),
      ),
    );
  }

  // --- Kulüp kasası ---

  Future<CashTransaction> _addCashTransaction(
    CashTransaction transaction,
  ) async {
    final saved = await _firestoreService.addCashTransaction(transaction);
    setState(() => _cashTransactions.insert(0, saved));
    return saved;
  }

  Future<void> _deleteCashTransaction(String id) async {
    await _firestoreService.deleteCashTransaction(id);
    setState(() {
      _cashTransactions.removeWhere((t) => t.id == id);
    });
  }

  void _openClubFinanceScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClubFinanceScreen(
          transactions: _cashTransactions,
          onAdd: _addCashTransaction,
          onDelete: _deleteCashTransaction,
        ),
      ),
    );
  }

  // --- Depo / ekipman ---

  Future<EquipmentItem> _addEquipment(EquipmentItem item) async {
    final saved = await _firestoreService.addEquipment(item);
    setState(() => _equipment.insert(0, saved));
    return saved;
  }

  Future<void> _updateEquipment(EquipmentItem item) async {
    await _firestoreService.updateEquipment(item);
    setState(() {
      final index = _equipment.indexWhere((i) => i.id == item.id);
      if (index != -1) {
        _equipment[index] = item;
      }
    });
  }

  Future<void> _deleteEquipment(String id) async {
    await _firestoreService.deleteEquipment(id);
    setState(() {
      _equipment.removeWhere((i) => i.id == id);
    });
  }

  void _openEquipmentScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EquipmentScreen(
          items: _equipment,
          canManage: _isAdmin || _isCoach,
          onAdd: _addEquipment,
          onUpdate: _updateEquipment,
          onDelete: _deleteEquipment,
        ),
      ),
    );
  }

  // --- SporTekAi ---

  void _openSporTekAiScreen(BuildContext context) {
    final pendingLeaves = _leaveRequests
        .where((r) => r.status == LeaveStatus.pending)
        .length;

    final String summary;
    final List<String> suggestions;
    final String introSubtitle;
    if (_isParent) {
      summary = AiSummary.buildParentSummary(
        childCount: _myChildren.length,
        attendance: _attendanceRecords,
        payments: _payments,
        performance: _performanceRecords,
        eventCount: _events.length,
        pendingLeaveCount: pendingLeaves,
      );
      suggestions = kParentAiSuggestions;
      introSubtitle =
          'Çocuğunuzun güncel özetini biliyorum. Aşağıdakilerden birini '
          'seçebilir ya da kendi sorunuzu yazabilirsiniz.';
    } else if (_isStudent) {
      summary = AiSummary.buildStudentSummary(
        attendance: _attendanceRecords,
        performance: _performanceRecords,
        eventCount: _events.length,
      );
      suggestions = kStudentAiSuggestions;
      introSubtitle =
          'Güncel durumunu biliyorum. Aşağıdakilerden birini seçebilir '
          'ya da kendi sorunu yazabilirsin.';
    } else {
      summary = AiSummary.buildStaffSummary(
        isAdmin: _isAdmin,
        studentCount: _students.length,
        coachCount: _coaches.length,
        groupCount: _groups.length,
        attendance: _attendanceRecords,
        payments: _payments,
        cash: _cashTransactions,
        equipment: _equipment,
        pendingLeaveCount: pendingLeaves,
      );
      suggestions = kStaffAiSuggestions;
      introSubtitle =
          'Kulübünüzün güncel özetini biliyorum. Aşağıdakilerden birini '
          'seçebilir ya da kendi sorunu yazabilirsin.';
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SporTekAiScreen(
          summary: summary,
          suggestions: suggestions,
          introSubtitle: introSubtitle,
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

  // --- Öğrenci hesapları ---

  Future<void> _reloadStudentAccounts() async {
    final accounts = await _parentService.loadStudentAccounts();

    if (!mounted) {
      return;
    }

    setState(() {
      _studentAccounts
        ..clear()
        ..addAll(accounts);
    });
  }

  Future<void> _addStudentAccount(String email) async {
    await _parentService.promoteToStudentByEmail(email);
    await _reloadStudentAccounts();
  }

  Future<void> _assignStudentToAccount(
    String uid,
    List<String> studentIds,
  ) async {
    await _parentService.setAssignedStudents(uid, studentIds);
    await _reloadStudentAccounts();
  }

  Future<void> _removeStudentAccount(String uid) async {
    // Veliyle aynı sadeleştirme: rolü görüntüleyiciye indirir, eşleşmeyi siler.
    await _parentService.removeParent(uid);
    await _reloadStudentAccounts();
  }

  void _openStudentAccountsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentAccountsScreen(
          accounts: _studentAccounts,
          students: _students,
          onAddAccount: _addStudentAccount,
          onAssignStudent: _assignStudentToAccount,
          onRemoveAccount: _removeStudentAccount,
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

  Future<void> _approveRoleRequest(String uid, String requestedRole) async {
    await _userManagementService.approveRequest(uid, requestedRole);
    await _reloadUsersAndParents();
  }

  Future<void> _rejectRoleRequest(String uid) async {
    await _userManagementService.rejectRequest(uid);
    await _reloadUsersAndParents();
  }

  void _openRoleRequestsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoleRequestsScreen(
          users: _users,
          onApprove: _approveRoleRequest,
          onReject: _rejectRoleRequest,
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
    if (!_isChildScoped) {
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
          children: _isChildScoped ? _myChildren : const [],
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
}
