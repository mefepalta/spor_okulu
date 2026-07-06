import 'package:flutter/material.dart';

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

    return Scaffold(
      appBar: AppBar(title: const Text('Yoklama')),
      body: entries.isEmpty
          ? const EmptyState(
              icon: Icons.check_circle,
              title: 'Yoklama kaydı yok',
              message:
                  'Çocuğunuzun bulunduğu bir yoklama kaydı henüz oluşturulmadı.',
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                final present = entry.present;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: present ? Colors.green : Colors.red,
                      foregroundColor: Colors.white,
                      child: Icon(present ? Icons.check : Icons.close),
                    ),
                    title: Text(
                      '${entry.childName} • ${present ? 'Geldi' : 'Gelmedi'}',
                    ),
                    subtitle: Text(
                      '${entry.record.groupName} • ${entry.record.dateText}',
                    ),
                  ),
                );
              },
            ),
    );
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
