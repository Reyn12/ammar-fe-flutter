class TableAccountModel {
  const TableAccountModel({
    required this.id,
    required this.branchId,
    required this.tableNumber,
    required this.qrToken,
    this.isActive = true,
  });

  final int id;
  final int branchId;
  final String tableNumber;

  /// Token unik di URL QR meja (di-rotate saat generate ulang).
  final String qrToken;
  final bool isActive;

  /// URL mock yang di-scan customer (Next.js order page).
  String get qrPayload =>
      'https://order.ammar.id/m/$tableNumber?t=$qrToken';

  String get label => 'Meja $tableNumber';

  TableAccountModel copyWith({
    int? id,
    int? branchId,
    String? tableNumber,
    String? qrToken,
    bool? isActive,
  }) {
    return TableAccountModel(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      tableNumber: tableNumber ?? this.tableNumber,
      qrToken: qrToken ?? this.qrToken,
      isActive: isActive ?? this.isActive,
    );
  }
}
