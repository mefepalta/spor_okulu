part of 'dashboard_screen.dart';

// setState, State alt sınıfının kendi extension'ında çağrılıyor (aynı kütüphane,
// State üzerinde tanımlı extension). Bu bağlamda protected kullanım güvenli.
// ignore_for_file: invalid_use_of_protected_member

extension _DashboardChrome on _DashboardScreenState {
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
        : _isStudent
        ? 'Öğrenci'
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
            'Ana Panel',
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
    return [
      _drawerSection('Kayıtlar'),
      _drawerNav(Icons.people, 'Öğrenciler', _openStudentsScreen),
      _drawerNav(Icons.sports, 'Antrenörler', _openCoachesScreen),
      _drawerNav(Icons.groups, 'Gruplar', _openGroupsScreen),
      if (_isAdmin)
        _drawerNav(Icons.family_restroom, 'Veliler', _openParentsScreen),
      if (_isAdmin)
        _drawerNav(
          Icons.school,
          'Öğrenci Hesapları',
          _openStudentAccountsScreen,
        ),
      _drawerSection('Operasyon'),
      _drawerNav(Icons.check_circle, 'Yoklama', _openAttendanceScreen),
      _drawerNav(Icons.event_busy, 'Mazeretler', _openLeaveRequestsScreen),
      if (_canViewPayments)
        _drawerNav(Icons.payment, 'Ödemeler', _openPaymentsScreen),
      if (_canManagePerformance)
        _drawerNav(Icons.query_stats, 'Performans', _openPerformanceScreen),
      if (_canManageEvents)
        _drawerNav(Icons.event_available, 'Etkinlikler', _openEventsScreen),
      _drawerNav(Icons.inventory_2, 'Depo', _openEquipmentScreen),
      _drawerNav(Icons.campaign, 'Duyurular', _openAnnouncementsScreen),
      if (_isAdmin) ...[
        _drawerSection('Kulüp'),
        _drawerNav(
          Icons.account_balance,
          'Kulüp Kasası',
          _openClubFinanceScreen,
        ),
      ],
      _drawerSection('Genel'),
      _drawerNav(Icons.auto_awesome, 'SporTekAi', _openSporTekAiScreen),
      _drawerNav(Icons.analytics, 'Raporlar', _openReportsScreen),
      _drawerNav(Icons.sports_soccer, 'Sporlar', _openSportsScreen),
      if (_isAdmin)
        _drawerNavBadge(
          Icons.how_to_reg,
          'Rol Başvuruları',
          _openRoleRequestsScreen,
          _pendingRoleRequestCount,
        ),
      if (_isAdmin)
        _drawerNav(Icons.manage_accounts, 'Kullanıcılar', _openUsersScreen),
    ];
  }

  List<Widget> _parentDrawerItems(BuildContext context) {
    return [
      _drawerSection('Çocuğum'),
      _drawerNav(Icons.query_stats, 'Performans', _openPerformanceScreen),
      _drawerNav(Icons.check_circle, 'Yoklama', _openChildAttendanceScreen),
      _drawerNav(Icons.event_busy, 'Mazeret Bildir', _openLeaveRequestsScreen),
      _drawerNav(Icons.event_available, 'Etkinlikler', _openEventsScreen),
      _drawerNav(Icons.payment, 'Ödemeler', _openPaymentsScreen),
      _drawerSection('Genel'),
      _drawerNav(Icons.auto_awesome, 'SporTekAi', _openSporTekAiScreen),
      _drawerNav(Icons.campaign, 'Duyurular', _openAnnouncementsScreen),
      _drawerNav(Icons.sports_soccer, 'Sporlar', _openSportsScreen),
    ];
  }

  /// Viewer menüsü: rol henüz atanmadığından yalnızca genel içerik. Özel
  /// koleksiyon ekranları (öğrenci/antrenör/yoklama vb.) yer almaz.
  List<Widget> _viewerDrawerItems(BuildContext context) {
    return [
      _drawerSection('Genel'),
      _drawerNav(Icons.campaign, 'Duyurular', _openAnnouncementsScreen),
      _drawerNav(Icons.event_available, 'Etkinlikler', _openEventsScreen),
      _drawerNav(Icons.sports_soccer, 'Sporlar', _openSportsScreen),
    ];
  }

  /// Öğrenci menüsü: yalnızca kendi verisi ve salt-görüntüleme. Ödeme/mazeret
  /// gibi veli işlemleri yer almaz.
  List<Widget> _studentDrawerItems(BuildContext context) {
    return [
      _drawerSection('Ben'),
      _drawerNav(Icons.query_stats, 'Performansım', _openPerformanceScreen),
      _drawerNav(Icons.check_circle, 'Yoklamam', _openChildAttendanceScreen),
      _drawerNav(Icons.event_available, 'Etkinlikler', _openEventsScreen),
      _drawerSection('Genel'),
      _drawerNav(Icons.auto_awesome, 'SporTekAi', _openSporTekAiScreen),
      _drawerNav(Icons.campaign, 'Duyurular', _openAnnouncementsScreen),
      _drawerNav(Icons.sports_soccer, 'Sporlar', _openSportsScreen),
    ];
  }

  /// AppBar'ın sağ üstündeki bildirim çanı: okunmamış duyuru sayısını rozetle
  /// gösterir, dokununca bildirim merkezini açar ve rozeti sıfırlar.
  Widget _buildNotificationsAction(BuildContext context) {
    final hasUnread = _unreadAnnouncementCount > 0;

    return Badge(
      isLabelVisible: hasUnread,
      offset: const Offset(-6, 6),
      label: Text(
        _unreadAnnouncementCount > 99 ? '99+' : '$_unreadAnnouncementCount',
      ),
      child: IconButton(
        tooltip: 'Bildirimler',
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
    final items = <AppNotification>[];

    for (final announcement in _visibleAnnouncements(_announcements)) {
      items.add(
        AppNotification(
          category: 'Duyuru',
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
            category: 'Ödeme',
            icon: Icons.payment,
            color: payment.status == 'Gecikti' ? Colors.red : Colors.orange,
            title: '${payment.studentName} • ${payment.status}',
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
            category: 'Mazeret',
            icon: Icons.event_busy,
            color: Colors.orange,
            title: '${request.studentName} • mazeret',
            subtitle: request.reason.isNotEmpty
                ? request.reason
                : 'Onay bekliyor',
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
            category: 'Mazeret',
            icon: Icons.event_busy,
            color: request.status == LeaveStatus.approved
                ? Colors.green
                : Colors.red,
            title: '${request.studentName} • ${request.status}',
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
                category: 'Devamsızlık',
                icon: Icons.report_gmailerrorred,
                color: Colors.red,
                title: '${child.name} gelmedi',
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
