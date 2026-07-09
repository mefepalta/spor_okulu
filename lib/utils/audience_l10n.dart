import '../constants/app_roles.dart';
import '../l10n/app_localizations.dart';

/// Duyuru hedef kitlesi Firestore'da Türkçe değerle saklanır
/// ([AnnouncementAudience]). Bu yardımcı yalnızca gösterim için çevirir;
/// öğrenci/antrenör/veli için mevcut menü anahtarları yeniden kullanılır.
String localizedAudience(AppLocalizations l10n, String audience) {
  switch (audience) {
    case AnnouncementAudience.everyone:
      return l10n.audienceEveryone;
    case AnnouncementAudience.students:
      return l10n.navStudents;
    case AnnouncementAudience.coaches:
      return l10n.navCoaches;
    case AnnouncementAudience.parents:
      return l10n.navParents;
    default:
      return audience;
  }
}
