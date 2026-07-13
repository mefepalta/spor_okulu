import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Uygulama kapalı/arka plandayken gelen bildirim mesajları sistem tarafından
/// otomatik gösterilir; ekstra işe gerek yok. Bu üst düzey fonksiyon yalnızca
/// arka plan isolate'i için kayıtlı olmak zorunda olduğundan tanımlı.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Bilinçli olarak boş: bildirim mesajlarını Android sistem tepsisi gösterir.
}

/// Firebase Cloud Messaging (FCM) alıcı tarafı.
///
/// Sorumlulukları:
///  - Bildirim iznini ister (Android 13+ / iOS).
///  - "all" konusuna abone olur (duyurular herkese yayınlanır).
///  - Cihaz FCM jetonunu `users/{uid}.fcmToken` alanına yazar (yenilenince
///    günceller) ki sunucu tarafı ileride kişiye özel (ör. aidat hatırlatma)
///    bildirim gönderebilsin.
///
/// Gönderme tarafı (Cloudflare Worker + servis hesabı) ayrı bir fazda kurulur.
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  bool _initialized = false;

  /// Uygulama açılışında bir kez çağrılır (giriş sonrası). İzin ister, arka
  /// plan işleyicisini kaydeder ve genel konuya abone olur. Hata olursa sessizce
  /// yutulur; bildirim, uygulamanın çalışması için kritik değildir.
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    try {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      await _messaging.requestPermission();

      // Genel duyurular için konu aboneliği (web'de topic desteklenmez).
      if (!kIsWeb) {
        await _messaging.subscribeToTopic('all');
      }
    } catch (error) {
      debugPrint('Bildirim başlatma hatası: $error');
    }
  }

  /// Giriş yapmış kullanıcının cihaz jetonunu Firestore'a yazar ve jeton
  /// yenilendiğinde günceller. Giriş sonrası çağrılmalıdır.
  Future<void> registerTokenForCurrentUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      final token = await _messaging.getToken();
      if (token != null) {
        await _saveToken(uid, token);
      }
      _messaging.onTokenRefresh.listen((refreshed) => _saveToken(uid, refreshed));
    } catch (error) {
      debugPrint('FCM jetonu kaydedilemedi: $error');
    }
  }

  Future<void> _saveToken(String uid, String token) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set(
        {'fcmToken': token, 'fcmUpdatedAt': FieldValue.serverTimestamp()},
        SetOptions(merge: true),
      );
    } catch (error) {
      debugPrint('FCM jetonu yazılamadı: $error');
    }
  }
}
