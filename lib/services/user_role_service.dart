import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/app_roles.dart';

class UserRoleService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> _currentUserData() async {
    final user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    try {
      final userDoc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get()
          .timeout(const Duration(seconds: 8));
      return userDoc.data();
    } catch (_) {
      return null;
    }
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
}
