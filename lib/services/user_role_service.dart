import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRoleService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getCurrentUserRole() async {
    final user = _auth.currentUser;

    if (user == null) {
      return 'viewer';
    }

    final Map<String, dynamic>? data;

    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      data = userDoc.data();
    } catch (_) {
      return 'viewer';
    }

    if (data == null) {
      return 'viewer';
    }

    final role = data['role'];

    if (role is String) {
      final normalizedRole = role.trim().toLowerCase();

      if (normalizedRole == 'admin' ||
          normalizedRole == 'coach' ||
          normalizedRole == 'viewer') {
        return normalizedRole;
      }
    }

    return 'viewer';
  }

  Future<bool> isCurrentUserAdmin() async {
    final role = await getCurrentUserRole();
    return role == 'admin';
  }
}
