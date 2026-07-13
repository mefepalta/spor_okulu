import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../services/schedule_service.dart';
import '../theme/app_colors.dart';
import '../utils/day_l10n.dart';
import '../widgets/empty_state.dart';
import '../widgets/wave_background.dart';

/// Haftalık ders programı. Herkes (onaylı üye) görür; yalnızca admin+antrenör
/// ([canManage]) ekler/düzenler/siler. Oturumlar gerçek zamanlı akar.
class ScheduleScreen extends StatefulWidget {
  final List<TrainingGroup> groups;
  final List<Coach> coaches;
  final bool canManage;

  /// Bir dersten hızlı yoklama almak için (yalnızca yetkili personelde dolu).
  /// Dersin grup kimliği geçilir; null ise yoklama kısayolu gösterilmez.
  final void Function(String groupId)? onTakeAttendance;

  const ScheduleScreen({
    super.key,
    required this.groups,
    required this.coaches,
    required this.canManage,
    this.onTakeAttendance,
  });

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

/// Haftanın günleri, veritabanındaki ASCII Türkçe biçimiyle ve sırayla.
const List<String> kScheduleDays = [
  'Pazartesi',
  'Sali',
  'Carsamba',
  'Persembe',
  'Cuma',
  'Cumartesi',
  'Pazar',
];

/// Program görünümü: haftalık liste (tüm günler alt alta) ya da günlük zaman
/// ızgarası (tek gün, saatlere göre bloklar).
enum _ScheduleView { week, day }

class _ScheduleScreenState extends State<ScheduleScreen> {
  final ScheduleService _service = ScheduleService();

  _ScheduleView _view = _ScheduleView.week;
  // Bugünün gün indeksi (DateTime.weekday 1..7 → 0..6). Vurgulamada kullanılır.
  final int _todayIndex = (DateTime.now().weekday - 1).clamp(0, 6);
  // Günlük ızgarada seçili gün (bugünle başlar).
  late int _selectedDayIndex = _todayIndex;
  // Akıştaki en son giriş listesi (çakışma denetimi için editörden erişilir).
  List<ScheduleEntry> _entries = const [];

  Future<void> _openEditor(ScheduleEntry? existing) async {
    final l10n = AppLocalizations.of(context);
    if (widget.groups.isEmpty || widget.coaches.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.scheduleNeedsGroupCoach)),
      );
      return;
    }
    final result = await showModalBottomSheet<ScheduleEntry>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ScheduleEntrySheet(
        groups: widget.groups,
        coaches: widget.coaches,
        initial: existing,
      ),
    );
    if (result == null) {
      return;
    }
    // Çakışma denetimi: aynı gün, kesişen saat ve aynı antrenör ya da aynı grup.
    final conflicts = _findConflicts(result, excludeId: existing?.id);
    if (conflicts.isNotEmpty && mounted) {
      final proceed = await _confirmConflict(conflicts);
      if (proceed != true) {
        return;
      }
    }
    if (existing == null) {
      await _service.addEntry(result);
    } else {
      await _service.updateEntry(result.copyWith(id: existing.id));
    }
  }

  /// [candidate] ile aynı gün + kesişen saat aralığında olup aynı antrenörü ya
  /// da aynı grubu paylaşan mevcut dersleri döndürür ([excludeId] hariç).
  List<ScheduleEntry> _findConflicts(
    ScheduleEntry candidate, {
    String? excludeId,
  }) {
    final start = _timeToMinutes(candidate.startTime);
    final end = _timeToMinutes(candidate.endTime);
    if (start == null || end == null) {
      return const [];
    }
    return _entries.where((e) {
      if (e.id == excludeId || e.day != candidate.day) {
        return false;
      }
      if (e.coachId != candidate.coachId && e.groupId != candidate.groupId) {
        return false;
      }
      final s = _timeToMinutes(e.startTime);
      final en = _timeToMinutes(e.endTime);
      if (s == null || en == null) {
        return false;
      }
      return start < en && s < end; // aralıklar kesişiyor mu
    }).toList();
  }

  Future<bool?> _confirmConflict(List<ScheduleEntry> conflicts) {
    final l10n = AppLocalizations.of(context);
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.scheduleConflictTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.scheduleConflictBody),
            const SizedBox(height: 8),
            for (final e in conflicts)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '• ${localizedDay(l10n, e.day)} ${e.startTime}–${e.endTime} · '
                  '${e.groupName} · ${e.coachName}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.scheduleSaveAnyway),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(ScheduleEntry entry) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.scheduleDeleteTitle),
        content: Text(l10n.scheduleDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await _service.deleteEntry(entry.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_month, size: 20),
            const SizedBox(width: 8),
            Text(l10n.scheduleTitle),
          ],
        ),
      ),
      floatingActionButton: widget.canManage
          ? FloatingActionButton.extended(
              onPressed: () => _openEditor(null),
              icon: const Icon(Icons.add),
              label: Text(l10n.scheduleAddTitle),
            )
          : null,
      body: Column(
        children: [
          _buildViewToggle(l10n),
          Expanded(
            child: StreamBuilder<List<ScheduleEntry>>(
              stream: _service.watchEntries(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return EmptyState(
                    icon: Icons.error_outline,
                    title: l10n.scheduleTitle,
                    message: l10n.scheduleLoadError,
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final entries = snapshot.data ?? const [];
                _entries = entries; // çakışma denetimi için önbelleğe al
                if (entries.isEmpty) {
                  return EmptyState(
                    icon: Icons.calendar_month,
                    title: l10n.scheduleEmptyTitle,
                    message: widget.canManage
                        ? l10n.scheduleEmptyBodyManage
                        : l10n.scheduleEmptyBody,
                  );
                }
                if (_view == _ScheduleView.day) {
                  return _buildDayView(l10n, entries);
                }
                return ListView(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
                  children: [
                    for (final day in kScheduleDays)
                      _buildDaySection(l10n, day, entries),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggle(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: SegmentedButton<_ScheduleView>(
        showSelectedIcon: false,
        style: SegmentedButton.styleFrom(
          visualDensity: VisualDensity.compact,
        ),
        segments: [
          ButtonSegment(
            value: _ScheduleView.week,
            icon: const Icon(Icons.view_week, size: 18),
            label: Text(l10n.scheduleViewWeek),
          ),
          ButtonSegment(
            value: _ScheduleView.day,
            icon: const Icon(Icons.view_day, size: 18),
            label: Text(l10n.scheduleViewDay),
          ),
        ],
        selected: {_view},
        onSelectionChanged: (selection) {
          setState(() => _view = selection.first);
        },
      ),
    );
  }

  Widget _buildDaySection(
    AppLocalizations l10n,
    String day,
    List<ScheduleEntry> allEntries,
  ) {
    final dayEntries = allEntries.where((e) => e.day == day).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    final isToday = kScheduleDays.indexOf(day) == _todayIndex;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 6),
          child: Row(
            children: [
              Text(
                localizedDay(l10n, day).toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: AppColors.primary,
                ),
              ),
              if (isToday) ...[
                const SizedBox(width: 8),
                _todayBadge(l10n),
              ],
            ],
          ),
        ),
        if (dayEntries.isEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 8, bottom: 4),
            child: Text(
              l10n.scheduleNoLesson,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        else
          for (final entry in dayEntries) _buildEntryCard(l10n, entry),
      ],
    );
  }

  Widget _buildEntryCard(AppLocalizations l10n, ScheduleEntry entry) {
    final groupLine = entry.branch.isNotEmpty
        ? '${entry.groupName} · ${entry.branch}'
        : entry.groupName;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: widget.canManage ? () => _openEditor(entry) : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      entry.startTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      entry.endTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupLine,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 14),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            entry.coachName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (widget.onTakeAttendance != null)
                IconButton(
                  tooltip: l10n.scheduleTakeAttendance,
                  icon: const Icon(Icons.fact_check_outlined),
                  color: AppColors.primary,
                  onPressed: () => widget.onTakeAttendance!(entry.groupId),
                ),
              if (widget.canManage)
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => _confirmDelete(entry),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// "Bugün" rozeti — bugünün gün başlığının yanında gösterilir.
  Widget _todayBadge(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        l10n.scheduleTodayLabel,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          color: Colors.white,
        ),
      ),
    );
  }

  // ---- Günlük ızgara görünümü ----

  /// "HH:MM" biçimini gün içi dakika sayısına çevirir (geçersizse null).
  int? _timeToMinutes(String value) {
    if (!value.contains(':')) {
      return null;
    }
    final parts = value.split(':');
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) {
      return null;
    }
    return hour * 60 + minute;
  }

  Widget _buildDayView(AppLocalizations l10n, List<ScheduleEntry> allEntries) {
    final day = kScheduleDays[_selectedDayIndex];
    final dayEntries = allEntries.where((e) => e.day == day).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
    return Column(
      children: [
        _buildDayStrip(l10n, allEntries),
        Expanded(
          child: dayEntries.isEmpty
              ? Center(
                  child: Text(
                    l10n.scheduleNoLesson,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              : _buildDayGrid(l10n, dayEntries),
        ),
      ],
    );
  }

  /// Üstteki gün seçici şerit: 7 gün yan yana, seçili gün vurgulu, o gün ders
  /// varsa altında küçük bir nokta.
  Widget _buildDayStrip(AppLocalizations l10n, List<ScheduleEntry> allEntries) {
    final busyDays = allEntries.map((e) => e.day).toSet();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      child: Row(
        children: [
          for (var i = 0; i < kScheduleDays.length; i++)
            Expanded(
              child: _dayStripCell(
                l10n,
                index: i,
                selected: i == _selectedDayIndex,
                hasLesson: busyDays.contains(kScheduleDays[i]),
              ),
            ),
        ],
      ),
    );
  }

  Widget _dayStripCell(
    AppLocalizations l10n, {
    required int index,
    required bool selected,
    required bool hasLesson,
  }) {
    final mutedColor = Theme.of(context).textTheme.bodySmall?.color;
    final isToday = index == _todayIndex;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: selected
            ? AppColors.primary.withValues(alpha: 0.14)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => setState(() => _selectedDayIndex = index),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Text(
                  localizedDayShort(l10n, kScheduleDays[index]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        (selected || isToday) ? FontWeight.w700 : FontWeight.w500,
                    // Bugün, seçili olmasa da vurgulanır.
                    color: (selected || isToday) ? AppColors.primary : mutedColor,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: hasLesson
                        ? (selected ? AppColors.primary : mutedColor)
                        : Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Seçili günün dikey zaman ızgarası: solda saat çizgileri, dersler süreye
  /// orantılı yükseklikte bloklar. Kaydırılabilir.
  Widget _buildDayGrid(AppLocalizations l10n, List<ScheduleEntry> dayEntries) {
    const gutter = 52.0;
    const pxPerHour = 72.0;
    const minBlockHeight = 48.0;

    // Izgara aralığını günün derslerine göre belirle (kenarlarda birer saat pay).
    var minStart = 24 * 60;
    var maxEnd = 0;
    for (final e in dayEntries) {
      final s = _timeToMinutes(e.startTime);
      final en = _timeToMinutes(e.endTime);
      if (s != null) {
        minStart = s < minStart ? s : minStart;
      }
      if (en != null) {
        maxEnd = en > maxEnd ? en : maxEnd;
      }
    }
    if (minStart >= maxEnd) {
      // Ayrıştırılamayan saatler için makul varsayılan.
      minStart = 8 * 60;
      maxEnd = 20 * 60;
    }
    final startHour = (minStart ~/ 60);
    final endHour = ((maxEnd + 59) ~/ 60);
    final totalHours = (endHour - startHour).clamp(1, 24);
    final gridStartMinutes = startHour * 60;
    final totalHeight = totalHours * pxPerHour;
    final muted = Theme.of(context).textTheme.bodySmall?.color;
    final lineColor = Theme.of(context).dividerColor;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 88),
      child: SizedBox(
        // Son saat etiketi taban çizgisinin altına düştüğü için biraz pay bırak.
        height: totalHeight + 20,
        child: Stack(
          children: [
            // Saat çizgileri + etiketleri.
            for (var h = startHour; h <= endHour; h++)
              Positioned(
                top: (h - startHour) * pxPerHour,
                left: 0,
                right: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: gutter,
                      child: Text(
                        '${h.toString().padLeft(2, '0')}:00',
                        style: TextStyle(fontSize: 11, color: muted),
                      ),
                    ),
                    Expanded(child: Container(height: 0.5, color: lineColor)),
                  ],
                ),
              ),
            // Ders blokları.
            for (final entry in dayEntries)
              _buildGridBlock(
                l10n,
                entry,
                gutter: gutter,
                pxPerHour: pxPerHour,
                minBlockHeight: minBlockHeight,
                gridStartMinutes: gridStartMinutes,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridBlock(
    AppLocalizations l10n,
    ScheduleEntry entry, {
    required double gutter,
    required double pxPerHour,
    required double minBlockHeight,
    required int gridStartMinutes,
  }) {
    final start = _timeToMinutes(entry.startTime) ?? gridStartMinutes;
    final end = _timeToMinutes(entry.endTime) ?? (start + 60);
    final top = (start - gridStartMinutes) / 60 * pxPerHour;
    final rawHeight = (end - start) / 60 * pxPerHour;
    final height = rawHeight < minBlockHeight ? minBlockHeight : rawHeight;
    final groupLine = entry.branch.isNotEmpty
        ? '${entry.groupName} · ${entry.branch}'
        : entry.groupName;
    final compact = height < 60;

    return Positioned(
      top: top,
      left: gutter + 4,
      right: 4,
      height: height,
      child: Material(
        color: AppColors.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: widget.canManage ? () => _openEditor(entry) : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${entry.startTime} – ${entry.endTime}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        groupLine,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (!compact)
                        Text(
                          entry.coachName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                    ],
                  ),
                ),
                if (widget.onTakeAttendance != null)
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 18,
                      tooltip: l10n.scheduleTakeAttendance,
                      icon: const Icon(Icons.fact_check_outlined),
                      color: AppColors.primary,
                      onPressed: () => widget.onTakeAttendance!(entry.groupId),
                    ),
                  ),
                if (widget.canManage)
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 18,
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _confirmDelete(entry),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Ders ekleme/düzenleme için alt sayfa (bottom sheet). Kendi durumunu yönetir;
/// Kaydet'e basınca oluşturulan [ScheduleEntry]'yi geri döndürür.
class _ScheduleEntrySheet extends StatefulWidget {
  final List<TrainingGroup> groups;
  final List<Coach> coaches;
  final ScheduleEntry? initial;

  const _ScheduleEntrySheet({
    required this.groups,
    required this.coaches,
    this.initial,
  });

  @override
  State<_ScheduleEntrySheet> createState() => _ScheduleEntrySheetState();
}

class _ScheduleEntrySheetState extends State<_ScheduleEntrySheet> {
  late String _day;
  late TimeOfDay _start;
  late TimeOfDay _end;
  late String _groupId;
  late String _coachId;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _day = initial != null && kScheduleDays.contains(initial.day)
        ? initial.day
        : kScheduleDays.first;
    _start = _parseTime(initial?.startTime) ?? const TimeOfDay(hour: 18, minute: 0);
    _end = _parseTime(initial?.endTime) ?? const TimeOfDay(hour: 19, minute: 0);

    final groupIds = widget.groups.map((g) => g.id).toSet();
    _groupId = initial != null && groupIds.contains(initial.groupId)
        ? initial.groupId
        : widget.groups.first.id;

    final coachIds = widget.coaches.map((c) => c.id).toSet();
    if (initial != null && coachIds.contains(initial.coachId)) {
      _coachId = initial.coachId;
    } else {
      // Yeni oturumda antrenörü grubun antrenörüyle başlat (varsa).
      final group = _groupById(_groupId);
      _coachId = group != null && coachIds.contains(group.coachId)
          ? group.coachId
          : widget.coaches.first.id;
    }
  }

  TimeOfDay? _parseTime(String? value) {
    if (value == null || !value.contains(':')) {
      return null;
    }
    final parts = value.split(':');
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) {
      return null;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  String _formatTime(TimeOfDay time) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(time.hour)}:${two(time.minute)}';
  }

  TrainingGroup? _groupById(String id) {
    for (final group in widget.groups) {
      if (group.id == id) {
        return group;
      }
    }
    return null;
  }

  Coach? _coachById(String id) {
    for (final coach in widget.coaches) {
      if (coach.id == id) {
        return coach;
      }
    }
    return null;
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _start : _end,
    );
    if (picked == null) {
      return;
    }
    setState(() {
      if (isStart) {
        _start = picked;
      } else {
        _end = picked;
      }
    });
  }

  void _save() {
    final group = _groupById(_groupId);
    final coach = _coachById(_coachId);
    if (group == null || coach == null) {
      return;
    }
    Navigator.pop(
      context,
      ScheduleEntry(
        id: widget.initial?.id ?? '',
        day: _day,
        startTime: _formatTime(_start),
        endTime: _formatTime(_end),
        groupId: group.id,
        groupName: group.name,
        branch: group.branch,
        coachId: coach.id,
        coachName: coach.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.initial == null
                  ? l10n.scheduleAddTitle
                  : l10n.scheduleEditTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _day,
              decoration: InputDecoration(
                labelText: l10n.scheduleDayLabel,
                border: const OutlineInputBorder(),
              ),
              items: [
                for (final day in kScheduleDays)
                  DropdownMenuItem(value: day, child: Text(localizedDay(l10n, day))),
              ],
              onChanged: (value) => setState(() => _day = value ?? _day),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _TimeField(
                    label: l10n.scheduleStartLabel,
                    value: _formatTime(_start),
                    onTap: () => _pickTime(true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TimeField(
                    label: l10n.scheduleEndLabel,
                    value: _formatTime(_end),
                    onTap: () => _pickTime(false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _groupId,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: l10n.scheduleGroupLabel,
                border: const OutlineInputBorder(),
              ),
              items: [
                for (final group in widget.groups)
                  DropdownMenuItem(value: group.id, child: Text(group.name)),
              ],
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  _groupId = value;
                  // Grup değişince antrenörü grubun antrenörüne getir (varsa).
                  final group = _groupById(value);
                  final coachIds = widget.coaches.map((c) => c.id).toSet();
                  if (group != null && coachIds.contains(group.coachId)) {
                    _coachId = group.coachId;
                  }
                });
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _coachId,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: l10n.scheduleCoachLabel,
                border: const OutlineInputBorder(),
              ),
              items: [
                for (final coach in widget.coaches)
                  DropdownMenuItem(value: coach.id, child: Text(coach.name)),
              ],
              onChanged: (value) => setState(() => _coachId = value ?? _coachId),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: Text(l10n.commonSave),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Saat seçici alan: dokununca [showTimePicker] açan salt-okunur bir kutu.
class _TimeField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _TimeField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.schedule),
        ),
        child: Text(value),
      ),
    );
  }
}
