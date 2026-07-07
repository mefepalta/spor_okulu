import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/app_models.dart';
import '../theme/app_colors.dart';
import '../widgets/empty_state.dart';
import '../widgets/summary_section.dart';
import '../widgets/wave_background.dart';

/// Depo / Ekipman envanteri ekranı.
///
/// Personel görür; admin/antrenör ekler, düzenler, siler. Üstte çeşit/adet/
/// dikkat özeti, altta kategoriye göre süzülebilen malzeme listesi.
class EquipmentScreen extends StatefulWidget {
  final List<EquipmentItem> items;
  final bool canManage;
  final Future<EquipmentItem> Function(EquipmentItem item) onAdd;
  final Future<void> Function(EquipmentItem item) onUpdate;
  final Future<void> Function(String id) onDelete;

  const EquipmentScreen({
    super.key,
    required this.items,
    required this.canManage,
    required this.onAdd,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<EquipmentScreen> createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends State<EquipmentScreen> {
  late final List<EquipmentItem> _items = List.of(widget.items);

  /// Seçili kategori filtresi; null ise tümü gösterilir.
  String? _categoryFilter;

  int get _totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  int get _attentionCount =>
      _items.where((item) => item.condition != EquipmentCondition.good).length;

  Color _conditionColor(String condition) {
    switch (condition) {
      case EquipmentCondition.good:
        return Colors.green;
      case EquipmentCondition.maintenance:
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  /// Envanterde bulunan kategoriler (filtre çipleri için).
  List<String> get _presentCategories {
    final categories = <String>{
      for (final item in _items)
        if (item.category.trim().isNotEmpty) item.category.trim(),
    }.toList();
    categories.sort();
    return categories;
  }

  List<EquipmentItem> get _filteredItems {
    if (_categoryFilter == null) {
      return _items;
    }
    return _items.where((item) => item.category == _categoryFilter).toList();
  }

  Future<void> _openForm({EquipmentItem? existing}) async {
    final result = await showModalBottomSheet<EquipmentItem>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _EquipmentForm(existing: existing),
    );
    if (result == null) {
      return;
    }

    if (existing == null) {
      final created = await widget.onAdd(result);
      if (!mounted) {
        return;
      }
      setState(() => _items.insert(0, created));
    } else {
      final updated = result.copyWith(id: existing.id);
      await widget.onUpdate(updated);
      if (!mounted) {
        return;
      }
      final index = _items.indexWhere((i) => i.id == existing.id);
      if (index != -1) {
        setState(() => _items[index] = updated);
      }
    }
  }

  Future<void> _delete(EquipmentItem item) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Malzemeyi sil'),
        content: Text('"${item.name}" kaydını silmek istiyor musunuz?'),
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
    await widget.onDelete(item.id);
    if (!mounted) {
      return;
    }
    setState(() => _items.removeWhere((i) => i.id == item.id));
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredItems;

    return WaveScaffold(
      appBar: AppBar(title: const Text('Depo')),
      floatingActionButton: widget.canManage
          ? FloatingActionButton.extended(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('Yeni Malzeme'),
            )
          : null,
      body: _items.isEmpty
          ? EmptyState(
              icon: Icons.inventory_2_outlined,
              title: 'Depo boş',
              message: widget.canManage
                  ? 'Henüz malzeme yok. Sağ alttaki butonla ilk kaydı ekleyin.'
                  : 'Henüz depoya malzeme eklenmemiş.',
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildSummaryCard(context),
                ),
                _buildCategoryFilter(),
                Expanded(
                  child: filtered.isEmpty
                      ? const EmptyState(
                          icon: Icons.search_off,
                          title: 'Sonuç yok',
                          message: 'Bu kategoride malzeme bulunmuyor.',
                        )
                      : ListView(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
                          children: [
                            for (final item in filtered) _buildTile(item),
                          ],
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return SummarySection(
      icon: Icons.inventory_2,
      title: 'Depo Özeti',
      iconColor: AppColors.primary,
      child: SummaryMetricsRow(
        metrics: [
          SummaryMetric(
            value: '${_items.length}',
            label: 'Çeşit',
            color: AppColors.primary,
          ),
          SummaryMetric(
            value: '$_totalQuantity',
            label: 'Toplam Adet',
            color: Colors.green,
          ),
          SummaryMetric(
            value: '$_attentionCount',
            label: 'Dikkat',
            color: _attentionCount > 0 ? Colors.orange : Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = _presentCategories;
    if (categories.isEmpty) {
      return const SizedBox(height: 8);
    }

    Widget chip(String label, String? value) {
      final selected = _categoryFilter == value;
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: FilterChip(
          label: Text(label),
          selected: selected,
          showCheckmark: false,
          selectedColor: AppColors.primary.withValues(alpha: 0.18),
          side: BorderSide(
            color: selected
                ? AppColors.primary
                : Colors.grey.withValues(alpha: 0.35),
          ),
          labelStyle: TextStyle(
            color: selected ? AppColors.primary : null,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
          onSelected: (_) => setState(() => _categoryFilter = value),
        ),
      );
    }

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          chip('Tümü', null),
          for (final category in categories) chip(category, category),
        ],
      ),
    );
  }

  Widget _buildTile(EquipmentItem item) {
    final conditionColor = _conditionColor(item.condition);
    final subtitleParts = [
      if (item.category.isNotEmpty) item.category,
      if (item.assignedTo.isNotEmpty) 'Zimmet: ${item.assignedTo}',
    ];

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: widget.canManage ? () => _openForm(existing: item) : null,
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.14),
          child: Text(
            '${item.quantity}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        title: Text(
          item.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subtitleParts.isNotEmpty)
              Text(
                subtitleParts.join(' • '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (item.note.isNotEmpty)
              Text(
                item.note,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: conditionColor.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item.condition,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: conditionColor,
                ),
              ),
            ),
            if (widget.canManage)
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                color: Colors.red,
                tooltip: 'Sil',
                onPressed: () => _delete(item),
              ),
          ],
        ),
      ),
    );
  }
}

/// Malzeme ekleme/düzenleme formu (alt sayfa).
class _EquipmentForm extends StatefulWidget {
  final EquipmentItem? existing;

  const _EquipmentForm({this.existing});

  @override
  State<_EquipmentForm> createState() => _EquipmentFormState();
}

class _EquipmentFormState extends State<_EquipmentForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _quantityController;
  late final TextEditingController _assignedController;
  late final TextEditingController _noteController;

  String? _category;
  late String _condition;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _nameController = TextEditingController(text: existing?.name ?? '');
    _quantityController = TextEditingController(
      text: existing != null ? existing.quantity.toString() : '1',
    );
    _assignedController = TextEditingController(text: existing?.assignedTo ?? '');
    _noteController = TextEditingController(text: existing?.note ?? '');
    _condition = existing?.condition ?? EquipmentCondition.good;
    if (existing != null &&
        existing.category.isNotEmpty &&
        EquipmentCategories.all.contains(existing.category)) {
      _category = existing.category;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _assignedController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    final quantity = int.tryParse(_quantityController.text.trim()) ?? 0;
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen malzeme adını yazın.')),
      );
      return;
    }
    if (quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adet 0’dan büyük olmalıdır.')),
      );
      return;
    }
    Navigator.pop(
      context,
      EquipmentItem(
        name: name,
        category: _category ?? '',
        quantity: quantity,
        condition: _condition,
        assignedTo: _assignedController.text.trim(),
        note: _noteController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isEditing ? 'Malzemeyi Düzenle' : 'Yeni Malzeme',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Malzeme adı',
                hintText: 'Örn: Futbol topu, forma...',
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
                for (final category in EquipmentCategories.all)
                  DropdownMenuItem(value: category, child: Text(category)),
              ],
              onChanged: (value) => setState(() => _category = value),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Adet',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _condition,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Durum',
                border: OutlineInputBorder(),
              ),
              items: [
                for (final condition in EquipmentCondition.all)
                  DropdownMenuItem(value: condition, child: Text(condition)),
              ],
              onChanged: (value) =>
                  setState(() => _condition = value ?? EquipmentCondition.good),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _assignedController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Zimmet (isteğe bağlı)',
                hintText: 'Kimde / nerede',
                border: OutlineInputBorder(),
              ),
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
              label: Text(isEditing ? 'Kaydet' : 'Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
