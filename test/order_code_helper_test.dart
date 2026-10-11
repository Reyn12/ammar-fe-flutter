import 'package:ammar_fe_flutter/features/kitchen/models/kitchen_batch_table_model.dart';
import 'package:ammar_fe_flutter/helper/order_code_helper.dart';
import 'package:ammar_fe_flutter/models/order_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('queue number is the digits after the last dash', () {
    expect(queueNumberOf('A261011-021'), '021');
    expect(queueNumberOf('AMR-20261011-007'), '007');
  });

  test('codes without a dash and missing codes are handled', () {
    expect(queueNumberOf('#AMR241'), '#AMR241');
    expect(queueNumberOf(''), '-');
    expect(queueNumberOf(null), '-');
  });

  test('orders and kitchen batch rows expose the queue number', () {
    expect(const OrderModel(code: 'A261011-021').queueNumber, '021');
    expect(
      const KitchenBatchTableModel(orderCode: 'A261011-005').queueNumber,
      '005',
    );
  });
}
