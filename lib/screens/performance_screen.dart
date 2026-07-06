import 'package:flutter/material.dart';

import '../constants/app_roles.dart';
import '../models/app_models.dart';
import '../widgets/empty_state.dart';
import '../widgets/performance_comparison_chart.dart';

/// Performans ekranı.
///
/// Veliler için (canManage = false): çocuklarını seçip antrenörün girdiği
/// performans puanlarını tarihlere göre karşılaştırmalı grafikte görürler.
/// Antrenör/Admin için (canManage = true): bir öğrenciye yeni performans kaydı
/// ekleyebilirler.
class PerformanceScreen extends StatefulWidget {
  final List<Student> students;
  final List<PerformanceRecord> records;
  final bool canManage;
  final Future<void> Function(PerformanceRecord record) onAddRecord;
  final Future<void> Function(String recordId) onDeleteRecord;

  const PerformanceScreen({
    super.key,
    required this.students,
    required this.records,
    required this.canManage,
    required this.onAddRecord,
    required this.onDeleteRecord,
  });

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  String? _selectedStudentId;

  @override
  void initState() {
    super.initState();
    if (widget.students.isNotEmpty) {
      _selectedStudentId = widget.students.first.id;
    }
  }

  List<PerformanceRecord> get _selectedStudentRecords {
    final id = _selectedStudentId;
    if (id == null) {
      return const [];
    }

    final records = widget.records
        .where((record) => record.studentId == id)
        .toList()
      ..sort((a, b) => a.dateText.compareTo(b.dateText));

    return records;
  }

  Future<void> _openAddRecordScreen() async {
    final newRecord = await Navigator.push<PerformanceRecord>(
      context,
      MaterialPageRoute(
        builder: (context) => AddPerformanceRecordScreen(
          students: widget.students,
          initialStudentId: _selectedStudentId,
        ),
      ),
    );

    if (newRecord == null) {
      return;
    }

    try {
      await widget.onAddRecord(newRecord);
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt eklenemedi: $error')),
      );
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _selectedStudentId = newRecord.studentId;
    });
  }

  Future<void> _confirmDeleteRecord(PerformanceRecord record) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Kaydı Sil'),
          content: Text(
            '${record.dateText} tarihli performans kaydını silmek istediğine '
            'emin misin?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Vazgeç'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Sil', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    try {
      await widget.onDeleteRecord(record.id);
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt silinemedi: $error')),
      );
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.canManage ? 'Performans' : 'Performans Analizi'),
      ),
      body: widget.students.isEmpty
          ? EmptyState(
              icon: Icons.query_stats,
              title: 'Öğrenci bulunamadı',
              message: widget.canManage
                  ? 'Performans girmek için önce öğrenci eklenmeli.'
                  : 'Hesabına henüz öğrenci atanmamış. Lütfen spor okulu '
                        'yönetimiyle iletişime geç.',
            )
          : _buildContent(),
      floatingActionButton: widget.canManage
          ? FloatingActionButton.extended(
              onPressed: _openAddRecordScreen,
              icon: const Icon(Icons.add),
              label: const Text('Performans Ekle'),
            )
          : null,
    );
  }

  Widget _buildContent() {
    final records = _selectedStudentRecords;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        DropdownButtonFormField<String>(
          initialValue: _selectedStudentId,
          decoration: const InputDecoration(
            labelText: 'Öğrenci',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
          items: widget.students.map((student) {
            return DropdownMenuItem<String>(
              value: student.id,
              child: Text(student.name),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedStudentId = value;
            });
          },
        ),
        const SizedBox(height: 16),
        if (records.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(
                    Icons.insights,
                    size: 56,
                    color: Colors.indigo.shade200,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Bu öğrenci için henüz performans kaydı yok.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        else ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tarihlere Göre Karşılaştırma',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  PerformanceComparisonChart(records: records),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Kayıtlar',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...records.reversed.map(_buildRecordCard),
        ],
      ],
    );
  }

  Widget _buildRecordCard(PerformanceRecord record) {
    final scoreText = PerformanceMetrics.all
        .map((metric) => '$metric: ${(record.scores[metric] ?? 0).round()}')
        .join('  •  ');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          child: Icon(Icons.event_note),
        ),
        title: Text(record.dateText),
        subtitle: Text(scoreText),
        isThreeLine: true,
        trailing: widget.canManage
            ? IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _confirmDeleteRecord(record),
              )
            : null,
      ),
    );
  }
}

/// Antrenör/Admin'in bir öğrenci için performans puanı girdiği ekran.
class AddPerformanceRecordScreen extends StatefulWidget {
  final List<Student> students;
  final String? initialStudentId;

  const AddPerformanceRecordScreen({
    super.key,
    required this.students,
    this.initialStudentId,
  });

  @override
  State<AddPerformanceRecordScreen> createState() =>
      _AddPerformanceRecordScreenState();
}

class _AddPerformanceRecordScreenState
    extends State<AddPerformanceRecordScreen> {
  String? _studentId;
  DateTime _date = DateTime.now();
  late final Map<String, double> _scores;

  @override
  void initState() {
    super.initState();
    _studentId = widget.initialStudentId ?? widget.students.first.id;
    _scores = {for (final metric in PerformanceMetrics.all) metric: 50};
  }

  String get _dateText {
    final y = _date.year.toString().padLeft(4, '0');
    final m = _date.month.toString().padLeft(2, '0');
    final d = _date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  void _save() {
    final studentId = _studentId;
    if (studentId == null) {
      return;
    }

    final record = PerformanceRecord(
      studentId: studentId,
      dateText: _dateText,
      scores: {
        for (final entry in _scores.entries) entry.key: entry.value.round(),
      },
    );

    Navigator.pop(context, record);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Performans Ekle')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            initialValue: _studentId,
            decoration: const InputDecoration(
              labelText: 'Öğrenci',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            items: widget.students.map((student) {
              return DropdownMenuItem<String>(
                value: student.id,
                child: Text(student.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _studentId = value;
              });
            },
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Tarih'),
              subtitle: Text(_dateText),
              trailing: TextButton(
                onPressed: _pickDate,
                child: const Text('Seç'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Puanlar (0-100)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...PerformanceMetrics.all.map(_buildScoreSlider),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreSlider(String metric) {
    final value = _scores[metric] ?? 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  metric,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  value.round().toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
            Slider(
              value: value,
              min: PerformanceMetrics.minScore.toDouble(),
              max: PerformanceMetrics.maxScore.toDouble(),
              divisions: PerformanceMetrics.maxScore,
              label: value.round().toString(),
              onChanged: (newValue) {
                setState(() {
                  _scores[metric] = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
