import 'addon_model.dart';

class AddonGroupModel {
  const AddonGroupModel({
    this.id,
    this.productId,
    this.name,
    this.isRequired,
    this.minQty,
    this.maxQty,
    this.addons,
  });

  final int? id;
  final int? productId;
  final String? name;
  final bool? isRequired;
  final int? minQty;
  final int? maxQty;
  final List<AddonModel>? addons;

  factory AddonGroupModel.fromJson(Map<String, dynamic> json) {
    return AddonGroupModel(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      name: json['name']?.toString(),
      isRequired: json['is_required'] as bool?,
      minQty: (json['min_qty'] as num?)?.toInt(),
      maxQty: (json['max_qty'] as num?)?.toInt(),
      addons: (json['addons'] as List?)
          ?.map((e) => AddonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
