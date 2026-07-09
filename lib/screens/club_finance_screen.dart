import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import '../widgets/empty_state.dart';
import '../widgets/summary_section.dart';
import '../widgets/wave_background.dart';

/// Kulüp Kasası (gelir/gider defteri) ekranı.
///
/// Yalnızca admin erişir. Üstte güncel kasa + toplam gelir/gider özeti, altta
/// hareket listesi. Güncel kasa hareketlerden türetilir (ayrı bakiye tutulmaz).
class ClubFinanceScreen extends StatefulWidget {
  final List<CashTransaction> transactions;
  final Future<CashTransaction> Function(CashTransaction transaction) onAdd;
  final Future<void> Function(String id) onDelete;

  const ClubFinanceScreen({
    super.key,
    required this.transactions,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  State<ClubFinanceScreen> createState() => _ClubFinanceScreenState();
}

class _ClubFinanceScreenState extends State<ClubFinanceScreen> {
  late final List<CashTransaction> _transactions = List.of(widget.transactions);

  int get _totalIncome => _transactions
      .where((t) => t.isIncome)
      .fold(0, (sum, t) => sum + t.amount);

  int get _totalExpense => _transactions
      .where((t) => !t.isIncome)
      .fold(0, (sum, t) => sum + t.amount);

  int get _balance => _totalIncome - _totalExpense;

  Future<void> _add() async {
    final result = await showModalBottomSheet<CashTransaction>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _CashForm(),
    );
    if (result == null) {
      return;
    }
    final created = await widget.onAdd(result);
    if (!mounted) {
      return;
    }
    setState(() => _transactions.insert(0, created));
  }

  Future<void> _delete(CashTransaction transaction) async {
    final l10n = AppLocalizations.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.cashDeleteTitle),
        content: Text(l10n.cashDeleteConfirm(transaction.title)),
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
    await widget.onDelete(transaction.id);
    if (!mounted) {
      return;
    }
    setState(() => _transactions.removeWhere((t) => t.id == transaction.id));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.navClubCash)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _add,
        icon: const Icon(Icons.add),
        label: Text(l10n.newCashEntry),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
        children: [
          _buildSummaryCard(context),
          const SizedBox(height: 4),
          if (_transactions.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: EmptyState(
                icon: Icons.account_balance_wallet_outlined,
                title: l10n.cashEmptyTitle,
                message: l10n.cashEmptyBody,
              ),
            )
          else
            for (final transaction in _transactions) _buildTile(transaction),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final balanceColor = _balance >= 0 ? Colors.green : Colors.red;

    return SummarySection(
      icon: Icons.account_balance_wallet,
      title: l10n.currentBalance,
      iconColor: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            formatTl(_balance),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: balanceColor,
            ),
          ),
          const SizedBox(height: 12),
          SummaryMetricsRow(
            metrics: [
              SummaryMetric(
                value: formatTl(_totalIncome),
                label: l10n.totalIncome,
                color: Colors.green,
              ),
              SummaryMetric(
                value: formatTl(_totalExpense),
                label: l10n.totalExpense,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTile(CashTransaction transaction) {
    final color = transaction.isIncome ? Colors.green : Colors.red;
    final sign = transaction.isIncome ? '+' : '-';
    final subtitleParts = [
      if (transaction.category.isNotEmpty) transaction.category,
      if (transaction.dateText.isNotEmpty) transaction.dateText,
    ];

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.14),
          child: Icon(
            transaction.isIncome
                ? Icons.arrow_downward
                : Icons.arrow_upward,
            color: color,
          ),
        ),
        title: Text(
          transaction.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: subtitleParts.isEmpty
            ? (transaction.note.isEmpty ? null : Text(transaction.note))
            : Text(
                subtitleParts.join(' • '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$sign${formatTl(transaction.amount)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: color,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              color: Colors.red,
              tooltip: AppLocalizations.of(context).commonDelete,
              onPressed: () => _delete(transaction),
            ),
          ],
        ),
      ),
    );
  }
}

/// Yeni kasa hareketi (gelir/gider) formu — alt sayfa.
class _CashForm extends StatefulWidget {
  const _CashForm();

  @override
  State<_CashForm> createState() => _CashFormState();
}

class _CashFormState extends State<_CashForm> {
  String _type = CashType.income;
  String? _category;
  DateTime _date = DateTime.now();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
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
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  void _save() {
    final l10n = AppLocalizations.of(context);
    final title = _titleController.text.trim();
    final amount = int.tryParse(_amountController.text.trim()) ?? 0;
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.titleRequired)),
      );
      return;
    }
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.amountInvalid)),
      );
      return;
    }
    Navigator.pop(
      context,
      CashTransaction(
        type: _type,
        title: title,
        category: _category ?? '',
        amount: amount,
        dateText: _fmt(_date),
        note: _noteController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final categories = CashCategories.forType(_type);

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
            l10n.newCashEntry,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(
                value: CashType.income,
                label: Text(l10n.metricIncome),
                icon: const Icon(Icons.arrow_downward),
              ),
              ButtonSegment(
                value: CashType.expense,
                label: Text(l10n.metricExpense),
                icon: const Icon(Icons.arrow_upward),
              ),
            ],
            selected: {_type},
            onSelectionChanged: (selection) {
              setState(() {
                _type = selection.first;
                _category = null; // tür değişince kategori sıfırlanır
              });
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _titleController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.fieldTitle,
              hintText: l10n.cashTitleHint,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.fieldAmountCurrency,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _category,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: l10n.fieldCategory,
              border: const OutlineInputBorder(),
            ),
            items: [
              for (final category in categories)
                DropdownMenuItem(value: category, child: Text(category)),
            ],
            onChanged: (value) => setState(() => _category = value),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_today),
            label: Text(l10n.dateWithValue(_fmt(_date))),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _noteController,
            maxLines: 2,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.fieldNoteOptional,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.check),
            label: Text(l10n.commonSave),
          ),
        ],
      ),
    );
  }
}
