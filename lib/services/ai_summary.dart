import '../models/app_models.dart';

/// SporTekAi'ye gönderilecek **anonim** kulüp özetini üretir.
///
/// Yalnızca sayısal/toplu bilgiler döner; öğrenci/veli adı, telefon gibi ham
/// kişisel veri **içermez** (KVKK). Model bu özeti bağlam olarak kullanır.
class AiSummary {
  AiSummary._();

  static String buildStaffSummary({
    required bool isAdmin,
    required int studentCount,
    required int coachCount,
    required int groupCount,
    required List<AttendanceRecord> attendance,
    required List<PaymentRecord> payments,
    required List<CashTransaction> cash,
    required List<EquipmentItem> equipment,
    required int pendingLeaveCount,
  }) {
    final lines = <String>[];
    lines.add('Kulüp güncel durum özeti (anonim):');
    lines.add(
      '- Kadro: $studentCount öğrenci, $coachCount antrenör, $groupCount grup.',
    );

    // Yoklama
    var present = 0;
    var absent = 0;
    final absencesByStudent = <String, int>{};
    for (final record in attendance) {
      present += record.presentStudentIds.isNotEmpty
          ? record.presentStudentIds.length
          : record.presentStudentNames.length;
      final absentKeys = record.absentStudentIds.isNotEmpty
          ? record.absentStudentIds
          : record.absentStudentNames;
      absent += absentKeys.length;
      for (final key in absentKeys) {
        absencesByStudent[key] = (absencesByStudent[key] ?? 0) + 1;
      }
    }
    final totalMarks = present + absent;
    if (totalMarks > 0) {
      final rate = (present / totalMarks * 100).round();
      final riskyCount =
          absencesByStudent.values.where((count) => count >= 3).length;
      lines.add(
        '- Yoklama: ${attendance.length} kayıt, ortalama katılım %$rate '
        '($present geldi, $absent gelmedi). '
        '3+ devamsızlığı olan öğrenci sayısı: $riskyCount.',
      );
    } else {
      lines.add('- Yoklama: henüz kayıt yok.');
    }

    // Ödemeler
    if (payments.isNotEmpty) {
      final collected = _sum(payments, 'Ödendi');
      final waiting = _sum(payments, 'Bekliyor');
      final overdue = _sum(payments, 'Gecikti');
      final overdueCount = payments.where((p) => p.status == 'Gecikti').length;
      lines.add(
        '- Ödemeler: tahsil $collected TL, bekleyen $waiting TL, '
        'geciken $overdue TL ($overdueCount kayıt).',
      );
    } else {
      lines.add('- Ödemeler: henüz kayıt yok.');
    }

    // Kasa (yalnızca admin)
    if (isAdmin) {
      if (cash.isNotEmpty) {
        final income = cash
            .where((t) => t.isIncome)
            .fold(0, (s, t) => s + t.amount);
        final expense = cash
            .where((t) => !t.isIncome)
            .fold(0, (s, t) => s + t.amount);
        lines.add(
          '- Kasa: bakiye ${income - expense} TL '
          '(gelir $income TL, gider $expense TL).',
        );
      } else {
        lines.add('- Kasa: henüz hareket yok.');
      }
    }

    // Depo
    if (equipment.isNotEmpty) {
      final totalQty = equipment.fold(0, (s, e) => s + e.quantity);
      final attention = equipment
          .where((e) => e.condition != EquipmentCondition.good)
          .length;
      lines.add(
        '- Depo: ${equipment.length} çeşit, toplam $totalQty adet, '
        'bakım/dikkat gereken $attention kalem.',
      );
    }

    // Mazeret
    if (pendingLeaveCount > 0) {
      lines.add('- Bekleyen mazeret talebi: $pendingLeaveCount.');
    }

    return lines.join('\n');
  }

  /// Veli için **anonim** çocuk-odaklı özet. Yalnızca velinin kendi
  /// çocuk(lar)ına dair toplu bilgiler; ad/telefon içermez.
  static String buildParentSummary({
    required int childCount,
    required List<AttendanceRecord> attendance,
    required List<PaymentRecord> payments,
    required List<PerformanceRecord> performance,
    required int eventCount,
    required int pendingLeaveCount,
  }) {
    final lines = <String>[];
    lines.add('Velinin çocuk(lar)ına dair güncel durum (anonim):');
    lines.add('- Takip edilen çocuk sayısı: $childCount.');

    var present = 0;
    var absent = 0;
    for (final record in attendance) {
      present += record.presentStudentIds.isNotEmpty
          ? record.presentStudentIds.length
          : record.presentStudentNames.length;
      absent += record.absentStudentIds.isNotEmpty
          ? record.absentStudentIds.length
          : record.absentStudentNames.length;
    }
    final totalMarks = present + absent;
    if (totalMarks > 0) {
      final rate = (present / totalMarks * 100).round();
      lines.add(
        '- Yoklama: ${attendance.length} kayıt, katılım %$rate '
        '($present geldi, $absent gelmedi).',
      );
    } else {
      lines.add('- Yoklama: henüz kayıt yok.');
    }

    if (payments.isNotEmpty) {
      final paid = _sum(payments, 'Ödendi');
      final waiting = _sum(payments, 'Bekliyor');
      final overdue = _sum(payments, 'Gecikti');
      lines.add(
        '- Ödemeler: ödenen $paid TL, bekleyen $waiting TL, '
        'geciken $overdue TL.',
      );
    } else {
      lines.add('- Ödemeler: henüz kayıt yok.');
    }

    if (performance.isNotEmpty) {
      lines.add('- Performans: ${performance.length} değerlendirme kaydı var.');
    }
    if (eventCount > 0) {
      lines.add('- Planlı etkinlik sayısı: $eventCount.');
    }
    if (pendingLeaveCount > 0) {
      lines.add('- Bekleyen mazeret talebi: $pendingLeaveCount.');
    }

    return lines.join('\n');
  }

  static int _sum(List<PaymentRecord> payments, String status) => payments
      .where((p) => p.status == status)
      .fold(0, (total, p) => total + p.amount);
}
