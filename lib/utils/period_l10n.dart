import '../l10n/app_localizations.dart';

/// Ödeme dönemi ("Haziran 2026") Firestore'da Türkçe ay adıyla saklanır.
/// Bu yardımcı yalnızca GÖSTERİM için, metindeki Türkçe ay adını geçerli dile
/// çevirir; yılı ve diğer kısımları korur. Filtre/eşleştirme değeri ham kalır.
const List<String> _turkishMonths = [
  'Ocak',
  'Şubat',
  'Mart',
  'Nisan',
  'Mayıs',
  'Haziran',
  'Temmuz',
  'Ağustos',
  'Eylül',
  'Ekim',
  'Kasım',
  'Aralık',
];

String localizedPeriod(AppLocalizations l10n, String period) {
  if (period.isEmpty) {
    return period;
  }
  final localized = [
    l10n.monthJanuary,
    l10n.monthFebruary,
    l10n.monthMarch,
    l10n.monthApril,
    l10n.monthMay,
    l10n.monthJune,
    l10n.monthJuly,
    l10n.monthAugust,
    l10n.monthSeptember,
    l10n.monthOctober,
    l10n.monthNovember,
    l10n.monthDecember,
  ];
  var result = period;
  for (var i = 0; i < _turkishMonths.length; i++) {
    if (result.contains(_turkishMonths[i])) {
      result = result.replaceAll(_turkishMonths[i], localized[i]);
      break; // bir dönemde tek ay adı bulunur
    }
  }
  return result;
}
