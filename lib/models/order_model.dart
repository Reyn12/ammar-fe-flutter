import 'order_enums.dart';
import 'order_item_model.dart';

class OrderModel {
  const OrderModel({
    this.id,
    this.code,
    this.shiftId,
    this.tableId,
    this.tableNumber,
    this.branchId,
    this.customerName,
    this.orderType,
    this.status,
    this.paymentMethod,
    this.paymentStatus,
    this.totalAmount,
    this.taxAmount,
    this.createdAt,
    this.items,
  });

  final int? id;
  final String? code;
  final int? shiftId;
  final int? tableId;
  final String? tableNumber;
  final int? branchId;
  final String? customerName;
  final OrderType? orderType;
  final OrderStatus? status;
  final PaymentMethod? paymentMethod;
  final PaymentStatus? paymentStatus;
  final int? totalAmount;
  final int? taxAmount;
  final DateTime? createdAt;
  final List<OrderItemModel>? items;

  bool get isTakeaway => orderType == OrderType.takeaway;

  /// Order tunai yang uangnya belum diverifikasi kasir.
  bool get needCashConfirmation =>
      paymentMethod == PaymentMethod.cash && paymentStatus != PaymentStatus.paid;

  int get subtotal =>
      (items ?? []).fold(0, (total, item) => total + item.lineTotal);

  int get totalQty => (items ?? []).fold(0, (total, item) => total + (item.qty ?? 0));

  int get remainingItemCount => (items ?? [])
      .where((item) => item.status != OrderItemStatus.ready)
      .length;

  String get placeLabel =>
      isTakeaway ? 'Takeaway' : 'Meja ${tableNumber ?? '-'}';

  OrderModel copyWith({
    OrderStatus? status,
    PaymentStatus? paymentStatus,
    List<OrderItemModel>? items,
  }) {
    return OrderModel(
      id: id,
      code: code,
      shiftId: shiftId,
      tableId: tableId,
      tableNumber: tableNumber,
      branchId: branchId,
      customerName: customerName,
      orderType: orderType,
      status: status ?? this.status,
      paymentMethod: paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      totalAmount: totalAmount,
      taxAmount: taxAmount,
      createdAt: createdAt,
      items: items ?? this.items,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: (json['id'] as num?)?.toInt(),
      code: json['code']?.toString(),
      shiftId: (json['shift_id'] as num?)?.toInt(),
      tableId: (json['table_id'] as num?)?.toInt(),
      tableNumber: json['table_number']?.toString(),
      branchId: (json['branch_id'] as num?)?.toInt(),
      customerName: json['customer_name']?.toString(),
      orderType: OrderType.fromValue(json['order_type']?.toString()),
      status: OrderStatus.fromValue(json['status']?.toString()),
      paymentMethod: PaymentMethod.fromValue(json['payment_method']?.toString()),
      paymentStatus: PaymentStatus.fromValue(json['payment_status']?.toString()),
      totalAmount: (json['total_amount'] as num?)?.toInt(),
      taxAmount: (json['tax_amount'] as num?)?.toInt(),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      items: (json['items'] as List?)
          ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
