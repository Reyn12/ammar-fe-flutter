import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/order_model.dart';
import '../../../network/api_service.dart';
import '../models/incoming_order_filter.dart';

part 'incoming_orders_provider.g.dart';

/// Jumlah kartu per halaman list Pesanan Masuk (mirip kitchen board).
const int kasirOrdersPerPage = 6;

@riverpod
class IncomingOrders extends _$IncomingOrders {
  @override
  Future<List<OrderModel>> build() async {
    // TODO: tambah SSE GET /v1/stream/orders untuk live update.
    return ref.watch(apiServiceProvider).fetchIncomingOrders();
  }

  /// Ambil ulang tanpa menampilkan loading (dipanggil saat ada event SSE).
  Future<void> refresh() async {
    final orders = await ref.read(apiServiceProvider).fetchIncomingOrders();
    state = AsyncData(orders);
  }

  /// Sisipkan pesanan baru di depan list (simulasi SSE / event paid).
  void insertIncomingOrder(OrderModel order) {
    state = AsyncData([order, ...state.value ?? <OrderModel>[]]);
  }

  /// SKPL-F-006 — set pembayaran tunai jadi lunas.
  Future<void> confirmCashPayment(int orderId, {int? receivedAmount}) async {
    final updated = await ref
        .read(apiServiceProvider)
        .confirmCashPayment(orderId: orderId, receivedAmount: receivedAmount);

    state = AsyncData([
      for (final order in state.value ?? <OrderModel>[])
        if (order.id == orderId) updated else order,
    ]);
  }
}

@riverpod
class IncomingOrderFilterState extends _$IncomingOrderFilterState {
  @override
  IncomingOrderFilter build() => IncomingOrderFilter.all;

  void select(IncomingOrderFilter filter) {
    state = filter;
    ref.read(kasirOrderPageIndexProvider.notifier).select(0);
  }
}

@riverpod
class IncomingOrderSearchQuery extends _$IncomingOrderSearchQuery {
  @override
  String build() => '';

  void setQuery(String value) {
    state = value;
    ref.read(kasirOrderPageIndexProvider.notifier).select(0);
  }

  void clear() {
    state = '';
    ref.read(kasirOrderPageIndexProvider.notifier).select(0);
  }
}

@riverpod
class KasirOrderPageIndex extends _$KasirOrderPageIndex {
  @override
  int build() => 0;

  void select(int page) => state = page;
}

@riverpod
class SelectedOrderId extends _$SelectedOrderId {
  @override
  int? build() => null;

  void select(int? orderId) => state = orderId;
}

bool _matchesSearch(OrderModel order, String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return true;

  final haystack = [
    order.code,
    order.customerName,
    order.tableNumber,
    order.placeLabel,
    order.paymentMethod?.label,
    ...(order.items ?? []).map((item) => item.productName),
  ].whereType<String>().join(' ').toLowerCase();

  return haystack.contains(q);
}

/// Filter + search (sebelum pagination).
@riverpod
List<OrderModel> filteredIncomingOrders(Ref ref) {
  final orders = ref.watch(incomingOrdersProvider).value ?? <OrderModel>[];
  final filter = ref.watch(incomingOrderFilterStateProvider);
  final query = ref.watch(incomingOrderSearchQueryProvider);

  return [
    for (final order in orders)
      if (filter.matches(order) && _matchesSearch(order, query)) order,
  ];
}

@riverpod
int kasirOrderTotalPages(Ref ref) {
  final total = ref.watch(filteredIncomingOrdersProvider).length;
  return (total / kasirOrdersPerPage).ceil().clamp(1, 999);
}

@riverpod
List<OrderModel> pagedIncomingOrders(Ref ref) {
  final filtered = ref.watch(filteredIncomingOrdersProvider);
  final totalPages = (filtered.length / kasirOrdersPerPage).ceil().clamp(1, 999);
  final pageIndex = ref.watch(kasirOrderPageIndexProvider).clamp(0, totalPages - 1);

  if (pageIndex != ref.watch(kasirOrderPageIndexProvider)) {
    Future.microtask(() {
      if (!ref.mounted) return;
      ref.read(kasirOrderPageIndexProvider.notifier).select(pageIndex);
    });
  }

  return filtered
      .skip(pageIndex * kasirOrdersPerPage)
      .take(kasirOrdersPerPage)
      .toList();
}

@riverpod
OrderModel? selectedIncomingOrder(Ref ref) {
  final selectedId = ref.watch(selectedOrderIdProvider);
  // Cari di semua hasil filter (bukan cuma halaman aktif).
  for (final order in ref.watch(filteredIncomingOrdersProvider)) {
    if (order.id == selectedId) return order;
  }
  return null;
}

/// Jumlah order tunai yang masih menunggu konfirmasi, dipakai badge sidebar.
@riverpod
int waitingCashCount(Ref ref) {
  return (ref.watch(incomingOrdersProvider).value ?? <OrderModel>[])
      .where((order) => order.needCashConfirmation)
      .length;
}
