// Sayısal biçimlendirme yardımcıları (tek yerde, tüm ekranlar paylaşır).

/// Tam sayıyı Türk usulü binlik ayraçla biçimler: `1500 -> "1.500"`.
/// Sembol/para birimi eklemez; metin ekleyen çağıran taraf karar verir.
String formatThousands(int amount) {
  final digits = amount.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(digits[i]);
  }
  return '${amount < 0 ? '-' : ''}$buffer';
}

/// Kuruşsuz TL tutarını binlik ayraç + ₺ sembolüyle biçimler: `12500 -> "12.500 ₺"`.
String formatTl(int amount) => '${formatThousands(amount)} ₺';
