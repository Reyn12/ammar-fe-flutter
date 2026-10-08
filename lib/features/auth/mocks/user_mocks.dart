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

  static const owner = UserModel(
    id: 99,
    name: 'Pak Ammar',
    email: 'owner@ammar.id',
    role: 'owner',
    roles: [
      UserRoleModel(id: 3, name: 'owner', description: 'Pemilik toko'),
    ],
  );

  /// Password demo sementara (mock UI, belum API).
  static const demoPassword = '123456';

  static const demoCashierUsername = 'kasir';
  static const demoKitchenUsername = 'dapur';
  static const demoOwnerUsername = 'owner';

  static UserModel cashierFromAccount({
    required int id,
    required String name,
    required String username,
  }) {
    return UserModel(
      id: id,
      name: name,
      email: '$username@ammar.id',
      role: 'cashier',
      roles: const [
        UserRoleModel(id: 1, name: 'cashier', description: 'Kasir cabang'),
      ],
    );
  }

  static AppRole roleOf(UserModel user) =>
      AppRole.fromValue(user.role) ?? AppRole.cashier;
}
