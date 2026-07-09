import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import '../widgets/wave_background.dart';

import '../l10n/app_localizations.dart';
import '../models/app_models.dart';

class ReportsScreen extends StatelessWidget {
  final List<Student> students;
  final List<Coach> coaches;
  final List<TrainingGroup> groups;
  final List<AttendanceRecord> attendanceRecords;
  final List<PaymentRecord> payments;
  final List<Announcement> announcements;

  const ReportsScreen({
    super.key,
    required this.students,
    required this.coaches,
    required this.groups,
    required this.attendanceRecords,
    required this.payments,
    required this.announcements,
  });

  int get _paidPaymentCount {
    return payments.where((payment) {
      final status = payment.status.toLowerCase();

      return status.contains('ödendi') ||
          status.contains('odendi') ||
          status.contains('paid');
    }).length;
  }

  int get _pendingPaymentCount {
    return payments.length - _paidPaymentCount;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.navReports)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.generalSummary,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.25,
            children: [
              _ReportCard(
                icon: Icons.people,
                title: l10n.navStudents,
                value: students.length.toString(),
                color: AppColors.primary,
              ),
              _ReportCard(
                icon: Icons.sports,
                title: l10n.navCoaches,
                value: coaches.length.toString(),
                color: Colors.deepPurple,
              ),
              _ReportCard(
                icon: Icons.groups,
                title: l10n.navGroups,
                value: groups.length.toString(),
                color: Colors.blue,
              ),
              _ReportCard(
                icon: Icons.check_circle,
                title: l10n.navAttendance,
                value: attendanceRecords.length.toString(),
                color: Colors.green,
              ),
              _ReportCard(
                icon: Icons.payment,
                title: l10n.navPayments,
                value: payments.length.toString(),
                color: Colors.orange,
              ),
              _ReportCard(
                icon: Icons.campaign,
                title: l10n.navAnnouncements,
                value: announcements.length.toString(),
                color: Colors.redAccent,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            l10n.paymentSummary,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(l10n.paidPayments),
                  trailing: Text(
                    _paidPaymentCount.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(
                    Icons.pending_actions,
                    color: Colors.orange,
                  ),
                  title: Text(l10n.pendingPayments),
                  trailing: Text(
                    _pendingPaymentCount.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.statusComment,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _buildSummaryText(l10n),
                style: const TextStyle(height: 1.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildSummaryText(AppLocalizations l10n) {
    if (students.isEmpty && groups.isEmpty && payments.isEmpty) {
      return l10n.reportsNoData;
    }

    return l10n.reportsSummary(
      students.length,
      coaches.length,
      groups.length,
      payments.length,
      _paidPaymentCount,
      _pendingPaymentCount,
    );
  }
}

class _ReportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _ReportCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 34),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
