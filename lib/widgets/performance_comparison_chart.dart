import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants/app_roles.dart';
import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../utils/metric_l10n.dart';

/// Bir öğrencinin farklı tarihlerdeki performans puanlarını, ölçütler bazında
/// gruplanmış çubuklarla karşılaştırır. Her tarih ayrı renkte bir seridir.
class PerformanceComparisonChart extends StatelessWidget {
  /// Aynı öğrenciye ait, tarihe göre eskiden yeniye sıralı kayıtlar.
  final List<PerformanceRecord> records;

  const PerformanceComparisonChart({super.key, required this.records});

  static const List<Color> _seriesColors = [
    Color(0xFFEF8354),
    Color(0xFF6DAF8E),
    Color(0xFFF2B134),
    Color(0xFF4F86C6),
    Color(0xFF9B5DE5),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final metrics = PerformanceMetrics.all;
    final maxScore = PerformanceMetrics.maxScore.toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Legend(records: records, colors: _seriesColors),
        const SizedBox(height: 16),
        SizedBox(
          height: 260,
          child: BarChart(
            BarChartData(
              maxY: maxScore,
              minY: 0,
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final metric = metrics[group.x];
                    return BarTooltipItem(
                      '${localizedMetric(l10n, metric)}\n${rod.toY.round()}',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 25,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.round().toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 46,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= metrics.length) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SizedBox(
                          width: 60,
                          child: Text(
                            localizedMetric(l10n, metrics[index]),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 25,
              ),
              borderData: FlBorderData(show: false),
              barGroups: _buildBarGroups(metrics),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups(List<String> metrics) {
    return List.generate(metrics.length, (metricIndex) {
      final metric = metrics[metricIndex];

      final rods = List.generate(records.length, (recordIndex) {
        final record = records[recordIndex];
        final value = (record.scores[metric] ?? 0).toDouble();

        return BarChartRodData(
          toY: value,
          color: _seriesColors[recordIndex % _seriesColors.length],
          width: records.length > 3 ? 7 : 12,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(3),
            topRight: Radius.circular(3),
          ),
        );
      });

      return BarChartGroupData(
        x: metricIndex,
        barRods: rods,
        barsSpace: 3,
      );
    });
  }
}

class _Legend extends StatelessWidget {
  final List<PerformanceRecord> records;
  final List<Color> colors;

  const _Legend({required this.records, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: List.generate(records.length, (index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              records[index].dateText,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        );
      }),
    );
  }
}
