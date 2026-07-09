import '../l10n/app_localizations.dart';

/// Telefon doğrulayıcı (dile duyarlı). Form alanlarında
/// `validator: phoneValidator(l10n)` şeklinde kullanılır.
String? Function(String?) phoneValidator(AppLocalizations l10n) {
  return (value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.phoneEmpty;
    }
    if (!RegExp(r'^05[0-9]{9}$').hasMatch(value.trim())) {
      return l10n.phoneFormat;
    }
    return null;
  };
}

/// Saat doğrulayıcı (dile duyarlı).
String? Function(String?) timeValidator(AppLocalizations l10n) {
  return (value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.timeEmpty;
    }
    if (!RegExp(r'^([01]\d|2[0-3]):[0-5]\d$').hasMatch(value.trim())) {
      return l10n.timeFormat;
    }
    return null;
  };
}

/// Tarih doğrulayıcı (dile duyarlı).
String? Function(String?) dateValidator(AppLocalizations l10n) {
  return (value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.dateEmpty;
    }
    final dateRegExp = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.[0-9]{4}$',
    );
    if (!dateRegExp.hasMatch(value.trim())) {
      return l10n.dateFormat;
    }
    return null;
  };
}

String normalizeTurkishText(String value) {
  return value
      .toLowerCase()
      .replaceAll('ı', 'i')
      .replaceAll('ğ', 'g')
      .replaceAll('ü', 'u')
      .replaceAll('ş', 's')
      .replaceAll('ö', 'o')
      .replaceAll('ç', 'c');
}

String dropdownDayFromText(String value) {
  final normalizedDay = normalizeTurkishText(value.trim());

  switch (normalizedDay) {
    case 'pazartesi':
      return 'Pazartesi';
    case 'sali':
      return 'Sali';
    case 'carsamba':
      return 'Carsamba';
    case 'persembe':
      return 'Persembe';
    case 'cuma':
      return 'Cuma';
    case 'cumartesi':
      return 'Cumartesi';
    case 'pazar':
      return 'Pazar';
    default:
      return 'Pazartesi';
  }
}

String? validateTime(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Saat boş bırakılamaz.';
  }

  final time = value.trim();
  final timeRegExp = RegExp(r'^([01]\d|2[0-3]):[0-5]\d$');

  if (!timeRegExp.hasMatch(time)) {
    return 'Saat 18:00 formatında olmalıdır.';
  }

  return null;
}

String normalizeTime(String value) {
  final parts = value.trim().split(':');

  final hour = int.parse(parts[0]).toString().padLeft(2, '0');
  final minute = int.parse(parts[1]).toString().padLeft(2, '0');

  return '$hour:$minute';
}

String? validateDateText(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Tarih boş bırakılamaz.';
  }

  final date = value.trim();

  final dateRegExp = RegExp(
    r'^(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.[0-9]{4}$',
  );

  if (!dateRegExp.hasMatch(date)) {
    return 'Tarih 24.06.2026 formatında olmalı.';
  }

  return null;
}
