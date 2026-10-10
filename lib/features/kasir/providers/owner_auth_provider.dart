import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/api_service.dart';
import '../../../network/environment.dart';
import '../../auth/mocks/user_mocks.dart';

part 'owner_auth_provider.g.dart';

/// Password owner untuk mock login lokal.
@Riverpod(keepAlive: true)
class OwnerAuth extends _$OwnerAuth {
  @override
  String build() => UserMocks.demoPassword;

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // Password asli divalidasi backend (pesan error dari server ditampilkan apa adanya).
    // Pencocokan lokal hanya untuk mode mock.
    if (mockStatus) {
      if (currentPassword != state) {
        throw Exception('Password lama tidak sesuai.');
      }
      if (newPassword == currentPassword) {
        throw Exception('Password baru harus berbeda dari password lama.');
      }
    }

    await ref
        .read(apiServiceProvider)
        .changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
        );

    state = newPassword;
  }
}
