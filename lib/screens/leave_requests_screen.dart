import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../utils/status_l10n.dart';
import '../widgets/empty_state.dart';
import '../widgets/wave_background.dart';

/// Mazeret / izin ekranı.
///
/// Veli kendi çocuğu için mazeret bildirir ve kendi taleplerini (durumlarıyla)
/// görür; personel tüm talepleri görüp Onaylar/Reddeder. Aynı ekran role göre
/// uyarlanır.
class LeaveRequestsScreen extends StatefulWidget {
  final List<LeaveRequest> requests;

  /// Velinin çocukları (mazeret bildirirken seçim için). Personelde boş.
  final List<Student> children;
  final bool isParent;

  /// Personel talebin durumunu güncelleyebilir mi (admin/antrenör).
  final bool canManage;
  final String currentUserUid;

  final Future<LeaveRequest> Function(LeaveRequest request) onAdd;
  final Future<void> Function(String id, String status) onUpdateStatus;
  final Future<void> Function(String id) onDelete;

  const LeaveRequestsScreen({
    super.key,
    required this.requests,
    required this.children,
    required this.isParent,
    required this.canManage,
    required this.currentUserUid,
    required this.onAdd,
    required this.onUpdateStatus,
    required this.onDelete,
  });

  @override
  State<LeaveRequestsScreen> createState() => _LeaveRequestsScreenState();
}

class _LeaveRequestsScreenState extends State<LeaveRequestsScreen> {
  late final List<LeaveRequest> _requests = List.of(widget.requests);

  Color _statusColor(String status) {
    switch (status) {
      case LeaveStatus.approved:
        return Colors.green;
      case LeaveStatus.rejected:
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  Future<void> _submit() async {
    final result = await showModalBottomSheet<LeaveRequest>(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          _LeaveForm(children: widget.children, parentUid: widget.currentUserUid),
    );
    if (result == null) {
      return;
    }
    final created = await widget.onAdd(result);
    if (!mounted) {
      return;
    }
    setState(() => _requests.insert(0, created));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).leaveReported)),
      );
    }
  }

  Future<void> _setStatus(LeaveRequest request, String status) async {
    await widget.onUpdateStatus(request.id, status);
    if (!mounted) {
      return;
    }
    final index = _requests.indexWhere((r) => r.id == request.id);
    if (index != -1) {
      setState(() => _requests[index] = request.copyWith(status: status));
    }
  }

  Future<void> _delete(LeaveRequest request) async {
    final l10n = AppLocalizations.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.leaveDeleteTitle),
        content: Text(l10n.leaveDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirm != true) {
      return;
    }
    await widget.onDelete(request.id);
    if (!mounted) {
      return;
    }
    setState(() => _requests.removeWhere((r) => r.id == request.id));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(
        title: Text(widget.isParent ? l10n.navReportAbsence : l10n.navLeaveRequests),
      ),
      floatingActionButton: widget.isParent && widget.children.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _submit,
              icon: const Icon(Icons.add),
              label: Text(l10n.newLeave),
            )
          : null,
      body: _requests.isEmpty
          ? EmptyState(
              icon: Icons.event_busy,
              title: l10n.leaveEmptyTitle,
              message: widget.isParent
                  ? l10n.leaveEmptyParent
                  : l10n.leaveEmptyStaff,
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
              itemCount: _requests.length,
              itemBuilder: (context, index) => _buildCard(_requests[index]),
            ),
    );
  }

  Widget _buildCard(LeaveRequest request) {
    final statusColor = _statusColor(request.status);
    final isPending = request.status == LeaveStatus.pending;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    request.studentName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    localizedLeaveStatus(
                      AppLocalizations.of(context),
                      request.status,
                    ),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.event,
                  size: 16,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
                const SizedBox(width: 6),
                Text(
                  request.dateText,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
            if (request.reason.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(request.reason),
            ],
            const SizedBox(height: 10),
            _buildActions(request, isPending),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(LeaveRequest request, bool isPending) {
    final l10n = AppLocalizations.of(context);
    // Personel: bekleyen talepleri onaylar/reddeder.
    if (widget.canManage && isPending) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _setStatus(request, LeaveStatus.approved),
              icon: const Icon(Icons.check, color: Colors.green),
              label: Text(
                l10n.approveAction,
                style: const TextStyle(color: Colors.green),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _setStatus(request, LeaveStatus.rejected),
              icon: const Icon(Icons.close, color: Colors.red),
              label: Text(
                l10n.rejectAction,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      );
    }

    // Veli: kendi bekleyen talebini silebilir (iptal).
    if (widget.isParent && isPending) {
      return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: TextButton.icon(
          onPressed: () => _delete(request),
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          label: Text(
            l10n.cancelLeaveAction,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

/// Mazeret bildirme formu (alt sayfa): çocuk seçimi + tarih + gerekçe.
class _LeaveForm extends StatefulWidget {
  final List<Student> children;
  final String parentUid;

  const _LeaveForm({required this.children, required this.parentUid});

  @override
  State<_LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<_LeaveForm> {
  late Student _selectedChild = widget.children.first;
  DateTime _date = DateTime.now();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  String _fmt(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}.'
      '${date.month.toString().padLeft(2, '0')}.${date.year}';

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  void _save() {
    final reason = _reasonController.text.trim();
    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).reasonRequired)),
      );
      return;
    }
    Navigator.pop(
      context,
      LeaveRequest(
        studentId: _selectedChild.id,
        studentName: _selectedChild.name,
        parentUid: widget.parentUid,
        dateText: _fmt(_date),
        reason: reason,
        status: LeaveStatus.pending,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.newLeave,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (widget.children.length > 1) ...[
            DropdownButtonFormField<Student>(
              initialValue: _selectedChild,
              decoration: InputDecoration(
                labelText: l10n.roleStudent,
                border: const OutlineInputBorder(),
              ),
              items: [
                for (final child in widget.children)
                  DropdownMenuItem(value: child, child: Text(child.name)),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedChild = value);
                }
              },
            ),
            const SizedBox(height: 12),
          ],
          OutlinedButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_today),
            label: Text(l10n.dateWithValue(_fmt(_date))),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _reasonController,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.fieldReason,
              hintText: l10n.reasonHint,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.send),
            label: Text(l10n.sendAction),
          ),
        ],
      ),
    );
  }
}
