import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../utils/role_l10n.dart';
import '../widgets/empty_state.dart';
import '../widgets/wave_background.dart';
import 'users_screen.dart';

/// Admin'in, kullanıcıların kayıtta yaptığı rol başvurularını (veli/öğrenci)
/// onaylayıp reddettiği ekran.
///
/// Bekleyen başvurular admin'in zaten yüklediği kullanıcı listesinden türetilir
/// (`requestStatus == 'pending'`); yeni bir koleksiyon yoktur. Onay kullanıcıyı
/// istediği role yükseltir; ret hesabı reddedilmiş işaretler (kullanıcı bir
/// sonraki girişinde hesabı tamamen silinir).
class RoleRequestsScreen extends StatefulWidget {
  final List<UserAccount> users;
  final Future<void> Function(String uid, String requestedRole) onApprove;
  final Future<void> Function(String uid) onReject;

  const RoleRequestsScreen({
    super.key,
    required this.users,
    required this.onApprove,
    required this.onReject,
  });

  @override
  State<RoleRequestsScreen> createState() => _RoleRequestsScreenState();
}

class _RoleRequestsScreenState extends State<RoleRequestsScreen> {
  String? _busyUid;

  List<UserAccount> get _pending =>
      widget.users.where((user) => user.isPendingRequest).toList();

  Future<void> _approve(UserAccount user) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await _confirm(
      title: l10n.approveTitle,
      message: l10n.approveConfirm(
        _nameOf(user),
        localizedRole(l10n, user.requestedRole),
      ),
      actionLabel: l10n.approveAction,
    );
    if (confirmed != true) {
      return;
    }

    setState(() => _busyUid = user.uid);
    try {
      await widget.onApprove(user.uid, user.requestedRole);
      if (!mounted) {
        return;
      }
      _showSnack(
        l10n.approvedSnack(
          _nameOf(user),
          localizedRole(l10n, user.requestedRole),
        ),
      );
    } catch (error) {
      if (mounted) {
        _showSnack(_errorText(l10n, error));
      }
    } finally {
      if (mounted) {
        setState(() => _busyUid = null);
      }
    }
  }

  Future<void> _reject(UserAccount user) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await _confirm(
      title: l10n.rejectTitle,
      message: l10n.rejectConfirm(_nameOf(user)),
      actionLabel: l10n.rejectAction,
      destructive: true,
    );
    if (confirmed != true) {
      return;
    }

    setState(() => _busyUid = user.uid);
    try {
      await widget.onReject(user.uid);
      if (!mounted) {
        return;
      }
      _showSnack(l10n.rejectedSnack(_nameOf(user)));
    } catch (error) {
      if (mounted) {
        _showSnack(_errorText(l10n, error));
      }
    } finally {
      if (mounted) {
        setState(() => _busyUid = null);
      }
    }
  }

  Future<bool?> _confirm({
    required String title,
    required String message,
    required String actionLabel,
    bool destructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context);
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.commonCancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: destructive
                  ? TextButton.styleFrom(foregroundColor: Colors.red)
                  : null,
              child: Text(actionLabel),
            ),
          ],
        );
      },
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  String _errorText(AppLocalizations l10n, Object error) =>
      error is StateError ? error.message : l10n.genericOperationError;

  String _nameOf(UserAccount user) =>
      user.displayName.isNotEmpty ? user.displayName : user.email;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pending = _pending;

    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.roleRequestsTitle)),
      body: pending.isEmpty
          ? EmptyState(
              icon: Icons.how_to_reg,
              title: l10n.noPendingRequests,
              message: l10n.noPendingRequestsBody,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pending.length,
              itemBuilder: (context, index) {
                final user = pending[index];
                final isBusy = _busyUid == user.uid;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppRoleLabels.color(
                                user.requestedRole,
                              ),
                              foregroundColor: Colors.white,
                              child: Icon(
                                AppRoleLabels.icon(user.requestedRole),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _nameOf(user),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  if (user.displayName.isNotEmpty)
                                    Text(
                                      user.email,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.color,
                                      ),
                                    ),
                                  const SizedBox(height: 2),
                                  Text(
                                    l10n.requestLabel(
                                      localizedRole(l10n, user.requestedRole),
                                    ),
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppRoleLabels.color(
                                        user.requestedRole,
                                      ),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (isBusy)
                          const Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () => _reject(user),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                icon: const Icon(Icons.close),
                                label: Text(l10n.rejectAction),
                              ),
                              const SizedBox(width: 4),
                              FilledButton.icon(
                                onPressed: () => _approve(user),
                                icon: const Icon(Icons.check),
                                label: Text(l10n.approveAction),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
