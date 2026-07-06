import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/app_models.dart';
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
    final payment = widget.payments[index];

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ödemeyi Sil'),
          content: Text(
            '${payment.studentName} - ${payment.period} ödeme kaydını silmek istediğine emin misin',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Vazgeç'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Sil', style: TextStyle(color: Colors.red)),
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
    ).showSnackBar(const SnackBar(content: Text('Ödeme kaydı silindi.')));
  }

  @override
  Widget build(BuildContext context) {
    final filteredPayments = widget.payments.where((payment) {
      final query = _searchQuery.toLowerCase();

      return payment.studentName.toLowerCase().contains(query) ||
          payment.period.toLowerCase().contains(query) ||
          payment.status.toLowerCase().contains(query);
    }).toList();
    final canAddPayment = widget.isAdmin && widget.students.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Ödemeler')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Ödeme ara',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: widget.payments.isEmpty
                ? EmptyState(
                    icon: Icons.payment,
                    title: 'Henüz ödeme kaydı yok',
                    message: widget.isAdmin
                        ? widget.students.isNotEmpty
                              ? 'Yeni ödeme kaydı eklemek için sağ alttaki + butonunu kullan.'
                              : 'Odeme eklemek için once en az bir öğrenci ekle.'
                        : 'Henüz ödeme kaydı yok. Admin ödeme eklediçinde burada görünecek.',
                  )
                : filteredPayments.isEmpty
                ? const EmptyState(
                    icon: Icons.search_off,
                    title: 'Sonuç bulunamadı',
                    message: 'Arama metnini değiştirerek tekrar dene.',
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
                            '${payment.period} • ${payment.amount} TL\n${payment.status} • ${payment.dateText}',
                          ),
                          isThreeLine: true,
                          trailing: widget.isAdmin
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _confirmDeletePayment(originalIndex);
                                  },
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
    final payment = _payment;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödeme Detayı'),
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
                    payment.status,
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
              title: const Text('Öğrenci'),
              subtitle: Text(payment.studentName),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Ay / Dönem'),
              subtitle: Text(payment.period),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Tutar'),
              subtitle: Text('${payment.amount} TL'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Durum'),
              subtitle: Text(payment.status),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Tarih'),
              subtitle: Text(payment.dateText),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.note),
              title: const Text('Not'),
              subtitle: Text(payment.note.isEmpty ? 'Not yok.' : payment.note),
            ),
          ),
          const SizedBox(height: 20),
          if (widget.isAdmin)
            ElevatedButton.icon(
              onPressed: _openEditPaymentScreen,
              icon: const Icon(Icons.edit),
              label: const Text('Ödemeyi Düzenle'),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Ödeme Listesine Dön'),
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
        const SnackBar(content: Text('Önce bir öğrenci seçmelisin.')),
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
    final isEditing = widget.payment != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Ödemeyi Düzenle' : 'Yeni Ödeme Ekle'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: widget.students.isEmpty
            ? const Center(
                child: Text(
                  'Ödeme eklemek için önce en az bir öğrenci eklemelisin.',
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
                      decoration: const InputDecoration(
                        labelText: 'Öğrenci',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
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
                          return 'Öğrenci seçmelisin.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _periodController,
                      decoration: const InputDecoration(
                        labelText: 'Ay / Dönem',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_month),
                        hintText: 'Haziran 2026',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Ay / dönem boş bırakılamaz.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Tutar',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                        hintText: '1500',
                        suffixText: 'TL',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Tutar boş bırakılamaz.';
                        }

                        final amount = int.tryParse(value.trim());

                        if (amount == null) {
                          return 'Tutar sayı olmalıdır.';
                        }

                        if (amount <= 0) {
                          return 'Tutar 0’dan büyük olmalıdır.';
                        }

                        if (amount > 100000) {
                          return 'Tutar çok yüksek görünüyor.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedStatus,
                      decoration: const InputDecoration(
                        labelText: 'Durum',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.info),
                      ),
                      items: _statuses.map((status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Durum seçmelisin.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _dateController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: 'Tarih',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.event),
                        hintText: '24.06.2026',
                      ),
                      validator: validateDateText,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _noteController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Not',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.note),
                        hintText: 'İsteğe bağlı not',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _savePayment,
                      icon: const Icon(Icons.save),
                      label: Text(
                        isEditing ? 'Değişiklikleri Kaydet' : 'Ödemeyi Kaydet',
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
