import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'api_service.dart';
import 'environment.dart';

part 'push_notification_service.g.dart';

/// Harus sama dengan `services.firebase.android_channel` / `android_sound` di backend
/// dan file `android/app/src/main/res/raw/notif_order_masuk.wav`.
const String _orderChannelId = 'order_masuk_v2';

/// Channel versi lama (suara pelan). Suara channel tidak bisa diubah setelah dibuat, jadi dihapus.
const String _legacyOrderChannelId = 'order_masuk';
const String _orderSoundName = 'notif_order_masuk';

/// Push notifikasi pesanan masuk lewat FCM, supaya kasir/dapur tetap dapat bunyi saat app
/// di background. Saat app terbuka, bunyi dan toast datang dari SSE (lihat OrderSound).
///
/// Semua langkah aman dijalankan tanpa konfigurasi Firebase (google-services.json belum ada):
/// push mati, sisa app tetap jalan.
class PushNotificationService {
  PushNotificationService(this.api);

  final ApiService api;

  static final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();
  static bool _firebaseReady = false;
  static StreamSubscription<String>? _tokenRefresh;
  static String? _registeredToken;

  /// Dipanggil sekali di main(): inisialisasi Firebase dan buat channel dengan suara kustom.
  /// Suara channel Android tidak bisa diubah setelah dibuat; kalau ganti suara, pakai id channel baru.
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      await _local.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ),
      );
      final android = _local
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      await android?.deleteNotificationChannel(
        channelId: _legacyOrderChannelId,
      );
      await android?.createNotificationChannel(
        const AndroidNotificationChannel(
          _orderChannelId,
          'Pesanan masuk',
          description: 'Bunyi saat ada pesanan baru',
          importance: Importance.max,
          sound: RawResourceAndroidNotificationSound(_orderSoundName),
        ),
      );
      _firebaseReady = true;
    } catch (e) {
      debugPrint('Push notifikasi dimatikan: $e');
    }
  }

  /// Minta izin, ambil token FCM, lalu daftarkan ke backend untuk akun yang sedang login.
  Future<void> register() async {
    if (!_firebaseReady || mockStatus) return;

    try {
      await FirebaseMessaging.instance.requestPermission();

      final token = await FirebaseMessaging.instance.getToken();
      if (token == null) return;
      await _send(token);

      // Token bisa berganti sewaktu-waktu; daftarkan ulang otomatis.
      await _tokenRefresh?.cancel();
      _tokenRefresh = FirebaseMessaging.instance.onTokenRefresh.listen(
        (next) => unawaited(_send(next)),
      );
    } catch (e) {
      debugPrint('Gagal mendaftarkan perangkat untuk push: $e');
    }
  }

  /// Lepas token dari akun ini (panggil sebelum logout, selagi masih terautentikasi).
  Future<void> unregister() async {
    if (!_firebaseReady || mockStatus) return;

    await _tokenRefresh?.cancel();
    _tokenRefresh = null;

    final token = _registeredToken;
    if (token == null) return;

    try {
      await api.unregisterDevice(token: token);
      _registeredToken = null;
    } catch (e) {
      debugPrint('Gagal melepas perangkat dari push: $e');
    }
  }

  Future<void> _send(String token) async {
    await api.registerDevice(token: token);
    _registeredToken = token;
  }
}

@Riverpod(keepAlive: true)
PushNotificationService pushNotificationService(Ref ref) =>
    PushNotificationService(ref.watch(apiServiceProvider));
