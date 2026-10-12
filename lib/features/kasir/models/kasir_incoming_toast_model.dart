class KasirIncomingToastModel {
  const KasirIncomingToastModel({
    required this.orderId,
    required this.orderCode,
    required this.placeLabel,
    required this.customerName,
    this.isReady = false,
    this.queueNumber = '-',
  });

  final int orderId;
  final String orderCode;
  final String placeLabel;
  final String customerName;

  /// true = makanan sudah selesai di dapur dan siap diantar (bukan pesanan baru).
  final bool isReady;
  final String queueNumber;
}
