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

  Widget _buildStudentGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Merhaba 👋',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Güncel durumun aşağıda.',
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
        ),
      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Merhaba 👋',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Çocuğunuzun güncel özeti aşağıda.',
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
        ),
      ],
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
          : SummaryMetricsRow(
              metrics: [
                SummaryMetric(
                  value: formatTl(_sumPaymentsFor('Ödendi')),
                  label: 'Tahsil',
                  color: Colors.green,
                ),
                SummaryMetric(
                  value: formatTl(_sumPaymentsFor('Bekliyor')),
                  label: 'Bekleyen',
                  color: Colors.orange,
                ),
                SummaryMetric(
                  value: formatTl(_sumPaymentsFor('Gecikti')),
                  label: 'Geciken',
                  color: Colors.red,
                ),
              ],
            ),
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
          : SummaryMetricsRow(
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
