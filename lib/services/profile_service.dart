import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/app_models.dart';

/// Giriş yapan kullanıcının kendi profilini (ad, telefon, avatar) okuyup
/// güncellediği servis.
///
/// Yalnızca güvenli alanlar yazılır; `role` ve `studentIds` hiç dokunulmaz.
/// Firestore kuralı da bu alanların dışına yazmayı reddeder.
class ProfileService {
  ProfileService({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  DocumentReference<Map<String, dynamic>>? get _myDoc {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      return null;
    }
    return _firestore.collection('users').doc(uid);
  }

  /// Kendi profil belgesini döndürür. Belge yoksa Auth bilgisiyle asgari bir
  /// profil üretir.
  Future<UserProfile?> loadMyProfile() async {
    final user = _auth.currentUser;
    final doc = _myDoc;
    if (user == null || doc == null) {
      return null;
    }

    final snapshot = await doc.get();
    final data = snapshot.data();

    if (data == null) {
      return UserProfile(uid: user.uid, email: user.email ?? '', role: 'viewer');
    }

    final profile = UserProfile.fromJson(user.uid, data);
    // Belgede e-posta yoksa Auth'takini kullan.
    if (profile.email.isEmpty && (user.email ?? '').isNotEmpty) {
      return UserProfile(
        uid: profile.uid,
        email: user.email ?? '',
        role: profile.role,
        displayName: profile.displayName,
        phone: profile.phone,
        photoBase64: profile.photoBase64,
      );
    }
    return profile;
  }

  /// Yalnızca profil alanlarını (ad/telefon/foto) günceller.
  Future<void> updateMyProfile({
    String? displayName,
    String? phone,
    String? photoBase64,
  }) async {
    final doc = _myDoc;
    if (doc == null) {
      throw StateError('Oturum bulunamadı.');
    }

    final data = <String, dynamic>{'updatedAt': FieldValue.serverTimestamp()};

    if (displayName != null) {
      data['displayName'] = displayName;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    if (photoBase64 != null) {
      data['photoBase64'] = photoBase64;
    }

    await doc.set(data, SetOptions(merge: true));
  }
}
