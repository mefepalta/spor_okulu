part of 'dashboard_screen.dart';

// setState, State alt sınıfının kendi extension'ında çağrılıyor (aynı kütüphane,
// State üzerinde tanımlı extension). Bu bağlamda protected kullanım güvenli.
// ignore_for_file: invalid_use_of_protected_member

extension _DashboardChrome on _DashboardScreenState {
  // --- Sol menü (Drawer) ---

  /// Sol üstteki ☰ menüsü. Tüm gezinme hedeflerini role göre gruplayarak
  /// listeler; böylece Ana Panel yalnızca öne çıkan kartları taşır.
  Widget _buildDrawer(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _isParent
                  ? _parentDrawerItems(context)
                  : _isStudent
                  ? _studentDrawerItems(context)
                  : _isViewer
                  ? _viewerDrawerItems(context)
                  : _staffDrawerItems(context),
            ),
          ),
          const Divider(height: 1),
          _drawerTile(
            icon: Icons.account_circle,
            label: l10n.profileTitle,
            onTap: () {
              Navigator.pop(context);
              _openProfileScreen(context);
            },
          ),
          _drawerTile(
            icon: Icons.logout,
            label: l10n.logout,
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
    final l10n = AppLocalizations.of(context);
    final roleLabel = localizedRole(l10n, _userRole);
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
          Text(
            l10n.drawerMainPanel,
            style: const TextStyle(
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
      title: Text(label, style: color != null ? TextStyle(color: color) : null),
      onTap: onTap,
    );
  }

  /// Bir gezinme hedefini açar: önce menüyü kapatır, sonra ekranı iter.
  Widget _drawerNav(
    IconData icon,
    String label,
    void Function(BuildContext) open,
  ) {
    return _drawerTile(
      icon: icon,
      label: label,
      onTap: () {
        Navigator.pop(context);
        open(context);
      },
    );
  }

  /// [_drawerNav] gibi ama sağda bir sayı rozeti taşır (0 ise gizli).
  Widget _drawerNavBadge(
    IconData icon,
    String label,
    void Function(BuildContext) open,
    int badge,
  ) {
    return ListTile(
      dense: true,
      leading: Icon(icon),
      title: Text(label),
      trailing: badge > 0
          ? Badge(label: Text('$badge'))
          : null,
      onTap: () {
        Navigator.pop(context);
        open(context);
      },
    );
  }

  /// Yönetici onayı bekleyen rol başvurusu sayısı (yüklü kullanıcılardan).
  int get _pendingRoleRequestCount =>
      _users.where((user) => user.isPendingRequest).length;

  List<Widget> _staffDrawerItems(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [
      _drawerSection(l10n.sectionRecords),
      _drawerNav(Icons.people, l10n.navStudents, _openStudentsScreen),
      _drawerNav(Icons.sports, l10n.navCoaches, _openCoachesScreen),
      _drawerNav(Icons.groups, l10n.navGroups, _openGroupsScreen),
      if (_isAdmin)
        _drawerNav(Icons.family_restroom, l10n.navParents, _openParentsScreen),
      if (_isAdmin)
        _drawerNav(
          Icons.school,
          l10n.navStudentAccounts,
          _openStudentAccountsScreen,
        ),
      _drawerSection(l10n.sectionOperations),
      _drawerNav(Icons.check_circle, l10n.navAttendance, _openAttendanceScreen),
      _drawerNav(Icons.event_busy, l10n.navLeaveRequests, _openLeaveRequestsScreen),
      if (_canViewPayments)
        _drawerNav(Icons.payment, l10n.navPayments, _openPaymentsScreen),
      if (_canManagePerformance)
        _drawerNav(Icons.query_stats, l10n.navPerformance, _openPerformanceScreen),
      if (_canManageEvents)
        _drawerNav(Icons.event_available, l10n.navEvents, _openEventsScreen),
      _drawerNav(Icons.inventory_2, l10n.navEquipment, _openEquipmentScreen),
      _drawerNav(Icons.campaign, l10n.navAnnouncements, _openAnnouncementsScreen),
      if (_isAdmin) ...[
        _drawerSection(l10n.sectionClub),
        _drawerNav(
          Icons.account_balance,
          l10n.navClubCash,
          _openClubFinanceScreen,
        ),
      ],
      _drawerSection(l10n.sectionGeneral),
      _drawerNav(Icons.auto_awesome, 'SporTekAi', _openSporTekAiScreen),
      _drawerNav(Icons.analytics, l10n.navReports, _openReportsScreen),
      _drawerNav(Icons.sports_soccer, l10n.navSports, _openSportsScreen),
      if (_isAdmin)
        _drawerNavBadge(
          Icons.how_to_reg,
          l10n.roleRequestsTitle,
          _openRoleRequestsScreen,
          _pendingRoleRequestCount,
        ),
      if (_isAdmin)
        _drawerNav(Icons.manage_accounts, l10n.navUsers, _openUsersScreen),
    ];
  }

  List<Widget> _parentDrawerItems(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [
      _drawerSection(l10n.sectionMyChild),
      _drawerNav(Icons.query_stats, l10n.navPerformance, _openPerformanceScreen),
      _drawerNav(Icons.check_circle, l10n.navAttendance, _openChildAttendanceScreen),
      _drawerNav(Icons.event_busy, l10n.navReportAbsence, _openLeaveRequestsScreen),
      _drawerNav(Icons.event_available, l10n.navEvents, _openEventsScreen),
      _drawerNav(Icons.payment, l10n.navPayments, _openPaymentsScreen),
      _drawerSection(l10n.sectionGeneral),
      _drawerNav(Icons.auto_awesome, 'SporTekAi', _openSporTekAiScreen),
      _drawerNav(Icons.campaign, l10n.navAnnouncements, _openAnnouncementsScreen),
      _drawerNav(Icons.sports_soccer, l10n.navSports, _openSportsScreen),
    ];
  }

  /// Viewer menüsü: rol henüz atanmadığından yalnızca genel içerik. Özel
  /// koleksiyon ekranları (öğrenci/antrenör/yoklama vb.) yer almaz.
  List<Widget> _viewerDrawerItems(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [
      _drawerSection(l10n.sectionGeneral),
      _drawerNav(Icons.campaign, l10n.navAnnouncements, _openAnnouncementsScreen),
      _drawerNav(Icons.event_available, l10n.navEvents, _openEventsScreen),
      _drawerNav(Icons.sports_soccer, l10n.navSports, _openSportsScreen),
    ];
  }

  /// Öğrenci menüsü: yalnızca kendi verisi ve salt-görüntüleme. Ödeme/mazeret
  /// gibi veli işlemleri yer almaz.
  List<Widget> _studentDrawerItems(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [
      _drawerSection(l10n.sectionMe),
      _drawerNav(Icons.query_stats, l10n.navMyPerformance, _openPerformanceScreen),
      _drawerNav(Icons.check_circle, l10n.navMyAttendance, _openChildAttendanceScreen),
      _drawerNav(Icons.event_available, l10n.navEvents, _openEventsScreen),
      _drawerSection(l10n.sectionGeneral),
      _drawerNav(Icons.auto_awesome, 'SporTekAi', _openSporTekAiScreen),
      _drawerNav(Icons.campaign, l10n.navAnnouncements, _openAnnouncementsScreen),
      _drawerNav(Icons.sports_soccer, l10n.navSports, _openSportsScreen),
    ];
  }

  /// AppBar'ın sağ üstündeki bildirim çanı: okunmamış duyuru sayısını rozetle
  /// gösterir, dokununca bildirim merkezini açar ve rozeti sıfırlar.
  Widget _buildNotificationsAction(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hasUnread = _unreadAnnouncementCount > 0;

    return Badge(
      isLabelVisible: hasUnread,
      offset: const Offset(-6, 6),
      label: Text(
        _unreadAnnouncementCount > 99 ? '99+' : '$_unreadAnnouncementCount',
      ),
      child: IconButton(
        tooltip: l10n.notificationsTooltip,
        onPressed: () {
          _openNotificationsScreen(context);
        },
        icon: Icon(
          hasUnread ? Icons.notifications_active : Icons.notifications_outlined,
        ),
      ),
    );
  }

  /// Çan ikonunun açtığı bildirim merkezi. Bildirimler mevcut veriden
  /// (duyurular, ödenmemiş ödemeler, veli için devamsızlıklar) türetilir;
  /// açılışta duyuru rozeti sıfırlanır.
  void _openNotificationsScreen(BuildContext context) {
    setState(() {
      _unreadAnnouncementCount = 0;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NotificationsScreen(notifications: _buildNotifications()),
      ),
    );
  }

  /// Mevcut veriden bildirim listesi türetir (yeni koleksiyon gerektirmez).
  List<AppNotification> _buildNotifications() {
    final l10n = AppLocalizations.of(context);
    final items = <AppNotification>[];

    for (final announcement in _visibleAnnouncements(_announcements)) {
      items.add(
        AppNotification(
          category: l10n.notifCategoryAnnouncement,
          icon: Icons.campaign,
          color: AppColors.primary,
          title: announcement.title,
          subtitle: announcement.content,
          dateText: announcement.dateText,
          onTap: () => _openAnnouncementsScreen(context),
        ),
      );
    }

    // Ödeme bildirimleri: personel tümünü, veli kendi çocuklarınınkini görür
    // (veli ödemeleri zaten yalnızca kendi çocukları için yüklenir).
    if (_canViewPayments || _isParent) {
      for (final payment in _payments.where(
        (payment) => payment.status != 'Ödendi',
      )) {
        final parts = <String>[
          if (payment.period.isNotEmpty) payment.period,
          if (payment.amount > 0) formatTl(payment.amount),
        ];
        items.add(
          AppNotification(
            category: l10n.notifCategoryPayment,
            icon: Icons.payment,
            color: payment.status == 'Gecikti' ? Colors.red : Colors.orange,
            title:
                '${payment.studentName} • ${localizedPaymentStatus(l10n, payment.status)}',
            subtitle: parts.join(' • '),
            dateText: payment.dateText,
            onTap: () => _openPaymentsScreen(context),
          ),
        );
      }
    }

    // Mazeret bildirimleri: personel bekleyen talepleri, veli ise sonuçlanan
    // (Onaylandı/Reddedildi) taleplerini görür.
    if (_canManageAttendance) {
      for (final request in _leaveRequests.where(
        (request) => request.status == LeaveStatus.pending,
      )) {
        items.add(
          AppNotification(
            category: l10n.notifCategoryLeave,
            icon: Icons.event_busy,
            color: Colors.orange,
            title: l10n.notifLeaveTitle(request.studentName),
            subtitle: request.reason.isNotEmpty
                ? request.reason
                : l10n.leaveWaitingApproval,
            dateText: request.dateText,
            onTap: () => _openLeaveRequestsScreen(context),
          ),
        );
      }
    } else if (_isParent) {
      for (final request in _leaveRequests.where(
        (request) => request.status != LeaveStatus.pending,
      )) {
        items.add(
          AppNotification(
            category: l10n.notifCategoryLeave,
            icon: Icons.event_busy,
            color: request.status == LeaveStatus.approved
                ? Colors.green
                : Colors.red,
            title:
                '${request.studentName} • ${localizedLeaveStatus(l10n, request.status)}',
            subtitle: request.reason,
            dateText: request.dateText,
            onTap: () => _openLeaveRequestsScreen(context),
          ),
        );
      }
    }

    // Devamsızlık bildirimleri (veli/öğrenci): "Gelmedi" olunan kayıtlar.
    if (_isChildScoped) {
      for (final record in _attendanceRecords) {
        for (final child in _myChildren) {
          if (record.absentStudentIds.contains(child.id)) {
            items.add(
              AppNotification(
                category: l10n.notifCategoryAbsence,
                icon: Icons.report_gmailerrorred,
                color: Colors.red,
                title: l10n.notifAbsenceTitle(child.name),
                subtitle: '${record.groupName} • ${record.dateText}',
                dateText: record.dateText,
                onTap: () => _openChildAttendanceScreen(context),
              ),
            );
          }
        }
      }
    }

    return items;
  }
}
