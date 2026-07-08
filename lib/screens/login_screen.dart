import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);
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
          message: l10n.userNotFound,
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
      ).showSnackBar(SnackBar(content: Text(_authErrorMessage(l10n, error))));
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.loginCheckError(error))));
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
        final l10n = AppLocalizations.of(context);
        return AlertDialog(
          title: Text(l10n.emailNotVerifiedTitle),
          content: Text(l10n.emailNotVerifiedBody),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(l10n.commonClose),
            ),
            TextButton(
              onPressed: () async {
                await user.sendEmailVerification();

                if (!context.mounted) {
                  return;
                }

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.verificationResent)),
                );
              },
              child: Text(l10n.commonResend),
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
        final l10n = AppLocalizations.of(context);
        return AlertDialog(
          title: Text(l10n.rejectedTitle),
          content: Text(l10n.rejectedBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.commonOk),
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
    final l10n = AppLocalizations.of(context);
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.resetPasswordNeedEmail)),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.resetPasswordSent)),
      );
    } on FirebaseAuthException catch (error) {
      String message = l10n.resetPasswordError;

      if (error.code == 'invalid-email') {
        message = l10n.resetInvalidEmail;
      } else if (error.code == 'user-not-found') {
        message = l10n.resetUserNotFound;
      }

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  String _authErrorMessage(AppLocalizations l10n, FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return l10n.authInvalidEmail;
      case 'user-disabled':
        return l10n.authUserDisabled;
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return l10n.authWrongCredentials;
      case 'network-request-failed':
        return l10n.authNetwork;
      case 'operation-not-allowed':
        return l10n.authOperationNotAllowed;
      case 'configuration-not-found':
        return l10n.authConfigNotFound;
      case 'app-not-authorized':
        return l10n.authAppNotAuthorized;
      case 'invalid-api-key':
        return l10n.authInvalidApiKey;
      case 'too-many-requests':
        return l10n.authTooManyRequests;
      default:
        return l10n.authGenericWithCode(error.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
                      Text(
                        l10n.loginHeading,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: l10n.emailLabel,
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.email),
                          hintText: l10n.emailHint,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.emailEmpty;
                          }

                          if (!value.contains('@')) {
                            return l10n.emailInvalid;
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: l10n.passwordLabel,
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
                            return l10n.passwordEmpty;
                          }

                          if (value.trim().length < 6) {
                            return l10n.passwordMinLength;
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
                          _isLoading ? l10n.loginLoading : l10n.loginButton,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _resetPassword,
                        child: Text(l10n.forgotPassword),
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
                        child: Text(l10n.noAccountRegister),
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
