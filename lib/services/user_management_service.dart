import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/app_roles.dart';
import '../models/app_models.dart';

/// Admin'in tüm kullanıcı hesaplarını görüp rol atadığı servis.
///
/// [ParentService] yalnızca veli akışına (öğrenci eşleştirme) odaklıyken bu
/// servis genel rol yönetimini üstlenir: bir kullanıcıyı admin / antrenör /
/// veli / görüntüleyici yapmak.
class UserManagementService {
  UserManagementService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _users {
    return _firestore.collection('users');
  }

  /// Kayıtlı tüm kullanıcıları döndürür (yalnızca admin okuyabilir).
  Future<List<UserAccount>> loadUsers() async {
    final snapshot = await _users.get();

    return snapshot.docs
        .map((doc) => UserAccount.fromJson(doc.id, doc.data()))
        .toList();
  }

  /// Bir kullanıcının rolünü değiştirir. Rol 'veli'den çıkıyorsa atanmış
  /// öğrenci eşleşmeleri de temizlenir (veli olmayan hesapta anlamı yok).
  Future<void> setRole(String uid, String role) async {
    if (!AppRoles.isValid(role)) {
      throw StateError('Geçersiz rol: $role');
    }

    final data = <String, dynamic>{
      'role': role,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    // Öğrenci eşleştirmesi hem veli hem öğrenci rolünde 'studentIds' ile tutulur;
    // rol bunların dışına çıkıyorsa eşleşmeler temizlenir.
    if (role != AppRoles.parent && role != AppRoles.student) {
      data['studentIds'] = <String>[];
    }

    await _users.doc(uid).set(data, SetOptions(merge: true));
  }

  /// Rol başvurusunu onaylar: kullanıcıyı istediği role (veli/öğrenci) yükseltir
  /// ve başvuru durumunu 'approved' yapar. İstenen rol geçersizse hata verir.
  Future<void> approveRequest(String uid, String requestedRole) async {
    if (requestedRole != AppRoles.parent && requestedRole != AppRoles.student) {
      throw StateError('Geçersiz başvuru rolü: $requestedRole');
    }
    await setRole(uid, requestedRole);
    await _users.doc(uid).set({
      'roleRequestStatus': 'approved',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  /// Rol başvurusunu reddeder: belgeye 'rejected' işaretini koyar (rol 'viewer'
  /// kalır). Kullanıcının Auth hesabı, ücretsiz katman gereği bir sonraki
  /// girişinde kendi istemcisinden silinir (bkz. login_screen).
  Future<void> rejectRequest(String uid) async {
    await _users.doc(uid).set({
      'roleRequestStatus': 'rejected',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
