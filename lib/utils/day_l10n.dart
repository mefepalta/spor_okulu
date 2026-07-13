import '../l10n/app_localizations.dart';

/// Haftanın günü ([TrainingGroup.schedule] içinde) veritabanında Türkçe (ASCII)
/// saklanır: 'Pazartesi','Sali','Carsamba','Persembe','Cuma','Cumartesi',
/// 'Pazar'. Bu yardımcılar yalnızca **gösterim** için o anki dile çevirir;
/// saklanan/karşılaştırılan değerler değişmez.
String localizedDay(AppLocalizations l10n, String day) {
  switch (day) {
    case 'Pazartesi':
      return l10n.dayMonday;
    case 'Sali':
      return l10n.dayTuesday;
    case 'Carsamba':
      return l10n.dayWednesday;
    case 'Persembe':
      return l10n.dayThursday;
    case 'Cuma':
      return l10n.dayFriday;
    case 'Cumartesi':
      return l10n.daySaturday;
    case 'Pazar':
      return l10n.daySunday;
    default:
      return day;
  }
}

/// Günün kısa (3 harflik) etiketi — günlük ızgara görünümündeki gün şeridi
/// gibi dar yerlerde kullanılır (7 gün yan yana sığsın diye).
String localizedDayShort(AppLocalizations l10n, String day) {
  switch (day) {
    case 'Pazartesi':
      return l10n.dayShortMon;
    case 'Sali':
      return l10n.dayShortTue;
    case 'Carsamba':
      return l10n.dayShortWed;
    case 'Persembe':
      return l10n.dayShortThu;
    case 'Cuma':
      return l10n.dayShortFri;
    case 'Cumartesi':
      return l10n.dayShortSat;
    case 'Pazar':
      return l10n.dayShortSun;
    default:
      return day;
  }
}

/// "Pazartesi 18:00" gibi bir program metnindeki gün kısmını çevirir; saat
/// kısmı olduğu gibi kalır.
String localizedSchedule(AppLocalizations l10n, String schedule) {
  final trimmed = schedule.trim();
  if (trimmed.isEmpty) {
    return trimmed;
  }
  final spaceIndex = trimmed.indexOf(' ');
  if (spaceIndex < 0) {
    return localizedDay(l10n, trimmed);
  }
  final day = trimmed.substring(0, spaceIndex);
  final rest = trimmed.substring(spaceIndex);
  return '${localizedDay(l10n, day)}$rest';
}
