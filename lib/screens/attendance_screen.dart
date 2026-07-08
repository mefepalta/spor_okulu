import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import '../widgets/wave_background.dart';

import '../models/app_models.dart';
import '../utils/validators.dart';
import '../widgets/empty_state.dart';

class AttendanceScreen extends StatefulWidget {
  final List<TrainingGroup> groups;
  final List<Student> students;
  final List<AttendanceRecord> attendanceRecords;
  final bool isAdmin;
  final Future<void> Function(AttendanceRecord record) onAddAttendanceRecord;
  final Future<void> Function(int index) onDeleteAttendanceRecord;
  final Future<void> Function(int index, AttendanceRecord updatedRecord)
  onUpdateAttendanceRecord;

  const AttendanceScreen({
    super.key,
    required this.groups,
    required this.students,
    required this.attendanceRecords,
    required this.isAdmin,
    required this.onAddAttendanceRecord,
    required this.onDeleteAttendanceRecord,
    required this.onUpdateAttendanceRecord,
  });

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  Future<void> _openTakeAttendanceScreen() async {
    final newRecord = await Navigator.push<AttendanceRecord>(
      context,
      MaterialPageRoute(
        builder: (context) => TakeAttendanceScreen(
          groups: widget.groups,
          students: widget.students,
        ),
      ),
    );

    if (newRecord == null) {
      return;
    }

    await widget.onAddAttendanceRecord(newRecord);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _openAttendanceDetailScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendanceDetailScreen(
          attendanceRecords: widget.attendanceRecords,
          index: index,
          groups: widget.groups,
          students: widget.students,
          isAdmin: widget.isAdmin,
          onUpdateAttendanceRecord: widget.onUpdateAttendanceRecord,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmDeleteAttendanceRecord(int index) async {
    final record = widget.attendanceRecords[index];

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yoklamayı Sil'),
          content: Text(
            '${record.groupName} - ${record.dateText} yoklama kaydını silmek istediğine emin misin',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Vazgeç'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Sil', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    await widget.onDeleteAttendanceRecord(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Yoklama kaydı silindi.')));
  }

  @override
  Widget build(BuildContext context) {
    final canTakeAttendance =
        widget.groups.isNotEmpty && widget.students.isNotEmpty;

    return WaveScaffold(
      appBar: AppBar(title: const Text('Yoklama')),
      body: widget.attendanceRecords.isEmpty
          ? EmptyState(
              icon: Icons.check_circle,
              title: 'Henüz yoklama kaydı yok',
              message: widget.isAdmin
                  ? canTakeAttendance
                        ? 'Yeni yoklama kaydı eklemek için sağ alttaki + butonunu kullan.'
                        : 'Yoklama almak için once en az bir grup ve öğrenci ekle.'
                  : 'Henüz yoklama kaydı yok. Admin yoklama eklediçinde burada görünecek.',
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.attendanceRecords.length,
              itemBuilder: (context, index) {
                final record = widget.attendanceRecords[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () {
                      _openAttendanceDetailScreen(index);
                    },
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.check_circle),
                    ),
                    title: Text(record.groupName),
                    subtitle: Text(
                      '${record.dateText}\n'
                      'Geldi: ${record.presentStudentNames.length} • '
                      'Gelmedi: ${record.absentStudentNames.length}',
                    ),
                    isThreeLine: true,
                    trailing: widget.isAdmin
                        ? IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _confirmDeleteAttendanceRecord(index);
                            },
                          )
                        : null,
                  ),
                );
              },
            ),
      floatingActionButton: widget.isAdmin && canTakeAttendance
          ? FloatingActionButton(
              onPressed: _openTakeAttendanceScreen,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class TakeAttendanceScreen extends StatefulWidget {
  final List<TrainingGroup> groups;
  final List<Student> students;
  final AttendanceRecord? record;

  const TakeAttendanceScreen({
    super.key,
    required this.groups,
    required this.students,
    this.record,
  });

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  String? _selectedGroupId;

  /// Öğrenci kimliğine göre katılım durumu (true = geldi).
  final Map<String, bool> _attendanceStatus = {};

  @override
  void initState() {
    super.initState();

    final record = widget.record;

    if (widget.groups.isNotEmpty) {
      _selectedGroupId = widget.groups.first.id;
    }

    if (record != null) {
      // Önce grup id ile, eski kayıtlar için ada göre eşleştir.
      if (record.groupId.isNotEmpty &&
          widget.groups.any((g) => g.id == record.groupId)) {
        _selectedGroupId = record.groupId;
      } else {
        final matchByName = widget.groups
            .where((g) => g.name == record.groupName)
            .toList();
        if (matchByName.isNotEmpty) {
          _selectedGroupId = matchByName.first.id;
        }
      }

      _dateController.text = record.dateText;

      final hasIds =
          record.presentStudentIds.isNotEmpty ||
          record.absentStudentIds.isNotEmpty;

      for (final student in widget.students) {
        _attendanceStatus[student.id] = hasIds
            ? record.presentStudentIds.contains(student.id)
            : record.presentStudentNames.contains(student.name);
      }
    } else {
      final now = DateTime.now();
      final day = now.day.toString().padLeft(2, '0');
      final month = now.month.toString().padLeft(2, '0');
      final year = now.year.toString();

      _dateController.text = '$day.$month.$year';

      for (final student in widget.students) {
        _attendanceStatus[student.id] = true;
      }
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  TrainingGroup? get _selectedGroup {
    for (final group in widget.groups) {
      if (group.id == _selectedGroupId) {
        return group;
      }
    }
    return null;
  }

  /// Seçili grubun kadrosu; kadro tanımlı değilse (eski gruplar) tüm öğrenciler.
  List<Student> _rosterStudents() {
    final group = _selectedGroup;
    if (group == null || group.studentIds.isEmpty) {
      return widget.students;
    }
    return widget.students
        .where((student) => group.studentIds.contains(student.id))
        .toList();
  }

  void _saveAttendanceRecord() {
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    final group = _selectedGroup;
    if (group == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Önce bir grup seçmelisin.')),
      );
      return;
    }

    final presentStudentNames = <String>[];
    final absentStudentNames = <String>[];
    final presentStudentIds = <String>[];
    final absentStudentIds = <String>[];

    for (final student in _rosterStudents()) {
      final isPresent = _attendanceStatus[student.id] ?? false;

      if (isPresent) {
        presentStudentNames.add(student.name);
        presentStudentIds.add(student.id);
      } else {
        absentStudentNames.add(student.name);
        absentStudentIds.add(student.id);
      }
    }

    final record = AttendanceRecord(
      groupId: group.id,
      groupName: group.name,
      dateText: _dateController.text.trim(),
      presentStudentNames: presentStudentNames,
      absentStudentNames: absentStudentNames,
      presentStudentIds: presentStudentIds,
      absentStudentIds: absentStudentIds,
      studentIds: [...presentStudentIds, ...absentStudentIds],
    );

    Navigator.pop(context, record);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.record != null;

    return WaveScaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Yoklamayı Düzenle' : 'Yoklama Al'),
      ),
      body: widget.groups.isEmpty || widget.students.isEmpty
          ? const Center(
              child: Text(
                'Yoklama almak için önce en az bir grup ve öğrenci eklemelisin.',
                textAlign: TextAlign.center,
              ),
            )
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _selectedGroupId,
                    decoration: const InputDecoration(
                      labelText: 'Grup',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.groups),
                    ),
                    items: widget.groups.map((group) {
                      return DropdownMenuItem<String>(
                        value: group.id,
                        child: Text(group.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGroupId = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Grup seçmelisin.';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _dateController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: 'Tarih',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.event),
                      hintText: '24.06.2026',
                    ),
                    validator: validateDateText,
                  ),
                  const SizedBox(height: 20),
                  Builder(
                    builder: (context) {
                      final roster = _rosterStudents();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Öğrenciler (${roster.length})',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (roster.isEmpty)
                            const Card(
                              child: ListTile(
                                leading: Icon(Icons.info_outline),
                                title: Text('Bu grupta öğrenci yok.'),
                                subtitle: Text(
                                  'Grup detayından öğrenci ekleyebilirsin.',
                                ),
                              ),
                            )
                          else
                            ...roster.map((student) {
                              final isPresent =
                                  _attendanceStatus[student.id] ?? false;

                              return Card(
                                child: CheckboxListTile(
                                  value: isPresent,
                                  title: Text(student.name),
                                  subtitle: Text(
                                    '${student.branch} • ${student.age} yaş',
                                  ),
                                  secondary: const Icon(Icons.person),
                                  onChanged: (value) {
                                    setState(() {
                                      _attendanceStatus[student.id] =
                                          value ?? false;
                                    });
                                  },
                                ),
                              );
                            }),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _saveAttendanceRecord,
                    icon: const Icon(Icons.save),
                    label: Text(
                      isEditing ? 'Değişiklikleri Kaydet' : 'Yoklamayı Kaydet',
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class AttendanceDetailScreen extends StatefulWidget {
  final List<AttendanceRecord> attendanceRecords;
  final int index;
  final List<TrainingGroup> groups;
  final List<Student> students;
  final bool isAdmin;
  final Future<void> Function(int index, AttendanceRecord updatedRecord)
  onUpdateAttendanceRecord;

  const AttendanceDetailScreen({
    super.key,
    required this.attendanceRecords,
    required this.index,
    required this.groups,
    required this.students,
    required this.isAdmin,
    required this.onUpdateAttendanceRecord,
  });

  @override
  State<AttendanceDetailScreen> createState() => _AttendanceDetailScreenState();
}

class _AttendanceDetailScreenState extends State<AttendanceDetailScreen> {
  AttendanceRecord get _record => widget.attendanceRecords[widget.index];

  Future<void> _openEditAttendanceScreen() async {
    final updatedRecord = await Navigator.push<AttendanceRecord>(
      context,
      MaterialPageRoute(
        builder: (context) => TakeAttendanceScreen(
          groups: widget.groups,
          students: widget.students,
          record: _record,
        ),
      ),
    );

    if (updatedRecord == null) {
      return;
    }

    await widget.onUpdateAttendanceRecord(widget.index, updatedRecord);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final record = _record;

    return WaveScaffold(
      appBar: AppBar(
        title: const Text('Yoklama Detayı'),
        actions: widget.isAdmin
            ? [
                IconButton(
                  onPressed: _openEditAttendanceScreen,
                  icon: const Icon(Icons.edit),
                ),
              ]
            : null,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 64,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    record.groupName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(record.dateText),
                  const SizedBox(height: 8),
                  Text(
                    'Geldi: ${record.presentStudentNames.length} • '
                    'Gelmedi: ${record.absentStudentNames.length}',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Gelen Öğrenciler',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (record.presentStudentNames.isEmpty)
            const Card(
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text('Gelen öğrenci yok.'),
              ),
            )
          else
            ...record.presentStudentNames.map((studentName) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.check, color: Colors.green),
                  title: Text(studentName),
                ),
              );
            }),
          const SizedBox(height: 16),
          const Text(
            'Gelmeyen Öğrenciler',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (record.absentStudentNames.isEmpty)
            const Card(
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text('Gelmeyen öğrenci yok.'),
              ),
            )
          else
            ...record.absentStudentNames.map((studentName) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.close, color: Colors.red),
                  title: Text(studentName),
                ),
              );
            }),
          const SizedBox(height: 20),
          if (widget.isAdmin)
            ElevatedButton.icon(
              onPressed: _openEditAttendanceScreen,
              icon: const Icon(Icons.edit),
              label: const Text('Yoklamayı Düzenle'),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Yoklama Listesine Dön'),
          ),
        ],
      ),
    );
  }
}
