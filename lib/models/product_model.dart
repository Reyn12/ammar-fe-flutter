import 'addon_group_model.dart';
import 'product_component_model.dart';

class ProductModel {
  const ProductModel({
    this.id,
    this.branchId,
    this.categoryId,
    this.categoryName,
    this.imageUrl,
    this.name,
    this.price,
    this.isAvailable,
    this.addonGroups,
    this.components,
  });

  final int? id;
  final int? branchId;
  final int? categoryId;
  final String? categoryName;
  final String? imageUrl;
  final String? name;
  final int? price;
  final bool? isAvailable;
  final List<AddonGroupModel>? addonGroups;

  /// Isi paket; kosong/null untuk menu biasa.
  final List<ProductComponentModel>? components;

  bool get isPackage => (components ?? []).isNotEmpty;

  ProductModel copyWith({bool? isAvailable, String? imageUrl}) {
    return ProductModel(
      id: id,
      branchId: branchId,
      categoryId: categoryId,
      categoryName: categoryName,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name,
      price: price,
      isAvailable: isAvailable ?? this.isAvailable,
      addonGroups: addonGroups,
      components: components,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] as num?)?.toInt(),
      branchId: (json['branch_id'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      categoryName: json['category_name']?.toString(),
      imageUrl: json['image_url']?.toString(),
      name: json['name']?.toString(),
      price: (json['price'] as num?)?.toInt(),
      isAvailable: json['is_available'] as bool?,
      addonGroups: (json['addon_groups'] as List?)
          ?.map((e) => AddonGroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      components: (json['components'] as List?)
          ?.map(
            (e) => ProductComponentModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
