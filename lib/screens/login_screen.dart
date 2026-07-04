import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';
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

      await credential.user?.reload();
      final refreshedUser = _authService.currentUser;

      if (refreshedUser == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'Kullanıcı bulunamadı.',
        );
      }

      if (!refreshedUser.emailVerified) {
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
      default:
        return 'Giriş yapılamadı. Firebase ayarlarını ve kullanıcıyi kontrol et.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 4,
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
                      color: Colors.indigo,
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
                    const SizedBox(height: 8),
                    const Text(
                      'Admin Girişi',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
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
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.login),
                      label: Text(
                        _isLoading ? 'Giriş yapılıyor...' : 'Giriş Yap',
                      ),
                    ),
                    const SizedBox(height: 12),
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
                    const SizedBox(height: 16),
                    const Text(
                      'Firebase hesabınla giriş yap.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
