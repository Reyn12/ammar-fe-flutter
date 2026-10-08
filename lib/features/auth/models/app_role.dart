import '../../../routes/app_paths.dart';

enum AppRole {
  cashier('cashier', 'Kasir', AppPaths.kasirDashboard),
  kitchen('kitchen', 'Koki / Dapur', AppPaths.kitchenDashboard),
  owner('owner', 'Pemilik', AppPaths.kasirDashboard);

  const AppRole(this.value, this.label, this.homePath);

  final String value;
  final String label;

  /// Halaman awal setelah login sesuai role.
  final String homePath;

  static AppRole? fromValue(String? value) {
    for (final role in AppRole.values) {
      if (role.value == value) return role;
    }
    return null;
  }
}
