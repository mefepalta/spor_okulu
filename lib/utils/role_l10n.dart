import '../constants/app_roles.dart';
import '../l10n/app_localizations.dart';

/// Bir rol kodunun ([AppRoles]) o anki dildeki etiketini döndürür.
///
/// Rollerin ikon ve renkleri [AppRoleLabels] içinde (dilden bağımsız) kalır;
/// yalnızca metin çevirisi buradan gelir.
String localizedRole(AppLocalizations l10n, String role) {
  switch (role) {
    case AppRoles.admin:
      return l10n.roleAdmin;
    case AppRoles.coach:
      return l10n.roleCoach;
    case AppRoles.parent:
      return l10n.roleParent;
    case AppRoles.student:
      return l10n.roleStudent;
    case AppRoles.viewer:
      return l10n.roleViewer;
    default:
      return l10n.roleUnknown;
  }
}
