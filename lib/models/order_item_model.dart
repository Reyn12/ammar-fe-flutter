import 'order_enums.dart';
import 'order_item_addon_model.dart';

class OrderItemModel {
  const OrderItemModel({
    this.id,
    this.orderId,
    this.productId,
    this.productName,
    this.categoryName,
    this.qty,
    this.price,
    this.status,
    this.notes,
    this.addons,
  });

  final int? id;
  final int? orderId;
  final int? productId;
  final String? productName;
  final String? categoryName;
  final int? qty;
  final int? price;
  final OrderItemStatus? status;
  final String? notes;
  final List<OrderItemAddonModel>? addons;

  int get addonTotal =>
      (addons ?? []).fold(0, (total, addon) => total + (addon.price ?? 0));

  int get lineTotal => ((price ?? 0) + addonTotal) * (qty ?? 0);

  OrderItemModel copyWith({OrderItemStatus? status}) {
    return OrderItemModel(
      id: id,
      orderId: orderId,
      productId: productId,
      productName: productName,
      categoryName: categoryName,
      qty: qty,
      price: price,
      status: status ?? this.status,
      notes: notes,
      addons: addons,
    );
  }

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: (json['id'] as num?)?.toInt(),
      orderId: (json['order_id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      productName: json['product_name']?.toString(),
      categoryName: json['category_name']?.toString(),
      qty: (json['qty'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      status: OrderItemStatus.fromValue(json['status']?.toString()),
      notes: json['notes']?.toString(),
      addons: (json['addons'] as List?)
          ?.map((e) => OrderItemAddonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
