import '../l10n/app_localizations.dart';

/// Haftanın günü ([ScheduleEntry.day] içinde) veritabanında Türkçe (ASCII)
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
