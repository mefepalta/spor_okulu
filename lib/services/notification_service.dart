import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  /// Ön plan bildirimleri ve (manifest'teki varsayılan kanal üzerinden) arka
  /// plan bildirimleri için yüksek önemli kanal. Kimliği AndroidManifest'teki
  /// `default_notification_channel_id` ile aynı olmalı.
  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
        'sporokulu_default',
        'Genel Bildirimler',
        description: 'Duyurular ve hatırlatmalar',
        importance: Importance.high,
      );

  /// Uygulama açılışında bir kez çağrılır (giriş sonrası). İzin ister, arka
  /// plan işleyicisini kaydeder, genel konuya abone olur ve ön planda gelen
  /// bildirimleri yerel bildirimle gösterir. Hata olursa sessizce yutulur;
  /// bildirim, uygulamanın çalışması için kritik değildir.
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    try {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      // Yerel bildirim eklentisi + yüksek önemli kanal (ön planda görünür
      // bildirim ve arka planda tutarlı kanal için).
      if (!kIsWeb) {
        await _localNotifications.initialize(
          settings: const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          ),
        );
        await _localNotifications
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.createNotificationChannel(_androidChannel);
      }

      await _messaging.requestPermission();

      // Genel duyurular için konu aboneliği (web'de topic desteklenmez).
      if (!kIsWeb) {
        await _messaging.subscribeToTopic('all');
      }

      // Ön planda gelen bildirimler otomatik gösterilmez; yerel bildirimle
      // göster. Arka plan/kapalı durumu sistem tepsisi kendisi gösterir.
      FirebaseMessaging.onMessage.listen(_showForegroundNotification);
    } catch (error) {
      debugPrint('Bildirim başlatma hatası: $error');
    }
  }

  void _showForegroundNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null || kIsWeb) return;
    _localNotifications.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  /// Kullanıcının rolüne karşılık gelen konuya abone eder (rol bazlı hedefli
  /// duyurular için). "Herkes" hedefli duyurular 'all' konusuna gider ([initialize]);
  /// role özel duyurular ise `role_<rol>` konusuna. Rol öğrenildikten (giriş
  /// sonrası) çağrılır. Viewer'ın rol konusu yoktur (no-op).
  Future<void> subscribeToRoleTopic(String role) async {
    final topic = _roleTopic(role);
    if (topic == null || kIsWeb) return;
    try {
      await _messaging.subscribeToTopic(topic);
    } catch (error) {
      debugPrint('Rol konusuna abone olunamadı ($role): $error');
    }
  }

  /// Firestore rolünü FCM konu adına eşler (viewer/bilinmeyen → null).
  static String? _roleTopic(String role) {
    switch (role) {
      case 'admin':
        return 'role_admin';
      case 'coach':
        return 'role_coach';
      case 'veli':
        return 'role_veli';
      case 'ogrenci':
        return 'role_ogrenci';
      default:
        return null;
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
