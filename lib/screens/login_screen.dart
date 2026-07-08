import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';
import '../services/user_role_service.dart';
import '../theme/app_colors.dart';
import '../widgets/wave_background.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  final UserRoleService _userRoleService = UserRoleService();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final credential = await _authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Oturum bilgisini tazelemeye çalış; ağ yavaş/erişilemezse "Giriş
      // yapılıyor..." adımında sonsuza kadar takılmamak için zaman aşımı koy.
      try {
        await credential.user?.reload().timeout(const Duration(seconds: 8));
      } catch (_) {
        // Yenileme başarısız oldu; mevcut kullanıcı bilgisiyle devam et.
      }
      final refreshedUser = _authService.currentUser;

      if (refreshedUser == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'Kullanıcı bulunamadı.',
        );
      }

      final account = await _userRoleService.getCurrentUserAccount();
      final userRole = account?.role ?? 'viewer';

      // Reddedilen başvuru: hesabı (belge + Auth) sil ve çık. E-posta doğrulama
      // kontrolünden önce yapılır ki reddedilen kullanıcı her hâlükârda temizlensin.
      if (account != null && account.requestStatus == 'rejected') {
        if (!mounted) {
          return;
        }
        await _showRejectedDialog();
        await _deleteOwnAccount(refreshedUser);
        return;
      }

      if (!refreshedUser.emailVerified && userRole == 'viewer') {
        if (!mounted) {
          return;
        }

        await _showEmailNotVerifiedDialog(refreshedUser);

        await _authService.signOut();

        return;
      }

      if (!mounted) {
        return;
      }

      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    } on FirebaseAuthException catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_authErrorMessage(error))));
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Giriş kontrolü sırasında bir hata oluştu: $error'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _showEmailNotVerifiedDialog(User user) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('E-posta doğrulanmamış'),
          content: const Text(
            'Hesabını aktifleştirmek için e-postana gelen doğrulama linkine tıklamalısın. Link gelmediyse tekrar gönderebiliriz.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kapat'),
            ),
            TextButton(
              onPressed: () async {
                await user.sendEmailVerification();

                if (!context.mounted) {
                  return;
                }

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Doğrulama e-postası tekrar gönderildi. Spam klasörünü de kontrol et.',
                    ),
                  ),
                );
              },
              child: const Text('Tekrar Gönder'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showRejectedDialog() async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Başvurun reddedildi'),
          content: const Text(
            'Rol başvurun yönetici tarafından reddedildi. Hesabın kapatılıyor.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  /// Reddedilen kullanıcının kendi hesabını tamamen siler: önce Firestore
  /// belgesi (giriş yapılmışken kendi belgesini silebilir), sonra Auth hesabı
  /// (yeni giriş olduğundan recent-login gerekmez). Silme başarısızsa yine de
  /// oturumu kapatır.
  Future<void> _deleteOwnAccount(User user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();
    } catch (_) {
      // Belge silinemese de Auth silmeyi dene.
    }
    try {
      await user.delete();
    } catch (_) {
      await _authService.signOut();
    }
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Şifre sıfırlamak için önce e-posta adresini yaz.'),
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Şifre sıfırlama bağlantısı e-posta adresine gönderildi.',
          ),
        ),
      );
    } on FirebaseAuthException catch (error) {
      String message = 'Şifre sıfırlama sırasında bir hata oluştu.';

      if (error.code == 'invalid-email') {
        message = 'Geçerli bir e-posta adresi gir.';
      } else if (error.code == 'user-not-found') {
        message = 'Bu e-posta adresiyle kayıtlı kullanıcı bulunamadı.';
      }

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  String _authErrorMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'E-posta adresi geçersiz.';
      case 'user-disabled':
        return 'Bu kullanıcı hesabı pasif durumda.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'E-posta veya Şifre hatalı.';
      case 'network-request-failed':
        return 'İnternet bağlantısı kurulamadı. Bağlantıyı kontrol edip tekrar dene.';
      case 'operation-not-allowed':
        return 'Firebase Console içinde Email/Password giriş yöntemi aktif değil.';
      case 'configuration-not-found':
        return 'Firebase Authentication yapılandırması bulunamadı. Firebase Console ayarlarını kontrol et.';
      case 'app-not-authorized':
        return 'Bu Android uygulaması Firebase projesi için yetkili görünmüyor.';
      case 'invalid-api-key':
        return 'Firebase API anahtarı geçersiz görünüyor.';
      case 'too-many-requests':
        return 'Çok fazla giriş denemesi yapıldı. Bir süre sonra tekrar dene.';
      default:
        return 'Giriş yapılamadı. Hata kodu: ${error.code}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: WaveBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 8,
              shadowColor: AppColors.primary.withValues(alpha: 0.25),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.sports_soccer,
                        size: 72,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        AppConstants.appTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'E-posta',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          hintText: 'example@sporokulu.com',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'E-posta boş bırakılamaz.';
                          }

                          if (!value.contains('@')) {
                            return 'Geçerli bir e-posta gir.';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Şifre',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          hintText: '******',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Şifre boş bırakılamaz.';
                          }

                          if (value.trim().length < 6) {
                            return 'Şifre en az 6 karakter olmalıdır.';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _isLoading ? null : _login,
                        icon: _isLoading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.login),
                        label: Text(
                          _isLoading ? 'Giriş yapılıyor...' : 'Giriş Yap',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _resetPassword,
                        child: const Text('Şifremi unuttum'),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text('Hesabın yok mu? Kayıt ol'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
