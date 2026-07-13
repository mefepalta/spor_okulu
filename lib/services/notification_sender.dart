import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/fcm_config.dart';

/// Push bildirim **gönderme** tarafı: yetkili kullanıcı (admin/antrenör) adına
/// FCM Worker'ına istek atar. Worker, çağıranın Firebase kimliğini doğrular ve
/// rolünü kontrol eder; bu yüzden burada yalnızca ID token'ı iletmek yeterli.
///
/// Worker yapılandırılmamışsa ([FcmConfig.isConfigured] false) gönderim sessizce
/// atlanır — böylece Worker deploy edilmeden de uygulama sorunsuz çalışır.
class NotificationSender {
  final http.Client _client;

  NotificationSender({http.Client? client})
    : _client = client ?? http.Client();

  /// Duyuruyu bir konuya gönderir. Varsayılan "all" (herkes); rol hedefli
  /// duyurular için ilgili `role_<rol>` konusu geçilir.
  Future<bool> sendAnnouncement({
    required String title,
    required String body,
    String topic = FcmConfig.broadcastTopic,
  }) {
    return _send({
      'mode': 'topic',
      'topic': topic,
      'title': title,
      'body': body,
      'data': {'type': 'announcement'},
    });
  }

  /// Tek bir veliye (cihaz jetonuna) aidat hatırlatması gönderir.
  Future<bool> sendDuesReminder({
    required String token,
    required String title,
    required String body,
  }) {
    return _send({
      'mode': 'token',
      'token': token,
      'title': title,
      'body': body,
      'data': {'type': 'dues'},
    });
  }

  Future<bool> _send(Map<String, dynamic> payload) async {
    if (!FcmConfig.isConfigured) return false;

    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (idToken == null) return false;

    try {
      final response = await _client
          .post(
            Uri.parse(FcmConfig.endpoint),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $idToken',
            },
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) return true;
      debugPrint('Push gönderilemedi (${response.statusCode}): ${response.body}');
      return false;
    } catch (error) {
      debugPrint('Push gönderme hatası: $error');
      return false;
    }
  }
}
