import '../features/kitchen/models/kitchen_batch_model.dart';
import '../features/kitchen/models/kitchen_batch_table_model.dart';
import '../models/order_enums.dart';

// TODO: hapus file ini kalau endpoint /v1/kitchen/batches sudah siap di backend.
class KitchenBatchMocks {
  const KitchenBatchMocks._();

  static const List<KitchenBatchModel> batches = [
    KitchenBatchModel(
      id: 1,
      categoryName: 'Makanan',
      productId: 1,
      productName: 'Ayam Bakar Madu',
      totalQty: 7,
      status: OrderItemStatus.pending,
      tables: [
        KitchenBatchTableModel(orderId: 241, orderCode: '#AMR241', tableLabel: 'Meja 12', qty: 2),
        KitchenBatchTableModel(orderId: 244, orderCode: '#AMR244', tableLabel: 'Meja 07', qty: 3),
        KitchenBatchTableModel(orderId: 246, orderCode: '#AMR246', tableLabel: 'Takeaway', qty: 2),
      ],
    ),
    KitchenBatchModel(
      id: 2,
      categoryName: 'Makanan',
      productId: 2,
      productName: 'Ayam Bakar Kecap',
      totalQty: 3,
      status: OrderItemStatus.pending,
      tables: [
        KitchenBatchTableModel(orderId: 243, orderCode: '#AMR243', tableLabel: 'Takeaway', qty: 1),
        KitchenBatchTableModel(orderId: 248, orderCode: '#AMR248', tableLabel: 'Meja 11', qty: 2),
      ],
    ),
    KitchenBatchModel(
      id: 3,
      categoryName: 'Makanan',
      productId: 3,
      productName: 'Ayam Goreng Kremes',
      totalQty: 2,
      status: OrderItemStatus.cooking,
      tables: [
        KitchenBatchTableModel(orderId: 242, orderCode: '#AMR242', tableLabel: 'Meja 04', qty: 1),
        KitchenBatchTableModel(orderId: 245, orderCode: '#AMR245', tableLabel: 'Meja 02', qty: 1),
      ],
    ),
    KitchenBatchModel(
      id: 4,
      categoryName: 'Makanan',
      productId: 4,
      productName: 'Lele Bakar Sambal Ijo',
      totalQty: 3,
      status: OrderItemStatus.cooking,
      tables: [
        KitchenBatchTableModel(orderId: 241, orderCode: '#AMR241', tableLabel: 'Meja 12', qty: 1),
        KitchenBatchTableModel(orderId: 242, orderCode: '#AMR242', tableLabel: 'Meja 04', qty: 1),
        KitchenBatchTableModel(orderId: 247, orderCode: '#AMR247', tableLabel: 'Meja 09', qty: 1),
      ],
    ),
    KitchenBatchModel(
      id: 5,
      categoryName: 'Cemilan',
      productId: 7,
      productName: 'Tahu Tempe Goreng',
      totalQty: 2,
      status: OrderItemStatus.pending,
      tables: [
        KitchenBatchTableModel(orderId: 241, orderCode: '#AMR241', tableLabel: 'Meja 12', qty: 1),
        KitchenBatchTableModel(orderId: 243, orderCode: '#AMR243', tableLabel: 'Takeaway', qty: 1),
      ],
    ),
    KitchenBatchModel(
      id: 9,
      categoryName: 'Minuman',
      productId: 11,
      productName: 'Es Jeruk Peras',
      totalQty: 1,
      status: OrderItemStatus.pending,
      tables: [
        KitchenBatchTableModel(orderId: 241, orderCode: '#AMR241', tableLabel: 'Meja 12', qty: 1),
      ],
    ),
    KitchenBatchModel(
      id: 6,
      categoryName: 'Cemilan',
      productId: 9,
      productName: 'Lalapan Komplit',
      totalQty: 1,
      status: OrderItemStatus.pending,
      tables: [
        KitchenBatchTableModel(orderId: 247, orderCode: '#AMR247', tableLabel: 'Meja 09', qty: 1),
      ],
    ),
    KitchenBatchModel(
      id: 7,
      categoryName: 'Minuman',
      productId: 10,
      productName: 'Es Teh Manis',
      totalQty: 3,
      status: OrderItemStatus.ready,
      tables: [
        KitchenBatchTableModel(orderId: 241, orderCode: '#AMR241', tableLabel: 'Meja 12', qty: 2),
        KitchenBatchTableModel(orderId: 247, orderCode: '#AMR247', tableLabel: 'Meja 09', qty: 1),
      ],
    ),
    KitchenBatchModel(
      id: 8,
      categoryName: 'Minuman',
      productId: 12,
      productName: 'Jus Alpukat',
      totalQty: 1,
      status: OrderItemStatus.ready,
      tables: [
        KitchenBatchTableModel(orderId: 244, orderCode: '#AMR244', tableLabel: 'Meja 07', qty: 1),
      ],
    ),
  ];
}
