import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/app_roles.dart';
import '../models/app_models.dart';

/// Veli (parent) hesaplarını yönetir: rol atama ve öğrenci eşleştirme.
///
/// Veliler uygulamaya normal şekilde kayıt olur (rol 'viewer'). Admin, bu
/// servis üzerinden bir kullanıcıyı e-postasından bulup 'veli' rolüne yükseltir
/// ve ona öğrenci(ler) atar.
class ParentService {
  ParentService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _users {
    return _firestore.collection('users');
  }

  /// Rolü 'veli' olan tüm hesapları döndürür.
  Future<List<ParentAccount>> loadParents() async {
    final snapshot = await _users
        .where('role', isEqualTo: AppRoles.parent)
        .get();

    return snapshot.docs
        .map((doc) => ParentAccount.fromJson(doc.id, doc.data()))
        .toList();
  }

  /// Verilen e-postaya sahip kullanıcıyı 'veli' rolüne yükseltir ve döndürür.
  /// Kullanıcı bulunamazsa [StateError] fırlatır (önce kayıt olması gerekir).
  Future<ParentAccount> promoteToParentByEmail(String email) async {
    final normalizedEmail = email.trim().toLowerCase();

    final snapshot = await _users
        .where('email', isEqualTo: normalizedEmail)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      throw StateError(
        'Bu e-posta ile kayıtlı kullanıcı bulunamadı. '
        'Velinin önce uygulamaya kayıt olması gerekir.',
      );
    }

    final doc = snapshot.docs.first;

    await doc.reference.set({
      'role': AppRoles.parent,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    return ParentAccount.fromJson(doc.id, {
      ...doc.data(),
      'role': AppRoles.parent,
    });
  }

  /// Bir veliye atanmış öğrenci kimliklerini günceller.
  Future<void> setAssignedStudents(String uid, List<String> studentIds) async {
    await _users.doc(uid).set({
      'studentIds': studentIds,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  /// Veliyi normal görüntüleyici rolüne indirir ve öğrenci eşleşmelerini siler.
  Future<void> removeParent(String uid) async {
    await _users.doc(uid).set({
      'role': AppRoles.viewer,
      'studentIds': <String>[],
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
