import 'package:flutter/material.dart';

import '../models/app_models.dart';
import '../theme/app_colors.dart';
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

  String _formatTl(int amount) {
    final digits = amount.abs().toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(digits[i]);
    }
    return '${amount < 0 ? '-' : ''}$buffer ₺';
  }

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
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kaydı sil'),
        content: Text(
          '"${transaction.title}" kaydını silmek istiyor musunuz?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Vazgeç'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sil'),
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
    return WaveScaffold(
      appBar: AppBar(title: const Text('Kulüp Kasası')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _add,
        icon: const Icon(Icons.add),
        label: const Text('Yeni Kayıt'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
        children: [
          _buildSummaryCard(context),
          const SizedBox(height: 4),
          if (_transactions.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: EmptyState(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Kasa boş',
                message:
                    'Henüz gelir/gider kaydı yok. Sağ alttaki butonla ilk kaydı ekleyin.',
              ),
            )
          else
            for (final transaction in _transactions) _buildTile(transaction),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final balanceColor = _balance >= 0 ? Colors.green : Colors.red;

    return SummarySection(
      icon: Icons.account_balance_wallet,
      title: 'Güncel Kasa',
      iconColor: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _formatTl(_balance),
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
                value: _formatTl(_totalIncome),
                label: 'Toplam Gelir',
                color: Colors.green,
              ),
              SummaryMetric(
                value: _formatTl(_totalExpense),
                label: 'Toplam Gider',
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
              '$sign${_formatTl(transaction.amount)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: color,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              color: Colors.red,
              tooltip: 'Sil',
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
    final title = _titleController.text.trim();
    final amount = int.tryParse(_amountController.text.trim()) ?? 0;
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen bir başlık yazın.')),
      );
      return;
    }
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen geçerli bir tutar girin.')),
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
          const Text(
            'Yeni Kayıt',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: CashType.income,
                label: Text('Gelir'),
                icon: Icon(Icons.arrow_downward),
              ),
              ButtonSegment(
                value: CashType.expense,
                label: Text('Gider'),
                icon: Icon(Icons.arrow_upward),
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
            decoration: const InputDecoration(
              labelText: 'Başlık',
              hintText: 'Örn: Mart aidatları, salon kirası...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Tutar (₺)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _category,
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Kategori',
              border: OutlineInputBorder(),
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
            label: Text('Tarih: ${_fmt(_date)}'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _noteController,
            maxLines: 2,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Not (isteğe bağlı)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.check),
            label: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }
}
