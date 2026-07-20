import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../constants/ai_config.dart';

/// Sohbet mesajı (rol + içerik). Rol: 'system' | 'user' | 'assistant'.
class AiMessage {
  final String role;
  final String content;

  const AiMessage({required this.role, required this.content});

  Map<String, String> toJson() => {'role': role, 'content': content};

  factory AiMessage.system(String content) =>
      AiMessage(role: 'system', content: content);
  factory AiMessage.user(String content) =>
      AiMessage(role: 'user', content: content);
  factory AiMessage.assistant(String content) =>
      AiMessage(role: 'assistant', content: content);
}

/// AI çağrısı başarısız olduğunda kullanıcıya gösterilecek mesajı taşır.
class AiException implements Exception {
  final String message;
  const AiException(this.message);

  @override
  String toString() => message;
}

/// SporTekAi: Cloudflare Worker proxy üzerinden Groq'a sohbet isteği atar.
///
/// Anahtar Worker'da saklanır; uygulama yalnızca [AiConfig.endpoint] adresine
/// mesajları gönderir. Ham kişisel veri gönderilmemesi çağıran tarafın
/// sorumluluğundadır (bkz. AiSummary).
class AiService {
  final http.Client _client;

  AiService({http.Client? client}) : _client = client ?? http.Client();

  Future<String> chat(List<AiMessage> messages) async {
    if (!AiConfig.isConfigured) {
      throw const AiException(
        'SporTekAi henüz yapılandırılmadı (SPORTEKAI_ENDPOINT tanımlı değil).',
      );
    }

    // K-2: Worker artık kimlik doğrulaması ister. Giriş yapmış kullanıcının
    // Firebase ID token'ını Authorization başlığında iletiriz; böylece Groq
    // anahtarını yalnızca bu projede oturum açmış kullanıcılar kullanabilir.
    final String? idToken;
    try {
      idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    } catch (_) {
      throw const AiException(
        'SporTekAi için kimlik doğrulanamadı. Lütfen tekrar giriş yap.',
      );
    }
    if (idToken == null) {
      throw const AiException(
        'SporTekAi için oturum gerekli. Lütfen giriş yap.',
      );
    }

    late final http.Response response;
    try {
      response = await _client
          .post(
            Uri.parse(AiConfig.endpoint),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $idToken',
            },
            body: jsonEncode({
              'model': AiConfig.model,
              'temperature': 0.4,
              'messages': messages.map((m) => m.toJson()).toList(),
            }),
          )
          .timeout(const Duration(seconds: 45));
    } catch (_) {
      throw const AiException(
        'SporTekAi\'ye ulaşılamadı. İnternet bağlantını kontrol et.',
      );
    }

    if (response.statusCode != 200) {
      throw AiException(
        'SporTekAi yanıt veremedi (hata ${response.statusCode}).',
      );
    }

    try {
      final data = jsonDecode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>;
      final choices = data['choices'] as List<dynamic>?;
      String? content;
      if (choices != null && choices.isNotEmpty) {
        final message = (choices.first as Map<String, dynamic>)['message'];
        if (message is Map<String, dynamic>) {
          content = message['content'] as String?;
        }
      }
      final text = content?.trim() ?? '';
      if (text.isEmpty) {
        throw const AiException('SporTekAi boş bir yanıt döndü.');
      }
      return text;
    } on AiException {
      rethrow;
    } catch (_) {
      throw const AiException('SporTekAi yanıtı çözümlenemedi.');
    }
  }
}
