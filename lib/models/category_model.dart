class CategoryModel {
  const CategoryModel({this.id, this.name});

  final int? id;
  final String? name;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name']?.toString(),
    );
  }
}
