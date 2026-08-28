import '../../../models/order_enums.dart';
import '../../../models/order_model.dart';

enum IncomingOrderFilter {
  all('Semua'),
  waitingCash('Tunai Belum Dikonfirmasi'),
  dineIn('Dine-in'),
  takeaway('Takeaway');

  const IncomingOrderFilter(this.label);

  final String label;

  bool matches(OrderModel order) {
    switch (this) {
      case IncomingOrderFilter.all:
        return true;
      case IncomingOrderFilter.waitingCash:
        return order.needCashConfirmation;
      case IncomingOrderFilter.dineIn:
        return order.orderType == OrderType.dineIn;
      case IncomingOrderFilter.takeaway:
        return order.orderType == OrderType.takeaway;
    }
  }
}
