import '../l10n/app_localizations.dart';
import '../models/app_models.dart';

/// Ekipman durumu Firestore'da Türkçe değerle saklanır ([EquipmentCondition]).
/// Bu yardımcı yalnızca gösterim için çevirir; saklanan değer Türkçe kalır.
String localizedCondition(AppLocalizations l10n, String condition) {
  switch (condition) {
    case EquipmentCondition.good:
      return l10n.conditionGood;
    case EquipmentCondition.maintenance:
      return l10n.conditionMaintenance;
    case EquipmentCondition.worn:
      return l10n.conditionWorn;
    default:
      return condition;
  }
}
