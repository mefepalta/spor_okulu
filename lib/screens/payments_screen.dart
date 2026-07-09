import 'package:flutter/material.dart';

import '../widgets/wave_background.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import '../utils/launchers.dart';
import '../utils/status_l10n.dart';
import '../utils/validators.dart';
import '../widgets/empty_state.dart';

class PaymentsScreen extends StatefulWidget {
  final List<Student> students;
  final List<PaymentRecord> payments;
  final bool isAdmin;
  final Future<void> Function(PaymentRecord payment) onAddPayment;
  final Future<void> Function(int index) onDeletePayment;
  final Future<void> Function(int index, PaymentRecord updatedPayment)
  onUpdatePayment;

  const PaymentsScreen({
    super.key,
    required this.students,
    required this.payments,
    required this.isAdmin,
    required this.onAddPayment,
    required this.onDeletePayment,
    required this.onUpdatePayment,
  });

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  String _searchQuery = '';

  /// Seçili durum filtresi; null ise tüm durumlar gösterilir.
  String? _statusFilter;

  /// Seçili dönem (ör. "Haziran 2026"); null ise tüm dönemler gösterilir.
  String? _periodFilter;

  Color _statusColor(String status) {
    if (status == 'Ödendi') {
      return Colors.green;
    }

    if (status == 'Gecikti') {
      return Colors.red;
    }

    return Colors.orange;
  }

  Future<void> _openAddPaymentScreen() async {
    final newPayment = await Navigator.push<PaymentRecord>(
      context,
      MaterialPageRoute(
        builder: (context) => AddPaymentScreen(students: widget.students),
      ),
    );

    if (newPayment == null) {
      return;
    }

    await widget.onAddPayment(newPayment);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _openPaymentDetailScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentDetailScreen(
          payments: widget.payments,
          students: widget.students,
          index: index,
          isAdmin: widget.isAdmin,
          onUpdatePayment: widget.onUpdatePayment,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _confirmDeletePayment(int index) async {
    final l10n = AppLocalizations.of(context);
    final payment = widget.payments[index];

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.paymentDeleteTitle),
          content: Text(
            l10n.paymentDeleteConfirm(payment.studentName, payment.period),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(l10n.commonCancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(l10n.commonDelete, style: const TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    await widget.onDeletePayment(index);

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.paymentDeleted)));
  }

  /// Durum filtresi çipleri: Tümü / Ödendi / Bekliyor / Gecikti.
  Widget _buildStatusFilters() {
    final l10n = AppLocalizations.of(context);
    const statuses = ['Ödendi', 'Bekliyor', 'Gecikti'];

    Widget chip(String label, String? value) {
      final selected = _statusFilter == value;
      final color = value == null ? AppColors.primary : _statusColor(value);

      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: FilterChip(
          label: Text(label),
          selected: selected,
          showCheckmark: false,
          selectedColor: color.withValues(alpha: 0.18),
          side: BorderSide(
            color: selected ? color : Colors.grey.withValues(alpha: 0.35),
          ),
          labelStyle: TextStyle(
            color: selected ? color : null,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
          onSelected: (_) {
            setState(() {
              _statusFilter = value;
            });
          },
        ),
      );
    }

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          chip(l10n.commonAll, null),
          for (final status in statuses)
            chip(localizedPaymentStatus(l10n, status), status),
        ],
      ),
    );
  }

  /// Kayıtlardaki dönemleri (ör. "Haziran 2026") en yeniden eskiye sıralı,
  /// tekrarsız döner. Türkçe ay adı + yıl ayrıştırılabiliyorsa kronolojik,
  /// aksi halde alfabetik sıralanır.
  List<String> _distinctPeriods() {
    final periods = <String>{
      for (final payment in widget.payments)
        if (payment.period.trim().isNotEmpty) payment.period.trim(),
    }.toList();
    periods.sort((a, b) {
      final keyCompare = _periodSortKey(b).compareTo(_periodSortKey(a));
      return keyCompare != 0 ? keyCompare : a.compareTo(b);
    });
    return periods;
  }

  /// Dönem metninden kronolojik sıralama anahtarı (yıl*100 + ay). Ayrıştırma
  /// başarısızsa 0 döner (bu kayıtlar alfabetik sıralamaya düşer).
  int _periodSortKey(String period) {
    const months = [
      'ocak', 'şubat', 'mart', 'nisan', 'mayıs', 'haziran',
      'temmuz', 'ağustos', 'eylül', 'ekim', 'kasım', 'aralık',
    ];
    final lower = period.toLowerCase();
    var monthIndex = 0;
    for (var i = 0; i < months.length; i++) {
      if (lower.contains(months[i])) {
        monthIndex = i + 1;
        break;
      }
    }
    final yearMatch = RegExp(r'(\d{4})').firstMatch(period);
    final year = yearMatch != null ? int.parse(yearMatch.group(1)!) : 0;
    return year * 100 + monthIndex;
  }

  /// Dönem seçim satırı: tüm dönemler + kayıtlardaki her dönem için bir seçenek.
  Widget _buildPeriodFilter() {
    final l10n = AppLocalizations.of(context);
    final periods = _distinctPeriods();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        children: [
          Icon(
            Icons.calendar_month,
            size: 20,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
          const SizedBox(width: 8),
          Text(l10n.periodLabel),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButton<String?>(
              isExpanded: true,
              value: _periodFilter,
              hint: Text(l10n.allPeriods),
              underline: const SizedBox.shrink(),
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(l10n.allPeriods),
                ),
                for (final period in periods)
                  DropdownMenuItem<String?>(
                    value: period,
                    child: Text(period),
                  ),
              ],
              onChanged: (value) {
                setState(() => _periodFilter = value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _remindPayment(PaymentRecord payment) async {
    await sendPaymentReminder(
      context,
      payment,
      findStudentForPayment(payment, widget.students),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final query = _searchQuery.toLowerCase();

    // Arama + dönem filtresi: özet şeridi bu kümeyi yansıtır (durum çipleri
    // yalnızca alttaki listeyi daraltır, özeti değil).
    final searchAndPeriodFiltered = widget.payments.where((payment) {
      final matchesQuery =
          payment.studentName.toLowerCase().contains(query) ||
          payment.period.toLowerCase().contains(query) ||
          payment.status.toLowerCase().contains(query);

      final matchesPeriod =
          _periodFilter == null || payment.period == _periodFilter;

      return matchesQuery && matchesPeriod;
    }).toList();

    final filteredPayments = searchAndPeriodFiltered
        .where(
          (payment) => _statusFilter == null || payment.status == _statusFilter,
        )
        .toList();
    final canAddPayment = widget.isAdmin && widget.students.isNotEmpty;

    return WaveScaffold(
      appBar: AppBar(title: Text(l10n.navPayments)),
      body: Column(
        children: [
          if (widget.payments.isNotEmpty)
            _PaymentSummaryBar(payments: searchAndPeriodFiltered),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                labelText: l10n.paymentsSearchHint,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          if (widget.payments.isNotEmpty) _buildPeriodFilter(),
          if (widget.payments.isNotEmpty) _buildStatusFilters(),
          Expanded(
            child: widget.payments.isEmpty
                ? EmptyState(
                    icon: Icons.payment,
                    title: l10n.paymentsEmptyTitle,
                    message: widget.isAdmin
                        ? widget.students.isNotEmpty
                              ? l10n.paymentsEmptyAdmin
                              : l10n.paymentsEmptyNoStudent
                        : l10n.paymentsEmptyViewer,
                  )
                : filteredPayments.isEmpty
                ? EmptyState(
                    icon: Icons.search_off,
                    title: l10n.searchNoResults,
                    message: _statusFilter != null
                        ? l10n.paymentsNoStatusResults(
                            localizedPaymentStatus(l10n, _statusFilter!),
                          )
                        : l10n.searchNoResultsBody,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredPayments.length,
                    itemBuilder: (context, index) {
                      final payment = filteredPayments[index];
                      final originalIndex = widget.payments.indexOf(payment);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          onTap: () {
                            _openPaymentDetailScreen(originalIndex);
                          },
                          leading: CircleAvatar(
                            backgroundColor: _statusColor(payment.status),
                            foregroundColor: Colors.white,
                            child: const Icon(Icons.payments),
                          ),
                          title: Text(payment.studentName),
                          subtitle: Text(
                            '${payment.period} • ${payment.amount} TL\n${localizedPaymentStatus(l10n, payment.status)} • ${payment.dateText}',
                          ),
                          isThreeLine: true,
                          trailing: widget.isAdmin
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (payment.status != 'Ödendi')
                                      IconButton(
                                        icon: const Icon(
                                          Icons.notifications_active,
                                          color: Colors.teal,
                                        ),
                                        tooltip: l10n.remindTooltip,
                                        onPressed: () => _remindPayment(payment),
                                      ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        _confirmDeletePayment(originalIndex);
                                      },
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: canAddPayment
          ? FloatingActionButton(
              onPressed: _openAddPaymentScreen,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

/// Bir ödemenin ait olduğu öğrenciyi bulur (önce id, sonra ada göre eşleşir).
Student? findStudentForPayment(PaymentRecord payment, List<Student> students) {
  if (payment.studentId.isNotEmpty) {
    for (final student in students) {
      if (student.id == payment.studentId) {
        return student;
      }
    }
  }
  for (final student in students) {
    if (student.name == payment.studentName) {
      return student;
    }
  }
  return null;
}

/// Veliye ödeme hatırlatması gönderir: öğrencinin veli telefonuna, hazır bir
/// mesajla WhatsApp'ı dışarıda açar. Sunucu/SMS gerektirmez (ücretsiz).
///
/// Telefon yoksa ya da WhatsApp açılamazsa kullanıcıya bilgi verilir.
Future<void> sendPaymentReminder(
  BuildContext context,
  PaymentRecord payment,
  Student? student,
) async {
  final phone = student?.parentPhone ?? '';
  if (sanitizeTrPhone(phone).isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).noParentPhone),
      ),
    );
    return;
  }

  final durum = payment.status == 'Gecikti'
      ? 'gecikmiş durumdadır'
      : 'ödemesi beklenmektedir';
  final message =
      'Sayın velimiz, ${payment.studentName} için ${payment.period} dönemi '
      'aidatı (${formatThousands(payment.amount)} TL) $durum. '
      'Bilginize, teşekkür ederiz.';

  await launchWhatsApp(context, phone: phone, message: message);
}

/// Ödeme listesinin üstündeki özet şeridi: duruma göre toplam tutar ve sayı.
///
/// Düz listede kaybolan "ne kadar tahsil edildi, ne kadar bekliyor" bilgisini
/// tek bakışta verir. Hem admin/antrenör hem veli aynı özeti görür.
class _PaymentSummaryBar extends StatelessWidget {
  final List<PaymentRecord> payments;

  const _PaymentSummaryBar({required this.payments});

  int _sumFor(String status) => payments
      .where((p) => p.status == status)
      .fold(0, (total, p) => total + p.amount);

  int _countFor(String status) =>
      payments.where((p) => p.status == status).length;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        child: Row(
          children: [
            _stat(
              context,
              label: l10n.paymentCollectedLabel,
              amount: _sumFor('Ödendi'),
              count: _countFor('Ödendi'),
              color: Colors.green,
            ),
            _divider(),
            _stat(
              context,
              label: l10n.metricPending,
              amount: _sumFor('Bekliyor'),
              count: _countFor('Bekliyor'),
              color: Colors.orange,
            ),
            _divider(),
            _stat(
              context,
              label: l10n.metricOverdue,
              amount: _sumFor('Gecikti'),
              count: _countFor('Gecikti'),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(
    width: 1,
    height: 40,
    color: Colors.grey.withValues(alpha: 0.25),
  );

  Widget _stat(
    BuildContext context, {
    required String label,
    required int amount,
    required int count,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${formatThousands(amount)} TL',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            AppLocalizations.of(context).recordCount(count),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentDetailScreen extends StatefulWidget {
  final List<PaymentRecord> payments;
  final List<Student> students;
  final int index;
  final bool isAdmin;
  final Future<void> Function(int index, PaymentRecord updatedPayment)
  onUpdatePayment;

  const PaymentDetailScreen({
    super.key,
    required this.payments,
    required this.students,
    required this.index,
    required this.isAdmin,
    required this.onUpdatePayment,
  });

  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  PaymentRecord get _payment => widget.payments[widget.index];

  Color _statusColor(String status) {
    if (status == 'Ödendi') {
      return Colors.green;
    }

    if (status == 'Gecikti') {
      return Colors.red;
    }

    return Colors.orange;
  }

  Future<void> _openEditPaymentScreen() async {
    final updatedPayment = await Navigator.push<PaymentRecord>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddPaymentScreen(students: widget.students, payment: _payment),
      ),
    );

    if (updatedPayment == null) {
      return;
    }

    await widget.onUpdatePayment(widget.index, updatedPayment);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final payment = _payment;

    return WaveScaffold(
      appBar: AppBar(
        title: Text(l10n.paymentDetailTitle),
        actions: widget.isAdmin
            ? [
                IconButton(
                  onPressed: _openEditPaymentScreen,
                  icon: const Icon(Icons.edit),
                ),
              ]
            : null,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: _statusColor(payment.status),
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.payments, size: 36),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    payment.studentName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('${payment.period} • ${payment.amount} TL'),
                  const SizedBox(height: 8),
                  Text(
                    localizedPaymentStatus(l10n, payment.status),
                    style: TextStyle(
                      color: _statusColor(payment.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(l10n.roleStudent),
              subtitle: Text(payment.studentName),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: Text(l10n.fieldPeriod),
              subtitle: Text(payment.period),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.attach_money),
              title: Text(l10n.fieldAmount),
              subtitle: Text('${payment.amount} TL'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: Text(l10n.fieldStatus),
              subtitle: Text(localizedPaymentStatus(l10n, payment.status)),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.event),
              title: Text(l10n.fieldDate),
              subtitle: Text(payment.dateText),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.note),
              title: Text(l10n.fieldNote),
              subtitle: Text(payment.note.isEmpty ? l10n.noNote : payment.note),
            ),
          ),
          const SizedBox(height: 20),
          if (widget.isAdmin && payment.status != 'Ödendi') ...[
            ElevatedButton.icon(
              onPressed: () => sendPaymentReminder(
                context,
                payment,
                findStudentForPayment(payment, widget.students),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.notifications_active),
              label: Text(l10n.remindViaWhatsApp),
            ),
            const SizedBox(height: 8),
          ],
          if (widget.isAdmin)
            ElevatedButton.icon(
              onPressed: _openEditPaymentScreen,
              icon: const Icon(Icons.edit),
              label: Text(l10n.editPaymentTitle),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: Text(l10n.backToPaymentList),
          ),
        ],
      ),
    );
  }
}

class AddPaymentScreen extends StatefulWidget {
  final List<Student> students;
  final PaymentRecord? payment;

  const AddPaymentScreen({super.key, required this.students, this.payment});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _periodController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final List<String> _statuses = const ['Ödendi', 'Bekliyor', 'Gecikti'];

  String? _selectedStudentId;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();

    _selectedStatus = _statuses.first;

    final payment = widget.payment;

    if (payment != null) {
      _selectedStatus = payment.status;
      _periodController.text = payment.period;
      _amountController.text = payment.amount.toString();
      _dateController.text = payment.dateText;
      _noteController.text = payment.note;

      // Önce id ile, eski kayıtlar için ada göre eşleştir.
      if (payment.studentId.isNotEmpty &&
          widget.students.any((s) => s.id == payment.studentId)) {
        _selectedStudentId = payment.studentId;
      } else {
        final matchByName = widget.students
            .where((s) => s.name == payment.studentName)
            .toList();
        if (matchByName.isNotEmpty) {
          _selectedStudentId = matchByName.first.id;
        }
      }
    } else {
      if (widget.students.isNotEmpty) {
        _selectedStudentId = widget.students.first.id;
      }

      final now = DateTime.now();
      final day = now.day.toString().padLeft(2, '0');
      final month = now.month.toString().padLeft(2, '0');
      final year = now.year.toString();

      _dateController.text = '$day.$month.$year';
    }
  }

  Student? get _selectedStudent {
    for (final student in widget.students) {
      if (student.id == _selectedStudentId) {
        return student;
      }
    }
    return null;
  }

  @override
  void dispose() {
    _periodController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _savePayment() {
    final isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    final student = _selectedStudent;
    if (student == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).selectStudentFirst)),
      );
      return;
    }

    final payment = PaymentRecord(
      studentId: student.id,
      studentName: student.name,
      period: _periodController.text.trim(),
      amount: int.parse(_amountController.text.trim()),
      status: _selectedStatus!,
      dateText: _dateController.text.trim(),
      note: _noteController.text.trim(),
    );

    Navigator.pop(context, payment);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isEditing = widget.payment != null;

    return WaveScaffold(
      appBar: AppBar(
        title: Text(isEditing ? l10n.editPaymentTitle : l10n.addPaymentTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: widget.students.isEmpty
            ? Center(
                child: Text(
                  l10n.paymentNeedStudent,
                  textAlign: TextAlign.center,
                ),
              )
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: _selectedStudentId,
                      decoration: InputDecoration(
                        labelText: l10n.roleStudent,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      items: widget.students.map((student) {
                        return DropdownMenuItem<String>(
                          value: student.id,
                          child: Text(student.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStudentId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.studentRequired;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _periodController,
                      decoration: InputDecoration(
                        labelText: l10n.fieldPeriod,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.calendar_month),
                        hintText: 'Haziran 2026',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.periodEmpty;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: l10n.fieldAmount,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.attach_money),
                        hintText: '1500',
                        suffixText: 'TL',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.amountEmpty;
                        }

                        final amount = int.tryParse(value.trim());

                        if (amount == null) {
                          return l10n.amountMustBeNumber;
                        }

                        if (amount <= 0) {
                          return l10n.amountPositive;
                        }

                        if (amount > 100000) {
                          return l10n.amountTooHigh;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedStatus,
                      decoration: InputDecoration(
                        labelText: l10n.fieldStatus,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.info),
                      ),
                      items: _statuses.map((status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(localizedPaymentStatus(l10n, status)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.statusRequired;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _dateController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: l10n.fieldDate,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.event),
                        hintText: '24.06.2026',
                      ),
                      validator: dateValidator(l10n),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _noteController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: l10n.fieldNote,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.note),
                        hintText: l10n.noteHint,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _savePayment,
                      icon: const Icon(Icons.save),
                      label: Text(
                        isEditing ? l10n.saveChanges : l10n.savePayment,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
