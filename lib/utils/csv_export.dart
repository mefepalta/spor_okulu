import 'dart:convert';
import 'dart:io';
import 'dart:ui' show Rect;

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Bir CSV hücresini gerekiyorsa tırnak içine alır (virgül, tırnak, satır sonu
/// içeriyorsa) ve içteki tırnakları ikiye katlar (RFC 4180).
String _escape(String value) {
  if (value.contains(',') ||
      value.contains('"') ||
      value.contains('\n') ||
      value.contains('\r')) {
    return '"${value.replaceAll('"', '""')}"';
  }
  return value;
}

/// Başlık satırı + veri satırlarından CSV metni üretir.
String buildCsv(List<String> headers, List<List<String>> rows) {
  final buffer = StringBuffer();
  buffer.writeln(headers.map(_escape).join(','));
  for (final row in rows) {
    buffer.writeln(row.map(_escape).join(','));
  }
  return buffer.toString();
}

/// CSV'yi geçici bir dosyaya yazıp cihazın paylaş menüsüyle paylaşır.
/// Başa BOM eklenir ki Excel Türkçe karakterleri doğru açsın.
/// [sharePositionOrigin] iPad'de popover çapası için zorunludur
/// (bkz. utils/share_origin.dart).
Future<void> shareCsv(
  String filename,
  String csv, {
  Rect? sharePositionOrigin,
}) async {
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/$filename');
  await file.writeAsString('﻿$csv', encoding: utf8);
  await SharePlus.instance.share(
    ShareParams(
      files: [XFile(file.path, mimeType: 'text/csv')],
      sharePositionOrigin: sharePositionOrigin,
    ),
  );
}
