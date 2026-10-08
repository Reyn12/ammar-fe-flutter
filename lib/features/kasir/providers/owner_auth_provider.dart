import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/api_service.dart';
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
    if (currentPassword != state) {
      throw Exception('Password lama tidak sesuai.');
    }
    if (newPassword == currentPassword) {
      throw Exception('Password baru harus berbeda dari password lama.');
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
