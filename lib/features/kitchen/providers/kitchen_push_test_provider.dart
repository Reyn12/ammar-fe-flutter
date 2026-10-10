import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/api_service.dart';

part 'kitchen_push_test_provider.g.dart';

/// Tombol bel di header dapur: minta server mengirim notifikasi tes ke tablet ini.
/// State berisi pesan hasil dari server (null sebelum dipakai).
@riverpod
class KitchenPushTest extends _$KitchenPushTest {
  @override
  FutureOr<String?> build() => null;

  Future<void> send() async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(apiServiceProvider).sendTestPush(),
    );
  }
}
