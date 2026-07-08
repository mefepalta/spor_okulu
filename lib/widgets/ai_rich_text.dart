import 'package:flutter/material.dart';

/// SporTekAi yanıtlarındaki hafif markdown'ı okunur biçimde gösterir.
///
/// Model çoğu zaman `**kalın**`, `*italik*`, `` `kod` ``, `#` başlık ve `- `
/// madde imleri döndürür. Düz [Text] bunları ham işaretlerle gösterip "bozuk"
/// görünür; bu widget yaygın söz dizimini [Text.rich] ile biçimlendirir.
/// Amaç tam bir markdown motoru değil; sohbet için yeterli, bağımlılıksız bir
/// gösterimdir.
class AiRichText extends StatelessWidget {
  final String data;
  final TextStyle? style;

  const AiRichText(this.data, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    final base = (style ?? const TextStyle()).copyWith(height: 1.4);
    final lines = data.split('\n');
    final spans = <InlineSpan>[];

    for (var i = 0; i < lines.length; i++) {
      var line = lines[i];
      var lineStyle = base;

      // Başlık (# ... ######) → kalın satır.
      final heading = RegExp(r'^\s*#{1,6}\s+').firstMatch(line);
      if (heading != null) {
        line = line.substring(heading.end);
        lineStyle = base.copyWith(fontWeight: FontWeight.bold);
      }

      // Madde imi (- veya *) → •. Numaralı liste (1.) olduğu gibi kalır.
      line = line.replaceFirst(RegExp(r'^(\s*)[-*]\s+'), r'$1• ');

      spans.addAll(_inlineSpans(line, lineStyle));
      if (i < lines.length - 1) {
        spans.add(const TextSpan(text: '\n'));
      }
    }

    return Text.rich(TextSpan(style: base, children: spans));
  }

  /// Bir satır içindeki `**kalın**`, `*italik*` ve `` `kod` `` parçalarını ayırır.
  List<InlineSpan> _inlineSpans(String text, TextStyle base) {
    final spans = <InlineSpan>[];
    final pattern = RegExp(r'\*\*(.+?)\*\*|`([^`]+?)`|\*(.+?)\*');
    var start = 0;

    for (final match in pattern.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      if (match.group(1) != null) {
        spans.add(
          TextSpan(
            text: match.group(1),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      } else if (match.group(2) != null) {
        spans.add(
          TextSpan(
            text: match.group(2),
            style: TextStyle(
              fontFamily: 'monospace',
              backgroundColor: base.color?.withValues(alpha: 0.08),
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: match.group(3),
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        );
      }
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }
    return spans;
  }
}
