import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import '../widgets/wave_background.dart';
import 'package:flutter/services.dart';

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

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Antrenörü Sil'),
          content: Text(
            '${coach.name} adlı antrenörü silmek istediğine emin misin',
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

    await widget.onDeleteCoach(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Antrenör silindi.')));
  }

  @override
  Widget build(BuildContext context) {
    final filteredCoaches = widget.coaches.where((coach) {
      final query = _searchQuery.toLowerCase();

      return coach.name.toLowerCase().contains(query) ||
          coach.branch.toLowerCase().contains(query) ||
          coach.phone.toLowerCase().contains(query);
    }).toList();
    return WaveScaffold(
      appBar: AppBar(title: const Text('Antrenörler')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Antrenör ara',
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
            child: widget.coaches.isEmpty
                ? EmptyState(
                    icon: Icons.sports,
                    title: 'Henüz antrenör yok',
                    message: widget.isAdmin
                        ? 'Yeni antrenör eklemek için sağ alttaki + butonunu kullan.'
                        : 'Henüz antrenör kaydı yok. Admin antrenör eklediçinde burada görünecek.',
                  )
                : filteredCoaches.isEmpty
                ? const EmptyState(
                    icon: Icons.search_off,
                    title: 'Sonuç bulunamadı',
                    message: 'Arama metnini değiştirerek tekrar dene.',
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
                          subtitle: Text('${coach.branch} • ${coach.phone}'),
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

    return WaveScaffold(
      appBar: AppBar(
        title: const Text('Antrenör Detayı'),
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
              title: const Text('Ad Soyad'),
              subtitle: Text(coach.name),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.sports_soccer),
              title: const Text('Branş'),
              subtitle: Text(coach.branch),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Telefon'),
              subtitle: Text(coach.phone),
            ),
          ),
          const SizedBox(height: 20),
          if (widget.isAdmin)
            ElevatedButton.icon(
              onPressed: _openEditCoachScreen,
              icon: const Icon(Icons.edit),
              label: const Text('Antrenörü Düzenle'),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Antrenör Listesine Dön'),
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

    return WaveScaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Antrenörü Düzenle' : 'Yeni Antrenör Ekle'),
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
                decoration: const InputDecoration(
                  labelText: 'Ad Soyad',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Ahmet Yılmaz',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ad soyad boş bırakılamaz.';
                  }

                  if (value.trim().length < 3) {
                    return 'Ad soyad en az 3 karakter olmalıdır.';
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
                  prefixIcon: Icon(Icons.sports_soccer),
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
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: const InputDecoration(
                  labelText: 'Telefon',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: '05XXXXXXXXX',
                ),
                validator: validatePhoneNumber,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveCoach,
                icon: const Icon(Icons.save),
                label: Text(
                  isEditing ? 'Değişiklikleri Kaydet' : 'Antrenörü Kaydet',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
