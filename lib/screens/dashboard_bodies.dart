part of 'dashboard_screen.dart';

extension _DashboardBodies on _DashboardScreenState {
  /// Öğrenci panosu: veli düzeninin salt-görüntüleme, ödeme içermeyen sürümü.
  /// Ayrıntılara ☰ menüden erişilir.
  Widget _buildStudentBody(BuildContext context) {
    final sections = <Widget>[
      _buildStudentGreeting(),
      const SizedBox(height: 16),
      _buildStudentStatTilesRow(context),
      const SizedBox(height: 12),
      _buildAttendanceSummarySection(context),
      _buildRemindersSection(context),
    ];

    final announcementSection = _buildLatestAnnouncementSection(context);
    if (announcementSection != null) {
      sections.add(announcementSection);
    }

    return ListView(padding: const EdgeInsets.all(16), children: sections);
  }

  // --- Kişiselleştirilmiş selamlama başlığı ---

  /// Saate göre selamlama: Günaydın / İyi günler / İyi akşamlar.
  String get _timeGreeting {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Günaydın';
    }
    if (hour >= 12 && hour < 18) {
      return 'İyi günler';
    }
    return 'İyi akşamlar';
  }

  String _firstName(String fullName) {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) {
      return trimmed;
    }
    return trimmed.split(RegExp(r'\s+')).first;
  }

  /// Avatar + saat/isim selamlaması + bağlamsal içgörü rozetinden oluşan
  /// kişiselleştirilmiş pano başlığı (tüm roller paylaşır).
  Widget _buildGreetingHeader({
    required String title,
    required String subtitle,
    required IconData icon,
    ({String text, IconData icon, Color color})? highlight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              child: Icon(icon, color: AppColors.primary, size: 26),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (highlight != null) ...[
          const SizedBox(height: 12),
          _highlightPill(highlight),
        ],
      ],
    );
  }

  Widget _highlightPill(({String text, IconData icon, Color color}) data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: data.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(data.icon, color: data.color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              data.text,
              style: TextStyle(color: data.color, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  /// Velinin/öğrencinin çocuk-özel katılım yüzdesi (kayıt yoksa null).
  int? _childAttendanceRatePercent() {
    var present = 0;
    var absent = 0;
    for (final record in _attendanceRecords) {
      for (final child in _myChildren) {
        if (record.presentStudentIds.contains(child.id)) {
          present++;
        } else if (record.absentStudentIds.contains(child.id)) {
          absent++;
        }
      }
    }
    final total = present + absent;
    return total == 0 ? null : (present / total * 100).round();
  }

  /// Veli/öğrenci başlığındaki bağlamsal içgörü (öncelik sırasıyla).
  ({String text, IconData icon, Color color})? _childHighlight() {
    final overdue = _sumPaymentsFor('Gecikti');
    if (overdue > 0) {
      return (
        text: 'Geciken aidat: ${formatTl(overdue)}',
        icon: Icons.error_outline,
        color: Colors.red,
      );
    }
    final rate = _childAttendanceRatePercent();
    if (rate != null && rate >= 80) {
      return (
        text: 'Katılımın çok iyi, böyle devam! 🎯',
        icon: Icons.emoji_events,
        color: Colors.green,
      );
    }
    if (rate != null && rate < 50) {
      return (
        text: 'Katılıma biraz dikkat edelim',
        icon: Icons.trending_down,
        color: Colors.orange,
      );
    }
    if (_events.isNotEmpty) {
      return (
        text: 'Planlı etkinlik var, kaçırma',
        icon: Icons.event_available,
        color: AppColors.primary,
      );
    }
    return (
      text: 'Her şey yolunda görünüyor 👍',
      icon: Icons.check_circle,
      color: Colors.green,
    );
  }

  /// Personel başlığındaki bağlamsal içgörü.
  ({String text, IconData icon, Color color})? _staffHighlight() {
    if (_canViewPayments) {
      final unpaid = _payments.where((p) => p.status != 'Ödendi').length;
      if (unpaid > 0) {
        return (
          text: '$unpaid ödeme takip bekliyor',
          icon: Icons.payments,
          color: Colors.orange,
        );
      }
    }
    if (_canManageAttendance) {
      final pending = _leaveRequests
          .where((r) => r.status == LeaveStatus.pending)
          .length;
      if (pending > 0) {
        return (
          text: '$pending mazeret onay bekliyor',
          icon: Icons.event_busy,
          color: Colors.orange,
        );
      }
    }
    return (
      text: 'Bekleyen bir işin yok, harika 👍',
      icon: Icons.check_circle,
      color: Colors.green,
    );
  }

  Widget _buildStudentGreeting() {
    final firstName = _myChildren.isEmpty
        ? null
        : _firstName(_myChildren.first.name);
    return _buildGreetingHeader(
      title: firstName == null
          ? '$_timeGreeting 👋'
          : '$_timeGreeting, $firstName 👋',
      subtitle: 'Güncel durumun aşağıda.',
      icon: Icons.school,
      highlight: _childHighlight(),
    );
  }

  Widget _buildStudentStatTilesRow(BuildContext context) {
    final performanceCount = _performanceRecords.length;
    final visibleAnnouncements = _visibleAnnouncements(_announcements).length;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StatTile(
              icon: Icons.query_stats,
              value: '$performanceCount',
              label: 'Performans',
              accent: Colors.green,
              onTap: () => _openPerformanceScreen(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatTile(
              icon: Icons.event_available,
              value: '${_events.length}',
              label: 'Etkinlik',
              accent: Colors.orange,
              onTap: () => _openEventsScreen(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatTile(
              icon: Icons.campaign,
              value: '$visibleAnnouncements',
              label: 'Duyuru',
              accent: AppColors.primary,
              onTap: () => _openAnnouncementsScreen(context),
            ),
          ),
        ],
      ),
    );
  }

  /// Veli panosu: gezinme kartları yerine çocuğa dair türetilen özetler.
  /// Ayrıntılara ☰ menüden erişilir (personel panosuyla aynı düzen).
  Widget _buildParentBody(BuildContext context) {
    final sections = <Widget>[
      _buildParentGreeting(),
      const SizedBox(height: 16),
      _buildParentStatTilesRow(context),
      const SizedBox(height: 12),
      _buildAttendanceSummarySection(context),
      _buildFinanceSummarySection(context),
    ];

    final unpaidSection = _buildUnpaidSection(context);
    if (unpaidSection != null) {
      sections.add(unpaidSection);
    }

    sections.add(_buildRemindersSection(context));

    final announcementSection = _buildLatestAnnouncementSection(context);
    if (announcementSection != null) {
      sections.add(announcementSection);
    }

    return ListView(padding: const EdgeInsets.all(16), children: sections);
  }

  Widget _buildParentGreeting() {
    final subtitle = _myChildren.length == 1
        ? '${_myChildren.first.name} • güncel özet'
        : 'Çocuklarınızın güncel özeti aşağıda.';
    return _buildGreetingHeader(
      title: '$_timeGreeting 👋',
      subtitle: subtitle,
      icon: Icons.family_restroom,
      highlight: _childHighlight(),
    );
  }

  Widget _buildParentStatTilesRow(BuildContext context) {
    final childCount = _myChildren.length;
    final visibleAnnouncements = _visibleAnnouncements(_announcements).length;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StatTile(
              icon: Icons.query_stats,
              value: '$childCount',
              label: 'Çocuğum',
              accent: Colors.green,
              onTap: () => _openPerformanceScreen(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatTile(
              icon: Icons.event_available,
              value: '${_events.length}',
              label: 'Etkinlik',
              accent: Colors.orange,
              onTap: () => _openEventsScreen(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatTile(
              icon: Icons.campaign,
              value: '$visibleAnnouncements',
              label: 'Duyuru',
              accent: AppColors.primary,
              onTap: () => _openAnnouncementsScreen(context),
            ),
          ),
        ],
      ),
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

    // Kulüp kasası yalnızca admin'e yüklenir ve gösterilir.
    if (_isAdmin) {
      sections.add(_buildClubCashSummarySection(context));
    }

    sections.add(_buildRemindersSection(context));

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
    final icon = _isAdmin
        ? Icons.admin_panel_settings
        : _isCoach
        ? Icons.sports
        : Icons.visibility;
    return _buildGreetingHeader(
      title: '$_timeGreeting, $label 👋',
      subtitle: 'Kulübünüzün güncel özeti aşağıda.',
      icon: icon,
      highlight: _staffHighlight(),
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
    int recordCount;
    var present = 0;
    var absent = 0;

    if (_isChildScoped) {
      // Çocuğa özel sayım: yalnızca velinin/öğrencinin kendi çocuk(lar)ının o
      // kayıttaki Geldi/Gelmedi durumu sayılır; grubun diğer öğrencileri değil.
      // ChildAttendanceScreen ile aynı semantik (kimlik eşleşmesi üzerinden).
      for (final record in _attendanceRecords) {
        for (final child in _myChildren) {
          if (record.presentStudentIds.contains(child.id)) {
            present++;
          } else if (record.absentStudentIds.contains(child.id)) {
            absent++;
          }
        }
      }
      recordCount = present + absent;
    } else {
      recordCount = _attendanceRecords.length;
      for (final record in _attendanceRecords) {
        present += _presentCountOf(record);
        absent += _absentCountOf(record);
      }
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
      onAction: () => _isChildScoped
          ? _openChildAttendanceScreen(context)
          : _openAttendanceScreen(context),
      child: recordCount == 0
          ? _emptyHint('Henüz yoklama kaydı yok.')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SummaryMetricsRow(
                  metrics: [
                    SummaryMetric(
                      value: '$recordCount',
                      label: _isChildScoped ? 'Ders' : 'Kayıt',
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
                const SizedBox(height: 12),
                SummaryBar(
                  segments: [
                    SummaryBarSegment(value: present, color: Colors.green),
                    SummaryBarSegment(value: absent, color: Colors.red),
                  ],
                ),
                if (_isChildScoped && _unreadAbsenceCount > 0) ...[
                  const SizedBox(height: 12),
                  _absenceAlertNote(context),
                ],
              ],
            ),
    );
  }

  /// Velinin bu cihazda henüz görmediği devamsızlıkları vurgulayan rozet.
  Widget _absenceAlertNote(BuildContext context) {
    final count = _unreadAbsenceCount;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.notification_important, color: Colors.red, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              count == 1
                  ? '1 yeni devamsızlık kaydı'
                  : '$count yeni devamsızlık kaydı',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
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
          : _financeContent(context),
    );
  }

  Widget _financeContent(BuildContext context) {
    final collected = _sumPaymentsFor('Ödendi');
    final pending = _sumPaymentsFor('Bekliyor');
    final overdue = _sumPaymentsFor('Gecikti');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SummaryMetricsRow(
          metrics: [
            SummaryMetric(
              value: formatTl(collected),
              label: 'Tahsil',
              color: Colors.green,
            ),
            SummaryMetric(
              value: formatTl(pending),
              label: 'Bekleyen',
              color: Colors.orange,
            ),
            SummaryMetric(
              value: formatTl(overdue),
              label: 'Geciken',
              color: Colors.red,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SummaryBar(
          segments: [
            SummaryBarSegment(value: collected, color: Colors.green),
            SummaryBarSegment(value: pending, color: Colors.orange),
            SummaryBarSegment(value: overdue, color: Colors.red),
          ],
        ),
      ],
    );
  }

  /// Kulüp kasası özeti (yalnızca admin): güncel kasa + toplam gelir/gider.
  /// Değerler yüklü hareketlerden türetilir.
  Widget _buildClubCashSummarySection(BuildContext context) {
    final income = _cashTransactions
        .where((t) => t.isIncome)
        .fold(0, (sum, t) => sum + t.amount);
    final expense = _cashTransactions
        .where((t) => !t.isIncome)
        .fold(0, (sum, t) => sum + t.amount);
    final balance = income - expense;

    return SummarySection(
      icon: Icons.account_balance,
      title: 'Kulüp Kasası',
      iconColor: AppColors.primary,
      actionLabel: 'Defter',
      onAction: () => _openClubFinanceScreen(context),
      child: _cashTransactions.isEmpty
          ? _emptyHint('Henüz kasa hareketi yok.')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SummaryMetricsRow(
                  metrics: [
                    SummaryMetric(
                      value: formatTl(balance),
                      label: 'Kasa',
                      color: balance >= 0 ? Colors.green : Colors.red,
                    ),
                    SummaryMetric(
                      value: formatTl(income),
                      label: 'Gelir',
                      color: Colors.green,
                    ),
                    SummaryMetric(
                      value: formatTl(expense),
                      label: 'Gider',
                      color: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SummaryBar(
                  segments: [
                    SummaryBarSegment(value: income, color: Colors.green),
                    SummaryBarSegment(value: expense, color: Colors.red),
                  ],
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
              formatTl(payment.amount),
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
}
