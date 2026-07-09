import 'package:flutter/material.dart';

import '../data/sports_data.dart';
import '../l10n/app_localizations.dart';

/// Branş seçimi için katalog sporlarından oluşan dropdown.
///
/// Sporlar tek kaynaktan ([sportsCatalog]) gelir. Düzenlenen eski bir kaydın
/// branşı katalogda yoksa, değeri kaybolmasın diye listeye eklenir; yeni
/// seçimler yalnızca katalogdandır.
class BranchDropdownFormField extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const BranchDropdownFormField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = value;
    final items = <String>[...sportNames];

    if (current != null && current.isNotEmpty && !items.contains(current)) {
      items.insert(0, current);
    }

    return DropdownButtonFormField<String>(
      initialValue: (current != null && current.isNotEmpty) ? current : null,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: l10n.fieldBranch,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.sports_soccer),
      ),
      items: items
          .map((s) => DropdownMenuItem<String>(value: s, child: Text(s)))
          .toList(),
      onChanged: onChanged,
      validator: (selected) =>
          (selected == null || selected.isEmpty) ? l10n.branchRequired : null,
    );
  }
}
