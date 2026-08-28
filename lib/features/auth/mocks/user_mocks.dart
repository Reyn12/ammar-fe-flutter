import '../models/app_role.dart';
import '../models/user_model.dart';
import '../models/user_role_model.dart';

// TODO: hapus file ini kalau endpoint /v1/auth/login sudah siap di backend.
class UserMocks {
  const UserMocks._();

  static const cashier = UserModel(
    id: 1,
    name: 'Rani Kasir',
    email: 'kasir@ammar.id',
    role: 'cashier',
    roles: [
      UserRoleModel(id: 1, name: 'cashier', description: 'Kasir cabang'),
    ],
  );

  static const kitchen = UserModel(
    id: 2,
    name: 'Pak Udin',
    email: 'dapur@ammar.id',
    role: 'kitchen',
    roles: [
      UserRoleModel(id: 2, name: 'kitchen', description: 'Koki / dapur'),
    ],
  );

  /// Password demo sementara (mock UI, belum API).
  static const demoPassword = '123456';

  static const demoCashierUsername = 'kasir';
  static const demoKitchenUsername = 'dapur';

  static bool isValidLogin(String username, String password) {
    final normalized = username.trim().toLowerCase();
    if (password != demoPassword) return false;

    return normalized == demoCashierUsername ||
        normalized == demoKitchenUsername;
  }

  static UserModel userForLogin(String username) {
    final normalized = username.trim().toLowerCase();
    return normalized == demoKitchenUsername ? kitchen : cashier;
  }

  static AppRole roleOf(UserModel user) =>
      AppRole.fromValue(user.role) ?? AppRole.cashier;
}
