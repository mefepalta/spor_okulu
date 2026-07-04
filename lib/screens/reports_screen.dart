import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Raporlar')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Genel Özet',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                title: 'Öğrenciler',
                value: students.length.toString(),
                color: Colors.indigo,
              ),
              _ReportCard(
                icon: Icons.sports,
                title: 'Antrenörler',
                value: coaches.length.toString(),
                color: Colors.deepPurple,
              ),
              _ReportCard(
                icon: Icons.groups,
                title: 'Gruplar',
                value: groups.length.toString(),
                color: Colors.blue,
              ),
              _ReportCard(
                icon: Icons.check_circle,
                title: 'Yoklama',
                value: attendanceRecords.length.toString(),
                color: Colors.green,
              ),
              _ReportCard(
                icon: Icons.payment,
                title: 'Ödemeler',
                value: payments.length.toString(),
                color: Colors.orange,
              ),
              _ReportCard(
                icon: Icons.campaign,
                title: 'Duyurular',
                value: announcements.length.toString(),
                color: Colors.redAccent,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Ödeme Özeti',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: const Text('Ödenmiş ödemeler'),
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
                  title: const Text('Bekleyen ödemeler'),
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
          const Text(
            'Durum Yorumu',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _buildSummaryText(),
                style: const TextStyle(height: 1.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildSummaryText() {
    if (students.isEmpty && groups.isEmpty && payments.isEmpty) {
      return 'Henüz yeterli veri yok. Öğrenci, grup ve ödeme kayıtları eklendikçe burada genel durum özeti görünecek.';
    }

    return 'Sistemde ${students.length} öğrenci, ${coaches.length} antrenör ve ${groups.length} grup bulunuyor. '
        'Toplam ${payments.length} ödeme kaydının $_paidPaymentCount tanesi ödenmiş, $_pendingPaymentCount tanesi bekleyen durumda.';
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
