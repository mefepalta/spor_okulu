import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../widgets/empty_state.dart';
import '../widgets/wave_background.dart';

/// Bildirim merkezinde gösterilen tek bir bildirim.
///
/// Kalıcı bir koleksiyon değildir: uygulamada zaten yüklü olan veriden
/// (duyurular, ödenmemiş ödemeler, devamsızlıklar) türetilir.
class AppNotification {
  /// Filtre sekmelerinde kullanılan kategori etiketi (ör. "Duyuru", "Ödeme").
  final String category;
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String dateText;
  final VoidCallback? onTap;

  const AppNotification({
    required this.category,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    this.dateText = '',
    this.onTap,
  });
}

/// Çan ikonunun açtığı bildirim merkezi.
///
/// Bildirimleri kategoriye göre süzülebilen bir liste hâlinde gösterir. Veriler
/// [DashboardScreen] tarafından mevcut kayıtlardan türetilip verilir.
class NotificationsScreen extends StatefulWidget {
  final List<AppNotification> notifications;

  const NotificationsScreen({super.key, required this.notifications});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  /// Seçili kategori; `null` ise tümü gösterilir.
  String? _categoryFilter;

  List<String> get _categories {
    final seen = <String>[];
    for (final notification in widget.notifications) {
      if (!seen.contains(notification.category)) {
        seen.add(notification.category);
      }
    }
    return seen;
  }

  List<AppNotification> get _filtered {
    if (_categoryFilter == null) {
      return widget.notifications;
    }
    return widget.notifications
        .where((notification) => notification.category == _categoryFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final categories = _categories;
    final filtered = _filtered;

    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.notificationsTooltip)),
      body: widget.notifications.isEmpty
          ? EmptyState(
              icon: Icons.notifications_none,
              title: l10n.notificationsEmptyTitle,
              message: l10n.notificationsEmptyBody,
            )
          : Column(
              children: [
                if (categories.length > 1) _buildFilters(categories),
                Expanded(
                  child: filtered.isEmpty
                      ? EmptyState(
                          icon: Icons.filter_alt_off,
                          title: l10n.noRecordsTitle,
                          message: l10n.noNotificationsInCategory,
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) =>
                              _buildTile(filtered[index]),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildFilters(List<String> categories) {
    Widget chip(String label, String? value) {
      final selected = _categoryFilter == value;
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: FilterChip(
          label: Text(label),
          selected: selected,
          showCheckmark: false,
          onSelected: (_) => setState(() => _categoryFilter = value),
        ),
      );
    }

    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          chip(AppLocalizations.of(context).commonAll, null),
          for (final category in categories) chip(category, category),
        ],
      ),
    );
  }

  Widget _buildTile(AppNotification notification) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: notification.color.withValues(alpha: 0.14),
          child: Icon(notification.icon, color: notification.color),
        ),
        title: Text(
          notification.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (notification.subtitle.isNotEmpty)
              Text(
                notification.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            if (notification.dateText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  notification.dateText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ),
          ],
        ),
        trailing: notification.onTap == null
            ? null
            : const Icon(Icons.chevron_right),
        onTap: notification.onTap,
      ),
    );
  }
}
