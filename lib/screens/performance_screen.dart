import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import '../widgets/wave_background.dart';

import '../constants/app_roles.dart';
import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../utils/metric_l10n.dart';
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

    final records =
        widget.records.where((record) => record.studentId == id).toList()
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
        SnackBar(
          content: Text(AppLocalizations.of(context).recordAddError(error)),
        ),
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
    final l10n = AppLocalizations.of(context);
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.recordDeleteTitle),
          content: Text(l10n.performanceDeleteConfirm(record.dateText)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.commonCancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.commonDelete, style: const TextStyle(color: Colors.red)),
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
        SnackBar(content: Text(l10n.recordDeleteError(error))),
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
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(
        title: Text(
          widget.canManage ? l10n.navPerformance : l10n.performanceAnalysisTitle,
        ),
      ),
      body: widget.students.isEmpty
          ? EmptyState(
              icon: Icons.query_stats,
              title: l10n.noStudentFound,
              message: widget.canManage
                  ? l10n.performanceEmptyManage
                  : l10n.performanceEmptyParent,
            )
          : _buildContent(),
      floatingActionButton: widget.canManage
          ? FloatingActionButton.extended(
              onPressed: _openAddRecordScreen,
              icon: const Icon(Icons.add),
              label: Text(l10n.addPerformance),
            )
          : null,
    );
  }

  Widget _buildContent() {
    final l10n = AppLocalizations.of(context);
    final records = _selectedStudentRecords;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        DropdownButtonFormField<String>(
          initialValue: _selectedStudentId,
          decoration: InputDecoration(
            labelText: l10n.roleStudent,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.person),
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
                  Icon(Icons.insights, size: 56, color: AppColors.primary),
                  const SizedBox(height: 12),
                  Text(
                    l10n.noPerformanceForStudent,
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
                  Text(
                    l10n.comparisonByDate,
                    style: const TextStyle(
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
          Text(
            l10n.recordsTitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...records.reversed.map(_buildRecordCard),
        ],
      ],
    );
  }

  Widget _buildRecordCard(PerformanceRecord record) {
    final l10n = AppLocalizations.of(context);
    final scoreText = PerformanceMetrics.all
        .map(
          (metric) =>
              '${localizedMetric(l10n, metric)}: ${(record.scores[metric] ?? 0).round()}',
        )
        .join('  •  ');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.primary,
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
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.addPerformance)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            initialValue: _studentId,
            decoration: InputDecoration(
              labelText: l10n.roleStudent,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.person),
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
              title: Text(l10n.fieldDate),
              subtitle: Text(_dateText),
              trailing: TextButton(
                onPressed: _pickDate,
                child: Text(l10n.selectAction),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.scoresLabel,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...PerformanceMetrics.all.map(_buildScoreSlider),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: Text(l10n.commonSave),
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
                  localizedMetric(AppLocalizations.of(context), metric),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  value.round().toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
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
