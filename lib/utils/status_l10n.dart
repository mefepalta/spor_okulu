import '../l10n/app_localizations.dart';
import '../models/app_models.dart';

/// Ödeme durumu ([PaymentRecord.status]) veritabanında Türkçe saklanır
/// ('Ödendi'/'Bekliyor'/'Gecikti'); bu yardımcı yalnızca **gösterim** için o
/// anki dile çevirir. Saklanan/karşılaştırılan değerler değişmez.
String localizedPaymentStatus(AppLocalizations l10n, String status) {
  switch (status) {
    case 'Ödendi':
      return l10n.statusPaid;
    case 'Bekliyor':
      return l10n.statusPending;
    case 'Gecikti':
      return l10n.statusOverdue;
    default:
      return status;
  }
}

/// Mazeret/izin durumu ([LeaveStatus]) veritabanında Türkçe saklanır
/// ('Beklemede'/'Onaylandı'/'Reddedildi'); bu yardımcı yalnızca gösterim için
/// çevirir.
String localizedLeaveStatus(AppLocalizations l10n, String status) {
  switch (status) {
    case LeaveStatus.pending:
      return l10n.leaveStatusPending;
    case LeaveStatus.approved:
      return l10n.leaveStatusApproved;
    case LeaveStatus.rejected:
      return l10n.leaveStatusRejected;
    default:
      return status;
  }
}
