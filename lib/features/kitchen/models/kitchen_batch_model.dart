import '../../../models/order_enums.dart';
import 'kitchen_batch_table_model.dart';

class KitchenBatchModel {
  const KitchenBatchModel({
    this.id,
    this.categoryName,
    this.productId,
    this.productName,
    this.totalQty,
    this.status,
    this.tables,
  });

  /// Kapasitas maksimal nota per batch sesuai SKPL-F-010.
  static const int maxNotaPerBatch = 6;

  final int? id;
  final String? categoryName;
  final int? productId;
  final String? productName;
  final int? totalQty;
  final OrderItemStatus? status;
  final List<KitchenBatchTableModel>? tables;

  int get notaCount => (tables ?? []).length;

  bool get isFull => notaCount >= maxNotaPerBatch;

  KitchenBatchModel copyWith({OrderItemStatus? status}) {
    return KitchenBatchModel(
      id: id,
      categoryName: categoryName,
      productId: productId,
      productName: productName,
      totalQty: totalQty,
      status: status ?? this.status,
      tables: tables,
    );
  }

  factory KitchenBatchModel.fromJson(Map<String, dynamic> json) {
    return KitchenBatchModel(
      id: (json['id'] as num?)?.toInt(),
      categoryName: json['category_name']?.toString(),
      productId: (json['product_id'] as num?)?.toInt(),
      productName: json['product_name']?.toString(),
      totalQty: (json['total_qty'] as num?)?.toInt(),
      status: OrderItemStatus.fromValue(json['status']?.toString()),
      tables: (json['tables'] as List?)
          ?.map(
            (e) => KitchenBatchTableModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
