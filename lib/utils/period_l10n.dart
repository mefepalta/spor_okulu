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

/// Metni büyük/küçük harf ve Türkçe karakter (ı/İ/ş/ğ/ü/ö/ç) farklarına
/// duyarsız hale getirir. Elle girilen dönemlerde "Hazıran" (noktasız ı) gibi
/// yazımlar olabildiğinden eşleştirme bunun üzerinden yapılır. Her karakter
/// birebir tek karaktere eşlendiğinden dizideki konum (index) korunur.
String _normalize(String input) {
  const map = {
    'İ': 'i', 'I': 'i', 'ı': 'i', 'î': 'i', 'Î': 'i',
    'Ş': 's', 'ş': 's',
    'Ğ': 'g', 'ğ': 'g',
    'Ü': 'u', 'ü': 'u', 'û': 'u', 'Û': 'u',
    'Ö': 'o', 'ö': 'o',
    'Ç': 'c', 'ç': 'c',
    'Â': 'a', 'â': 'a',
  };
  final buffer = StringBuffer();
  for (final ch in input.split('')) {
    final mapped = map[ch];
    buffer.write(mapped ?? ch.toLowerCase());
  }
  return buffer.toString();
}

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
  final normalizedPeriod = _normalize(period);
  for (var i = 0; i < _turkishMonths.length; i++) {
    final normalizedMonth = _normalize(_turkishMonths[i]);
    final index = normalizedPeriod.indexOf(normalizedMonth);
    if (index >= 0) {
      // _normalize karakter sayısını korur; aynı aralık ham metinde de geçerli.
      return period.replaceRange(index, index + normalizedMonth.length, localized[i]);
    }
  }
  return period;
}
