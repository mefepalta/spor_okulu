import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/app_roles.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../widgets/wave_background.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();

  /// Kullanıcının talep ettiği rol: veli ya da öğrenci (yalnızca biri).
  String _requestedRole = AppRoles.parent;

  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordAgainController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final l10n = AppLocalizations.of(context);
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final firstName = _firstNameController.text.trim();
      final lastName = _lastNameController.text.trim();
      final displayName = '$firstName $lastName'.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = credential.user;

      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-not-created',
          message: l10n.userNotCreated,
        );
      }

      await user.updateDisplayName(displayName);

      // Rol 'viewer' başlar; kullanıcı veli/öğrenci olma talebini 'pending'
      // olarak kaydeder. Admin onaylayınca role yükselir, reddedince silinir.
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': email,
        'displayName': displayName,
        'role': AppRoles.viewer,
        'requestedRole': _requestedRole,
        'roleRequestStatus': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      await user.sendEmailVerification();
      await FirebaseAuth.instance.signOut();

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.registerSuccess)),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      var message = l10n.registerGenericError;

      if (error.code == 'email-already-in-use') {
        message = l10n.emailAlreadyInUse;
      } else if (error.code == 'weak-password') {
        message = l10n.passwordTooWeak;
      } else if (error.code == 'invalid-email') {
        message = l10n.resetInvalidEmail;
      }

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.registerErrorWith(error))));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String? _requiredValidator(AppLocalizations l10n, String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return l10n.requiredField(label);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.registerTitle)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.person_add,
                      size: 64,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.registerHeading,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _firstNameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: l10n.firstNameLabel,
                        prefixIcon: const Icon(Icons.badge_outlined),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          _requiredValidator(l10n, value, l10n.firstNameLabel),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _lastNameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: l10n.lastNameLabel,
                        prefixIcon: const Icon(Icons.badge_outlined),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          _requiredValidator(l10n, value, l10n.lastNameLabel),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: l10n.emailLabel,
                        hintText: l10n.emailHint,
                        prefixIcon: const Icon(Icons.email),
                        border: const OutlineInputBorder(),
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
                        prefixIcon: const Icon(Icons.lock),
                        border: const OutlineInputBorder(),
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
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordAgainController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: l10n.passwordAgainLabel,
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.passwordAgainEmpty;
                        }

                        if (value.trim() != _passwordController.text.trim()) {
                          return l10n.passwordsDontMatch;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        l10n.accountType,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<String>(
                      segments: [
                        ButtonSegment(
                          value: AppRoles.parent,
                          icon: const Icon(Icons.family_restroom),
                          label: Text(l10n.roleParent),
                        ),
                        ButtonSegment(
                          value: AppRoles.student,
                          icon: const Icon(Icons.school),
                          label: Text(l10n.roleStudent),
                        ),
                      ],
                      selected: {_requestedRole},
                      onSelectionChanged: _isLoading
                          ? null
                          : (selection) {
                              setState(() {
                                _requestedRole = selection.first;
                              });
                            },
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.selectionSentToAdmin,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _register,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.person_add),
                      label: Text(
                        _isLoading ? l10n.registerLoading : l10n.registerButton,
                      ),
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
