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

  /// Viewer (rolü henüz belli olmayan/bekleyen) panosu: özel veri **yok**;
  /// yalnızca karşılama, başvuru durumu ve genel içerik (etkinlik + duyuru).
  Widget _buildViewerBody(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final greeting = _timeGreeting(l10n);
    final firstName = _firstName(_viewerName);
    final sections = <Widget>[
      _buildGreetingHeader(
        title: firstName.isEmpty ? '$greeting 👋' : '$greeting, $firstName 👋',
        subtitle: l10n.viewerWelcomeSubtitle,
        icon: Icons.waving_hand,
      ),
      const SizedBox(height: 16),
      _buildRoleRequestStatusCard(context),
    ];

    final eventsSection = _buildViewerEventsSection(context);
    if (eventsSection != null) {
      sections.add(eventsSection);
    }

    final announcementSection = _buildLatestAnnouncementSection(context);
    if (announcementSection != null) {
      sections.add(announcementSection);
    }

    return ListView(padding: const EdgeInsets.all(16), children: sections);
  }

  /// Rol başvurusunun durumunu açıklayan bilgi kartı.
  Widget _buildRoleRequestStatusCard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final IconData icon;
    final Color color;
    final String title;
    final String message;

    if (_requestStatus == 'pending') {
      icon = Icons.hourglass_top;
      color = Colors.orange;
      title = l10n.requestPendingTitle;
      message = l10n.requestPendingMessage(localizedRole(l10n, _requestedRole));
    } else if (_requestStatus == 'approved') {
      icon = Icons.check_circle;
      color = Colors.green;
      title = l10n.requestApprovedTitle;
      message = l10n.requestApprovedMessage;
    } else {
      icon = Icons.info_outline;
      color = AppColors.primary;
      title = l10n.roleNotAssignedTitle;
      message = l10n.roleNotAssignedMessage;
    }

    return SummarySection(
      icon: icon,
      title: title,
      iconColor: color,
      child: _emptyHint(message),
    );
  }

  /// Genel etkinlik listesi (viewer için, salt gösterim). Etkinlik yoksa null.
  Widget? _buildViewerEventsSection(BuildContext context) {
    if (_events.isEmpty) {
      return null;
    }
    final shown = _events.take(4).toList();
    final l10n = AppLocalizations.of(context);

    return SummarySection(
      icon: Icons.event_available,
      title: l10n.navEvents,
      iconColor: Colors.orange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final event in shown)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 8, color: Colors.orange),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      event.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  if (event.dateText.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Text(
                      event.dateText,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  // --- Kişiselleştirilmiş selamlama başlığı ---

  /// Saate göre selamlama: Günaydın / İyi günler / İyi akşamlar.
  String _timeGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return l10n.greetingMorning;
    }
    if (hour >= 12 && hour < 18) {
      return l10n.greetingAfternoon;
    }
    return l10n.greetingEvening;
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.24),
            AppColors.primary.withValues(alpha: 0.06),
          ],
        ),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary,
                child: Icon(icon, color: Colors.white, size: 26),
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
            const SizedBox(height: 14),
            _highlightPill(highlight),
          ],
        ],
      ),
    );
  }

  Widget _highlightPill(({String text, IconData icon, Color color}) data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: data.color.withValues(alpha: 0.35)),
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
  ({String text, IconData icon, Color color})? _childHighlight(
    AppLocalizations l10n,
  ) {
    final overdue = _sumPaymentsFor('Gecikti');
    if (overdue > 0) {
      return (
        text: l10n.highlightOverdueDues(formatTl(overdue)),
        icon: Icons.error_outline,
        color: Colors.red,
      );
    }
    final rate = _childAttendanceRatePercent();
    if (rate != null && rate >= 80) {
      return (
        text: l10n.highlightGreatAttendance,
        icon: Icons.emoji_events,
        color: Colors.green,
      );
    }
    if (rate != null && rate < 50) {
      return (
        text: l10n.highlightWatchAttendance,
        icon: Icons.trending_down,
        color: Colors.orange,
      );
    }
    if (_events.isNotEmpty) {
      return (
        text: l10n.highlightPlannedEvent,
        icon: Icons.event_available,
        color: AppColors.primary,
      );
    }
    return (
      text: l10n.highlightAllGood,
      icon: Icons.check_circle,
      color: Colors.green,
    );
  }

  /// Personel başlığındaki bağlamsal içgörü.
  ({String text, IconData icon, Color color})? _staffHighlight(
    AppLocalizations l10n,
  ) {
    if (_canViewPayments) {
      final unpaid = _payments.where((p) => p.status != 'Ödendi').length;
      if (unpaid > 0) {
        return (
          text: l10n.highlightPaymentsPending(unpaid),
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
          text: l10n.highlightLeavePending(pending),
          icon: Icons.event_busy,
          color: Colors.orange,
        );
      }
    }
    return (
      text: l10n.highlightNoPending,
      icon: Icons.check_circle,
      color: Colors.green,
    );
  }

  Widget _buildStudentGreeting() {
    final l10n = AppLocalizations.of(context);
    final greeting = _timeGreeting(l10n);
    final firstName = _myChildren.isEmpty
        ? null
        : _firstName(_myChildren.first.name);
    return _buildGreetingHeader(
      title: firstName == null ? '$greeting 👋' : '$greeting, $firstName 👋',
      subtitle: l10n.studentGreetingSubtitle,
      icon: Icons.school,
      highlight: _childHighlight(l10n),
    );
  }

  /// Okunmamış duyuru rozeti metni (çan ile aynı kaynak); yoksa null.
  String? _newAnnouncementNote(AppLocalizations l10n) =>
      _unreadAnnouncementCount > 0 ? l10n.noteNew(_unreadAnnouncementCount) : null;

  /// Velinin henüz katılım cevabı vermediği etkinlik sayısı (çocuk bazında).
  int _pendingEventRsvpCount() {
    if (_events.isEmpty || _myChildren.isEmpty) {
      return 0;
    }
    final answered = <String>{
      for (final response in _myEventResponses)
        '${response.eventId}_${response.studentId}',
    };
    var pending = 0;
    for (final event in _events) {
      final needsAnswer = _myChildren.any(
        (child) => !answered.contains('${event.id}_${child.id}'),
      );
      if (needsAnswer) {
        pending++;
      }
    }
    return pending;
  }

  Widget _buildStudentStatTilesRow(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
              label: l10n.statPerformance,
              accent: Colors.green,
              onTap: () => _openPerformanceScreen(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatTile(
              icon: Icons.event_available,
              value: '${_events.length}',
              label: l10n.statEvent,
              accent: Colors.orange,
              onTap: () => _openEventsScreen(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatTile(
              icon: Icons.campaign,
              value: '$visibleAnnouncements',
              label: l10n.statAnnouncement,
              accent: AppColors.primary,
              note: _newAnnouncementNote(l10n),
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
    final l10n = AppLocalizations.of(context);
    final subtitle = _myChildren.length == 1
        ? l10n.parentGreetingSubtitleOne(_myChildren.first.name)
        : l10n.parentGreetingSubtitleMany;
    return _buildGreetingHeader(
      title: '${_timeGreeting(l10n)} 👋',
      subtitle: subtitle,
      icon: Icons.family_restroom,
      highlight: _childHighlight(l10n),
    );
  }

  Widget _buildParentStatTilesRow(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final childCount = _myChildren.length;
    final visibleAnnouncements = _visibleAnnouncements(_announcements).length;
    final pendingRsvp = _pendingEventRsvpCount();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StatTile(
              icon: Icons.query_stats,
              value: '$childCount',
              label: l10n.statMyChild,
              accent: Colors.green,
              onTap: () => _openPerformanceScreen(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatTile(
              icon: Icons.event_available,
              value: '${_events.length}',
              label: l10n.statEvent,
              accent: Colors.orange,
              note: pendingRsvp > 0 ? l10n.noteWaiting(pendingRsvp) : null,
              onTap: () => _openEventsScreen(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatTile(
              icon: Icons.campaign,
              value: '$visibleAnnouncements',
              label: l10n.statAnnouncement,
              accent: AppColors.primary,
              note: _newAnnouncementNote(l10n),
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
    final l10n = AppLocalizations.of(context);
    final label = localizedRole(l10n, _userRole);
    final icon = _isAdmin
        ? Icons.admin_panel_settings
        : _isCoach
        ? Icons.sports
        : Icons.visibility;
    return _buildGreetingHeader(
      title: '${_timeGreeting(l10n)}, $label 👋',
      subtitle: l10n.staffGreetingSubtitle,
      icon: icon,
      highlight: _staffHighlight(l10n),
    );
  }

  Widget _buildStatTilesRow(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
              label: l10n.statStudent,
              accent: Colors.green,
              onTap: () => _openStudentsScreen(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatTile(
              icon: Icons.sports,
              value: '${_coaches.length}',
              label: l10n.statCoach,
              accent: Colors.orange,
              onTap: () => _openCoachesScreen(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatTile(
              icon: Icons.groups,
              value: '${_groups.length}',
              label: l10n.statGroup,
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
    final l10n = AppLocalizations.of(context);

    return SummarySection(
      icon: Icons.check_circle,
      title: l10n.attendanceSummaryTitle,
      iconColor: Colors.green,
      actionLabel: l10n.commonAll,
      onAction: () => _isChildScoped
          ? _openChildAttendanceScreen(context)
          : _openAttendanceScreen(context),
      child: recordCount == 0
          ? _emptyHint(l10n.attendanceEmpty)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SummaryMetricsRow(
                  metrics: [
                    SummaryMetric(
                      value: '$recordCount',
                      label: _isChildScoped
                          ? l10n.metricLessons
                          : l10n.metricRecords,
                      color: AppColors.primary,
                    ),
                    SummaryMetric(
                      value: '$present',
                      label: l10n.metricPresent,
                      color: Colors.green,
                    ),
                    SummaryMetric(
                      value: '$absent',
                      label: l10n.metricAbsent,
                      color: Colors.red,
                    ),
                    SummaryMetric(
                      value: '%$rate',
                      label: l10n.metricAttendanceRate,
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
    final l10n = AppLocalizations.of(context);
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
              count == 1 ? l10n.absenceNoteOne : l10n.absenceNoteMany(count),
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
    final l10n = AppLocalizations.of(context);
    return SummarySection(
      icon: Icons.account_balance_wallet,
      title: l10n.financeSummaryTitle,
      iconColor: AppColors.primary,
      actionLabel: l10n.navPayments,
      onAction: () => _openPaymentsScreen(context),
      child: _payments.isEmpty
          ? _emptyHint(l10n.financeEmpty)
          : _financeContent(context),
    );
  }

  Widget _financeContent(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
              label: l10n.metricCollected,
              color: Colors.green,
            ),
            SummaryMetric(
              value: formatTl(pending),
              label: l10n.metricPending,
              color: Colors.orange,
            ),
            SummaryMetric(
              value: formatTl(overdue),
              label: l10n.metricOverdue,
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
    final l10n = AppLocalizations.of(context);

    return SummarySection(
      icon: Icons.account_balance,
      title: l10n.clubCashTitle,
      iconColor: AppColors.primary,
      actionLabel: l10n.ledgerAction,
      onAction: () => _openClubFinanceScreen(context),
      child: _cashTransactions.isEmpty
          ? _emptyHint(l10n.clubCashEmpty)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SummaryMetricsRow(
                  metrics: [
                    SummaryMetric(
                      value: formatTl(balance),
                      label: l10n.metricBalance,
                      color: balance >= 0 ? Colors.green : Colors.red,
                    ),
                    SummaryMetric(
                      value: formatTl(income),
                      label: l10n.metricIncome,
                      color: Colors.green,
                    ),
                    SummaryMetric(
                      value: formatTl(expense),
                      label: l10n.metricExpense,
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
    final l10n = AppLocalizations.of(context);

    return SummarySection(
      icon: Icons.warning_amber_rounded,
      title: l10n.unpaidDuesTitle(unpaid.length),
      iconColor: Colors.red,
      actionLabel: l10n.commonAll,
      onAction: () => _openPaymentsScreen(context),
      child: Column(
        children: [
          for (final payment in shown) _unpaidRow(l10n, payment),
          if (remaining > 0)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.moreStudents(remaining),
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

  Widget _unpaidRow(AppLocalizations l10n, PaymentRecord payment) {
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
              localizedPaymentStatus(l10n, payment.status),
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
    final l10n = AppLocalizations.of(context);

    return SummarySection(
      icon: Icons.campaign,
      title: l10n.latestAnnouncementTitle,
      iconColor: AppColors.primary,
      actionLabel: l10n.commonAll,
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
