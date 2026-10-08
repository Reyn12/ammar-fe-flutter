class CashierAccountModel {
  const CashierAccountModel({
    required this.id,
    required this.username,
    required this.name,
    required this.password,
    this.isActive = true,
  });

  final int id;
  final String username;
  final String name;

  /// Hanya untuk mock login lokal — jangan simpan plaintext di production.
  final String password;
  final bool isActive;

  CashierAccountModel copyWith({
    int? id,
    String? username,
    String? name,
    String? password,
    bool? isActive,
  }) {
    return CashierAccountModel(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
    );
  }

  factory CashierAccountModel.fromJson(Map<String, dynamic> json) {
    return CashierAccountModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      username: json['username']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
      isActive: json['is_active'] as bool? ?? true,
    );
  }
}
