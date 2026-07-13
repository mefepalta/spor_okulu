import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import '../widgets/wave_background.dart';

import '../constants/app_roles.dart';
import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../utils/audience_l10n.dart';
import '../utils/validators.dart';
import '../widgets/empty_state.dart';

class AnnouncementsScreen extends StatefulWidget {
  final List<Announcement> announcements;
  final bool isAdmin;
  final Future<Announcement> Function(Announcement announcement)
  onAddAnnouncement;
  final Future<void> Function(Announcement announcement) onDeleteAnnouncement;
  final Future<void> Function(Announcement updatedAnnouncement)
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
  // Ekran, kendi görüntüleme listesini tutar (tek gerçek kaynak burada değil;
  // ekle/sil bu listeye id ile yansır). Böylece panonun realtime stream'i ile
  // paylaşılan mutable liste üzerinden oluşan çift-görünme/boşalma yarışları
  // olmaz. Başlangıç, panonun o anki görünür listesinin kopyasıdır.
  late final List<Announcement> _items = List.of(widget.announcements);

  Future<void> _openAddAnnouncementScreen() async {
    final newAnnouncement = await Navigator.push<Announcement>(
      context,
      MaterialPageRoute(builder: (context) => const AddAnnouncementScreen()),
    );

    if (newAnnouncement == null) {
      return;
    }

    final saved = await widget.onAddAnnouncement(newAnnouncement);

    if (!mounted) {
      return;
    }

    setState(() {
      // id ile tekilleştir (çift ekleme olmaz); en yeni üstte (stream sırasıyla).
      if (!_items.any((a) => a.id == saved.id)) {
        _items.insert(0, saved);
      }
    });
  }

  Future<void> _openAnnouncementDetailScreen(int index) async {
    final announcement = _items[index];
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnnouncementDetailScreen(
          announcement: announcement,
          isAdmin: widget.isAdmin,
          onUpdateAnnouncement: (updated) async {
            await widget.onUpdateAnnouncement(updated);
            if (!mounted) {
              return;
            }
            setState(() {
              final i = _items.indexWhere((a) => a.id == updated.id);
              if (i >= 0) {
                _items[i] = updated;
              }
            });
          },
        ),
      ),
    );
  }

  Future<void> _confirmDeleteAnnouncement(int index) async {
    final l10n = AppLocalizations.of(context);
    final announcement = _items[index];

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.announcementDeleteTitle),
          content: Text(l10n.announcementDeleteConfirm(announcement.title)),
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
              child: Text(l10n.commonDelete, style: const TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    await widget.onDeleteAnnouncement(announcement);

    if (!mounted) {
      return;
    }

    setState(() {
      _items.removeWhere((a) => a.id == announcement.id);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.announcementDeleted)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.navAnnouncements)),
      body: _items.isEmpty
          ? EmptyState(
              icon: Icons.campaign,
              title: l10n.announcementsEmptyTitle,
              message: widget.isAdmin
                  ? l10n.announcementsEmptyAdmin
                  : l10n.announcementsEmptyViewer,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final announcement = _items[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () {
                      _openAnnouncementDetailScreen(index);
                    },
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.campaign),
                    ),
                    title: Text(announcement.title),
                    subtitle: Text(
                      '${localizedAudience(l10n, announcement.targetAudience)} • ${announcement.dateText}\n${announcement.content}',
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
  final Announcement announcement;
  final bool isAdmin;
  final Future<void> Function(Announcement updatedAnnouncement)
  onUpdateAnnouncement;

  const AnnouncementDetailScreen({
    super.key,
    required this.announcement,
    required this.isAdmin,
    required this.onUpdateAnnouncement,
  });

  @override
  State<AnnouncementDetailScreen> createState() =>
      _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  late Announcement _announcement = widget.announcement;

  Future<void> _openEditAnnouncementScreen() async {
    final edited = await Navigator.push<Announcement>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddAnnouncementScreen(announcement: _announcement),
      ),
    );

    if (edited == null) {
      return;
    }

    // Düzenleme formu id taşımaz; mevcut kaydın id'sini enjekte et.
    final updated = edited.copyWith(id: _announcement.id);
    await widget.onUpdateAnnouncement(updated);

    if (!mounted) {
      return;
    }

    setState(() {
      _announcement = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final announcement = _announcement;

    return WaveScaffold(
      appBar: AppBar(
        title: Text(l10n.announcementDetailTitle),
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
                  const Icon(
                    Icons.campaign,
                    size: 64,
                    color: AppColors.primary,
                  ),
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
                  Text(localizedAudience(l10n, announcement.targetAudience)),
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
              title: Text(l10n.fieldTitle),
              subtitle: Text(announcement.title),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.group),
              title: Text(l10n.fieldTargetAudience),
              subtitle: Text(localizedAudience(l10n, announcement.targetAudience)),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.event),
              title: Text(l10n.fieldDate),
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
              label: Text(l10n.editAnnouncementTitle),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: Text(l10n.backToAnnouncementList),
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
    final l10n = AppLocalizations.of(context);
    final isEditing = widget.announcement != null;

    return WaveScaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? l10n.editAnnouncementTitle : l10n.addAnnouncementTitle,
        ),
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
                decoration: InputDecoration(
                  labelText: l10n.fieldTitle,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.title),
                  hintText: l10n.titleHint,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.titleEmpty;
                  }

                  if (value.trim().length < 3) {
                    return l10n.titleMinLength;
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: l10n.fieldContent,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.notes),
                  hintText: l10n.contentHint,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.contentEmpty;
                  }

                  if (value.trim().length < 10) {
                    return l10n.contentMinLength;
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedTargetAudience,
                decoration: InputDecoration(
                  labelText: l10n.fieldTargetAudience,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.group),
                ),
                items: _targetAudiences.map((targetAudience) {
                  return DropdownMenuItem<String>(
                    value: targetAudience,
                    child: Text(localizedAudience(l10n, targetAudience)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTargetAudience = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.audienceRequired;
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _dateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: l10n.fieldDate,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.event),
                  hintText: '24.06.2026',
                ),
                validator: dateValidator(l10n),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveAnnouncement,
                icon: const Icon(Icons.save),
                label: Text(
                  isEditing ? l10n.saveChanges : l10n.saveAnnouncement,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
