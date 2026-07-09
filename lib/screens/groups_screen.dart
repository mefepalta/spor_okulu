import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import '../widgets/wave_background.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../utils/day_l10n.dart';
import '../utils/validators.dart';
import '../widgets/branch_dropdown.dart';
import '../widgets/empty_state.dart';

class GroupsScreen extends StatefulWidget {
  final List<TrainingGroup> groups;
  final List<Coach> coaches;
  final List<Student> students;

  /// Ekleme/düzenleme yetkisi (admin veya antrenör).
  final bool canManage;

  /// Silme yetkisi (yalnızca admin).
  final bool canDelete;
  final Future<void> Function(TrainingGroup group) onAddGroup;
  final Future<void> Function(int index) onDeleteGroup;
  final Future<void> Function(int index, TrainingGroup updatedGroup)
  onUpdateGroup;

  const GroupsScreen({
    super.key,
    required this.groups,
    required this.coaches,
    required this.students,
    required this.canManage,
    required this.canDelete,
    required this.onAddGroup,
    required this.onDeleteGroup,
    required this.onUpdateGroup,
  });

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  String _searchQuery = '';

  Future<void> _openAddGroupScreen() async {
    final newGroup = await Navigator.push<TrainingGroup>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddGroupScreen(coaches: widget.coaches, students: widget.students),
      ),
    );

    if (newGroup == null) {
      return;
    }

    await widget.onAddGroup(newGroup);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _openGroupDetailScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupDetailScreen(
          groups: widget.groups,
          coaches: widget.coaches,
          students: widget.students,
          index: index,
          canManage: widget.canManage,
          onUpdateGroup: widget.onUpdateGroup,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmDeleteGroup(int index) async {
    final group = widget.groups[index];
    final l10n = AppLocalizations.of(context);

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context);
        return AlertDialog(
          title: Text(l10n.groupDeleteTitle),
          content: Text(l10n.groupDeleteConfirm(group.name)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(l10n.commonCancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                l10n.commonDelete,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    await widget.onDeleteGroup(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.groupDeleted)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filteredGroups = widget.groups.where((group) {
      final query = _searchQuery.toLowerCase();

      return group.name.toLowerCase().contains(query) ||
          group.branch.toLowerCase().contains(query) ||
          group.coachName.toLowerCase().contains(query);
    }).toList();
    final canAddGroup = widget.canManage && widget.coaches.isNotEmpty;

    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.navGroups)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                labelText: l10n.groupsSearchHint,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: widget.groups.isEmpty
                ? EmptyState(
                    icon: Icons.groups,
                    title: l10n.groupsEmptyTitle,
                    message: widget.canManage
                        ? widget.coaches.isNotEmpty
                              ? l10n.groupsEmptyAdd
                              : l10n.groupsEmptyNoCoach
                        : l10n.groupsEmptyViewer,
                  )
                : filteredGroups.isEmpty
                ? EmptyState(
                    icon: Icons.search_off,
                    title: l10n.searchNoResults,
                    message: l10n.searchNoResultsBody,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredGroups.length,
                    itemBuilder: (context, index) {
                      final group = filteredGroups[index];
                      final originalIndex = widget.groups.indexOf(group);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          onTap: () {
                            _openGroupDetailScreen(originalIndex);
                          },
                          leading: const CircleAvatar(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            child: Icon(Icons.groups),
                          ),
                          title: Text(group.name),
                          subtitle: Text(
                            l10n.groupSubtitle(
                              group.branch,
                              localizedSchedule(l10n, group.schedule),
                              group.coachName,
                              group.studentIds.length,
                              group.capacity,
                            ),
                          ),
                          isThreeLine: true,
                          trailing: widget.canDelete
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _confirmDeleteGroup(originalIndex);
                                  },
                                )
                              : null,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: canAddGroup
          ? FloatingActionButton(
              onPressed: _openAddGroupScreen,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class GroupDetailScreen extends StatefulWidget {
  final List<TrainingGroup> groups;
  final List<Coach> coaches;
  final List<Student> students;
  final int index;
  final bool canManage;
  final Future<void> Function(int index, TrainingGroup updatedGroup)
  onUpdateGroup;

  const GroupDetailScreen({
    super.key,
    required this.groups,
    required this.coaches,
    required this.students,
    required this.index,
    required this.canManage,
    required this.onUpdateGroup,
  });

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  TrainingGroup get _group => widget.groups[widget.index];

  String _memberName(String studentId) {
    for (final student in widget.students) {
      if (student.id == studentId) {
        return '${student.name} • ${student.branch}';
      }
    }
    return AppLocalizations.of(context).unknownStudent;
  }

  Future<void> _openEditGroupScreen() async {
    final updatedGroup = await Navigator.push<TrainingGroup>(
      context,
      MaterialPageRoute(
        builder: (context) => AddGroupScreen(
          coaches: widget.coaches,
          students: widget.students,
          group: _group,
        ),
      ),
    );

    if (updatedGroup == null) {
      return;
    }

    await widget.onUpdateGroup(widget.index, updatedGroup);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final group = _group;
    final l10n = AppLocalizations.of(context);

    return WaveScaffold(
      appBar: AppBar(
        title: Text(l10n.groupDetailTitle),
        actions: widget.canManage
            ? [
                IconButton(
                  onPressed: _openEditGroupScreen,
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
                  const Icon(Icons.groups, size: 64, color: AppColors.primary),
                  const SizedBox(height: 16),
                  Text(
                    group.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(group.branch),
                  const SizedBox(height: 8),
                  Text(localizedSchedule(l10n, group.schedule)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.badge),
              title: Text(l10n.fieldGroupName),
              subtitle: Text(group.name),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.sports),
              title: Text(l10n.fieldBranch),
              subtitle: Text(group.branch),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(l10n.roleCoach),
              subtitle: Text(group.coachName),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.schedule),
              title: Text(l10n.fieldSchedule),
              subtitle: Text(localizedSchedule(l10n, group.schedule)),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.people),
              title: Text(l10n.fieldCapacity),
              subtitle: Text(
                l10n.capacityPeople(group.studentIds.length, group.capacity),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.groups_2, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Text(
                        l10n.membersTitle(group.studentIds.length),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (group.studentIds.isEmpty)
                    Text(
                      l10n.noMembersAssigned,
                      style: const TextStyle(color: Colors.grey),
                    )
                  else
                    ...group.studentIds.map((studentId) {
                      final name = _memberName(studentId);
                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.person, size: 20),
                        title: Text(name),
                      );
                    }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (widget.canManage)
            ElevatedButton.icon(
              onPressed: _openEditGroupScreen,
              icon: const Icon(Icons.edit),
              label: Text(l10n.editGroup),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: Text(l10n.backToGroupList),
          ),
        ],
      ),
    );
  }
}

class AddGroupScreen extends StatefulWidget {
  final List<Coach> coaches;
  final List<Student> students;
  final TrainingGroup? group;

  const AddGroupScreen({
    super.key,
    required this.coaches,
    required this.students,
    this.group,
  });

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();

  String? _selectedBranch;

  final List<String> _days = const [
    'Pazartesi',
    'Sali',
    'Carsamba',
    'Persembe',
    'Cuma',
    'Cumartesi',
    'Pazar',
  ];

  String? _selectedCoachId;
  String? _selectedDay;
  final Set<String> _selectedStudentIds = {};

  @override
  void initState() {
    super.initState();

    _selectedDay = _days.first;

    if (widget.coaches.isNotEmpty) {
      _selectedCoachId = widget.coaches.first.id;
    }

    final group = widget.group;

    if (group != null) {
      _nameController.text = group.name;
      _selectedBranch = group.branch;
      _capacityController.text = group.capacity.toString();
      _selectedStudentIds.addAll(group.studentIds);

      final scheduleParts = group.schedule.trim().split(' ');

      if (scheduleParts.isNotEmpty) {
        _selectedDay = dropdownDayFromText(scheduleParts.first);
      }

      if (scheduleParts.length >= 2) {
        _timeController.text = scheduleParts[1];
      }

      // Önce id ile, eski kayıtlar için ada göre eşleştir.
      final coachById = widget.coaches.any(
        (coach) => coach.id == group.coachId,
      );
      if (group.coachId.isNotEmpty && coachById) {
        _selectedCoachId = group.coachId;
      } else {
        final matchByName = widget.coaches
            .where((coach) => coach.name == group.coachName)
            .toList();
        if (matchByName.isNotEmpty) {
          _selectedCoachId = matchByName.first.id;
        }
      }
    }
  }

  Coach? get _selectedCoach {
    for (final coach in widget.coaches) {
      if (coach.id == _selectedCoachId) {
        return coach;
      }
    }
    return null;
  }

  Future<void> _openMemberSelection() async {
    final capacity = int.tryParse(_capacityController.text.trim());

    final selected = await Navigator.push<Set<String>>(
      context,
      MaterialPageRoute(
        builder: (context) => _SelectMembersScreen(
          students: widget.students,
          initialSelected: _selectedStudentIds,
          capacity: capacity,
        ),
      ),
    );

    if (selected == null) {
      return;
    }

    setState(() {
      _selectedStudentIds
        ..clear()
        ..addAll(selected);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  void _saveGroup() {
    final l10n = AppLocalizations.of(context);
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    final coach = _selectedCoach;
    if (coach == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.selectCoachFirst)),
      );
      return;
    }

    final capacity = int.parse(_capacityController.text.trim());
    if (_selectedStudentIds.length > capacity) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.studentsExceedCapacity(_selectedStudentIds.length, capacity),
          ),
        ),
      );
      return;
    }

    final normalizedTime = normalizeTime(_timeController.text.trim());

    final group = TrainingGroup(
      name: _nameController.text.trim(),
      branch: (_selectedBranch ?? '').trim(),
      coachId: coach.id,
      coachName: coach.name,
      schedule: '$_selectedDay $normalizedTime',
      capacity: capacity,
      studentIds: _selectedStudentIds.toList(),
    );

    Navigator.pop(context, group);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.group != null;
    final l10n = AppLocalizations.of(context);

    return WaveScaffold(
      appBar: AppBar(
        title: Text(isEditing ? l10n.editGroup : l10n.addGroup),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: widget.coaches.isEmpty
            ? Center(
                child: Text(
                  l10n.groupsNeedCoach,
                  textAlign: TextAlign.center,
                ),
              )
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: l10n.fieldGroupName,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.badge),
                        hintText: 'Minikler A',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.groupNameEmpty;
                        }

                        if (value.trim().length < 2) {
                          return l10n.groupNameMinLength;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    BranchDropdownFormField(
                      value: _selectedBranch,
                      onChanged: (value) {
                        setState(() {
                          _selectedBranch = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCoachId,
                      decoration: InputDecoration(
                        labelText: l10n.roleCoach,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      items: widget.coaches.map((coach) {
                        return DropdownMenuItem<String>(
                          value: coach.id,
                          child: Text('${coach.name} - ${coach.branch}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCoachId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.coachRequired;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedDay,
                      decoration: InputDecoration(
                        labelText: l10n.fieldDay,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.calendar_month),
                      ),
                      items: _days.map((day) {
                        return DropdownMenuItem<String>(
                          value: day,
                          child: Text(localizedDay(l10n, day)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDay = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.dayRequired;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _timeController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: l10n.fieldTime,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.schedule),
                        hintText: '18:00',
                      ),
                      validator: timeValidator(l10n),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _capacityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: l10n.fieldCapacity,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.people),
                        hintText: '20',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.capacityEmpty;
                        }

                        final capacity = int.tryParse(value.trim());

                        if (capacity == null) {
                          return l10n.capacityMustBeNumber;
                        }

                        if (capacity <= 0) {
                          return l10n.capacityPositive;
                        }

                        if (capacity > 100) {
                          return l10n.capacityMax;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(color: Colors.grey.shade400),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.groups_2),
                        title: Text(l10n.membersLabel),
                        subtitle: Text(
                          _selectedStudentIds.isEmpty
                              ? l10n.noStudentSelected
                              : l10n.studentsSelected(
                                  _selectedStudentIds.length,
                                ),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: widget.students.isEmpty
                            ? null
                            : _openMemberSelection,
                      ),
                    ),
                    if (widget.students.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          l10n.membersNeedStudents,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _saveGroup,
                      icon: const Icon(Icons.save),
                      label: Text(isEditing ? l10n.saveChanges : l10n.saveGroup),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

/// Gruba öğrenci (üye) seçme ekranı — çoklu seçim, aramalı, kapasite duyarlı.
class _SelectMembersScreen extends StatefulWidget {
  final List<Student> students;
  final Set<String> initialSelected;
  final int? capacity;

  const _SelectMembersScreen({
    required this.students,
    required this.initialSelected,
    required this.capacity,
  });

  @override
  State<_SelectMembersScreen> createState() => _SelectMembersScreenState();
}

class _SelectMembersScreenState extends State<_SelectMembersScreen> {
  late final Set<String> _selected;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selected = {...widget.initialSelected};
  }

  bool get _overCapacity =>
      widget.capacity != null && _selected.length > widget.capacity!;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final query = _searchQuery.toLowerCase();
    final filtered = widget.students.where((student) {
      return student.name.toLowerCase().contains(query) ||
          student.branch.toLowerCase().contains(query);
    }).toList();

    final capacityText = widget.capacity == null
        ? l10n.selectedCount(_selected.length)
        : l10n.selectedCountOf(_selected.length, widget.capacity!);

    return WaveScaffold(
      appBar: AppBar(
        title: Text(l10n.selectMembersTitle),
        actions: [
          TextButton(
            onPressed: _overCapacity
                ? null
                : () => Navigator.pop(context, _selected),
            child: Text(
              l10n.commonSave,
              style: TextStyle(
                color: _overCapacity ? Colors.white54 : Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                labelText: l10n.studentsSearchHint,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  _overCapacity ? Icons.error_outline : Icons.people,
                  color: _overCapacity ? Colors.red : AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  capacityText,
                  style: TextStyle(
                    color: _overCapacity ? Colors.red : null,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (_overCapacity) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.capacityExceeded,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: widget.students.isEmpty
                ? EmptyState(
                    icon: Icons.people_outline,
                    title: l10n.noStudentsTitle,
                    message: l10n.noStudentsBody,
                  )
                : ListView(
                    children: filtered.map((student) {
                      return CheckboxListTile(
                        value: _selected.contains(student.id),
                        title: Text(student.name),
                        subtitle: Text(
                          l10n.studentBranchAge(student.branch, student.age),
                        ),
                        onChanged: (checked) {
                          setState(() {
                            if (checked == true) {
                              _selected.add(student.id);
                            } else {
                              _selected.remove(student.id);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
