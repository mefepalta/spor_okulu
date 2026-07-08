import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/app_roles.dart';
import '../models/app_models.dart';

class UserRoleService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Kullanıcı belgesini döndürür.
  ///
  /// Ağ/timeout gibi geçici hatalarda hata yeniden fırlatılır; böylece çağıran
  /// taraf "yükleme başarısız" gösterir. Aksi halde anlık bir bağlantı sorunu
  /// admin'i sessizce görüntüleyici rolüne düşürebilirdi. Yalnızca belge gerçek
  /// anlamda yoksa (kullanıcı yok) null döner.
  Future<Map<String, dynamic>?> _currentUserData() async {
    final user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    final userDoc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get()
        .timeout(const Duration(seconds: 8));

    return userDoc.data();
  }

  Future<String> getCurrentUserRole() async {
    final data = await _currentUserData();

    if (data == null) {
      return AppRoles.viewer;
    }

    final role = data['role'];

    if (role is String) {
      final normalizedRole = role.trim().toLowerCase();

      if (AppRoles.isValid(normalizedRole)) {
        return normalizedRole;
      }
    }

    return AppRoles.viewer;
  }

  /// Giriş yapan veli hesabına atanmış öğrenci kimlikleri.
  Future<List<String>> getCurrentUserStudentIds() async {
    final data = await _currentUserData();

    if (data == null) {
      return const [];
    }

    return List<String>.from(data['studentIds'] ?? const []);
  }

  Future<bool> isCurrentUserAdmin() async {
    final role = await getCurrentUserRole();
    return role == AppRoles.admin;
  }

  /// Giriş yapan kullanıcının tüm hesap bilgisi (rol, ad, başvuru durumu).
  /// Belge yoksa null döner. Viewer karşılama panosu ve giriş sonrası
  /// reddedilen-hesap kontrolü için kullanılır.
  Future<UserAccount?> getCurrentUserAccount() async {
    final user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    final data = await _currentUserData();
    if (data == null) {
      return null;
    }
    return UserAccount.fromJson(user.uid, data);
  }
}
