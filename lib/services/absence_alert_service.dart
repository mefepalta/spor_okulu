import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_models.dart';

/// Velinin çocuğuna ait "Gelmedi" yoklama olaylarından okunmamış devamsızlık
/// uyarısı türetir.
///
/// Yeni bir Firestore koleksiyonu ya da sunucu tetikleyicisi gerektirmez:
/// uyarılar zaten yüklenen yoklama kayıtlarından ([AttendanceRecord]) hesaplanır,
/// "görüldü" durumu yalnızca [SharedPreferences] ile bu cihazda saklanır. Bu
/// yüzden okundu bilgisi cihaza özeldir (cihazlar arası senkron yoktur).
class AbsenceAlertService {
  static const String _keyPrefix = 'seenAbsenceKeys_';

  String _prefsKey(String userId) => '$_keyPrefix$userId';

  /// Bir devamsızlık olayının kararlı kimliği: (kayıt, öğrenci) çifti.
  ///
  /// Kaydın kalıcı [AttendanceRecord.id] değeri varsa onu; yoksa eski kayıtlar
  /// için tarih + grup bilgisinden türetilmiş bir anahtar kullanılır.
  static String eventKey(AttendanceRecord record, String studentId) {
    final base = record.id.isNotEmpty
        ? record.id
        : '${record.dateText}|${record.groupId}|${record.groupName}';
    return '$base#$studentId';
  }

  /// [records] içinde [children]'dan herhangi birinin "Gelmedi" olduğu tüm
  /// devamsızlık olaylarının anahtarları.
  static List<String> absenceKeys(
    List<AttendanceRecord> records,
    List<Student> children,
  ) {
    final keys = <String>[];
    for (final record in records) {
      for (final child in children) {
        if (record.absentStudentIds.contains(child.id)) {
          keys.add(eventKey(record, child.id));
        }
      }
    }
    return keys;
  }

  Future<Set<String>> _loadSeen(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_prefsKey(userId)) ?? const <String>[]).toSet();
  }

  /// Bu velinin henüz görmediği (bu cihazda) devamsızlık sayısı.
  Future<int> unreadCount({
    required String userId,
    required List<AttendanceRecord> records,
    required List<Student> children,
  }) async {
    final keys = absenceKeys(records, children);
    if (keys.isEmpty) {
      return 0;
    }
    final seen = await _loadSeen(userId);
    return keys.where((key) => !seen.contains(key)).length;
  }

  /// Mevcut tüm devamsızlık olaylarını "görüldü" olarak işaretler.
  ///
  /// Yalnızca hâlâ var olan kayıtların anahtarlarını saklar; böylece silinen
  /// kayıtların anahtarları düşer ve liste zamanla şişmez.
  Future<void> markAllSeen({
    required String userId,
    required List<AttendanceRecord> records,
    required List<Student> children,
  }) async {
    final keys = absenceKeys(records, children).toSet().toList();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey(userId), keys);
  }
}
