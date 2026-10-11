class AddonModel {
  const AddonModel({
    this.id,
    this.groupId,
    this.name,
    this.price,
    this.isAvailable,
  });

  final int? id;
  final int? groupId;
  final String? name;
  final int? price;
  final bool? isAvailable;

  /// Body untuk POST/PUT /v1/products (bagian addon_groups[].addons[]).
  Map<String, dynamic> toBody() => {
    'id': ?id,
    'name': name,
    'price': price ?? 0,
    'is_available': isAvailable ?? true,
  };

  factory AddonModel.fromJson(Map<String, dynamic> json) {
    return AddonModel(
      id: (json['id'] as num?)?.toInt(),
      groupId: (json['group_id'] as num?)?.toInt(),
      name: json['name']?.toString(),
      price: (json['price'] as num?)?.toInt(),
      isAvailable: json['is_available'] as bool?,
    );
  }
}
