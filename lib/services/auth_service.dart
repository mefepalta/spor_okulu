import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  /// Şifre değiştirir. Güvenlik için önce mevcut şifreyle yeniden kimlik
  /// doğrulaması yapar (Firebase güncel oturum ister), sonra günceller.
  /// Mevcut şifre yanlışsa `wrong-password`/`invalid-credential` fırlatır.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _firebaseAuth.currentUser;
    final email = user?.email;
    if (user == null || email == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'Oturum bulunamadı.',
      );
    }
    final credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }

  /// Hesap silmeden önce mevcut parolayla yeniden kimlik doğrular (Firebase,
  /// hesap silme gibi hassas işlemler için güncel oturum ister). Parola
  /// yanlışsa `wrong-password`/`invalid-credential` fırlatır.
  Future<void> reauthenticate({required String currentPassword}) async {
    final user = _firebaseAuth.currentUser;
    final email = user?.email;
    if (user == null || email == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'Oturum bulunamadı.',
      );
    }
    final credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(credential);
  }

  /// Mevcut kullanıcının Firebase Authentication kaydını siler. Çağrılmadan
  /// önce [reauthenticate] ile yeniden kimlik doğrulanmış olmalıdır.
  Future<void> deleteCurrentUser() async {
    await _firebaseAuth.currentUser?.delete();
  }
}
