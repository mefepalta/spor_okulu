import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import '../widgets/wave_background.dart';

import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../widgets/empty_state.dart';

/// Etkinlikler ekranı.
///
/// Veliler için (canManage = false): antrenörlerin planladığı etkinliklere
/// çocukları adına olumlu/olumsuz katılım cevabı verirler.
/// Antrenör/Admin için (canManage = true): etkinlik oluşturur, siler ve
/// gelen katılım cevaplarını görürler.
class EventsScreen extends StatefulWidget {
  final List<PlannedEvent> events;
  final List<EventResponse> responses;
  final List<Student> children;
  final String currentUserUid;
  final bool canManage;
  final Future<void> Function(PlannedEvent event) onAddEvent;
  final Future<void> Function(String eventId) onDeleteEvent;
  final Future<void> Function(EventResponse response) onRespond;

  const EventsScreen({
    super.key,
    required this.events,
    required this.responses,
    required this.children,
    required this.currentUserUid,
    required this.canManage,
    required this.onAddEvent,
    required this.onDeleteEvent,
    required this.onRespond,
  });

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  /// Veli tarafındaki güncel seçimler. Anahtar: eventId_studentId.
  final Map<String, bool> _pending = {};

  /// Firestore'a kaydedilmiş son durumun aynası. `_pending` ile aynıysa
  /// gönderilecek yeni bir şey yoktur (buton pasifleşir).
  final Map<String, bool> _saved = {};

  /// Şu an gönderimi süren etkinliklerin id'leri. Butonun arka arkaya
  /// (eli kayarak) tekrar tetiklenmesini engeller.
  final Set<String> _submitting = {};

  @override
  void initState() {
    super.initState();
    for (final response in widget.responses) {
      final key = EventResponse.buildId(response.eventId, response.studentId);
      _pending[key] = response.willAttend;
      _saved[key] = response.willAttend;
    }
  }

  /// Bu etkinlik için henüz gönderilmemiş (kaydedilenden farklı) bir seçim
  /// var mı?
  bool _hasUnsentChanges(PlannedEvent event) {
    for (final child in widget.children) {
      final key = EventResponse.buildId(event.id, child.id);
      final pending = _pending[key];
      if (pending == null) {
        continue;
      }
      if (_saved[key] != pending) {
        return true;
      }
    }
    return false;
  }

  List<PlannedEvent> get _sortedEvents {
    final events = [...widget.events]
      ..sort((a, b) => a.dateText.compareTo(b.dateText));
    return events;
  }

  Future<void> _openAddEventScreen() async {
    final newEvent = await Navigator.push<PlannedEvent>(
      context,
      MaterialPageRoute(builder: (context) => const AddEventScreen()),
    );

    if (newEvent == null) {
      return;
    }

    try {
      await widget.onAddEvent(newEvent);
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).eventAddError(error)),
        ),
      );
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmDeleteEvent(PlannedEvent event) async {
    final l10n = AppLocalizations.of(context);
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.eventDeleteTitle),
          content: Text(l10n.eventDeleteConfirm(event.title)),
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
      await widget.onDeleteEvent(event.id);
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.eventDeleteError(error))),
      );
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _submitResponses(PlannedEvent event) async {
    // Zaten gönderim sürüyorsa yeni tetiklemeyi yok say (çift gönderim önlenir).
    if (_submitting.contains(event.id)) {
      return;
    }

    // Hiç seçim yapılmamışsa kullanıcıyı yönlendir.
    final l10n = AppLocalizations.of(context);
    final hasAnySelection = widget.children.any((child) {
      return _pending[EventResponse.buildId(event.id, child.id)] != null;
    });
    if (!hasAnySelection) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.selectAttendanceFirst)),
      );
      return;
    }

    // Kaydedilenden farklı bir şey yoksa tekrar göndermeye gerek yok.
    if (!_hasUnsentChanges(event)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.responseAlreadySaved)));
      return;
    }

    setState(() {
      _submitting.add(event.id);
    });

    var sentCount = 0;

    try {
      for (final child in widget.children) {
        final key = EventResponse.buildId(event.id, child.id);
        final willAttend = _pending[key];

        // Yalnızca değişen (henüz kaydedilmemiş) seçimleri gönder.
        if (willAttend == null || _saved[key] == willAttend) {
          continue;
        }

        await widget.onRespond(
          EventResponse(
            eventId: event.id,
            studentId: child.id,
            parentUid: widget.currentUserUid,
            willAttend: willAttend,
          ),
        );
        _saved[key] = willAttend;
        sentCount++;
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _submitting.remove(event.id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.responseSendError(error))),
      );
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _submitting.remove(event.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          sentCount == 0 ? l10n.responseAlreadySaved : l10n.responseSent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final events = _sortedEvents;

    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.navEvents)),
      body: events.isEmpty
          ? EmptyState(
              icon: Icons.event_available,
              title: l10n.eventsEmptyTitle,
              message: widget.canManage
                  ? l10n.eventsEmptyManage
                  : l10n.eventsEmptyViewer,
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: events.map((event) {
                return widget.canManage
                    ? _buildManageCard(event)
                    : _buildRespondCard(event);
              }).toList(),
            ),
      floatingActionButton: widget.canManage
          ? FloatingActionButton.extended(
              onPressed: _openAddEventScreen,
              icon: const Icon(Icons.add),
              label: Text(l10n.addEvent),
            )
          : null,
    );
  }

  Widget _buildManageCard(PlannedEvent event) {
    final l10n = AppLocalizations.of(context);
    final eventResponses = widget.responses
        .where((response) => response.eventId == event.id)
        .toList();
    final attending = eventResponses.where((r) => r.willAttend).length;
    final notAttending = eventResponses.length - attending;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.event, color: AppColors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDeleteEvent(event),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(l10n.dateWithValue(event.dateText)),
            if (event.description.trim().isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(event.description),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                _StatChip(
                  icon: Icons.sentiment_satisfied_alt,
                  color: Colors.green,
                  label: l10n.attendingCount(attending),
                ),
                const SizedBox(width: 8),
                _StatChip(
                  icon: Icons.sentiment_dissatisfied,
                  color: Colors.red,
                  label: l10n.notAttendingCount(notAttending),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRespondCard(PlannedEvent event) {
    final l10n = AppLocalizations.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.eventDateLabel(event.dateText),
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 4),
            Text(
              event.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (event.description.trim().isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(event.description),
            ],
            const Divider(height: 24),
            ...widget.children.map(
              (child) => _buildChildResponse(event, child),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: _buildSubmitButton(event),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(PlannedEvent event) {
    final l10n = AppLocalizations.of(context);
    final isSubmitting = _submitting.contains(event.id);
    final hasChanges = _hasUnsentChanges(event);
    // Gönderim sürerken ya da gönderilecek yeni bir şey yokken buton pasif.
    final enabled = !isSubmitting && hasChanges;

    return ElevatedButton.icon(
      onPressed: enabled ? () => _submitResponses(event) : null,
      icon: isSubmitting
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(hasChanges ? Icons.send : Icons.check),
      label: Text(
        isSubmitting
            ? l10n.sendingLabel
            : hasChanges
            ? l10n.sendAction
            : l10n.sentLabel,
      ),
    );
  }

  Widget _buildChildResponse(PlannedEvent event, Student child) {
    final l10n = AppLocalizations.of(context);
    final key = EventResponse.buildId(event.id, child.id);
    final selection = _pending[key];

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(child.name, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: Text(l10n.willAttend),
                  selected: selection == true,
                  selectedColor: Colors.green.shade100,
                  onSelected: (_) {
                    setState(() {
                      _pending[key] = true;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ChoiceChip(
                  label: Text(l10n.willNotAttend),
                  selected: selection == false,
                  selectedColor: Colors.red.shade100,
                  onSelected: (_) {
                    setState(() {
                      _pending[key] = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _StatChip({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, color: color, size: 18),
      label: Text(label),
      backgroundColor: color.withValues(alpha: 0.08),
    );
  }
}

/// Antrenör/Admin'in yeni etkinlik oluşturduğu ekran.
class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final event = PlannedEvent(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      dateText: _dateText,
    );

    Navigator.pop(context, event);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.addEventTitle)),
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
                  labelText: l10n.fieldEventName,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.event),
                  hintText: l10n.eventNameHint,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.eventNameEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: l10n.fieldDescriptionOptional,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.notes),
                ),
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
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: Text(l10n.saveEvent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
