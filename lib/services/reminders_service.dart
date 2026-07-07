import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Kullanıcının Ana Panel'de tuttuğu kişisel bir hatırlatıcı.
class Reminder {
  final String id;
  final String text;

  /// İsteğe bağlı görüntü tarihi (yoksa boş).
  final String dateText;

  const Reminder({required this.id, required this.text, this.dateText = ''});

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'dateText': dateText,
  };

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
    id: json['id'] ?? '',
    text: json['text'] ?? '',
    dateText: json['dateText'] ?? '',
  );
}

/// Kişisel "Hızlı Hatırlatıcılar" listesini cihazda saklayan servis.
///
/// Kullanıcıya özel notlar olduğundan sunucuya değil [SharedPreferences]'a
/// yazılır (uid bazlı anahtar). Böylece Firestore koleksiyonu/kural gerekmez ve
/// tamamen ücretsizdir; not yalnızca bu cihazda görünür.
class RemindersService {
  static const String _keyPrefix = 'quickReminders_';

  String _key(String userId) => '$_keyPrefix$userId';

  Future<List<Reminder>> load(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key(userId)) ?? const <String>[];
    return raw
        .map((item) => Reminder.fromJson(jsonDecode(item) as Map<String, dynamic>))
        .toList();
  }

  Future<void> _persist(String userId, List<Reminder> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _key(userId),
      items.map((reminder) => jsonEncode(reminder.toJson())).toList(),
    );
  }

  /// Yeni hatırlatıcıyı başa ekler ve güncel listeyi döner.
  Future<List<Reminder>> add(String userId, Reminder reminder) async {
    final items = await load(userId);
    items.insert(0, reminder);
    await _persist(userId, items);
    return items;
  }

  /// Verilen hatırlatıcıyı siler ve güncel listeyi döner.
  Future<List<Reminder>> remove(String userId, String id) async {
    final items = await load(userId);
    items.removeWhere((reminder) => reminder.id == id);
    await _persist(userId, items);
    return items;
  }
}
