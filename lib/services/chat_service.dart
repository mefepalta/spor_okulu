import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/app_models.dart';

/// Kulüp genel sohbeti (tek oda) servisi.
///
/// Mesajlar `chatMessages` koleksiyonunda tutulur; en yeni [_limit] mesaj
/// gerçek zamanlı dinlenir. Avatarlar mesajda değil, `users/{uid}.photoBase64`
/// içinde durur ve gönderen başına bir kez okunup önbelleğe alınır — bu sayede
/// ücretsiz Firestore kotası (depolama + bant genişliği) korunur.
class ChatService {
  ChatService({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  static const String _collection = 'chatMessages';
  static const int _limit = 50;

  /// Mesaj metni için üst sınır (güvenlik kuralıyla da doğrulanır).
  static const int maxLength = 1000;

  String? get currentUid => _auth.currentUser?.uid;

  CollectionReference<Map<String, dynamic>> get _messages {
    return _firestore.collection(_collection);
  }

  /// En yeni [_limit] mesajı eskiden yeniye sıralı akış olarak döndürür
  /// (liste altta en yeni olacak şekilde gösterilir).
  Stream<List<ChatMessage>> watchMessages() {
    return _messages
        .orderBy('createdAt', descending: true)
        .limit(_limit)
        .snapshots()
        .map((snapshot) {
          final list = snapshot.docs
              .map((doc) => ChatMessage.fromJson(doc.id, doc.data()))
              .toList();
          // En eski üstte olacak biçimde ters çevir.
          return list.reversed.toList();
        });
  }

  /// Yeni mesaj gönderir. [senderName] gönderenin o anki ad-soyadı;
  /// [senderStreak] o anki günlük giriş serisi (isim rengi/rozeti için
  /// denormalize edilir).
  Future<void> sendMessage({
    required String senderName,
    required String text,
    int senderStreak = 0,
  }) async {
    final uid = currentUid;
    final trimmed = text.trim();
    if (uid == null || trimmed.isEmpty) {
      return;
    }
    await _messages.add({
      'senderId': uid,
      'senderName': senderName,
      'text': trimmed.length > maxLength
          ? trimmed.substring(0, maxLength)
          : trimmed,
      'senderStreak': senderStreak,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Mesajı siler. Kural: admin her mesajı, kullanıcı yalnızca kendi mesajını.
  Future<void> deleteMessage(String id) async {
    if (id.isEmpty) {
      return;
    }
    await _messages.doc(id).delete();
  }

  /// Mesaj metnini günceller (yalnızca sahibi). `editedAt` damgası eklenir.
  Future<void> editMessage({required String id, required String text}) async {
    final trimmed = text.trim();
    if (id.isEmpty || trimmed.isEmpty) {
      return;
    }
    await _messages.doc(id).update({
      'text': trimmed.length > maxLength
          ? trimmed.substring(0, maxLength)
          : trimmed,
      'editedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Bir kullanıcının avatarını (base64) döndürür; yoksa boş dizi. Çağıran
  /// taraf sonucu gönderen başına önbelleğe almalıdır.
  Future<String> fetchAvatar(String uid) async {
    if (uid.isEmpty) {
      return '';
    }
    final snapshot = await _firestore.collection('users').doc(uid).get();
    final data = snapshot.data();
    return (data?['photoBase64'] as String?) ?? '';
  }
}
