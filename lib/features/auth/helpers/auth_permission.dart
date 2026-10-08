import '../models/app_role.dart';
import '../models/user_model.dart';

/// Helper akses berdasarkan role session yang sedang login.
bool isOwner(UserModel? user) =>
    AppRole.fromValue(user?.role) == AppRole.owner;

bool canManageMenu(UserModel? user) => isOwner(user);

bool canManageCashiers(UserModel? user) => isOwner(user);

bool canChangeOwnerPassword(UserModel? user) => isOwner(user);
