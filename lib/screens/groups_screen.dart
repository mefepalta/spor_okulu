import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/app_models.dart';
import '../utils/validators.dart';
import '../widgets/empty_state.dart';

class GroupsScreen extends StatefulWidget {
  final List<TrainingGroup> groups;
  final List<Coach> coaches;
  final bool isAdmin;
  final Future<void> Function(TrainingGroup group) onAddGroup;
  final Future<void> Function(int index) onDeleteGroup;
  final Future<void> Function(int index, TrainingGroup updatedGroup)
  onUpdateGroup;

  const GroupsScreen({
    super.key,
    required this.groups,
    required this.coaches,
    required this.isAdmin,
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
        builder: (context) => AddGroupScreen(coaches: widget.coaches),
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
          index: index,
          isAdmin: widget.isAdmin,
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

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Grubu Sil'),
          content: Text('${group.name} grubunu silmek istediğine emin misin'),
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

    await widget.onDeleteGroup(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Grup silindi.')));
  }

  @override
  Widget build(BuildContext context) {
    final filteredGroups = widget.groups.where((group) {
      final query = _searchQuery.toLowerCase();

      return group.name.toLowerCase().contains(query) ||
          group.branch.toLowerCase().contains(query) ||
          group.coachName.toLowerCase().contains(query);
    }).toList();
    final canAddGroup = widget.isAdmin && widget.coaches.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Gruplar')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Grup ara',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
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
                    title: 'Henüz grup yok',
                    message: widget.isAdmin
                        ? widget.coaches.isNotEmpty
                              ? 'Yeni grup eklemek için sağ alttaki + butonunu kullan.'
                              : 'Grup eklemek için once en az bir antrenör ekle.'
                        : 'Henüz grup kaydı yok. Admin grup eklediçinde burada görünecek.',
                  )
                : filteredGroups.isEmpty
                ? const EmptyState(
                    icon: Icons.search_off,
                    title: 'Sonuç bulunamadı',
                    message: 'Arama metnini değiştirerek tekrar dene.',
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
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            child: Icon(Icons.groups),
                          ),
                          title: Text(group.name),
                          subtitle: Text(
                            '${group.branch} • ${group.schedule}\n'
                            'Antrenör: ${group.coachName}',
                          ),
                          isThreeLine: true,
                          trailing: widget.isAdmin
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
  final int index;
  final bool isAdmin;
  final Future<void> Function(int index, TrainingGroup updatedGroup)
  onUpdateGroup;

  const GroupDetailScreen({
    super.key,
    required this.groups,
    required this.coaches,
    required this.index,
    required this.isAdmin,
    required this.onUpdateGroup,
  });

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  TrainingGroup get _group => widget.groups[widget.index];

  Future<void> _openEditGroupScreen() async {
    final updatedGroup = await Navigator.push<TrainingGroup>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddGroupScreen(coaches: widget.coaches, group: _group),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grup Detayı'),
        actions: widget.isAdmin
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
                  const Icon(Icons.groups, size: 64, color: Colors.indigo),
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
                  Text(group.schedule),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.badge),
              title: const Text('Grup Adı'),
              subtitle: Text(group.name),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.sports),
              title: const Text('Branş'),
              subtitle: Text(group.branch),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Antrenör'),
              subtitle: Text(group.coachName),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Program'),
              subtitle: Text(group.schedule),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Kapasite'),
              subtitle: Text('${group.capacity} kişi'),
            ),
          ),
          const SizedBox(height: 20),
          if (widget.isAdmin)
            ElevatedButton.icon(
              onPressed: _openEditGroupScreen,
              icon: const Icon(Icons.edit),
              label: const Text('Grubu Düzenle'),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Grup Listesine Dön'),
          ),
        ],
      ),
    );
  }
}

class AddGroupScreen extends StatefulWidget {
  final List<Coach> coaches;
  final TrainingGroup? group;

  const AddGroupScreen({super.key, required this.coaches, this.group});

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();

  final List<String> _days = const [
    'Pazartesi',
    'Sali',
    'Carsamba',
    'Persembe',
    'Cuma',
    'Cumartesi',
    'Pazar',
  ];

  String? _selectedCoachName;
  String? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _days.first;

    if (widget.coaches.isNotEmpty) {
      _selectedCoachName = widget.coaches.first.name;
    }

    final group = widget.group;

    if (group != null) {
      _nameController.text = group.name;
      _branchController.text = group.branch;
      _capacityController.text = group.capacity.toString();

      final scheduleParts = group.schedule.trim().split(' ');

      if (scheduleParts.isNotEmpty) {
        _selectedDay = dropdownDayFromText(scheduleParts.first);
      }

      if (scheduleParts.length >= 2) {
        _timeController.text = scheduleParts[1];
      }

      final coachStillExists = widget.coaches.any((coach) {
        return coach.name == group.coachName;
      });

      if (coachStillExists) {
        _selectedCoachName = group.coachName;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _branchController.dispose();
    _timeController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  void _saveGroup() {
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    if (_selectedCoachName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Önce bir antrenör eklemelisin.')),
      );
      return;
    }

    final normalizedTime = normalizeTime(_timeController.text.trim());

    final group = TrainingGroup(
      name: _nameController.text.trim(),
      branch: _branchController.text.trim(),
      coachName: _selectedCoachName!,
      schedule: '$_selectedDay $normalizedTime',
      capacity: int.parse(_capacityController.text.trim()),
    );

    Navigator.pop(context, group);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.group != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Grubu Düzenle' : 'Yeni Grup Ekle'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: widget.coaches.isEmpty
            ? const Center(
                child: Text(
                  'Grup eklemek için önce en az bir antrenör eklemelisin.',
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
                      decoration: const InputDecoration(
                        labelText: 'Grup Adı',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.badge),
                        hintText: 'Minikler A',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Grup adı boş bırakılamaz.';
                        }

                        if (value.trim().length < 2) {
                          return 'Grup adı en az 2 karakter olmalıdır.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _branchController,
                      decoration: const InputDecoration(
                        labelText: 'Branş',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.sports),
                        hintText: 'Futbol',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Branş boş bırakılamaz.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCoachName,
                      decoration: const InputDecoration(
                        labelText: 'Antrenör',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      items: widget.coaches.map((coach) {
                        return DropdownMenuItem<String>(
                          value: coach.name,
                          child: Text('${coach.name} - ${coach.branch}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCoachName = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Antrenör seçmelisin.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedDay,
                      decoration: const InputDecoration(
                        labelText: 'Gün',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_month),
                      ),
                      items: _days.map((day) {
                        return DropdownMenuItem<String>(
                          value: day,
                          child: Text(day),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDay = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Gün seçmelisin.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _timeController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: 'Saat',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.schedule),
                        hintText: '18:00',
                      ),
                      validator: validateTime,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _capacityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Kapasite',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.people),
                        hintText: '20',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Kapasite boş bırakılamaz.';
                        }

                        final capacity = int.tryParse(value.trim());

                        if (capacity == null) {
                          return 'Kapasite sayı olmalıdır.';
                        }

                        if (capacity <= 0) {
                          return 'Kapasite 0’dan büyük olmalıdır.';
                        }

                        if (capacity > 100) {
                          return 'Kapasite 100’den büyük olmamalıdır.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _saveGroup,
                      icon: const Icon(Icons.save),
                      label: Text(
                        isEditing ? 'Değişiklikleri Kaydet' : 'Grubu Kaydet',
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
