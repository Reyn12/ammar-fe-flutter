class OrderItemAddonModel {
  const OrderItemAddonModel({
    this.id,
    this.orderItemId,
    this.addonId,
    this.name,
    this.price,
  });

  final int? id;
  final int? orderItemId;
  final int? addonId;
  final String? name;
  final int? price;

  factory OrderItemAddonModel.fromJson(Map<String, dynamic> json) {
    return OrderItemAddonModel(
      id: (json['id'] as num?)?.toInt(),
      orderItemId: (json['order_item_id'] as num?)?.toInt(),
      addonId: (json['addon_id'] as num?)?.toInt(),
      name: json['name']?.toString(),
      price: (json['price'] as num?)?.toInt(),
    );
  }
}
