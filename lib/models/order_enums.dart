enum OrderType {
  dineIn('dine_in', 'Dine-in'),
  takeaway('takeaway', 'Takeaway');

  const OrderType(this.value, this.label);

  final String value;
  final String label;

  static OrderType? fromValue(String? value) {
    for (final type in OrderType.values) {
      if (type.value == value) return type;
    }
    return null;
  }
}

enum OrderStatus {
  pending('pending', 'Belum Diproses'),
  cooking('cooking', 'Sedang Dimasak'),
  ready('ready', 'Siap Disajikan'),
  completed('completed', 'Selesai'),
  cancelled('cancelled', 'Dibatalkan');

  const OrderStatus(this.value, this.label);

  final String value;
  final String label;

  static OrderStatus? fromValue(String? value) {
    for (final status in OrderStatus.values) {
      if (status.value == value) return status;
    }
    return null;
  }
}

enum OrderItemStatus {
  pending('pending', 'Belum Diproses'),
  cooking('cooking', 'Dimasak'),
  ready('ready', 'Disajikan');

  const OrderItemStatus(this.value, this.label);

  final String value;
  final String label;

  static OrderItemStatus? fromValue(String? value) {
    for (final status in OrderItemStatus.values) {
      if (status.value == value) return status;
    }
    return null;
  }
}

enum PaymentMethod {
  qris('qris', 'QRIS'),
  cash('cash', 'Tunai');

  const PaymentMethod(this.value, this.label);

  final String value;
  final String label;

  static PaymentMethod? fromValue(String? value) {
    for (final method in PaymentMethod.values) {
      if (method.value == value) return method;
    }
    return null;
  }
}

enum PaymentStatus {
  unpaid('unpaid', 'Belum Dibayar'),
  paid('paid', 'Dibayar'),
  expired('expired', 'Kedaluwarsa');

  const PaymentStatus(this.value, this.label);

  final String value;
  final String label;

  static PaymentStatus? fromValue(String? value) {
    for (final status in PaymentStatus.values) {
      if (status.value == value) return status;
    }
    return null;
  }
}

enum ShiftStatus {
  active('active', 'Aktif'),
  closed('closed', 'Ditutup');

  const ShiftStatus(this.value, this.label);

  final String value;
  final String label;

  static ShiftStatus? fromValue(String? value) {
    for (final status in ShiftStatus.values) {
      if (status.value == value) return status;
    }
    return null;
  }
}
