import 'package:flutter/material.dart';

/// Ana Panel'deki başlıklı özet bölümü (ör. "Yoklama Özeti").
///
/// Üst satırda ikon + başlık, isteğe bağlı sağda bir eylem ("Tümü"); altta
/// serbest [child] içerik. Mevcut [Card] temasıyla uyumludur.
class SummarySection extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? iconColor;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget child;

  const SummarySection({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.actionLabel,
    this.onAction,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? Theme.of(context).colorScheme.primary;
    final hasAction = actionLabel != null && onAction != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 14, hasAction ? 8 : 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                if (hasAction)
                  TextButton(onPressed: onAction, child: Text(actionLabel!)),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsetsDirectional.only(end: hasAction ? 8 : 0),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

/// Bir özet metriği: büyük değer + küçük etiket + renk.
class SummaryMetric {
  final String value;
  final String label;
  final Color color;

  const SummaryMetric({
    required this.value,
    required this.label,
    required this.color,
  });
}

/// Bir oran çubuğu segmenti: ağırlık (değer) + renk.
class SummaryBarSegment {
  final num value;
  final Color color;

  const SummaryBarSegment({required this.value, required this.color});
}

/// Metriklerin oranını gösteren ince, yuvarlatılmış yığılı çubuk. Örn. yoklama
/// için gelen/gelmeyen, finans için tahsil/bekleyen/geciken payı. Değeri 0 olan
/// segment gizlenir; toplam 0 ise nötr bir zemin gösterir.
class SummaryBar extends StatelessWidget {
  final List<SummaryBarSegment> segments;
  final double height;

  const SummaryBar({super.key, required this.segments, this.height = 8});

  @override
  Widget build(BuildContext context) {
    final total = segments.fold<double>(0, (sum, s) => sum + s.value);
    final radius = BorderRadius.circular(height / 2);

    if (total <= 0) {
      return Container(
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: radius,
        ),
      );
    }

    final parts = <Widget>[];
    for (final segment in segments) {
      if (segment.value <= 0) {
        continue;
      }
      // Alt piksel yuvarlamada segmentlerin kaybolmaması için 1000'lik ölçek.
      final flex = (segment.value / total * 1000).round().clamp(1, 1000);
      parts.add(Expanded(flex: flex, child: ColoredBox(color: segment.color)));
    }

    return ClipRRect(
      borderRadius: radius,
      child: SizedBox(
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: parts,
        ),
      ),
    );
  }
}

/// [SummaryMetric] listesini dikey ayraçlarla yatay dizen satır. Değerler
/// taşmayı önlemek için ölçeklenir.
class SummaryMetricsRow extends StatelessWidget {
  final List<SummaryMetric> metrics;

  const SummaryMetricsRow({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    final labelColor = Theme.of(context).textTheme.bodySmall?.color;
    final children = <Widget>[];

    for (var i = 0; i < metrics.length; i++) {
      if (i > 0) {
        children.add(
          Container(
            width: 1,
            height: 36,
            color: Theme.of(context).dividerColor,
          ),
        );
      }
      final metric = metrics[i];
      children.add(
        Expanded(
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  metric.value,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: metric.color,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              // Dar sütunda uzun etiketlerin (ör. Rusça "Присутствовал")
              // kesilmemesi için değer gibi ölçekleyerek küçült.
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  metric.label,
                  maxLines: 1,
                  style: TextStyle(fontSize: 12, color: labelColor),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: children);
  }
}

/// Ana Panel üst sırasındaki sayaç kutucuğu (ör. Öğrenci / Antrenör / Grup).
///
/// Üstte renkli bir vurgu şeridi, altında renkli daire içinde ikon, büyük sayı
/// ve etiket. Dokunulabilir.
class StatTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color accent;
  final VoidCallback? onTap;

  /// Etikete ek küçük bir dikkat rozeti (ör. "1 yeni"). Yalnızca gerçekten
  /// vurgulanacak bir şey varken verilir; boşsa gösterilmez.
  final String? note;

  const StatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.accent,
    this.onTap,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(height: 4, color: accent),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: accent.withValues(alpha: 0.14),
                    child: Icon(icon, color: accent, size: 22),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  if (note != null) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        note!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: accent,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
