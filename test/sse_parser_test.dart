import 'dart:convert';

import 'package:ammar_fe_flutter/network/staff_events_service.dart';
import 'package:flutter_test/flutter_test.dart';

Stream<String> _lines(String raw) =>
    Stream.fromIterable(const LineSplitter().convert(raw));

void main() {
  // Potongan stream asli dari backend (urutan dan format sama).
  const sample = 'retry: 3000\n'
      '\n'
      'id: 1\n'
      'event: order.created\n'
      'data: {"order_id":7,"code":"AMR-20261010-001","place_label":"Meja 5","customer_name":"Budi","payment_method":"cash","payment_status":"unpaid","status":"pending"}\n'
      '\n'
      ': ping\n'
      '\n'
      'id: 2\n'
      'event: order.paid\n'
      'data: {"order_id":7,"payment_method":"qris","payment_status":"paid"}\n'
      '\n';

  test('parses real server events and ignores retry and heartbeat', () async {
    final ids = <String>[];
    final events = await parseSseEvents(_lines(sample), onId: ids.add).toList();

    expect(events.map((e) => e.type), ['order.created', 'order.paid']);
    expect(events.map((e) => e.id), ['1', '2']);
    expect(events.first.orderId, 7);
    expect(events.first.paymentMethod, 'cash');
    expect(events.first.data['place_label'], 'Meja 5');
    expect(events.last.paymentMethod, 'qris');
    expect(ids, ['1', '2']); // dipakai sebagai Last-Event-ID saat sambung ulang
  });

  test('ignores events without data and joins multi-line data', () async {
    const raw = 'event: kitchen.updated\n'
        '\n'
        'id: 9\n'
        'event: kitchen.updated\n'
        'data: {"order_id":\n'
        'data: 12}\n'
        '\n';

    final events = await parseSseEvents(_lines(raw)).toList();

    expect(events, hasLength(1));
    expect(events.single.orderId, 12);
  });

  test('invalid json becomes an empty payload instead of crashing', () async {
    final events = await parseSseEvents(
      _lines('event: order.paid\ndata: bukan-json\n\n'),
    ).toList();

    expect(events.single.type, 'order.paid');
    expect(events.single.data, isEmpty);
    expect(events.single.orderId, isNull);
  });
}
