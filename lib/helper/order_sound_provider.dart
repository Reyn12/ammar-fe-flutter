import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_sound_provider.g.dart';

/// Bunyi sekali saat pesanan baru masuk dan app sedang terbuka.
/// Saat app di background, bunyi datang dari push FCM (lihat PushNotificationService).
class OrderSound {
  OrderSound(this.player);

  final AudioPlayer player;

  Future<void> play() async {
    try {
      await player.stop();
      await player.play(AssetSource('sounds/notif-order-masuk.wav'));
    } catch (e) {
      // Bunyi hanya pelengkap; jangan sampai menggagalkan alert pesanan.
      debugPrint('Gagal memutar bunyi pesanan: $e');
    }
  }
}

@Riverpod(keepAlive: true)
OrderSound orderSound(Ref ref) {
  final player = AudioPlayer();
  ref.onDispose(player.dispose);
  return OrderSound(player);
}
