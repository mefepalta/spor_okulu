import '../l10n/app_localizations.dart';

/// Performans ölçütleri Firestore'da Türkçe anahtarla saklanır
/// ([PerformanceMetrics.all]). Bu yardımcı yalnızca gösterim için çevirir;
/// saklanan değer Türkçe kalır.
String localizedMetric(AppLocalizations l10n, String metric) {
  switch (metric) {
    case 'Sıçrama':
      return l10n.metricJump;
    case 'Sürat':
      return l10n.metricSpeed;
    case 'Dayanıklılık':
      return l10n.metricEndurance;
    case 'Esneklik':
      return l10n.metricFlexibility;
    case 'Top Hakimiyeti':
      return l10n.metricBallControl;
    default:
      return metric;
  }
}
