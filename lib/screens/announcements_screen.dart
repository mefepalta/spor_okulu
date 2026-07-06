import 'package:flutter/material.dart';

import '../constants/app_roles.dart';
import '../models/app_models.dart';
import '../utils/validators.dart';
import '../widgets/empty_state.dart';

class AnnouncementsScreen extends StatefulWidget {
  final List<Announcement> announcements;
  final bool isAdmin;
  final Future<void> Function(Announcement announcement) onAddAnnouncement;
  final Future<void> Function(int index) onDeleteAnnouncement;
  final Future<void> Function(int index, Announcement updatedAnnouncement)
  onUpdateAnnouncement;

  const AnnouncementsScreen({
    super.key,
    required this.announcements,
    required this.isAdmin,
    required this.onAddAnnouncement,
    required this.onDeleteAnnouncement,
    required this.onUpdateAnnouncement,
  });

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  Future<void> _openAddAnnouncementScreen() async {
    final newAnnouncement = await Navigator.push<Announcement>(
      context,
      MaterialPageRoute(builder: (context) => const AddAnnouncementScreen()),
    );

    if (newAnnouncement == null) {
      return;
    }

    await widget.onAddAnnouncement(newAnnouncement);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _openAnnouncementDetailScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnnouncementDetailScreen(
          announcements: widget.announcements,
          index: index,
          isAdmin: widget.isAdmin,
          onUpdateAnnouncement: widget.onUpdateAnnouncement,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmDeleteAnnouncement(int index) async {
    final announcement = widget.announcements[index];

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Duyuruyu Sil'),
          content: Text(
            '${announcement.title} başlıklı duyuruyu silmek istediğine emin misin',
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

    await widget.onDeleteAnnouncement(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Duyuru silindi.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Duyurular')),
      body: widget.announcements.isEmpty
          ? EmptyState(
              icon: Icons.campaign,
              title: 'Henüz duyuru yok',
              message: widget.isAdmin
                  ? 'Yeni duyuru eklemek için sağ alttaki + butonunu kullan.'
                  : 'Henüz duyuru yok. Admin duyuru eklediçinde burada görünecek.',
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.announcements.length,
              itemBuilder: (context, index) {
                final announcement = widget.announcements[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () {
                      _openAnnouncementDetailScreen(index);
                    },
                    leading: const CircleAvatar(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.campaign),
                    ),
                    title: Text(announcement.title),
                    subtitle: Text(
                      '${announcement.targetAudience} • ${announcement.dateText}\n${announcement.content}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    isThreeLine: true,
                    trailing: widget.isAdmin
                        ? IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _confirmDeleteAnnouncement(index);
                            },
                          )
                        : null,
                  ),
                );
              },
            ),
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton(
              onPressed: _openAddAnnouncementScreen,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class AnnouncementDetailScreen extends StatefulWidget {
  final List<Announcement> announcements;
  final int index;
  final bool isAdmin;
  final Future<void> Function(int index, Announcement updatedAnnouncement)
  onUpdateAnnouncement;

  const AnnouncementDetailScreen({
    super.key,
    required this.announcements,
    required this.index,
    required this.isAdmin,
    required this.onUpdateAnnouncement,
  });

  @override
  State<AnnouncementDetailScreen> createState() =>
      _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  Announcement get _announcement => widget.announcements[widget.index];

  Future<void> _openEditAnnouncementScreen() async {
    final updatedAnnouncement = await Navigator.push<Announcement>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddAnnouncementScreen(announcement: _announcement),
      ),
    );

    if (updatedAnnouncement == null) {
      return;
    }

    await widget.onUpdateAnnouncement(widget.index, updatedAnnouncement);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final announcement = _announcement;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Duyuru Detayı'),
        actions: widget.isAdmin
            ? [
                IconButton(
                  onPressed: _openEditAnnouncementScreen,
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
                  const Icon(Icons.campaign, size: 64, color: Colors.indigo),
                  const SizedBox(height: 16),
                  Text(
                    announcement.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(announcement.targetAudience),
                  const SizedBox(height: 8),
                  Text(announcement.dateText),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.title),
              title: const Text('Başlık'),
              subtitle: Text(announcement.title),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Hedef Kitle'),
              subtitle: Text(announcement.targetAudience),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Tarih'),
              subtitle: Text(announcement.dateText),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                announcement.content,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (widget.isAdmin)
            ElevatedButton.icon(
              onPressed: _openEditAnnouncementScreen,
              icon: const Icon(Icons.edit),
              label: const Text('Duyuruyu Düzenle'),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Duyuru Listesine Dön'),
          ),
        ],
      ),
    );
  }
}

class AddAnnouncementScreen extends StatefulWidget {
  final Announcement? announcement;

  const AddAnnouncementScreen({super.key, this.announcement});

  @override
  State<AddAnnouncementScreen> createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final List<String> _targetAudiences = AnnouncementAudience.all;

  String? _selectedTargetAudience;

  @override
  void initState() {
    super.initState();

    _selectedTargetAudience = _targetAudiences.first;

    final announcement = widget.announcement;

    if (announcement != null) {
      _titleController.text = announcement.title;
      _contentController.text = announcement.content;
      _dateController.text = announcement.dateText;

      if (_targetAudiences.contains(announcement.targetAudience)) {
        _selectedTargetAudience = announcement.targetAudience;
      }
    } else {
      final now = DateTime.now();
      final day = now.day.toString().padLeft(2, '0');
      final month = now.month.toString().padLeft(2, '0');
      final year = now.year.toString();

      _dateController.text = '$day.$month.$year';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _saveAnnouncement() {
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    final announcement = Announcement(
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      targetAudience: _selectedTargetAudience!,
      dateText: _dateController.text.trim(),
    );

    Navigator.pop(context, announcement);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.announcement != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Duyuruyu Düzenle' : 'Yeni Duyuru Ekle'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Başlık',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                  hintText: 'Antrenman saati değişikliği',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Başlık boş bırakılamaz.';
                  }

                  if (value.trim().length < 3) {
                    return 'Başlık en az 3 karakter olmalıdır.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'İçerik',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.notes),
                  hintText: 'Duyuru içeriğini yaz...',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'İçerik boş bırakılamaz.';
                  }

                  if (value.trim().length < 10) {
                    return 'İçerik en az 10 karakter olmalıdır.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedTargetAudience,
                decoration: const InputDecoration(
                  labelText: 'Hedef Kitle',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.group),
                ),
                items: _targetAudiences.map((targetAudience) {
                  return DropdownMenuItem<String>(
                    value: targetAudience,
                    child: Text(targetAudience),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTargetAudience = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hedef kitle seçmelisin.';
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
              ElevatedButton.icon(
                onPressed: _saveAnnouncement,
                icon: const Icon(Icons.save),
                label: Text(
                  isEditing ? 'Değişiklikleri Kaydet' : 'Duyuruyu Kaydet',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
