import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Türk telefon numarasını WhatsApp (wa.me) için uluslararası biçime getirir:
/// rakam dışı karakterleri atar, baştaki 0'ı kaldırır, 90 ülke kodunu ekler.
/// Numara ayrıştırılamazsa boş döner.
String sanitizeTrPhone(String raw) {
  var digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.isEmpty) {
    return '';
  }
  if (digits.startsWith('90')) {
    return digits;
  }
  if (digits.startsWith('0')) {
    digits = digits.substring(1);
  }
  return digits.isEmpty ? '' : '90$digits';
}

/// Verilen numaraya (isteğe bağlı hazır mesajla) WhatsApp'ı dış uygulamada açar.
/// Numara geçersizse veya açılamazsa [context] üzerinden bilgilendirir.
Future<void> launchWhatsApp(
  BuildContext context, {
  required String phone,
  String message = '',
}) async {
  final sanitized = sanitizeTrPhone(phone);
  if (sanitized.isEmpty) {
    _notify(context, 'Geçerli bir telefon numarası bulunamadı.');
    return;
  }
  final query = message.isEmpty ? '' : '?text=${Uri.encodeComponent(message)}';
  await _launchExternal(
    context,
    Uri.parse('https://wa.me/$sanitized$query'),
    'WhatsApp açılamadı.',
  );
}

/// Verilen adrese (isteğe bağlı konuyla) e-posta uygulamasını açar.
Future<void> launchEmailApp(
  BuildContext context, {
  required String email,
  String subject = '',
}) async {
  final uri = Uri(
    scheme: 'mailto',
    path: email,
    query: subject.isEmpty ? null : 'subject=${Uri.encodeComponent(subject)}',
  );
  await _launchExternal(context, uri, 'E-posta uygulaması açılamadı.');
}

Future<void> _launchExternal(
  BuildContext context,
  Uri uri,
  String errorMessage,
) async {
  try {
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched && context.mounted) {
      _notify(context, errorMessage);
    }
  } catch (_) {
    if (context.mounted) {
      _notify(context, errorMessage);
    }
  }
}

void _notify(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
