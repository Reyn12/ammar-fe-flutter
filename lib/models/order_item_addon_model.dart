class OrderItemAddonModel {
  const OrderItemAddonModel({
    this.id,
    this.orderItemId,
    this.addonId,
    this.name,
    this.groupName,
    this.price,
  });

  final int? id;
  final int? orderItemId;
  final int? addonId;
  final String? name;
  final String? groupName;
  final int? price;

  /// "Level Es: Normal" supaya pilihan dengan nama sama (Normal, Normal) tidak ambigu.
  String get label => (groupName ?? '').isEmpty ? '$name' : '$groupName: $name';

  factory OrderItemAddonModel.fromJson(Map<String, dynamic> json) {
    return OrderItemAddonModel(
      id: (json['id'] as num?)?.toInt(),
      orderItemId: (json['order_item_id'] as num?)?.toInt(),
      addonId: (json['addon_id'] as num?)?.toInt(),
      name: json['name']?.toString(),
      groupName: json['group_name']?.toString(),
      price: (json['price'] as num?)?.toInt(),
    );
  }
}
