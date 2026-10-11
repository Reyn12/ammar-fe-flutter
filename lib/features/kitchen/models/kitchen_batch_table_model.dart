import '../../../helper/order_code_helper.dart';

class KitchenBatchTableModel {
  const KitchenBatchTableModel({
    this.orderId,
    this.orderCode,
    this.tableLabel,
    this.qty,
  });

  final int? orderId;
  final String? orderCode;
  final String? tableLabel;
  final int? qty;

  /// 3 angka belakang kode pesanan, mis. "021".
  String get queueNumber => queueNumberOf(orderCode);

  factory KitchenBatchTableModel.fromJson(Map<String, dynamic> json) {
    return KitchenBatchTableModel(
      orderId: (json['order_id'] as num?)?.toInt(),
      orderCode: json['order_code']?.toString(),
      tableLabel: json['table_label']?.toString(),
      qty: (json['qty'] as num?)?.toInt(),
    );
  }
}
