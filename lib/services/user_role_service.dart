import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRoleService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isCurrentUserAdmin() async {
    final user = _auth.currentUser;

    if (user == null) {
      return false;
    }

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    final data = userDoc.data();

    if (data == null) {
      return false;
    }

    return data['role'] == 'admin';
  }
}
