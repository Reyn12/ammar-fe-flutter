class UserRoleModel {
  const UserRoleModel({
    this.id,
    this.name,
    this.description,
  });

  final int? id;
  final String? name;
  final String? description;

  factory UserRoleModel.fromJson(Map<String, dynamic> json) {
    return UserRoleModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name']?.toString(),
      description: json['description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
