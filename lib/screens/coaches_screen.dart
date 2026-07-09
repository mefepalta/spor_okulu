import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import '../widgets/wave_background.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../utils/validators.dart';
import '../widgets/empty_state.dart';

class CoachesScreen extends StatefulWidget {
  final List<Coach> coaches;
  final bool isAdmin;
  final Future<void> Function(Coach coach) onAddCoach;
  final Future<void> Function(int index) onDeleteCoach;
  final Future<void> Function(int index, Coach updatedCoach) onUpdateCoach;

  const CoachesScreen({
    super.key,
    required this.coaches,
    required this.isAdmin,
    required this.onAddCoach,
    required this.onDeleteCoach,
    required this.onUpdateCoach,
  });

  @override
  State<CoachesScreen> createState() => _CoachesScreenState();
}

class _CoachesScreenState extends State<CoachesScreen> {
  String _searchQuery = '';

  Future<void> _openAddCoachScreen() async {
    final newCoach = await Navigator.push<Coach>(
      context,
      MaterialPageRoute(builder: (context) => const AddCoachScreen()),
    );

    if (newCoach == null) {
      return;
    }

    await widget.onAddCoach(newCoach);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _openCoachDetailScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoachDetailScreen(
          coaches: widget.coaches,
          index: index,
          isAdmin: widget.isAdmin,
          onUpdateCoach: widget.onUpdateCoach,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmDeleteCoach(int index) async {
    final coach = widget.coaches[index];
    final l10n = AppLocalizations.of(context);

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context);
        return AlertDialog(
          title: Text(l10n.coachDeleteTitle),
          content: Text(l10n.coachDeleteConfirm(coach.name)),
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

    await widget.onDeleteCoach(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.coachDeleted)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filteredCoaches = widget.coaches.where((coach) {
      final query = _searchQuery.toLowerCase();

      return coach.name.toLowerCase().contains(query) ||
          coach.branch.toLowerCase().contains(query) ||
          coach.phone.toLowerCase().contains(query);
    }).toList();
    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.navCoaches)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                labelText: l10n.coachesSearchHint,
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
            child: widget.coaches.isEmpty
                ? EmptyState(
                    icon: Icons.sports,
                    title: l10n.coachesEmptyTitle,
                    message: widget.isAdmin
                        ? l10n.coachesEmptyAdmin
                        : l10n.coachesEmptyViewer,
                  )
                : filteredCoaches.isEmpty
                ? EmptyState(
                    icon: Icons.search_off,
                    title: l10n.searchNoResults,
                    message: l10n.searchNoResultsBody,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredCoaches.length,
                    itemBuilder: (context, index) {
                      final coach = filteredCoaches[index];
                      final originalIndex = widget.coaches.indexOf(coach);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          onTap: () {
                            _openCoachDetailScreen(originalIndex);
                          },
                          leading: const CircleAvatar(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            child: Icon(Icons.sports),
                          ),
                          title: Text(coach.name),
                          subtitle: Text(
                            l10n.coachSubtitle(coach.branch, coach.phone),
                          ),
                          trailing: widget.isAdmin
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _confirmDeleteCoach(originalIndex);
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
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton(
              onPressed: _openAddCoachScreen,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class CoachDetailScreen extends StatefulWidget {
  final List<Coach> coaches;
  final int index;
  final bool isAdmin;
  final Future<void> Function(int index, Coach updatedCoach) onUpdateCoach;

  const CoachDetailScreen({
    super.key,
    required this.coaches,
    required this.index,
    required this.isAdmin,
    required this.onUpdateCoach,
  });

  @override
  State<CoachDetailScreen> createState() => _CoachDetailScreenState();
}

class _CoachDetailScreenState extends State<CoachDetailScreen> {
  Coach get _coach => widget.coaches[widget.index];

  Future<void> _openEditCoachScreen() async {
    final updatedCoach = await Navigator.push<Coach>(
      context,
      MaterialPageRoute(builder: (context) => AddCoachScreen(coach: _coach)),
    );

    if (updatedCoach == null) {
      return;
    }

    await widget.onUpdateCoach(widget.index, updatedCoach);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final coach = _coach;
    final l10n = AppLocalizations.of(context);

    return WaveScaffold(
      appBar: AppBar(
        title: Text(l10n.coachDetailTitle),
        actions: widget.isAdmin
            ? [
                IconButton(
                  onPressed: _openEditCoachScreen,
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
                  const Icon(Icons.sports, size: 64, color: AppColors.primary),
                  const SizedBox(height: 16),
                  Text(
                    coach.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(coach.branch),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(l10n.fieldFullName),
              subtitle: Text(coach.name),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.sports_soccer),
              title: Text(l10n.fieldBranch),
              subtitle: Text(coach.branch),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.phone),
              title: Text(l10n.fieldPhone),
              subtitle: Text(coach.phone),
            ),
          ),
          const SizedBox(height: 20),
          if (widget.isAdmin)
            ElevatedButton.icon(
              onPressed: _openEditCoachScreen,
              icon: const Icon(Icons.edit),
              label: Text(l10n.editCoach),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: Text(l10n.backToCoachList),
          ),
        ],
      ),
    );
  }
}

class AddCoachScreen extends StatefulWidget {
  final Coach? coach;

  const AddCoachScreen({super.key, this.coach});

  @override
  State<AddCoachScreen> createState() => _AddCoachScreenState();
}

class _AddCoachScreenState extends State<AddCoachScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final coach = widget.coach;

    if (coach != null) {
      _nameController.text = coach.name;
      _branchController.text = coach.branch;
      _phoneController.text = coach.phone;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _branchController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveCoach() {
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    final coach = Coach(
      name: _nameController.text.trim(),
      branch: _branchController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    Navigator.pop(context, coach);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.coach != null;
    final l10n = AppLocalizations.of(context);

    return WaveScaffold(
      appBar: AppBar(
        title: Text(isEditing ? l10n.editCoach : l10n.addCoach),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.fieldFullName,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                  hintText: l10n.fullNameHint,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.fullNameEmpty;
                  }

                  if (value.trim().length < 3) {
                    return l10n.fullNameMinLength;
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _branchController,
                decoration: InputDecoration(
                  labelText: l10n.fieldBranch,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.sports_soccer),
                  hintText: 'Futbol',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.branchEmpty;
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: InputDecoration(
                  labelText: l10n.fieldPhone,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.phone),
                  hintText: '05XXXXXXXXX',
                ),
                validator: phoneValidator(l10n),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveCoach,
                icon: const Icon(Icons.save),
                label: Text(isEditing ? l10n.saveChanges : l10n.saveCoach),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
