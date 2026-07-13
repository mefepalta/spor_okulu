import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Günlük giriş serisi (streak). users/{uid} belgesinde tutulur:
/// `currentStreak`, `longestStreak`, `lastActiveDate` ("yyyy-MM-dd", yerel gün).
/// Yalnızca kozmetiktir (ana ekran göstergesi + global chat renk/rozet).
class StreakService {
  StreakService({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  String _dateKey(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${d.year}-${two(d.month)}-${two(d.day)}';
  }

  /// Bugünkü girişi işler ve güncel seriyi döndürür. Gün değişmediyse yazma
  /// yapmaz. Dün girildiyse +1, ara verildiyse 1'e sıfırlanır. Hata olursa 0
  /// döner (kozmetik özellik; giriş/açılış akışını bozmamalı).
  Future<int> recordVisit() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      return 0;
    }
    try {
      final ref = _firestore.collection('users').doc(uid);
      final snap = await ref.get();
      final data = snap.data() ?? <String, dynamic>{};

      final today = DateTime.now();
      final todayKey = _dateKey(today);
      final lastKey = data['lastActiveDate'] as String?;
      var current = (data['currentStreak'] as num?)?.toInt() ?? 0;
      var longest = (data['longestStreak'] as num?)?.toInt() ?? 0;

      if (lastKey == todayKey) {
        return current < 1 ? 1 : current; // bugün zaten işlenmiş
      }

      final yesterdayKey = _dateKey(today.subtract(const Duration(days: 1)));
      current = (lastKey == yesterdayKey) ? current + 1 : 1;
      if (current > longest) {
        longest = current;
      }

      await ref.set({
        'currentStreak': current,
        'longestStreak': longest,
        'lastActiveDate': todayKey,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      return current;
    } catch (_) {
      return 0;
    }
  }
}
