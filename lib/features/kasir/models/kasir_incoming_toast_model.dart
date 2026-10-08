class KasirIncomingToastModel {
  const KasirIncomingToastModel({
    required this.orderId,
    required this.orderCode,
    required this.placeLabel,
    required this.customerName,
  });

  final int orderId;
  final String orderCode;
  final String placeLabel;
  final String customerName;
}
