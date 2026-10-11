class CategoryModel {
  const CategoryModel({this.id, this.name, this.productCount});

  final int? id;
  final String? name;

  /// Jumlah menu aktif di kategori ini (kategori yang masih punya menu tidak bisa dihapus).
  final int? productCount;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name']?.toString(),
      productCount: (json['product_count'] as num?)?.toInt(),
    );
  }
}
