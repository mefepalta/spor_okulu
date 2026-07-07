import 'package:flutter/material.dart';

import '../widgets/wave_background.dart';

import '../models/app_models.dart';
import '../widgets/empty_state.dart';

/// Velinin, çocuğunun yoklama geçmişini gördüğü salt-okunur ekran.
///
/// Gizlilik için yalnızca velinin kendi çocuğunun o kayıttaki durumu (Geldi /
/// Gelmedi) gösterilir; grubun diğer öğrencileri gösterilmez.
class ChildAttendanceScreen extends StatelessWidget {
  final List<Student> children;
  final List<AttendanceRecord> records;

  const ChildAttendanceScreen({
    super.key,
    required this.children,
    required this.records,
  });

  @override
  Widget build(BuildContext context) {
    // (kayıt, çocuk) çiftlerini düzleştir: her çocuğun her kayıttaki durumu.
    final entries = <_AttendanceEntry>[];
    for (final record in records) {
      for (final child in children) {
        final isPresent = record.presentStudentIds.contains(child.id);
        final isAbsent = record.absentStudentIds.contains(child.id);
        if (isPresent || isAbsent) {
          entries.add(
            _AttendanceEntry(
              record: record,
              childName: child.name,
              present: isPresent,
            ),
          );
        }
      }
    }

    return WaveScaffold(
      appBar: AppBar(title: const Text('Yoklama')),
      body: entries.isEmpty
          ? const EmptyState(
              icon: Icons.check_circle,
              title: 'Yoklama kaydı yok',
              message:
                  'Çocuğunuzun bulunduğu bir yoklama kaydı henüz oluşturulmadı.',
            )
          : Column(
              children: [
                _AttendanceSummaryBar(entries: entries, children: children),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      final present = entry.present;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: present
                                ? Colors.green
                                : Colors.red,
                            foregroundColor: Colors.white,
                            child: Icon(present ? Icons.check : Icons.close),
                          ),
                          title: Text(
                            '${entry.childName} • '
                            '${present ? 'Geldi' : 'Gelmedi'}',
                          ),
                          subtitle: Text(
                            '${entry.record.groupName} • '
                            '${entry.record.dateText}',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

/// Yoklama listesinin üstündeki katılım özeti.
///
/// Düz listede kaybolan "çocuğum kaç derse gelmiş" bilgisini yüzde ve oran
/// olarak verir. Birden fazla çocuk varsa her biri için ayrı satır gösterir.
class _AttendanceSummaryBar extends StatelessWidget {
  final List<_AttendanceEntry> entries;
  final List<Student> children;

  const _AttendanceSummaryBar({required this.entries, required this.children});

  Color _rateColor(int percent) {
    if (percent >= 80) {
      return Colors.green;
    }
    if (percent >= 50) {
      return Colors.orange;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final total = entries.length;
    final present = entries.where((e) => e.present).length;
    final percent = total == 0 ? 0 : (present / total * 100).round();

    final showPerChild = children.length > 1;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: _rateColor(percent).withValues(alpha: 0.15),
                  child: Text(
                    '%$percent',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _rateColor(percent),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Katılım',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$total dersin $present tanesine geldi',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (showPerChild) ...[
              const Divider(height: 24),
              ..._perChildRows(context),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _perChildRows(BuildContext context) {
    final rows = <Widget>[];
    for (final child in children) {
      final childEntries = entries.where((e) => e.childName == child.name);
      final total = childEntries.length;
      if (total == 0) {
        continue;
      }
      final present = childEntries.where((e) => e.present).length;
      final percent = (present / total * 100).round();

      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  child.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              Text(
                '$present/$total',
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '%$percent',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _rateColor(percent),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return rows;
  }
}

class _AttendanceEntry {
  final AttendanceRecord record;
  final String childName;
  final bool present;

  const _AttendanceEntry({
    required this.record,
    required this.childName,
    required this.present,
  });
}
