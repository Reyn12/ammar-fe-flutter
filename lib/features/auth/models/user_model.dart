import 'user_academic_model.dart';
import 'user_role_model.dart';

class UserModel {
  const UserModel({
    this.id,
    this.name,
    this.email,
    this.nim,
    this.role,
    this.roles,
    this.createdAt,
    this.updatedAt,
    this.academic,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? nim;
  final String? role;
  final List<UserRoleModel>? roles;
  final UserAcademicModel? academic;
  final String? createdAt;
  final String? updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final rawRoles = json['roles'];
    final parsedRoles = rawRoles is List
        ? rawRoles
              .whereType<Map>()
              .map((e) => UserRoleModel.fromJson(e.cast<String, dynamic>()))
              .toList()
        : null;
    final rawAcademic = json['academic'];

    return UserModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      nim: json['nim']?.toString(),
      role: json['role']?.toString(),
      roles: parsedRoles,
      academic: rawAcademic is Map
          ? UserAcademicModel.fromJson(rawAcademic.cast<String, dynamic>())
          : null,
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'nim': nim,
      'role': role,
      'roles': roles?.map((e) => e.toJson()).toList(),
      if (academic != null) 'academic': academic!.toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
