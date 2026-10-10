import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'dio_client_provider.dart';

part 'staff_events_service.g.dart';

/// Satu event dari SSE `GET /v1/stream/orders`. Isinya hanya pemberitahuan ringkas;
/// data lengkap diambil lewat endpoint REST biasa.
class StaffEvent {
  const StaffEvent({required this.type, required this.data, this.id});

  /// order.created | order.paid | order.cancelled | kitchen.updated
  final String type;
  final Map<String, dynamic> data;
  final String? id;

  int? get orderId => (data['order_id'] as num?)?.toInt();
  String? get paymentMethod => data['payment_method']?.toString();
}

/// true selama koneksi SSE tersambung; dipakai indikator Online/Offline di header.
@Riverpod(keepAlive: true)
class StaffEventsConnection extends _$StaffEventsConnection {
  @override
  bool build() => false;

  void set(bool connected) {
    if (state != connected) state = connected;
  }
}

/// Stream event realtime untuk kasir & dapur. Menyambung ulang otomatis (dengan jeda bertahap)
/// dan melanjutkan dari event terakhir lewat header `Last-Event-ID`, jadi event yang
/// terlewat saat koneksi putus tetap diterima.
///
/// Server menutup koneksi tiap ~25 detik; itu normal dan memicu sambung ulang.
@riverpod
Stream<StaffEvent> staffEvents(Ref ref) async* {
  final dio = ref.watch(dioClientProvider);
  final connection = ref.read(staffEventsConnectionProvider.notifier);
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);

  String? lastEventId;
  var failures = 0;

  while (!cancelToken.isCancelled) {
    try {
      final response = await dio.get<ResponseBody>(
        '/v1/stream/orders',
        cancelToken: cancelToken,
        options: Options(
          responseType: ResponseType.stream,
          // Koneksi memang panjang; heartbeat server tiap 15 detik.
          receiveTimeout: Duration.zero,
          headers: {
            'Accept': 'text/event-stream',
            'Cache-Control': 'no-cache',
            'Last-Event-ID': ?lastEventId,
          },
        ),
      );

      connection.set(true);
      failures = 0;

      final lines = utf8.decoder
          .bind(response.data!.stream.cast<List<int>>())
          .transform(const LineSplitter());

      await for (final event in parseSseEvents(
        lines,
        onId: (id) => lastEventId = id,
      )) {
        yield event;
      }
    } on DioException catch (error) {
      if (CancelToken.isCancel(error)) break;
      failures++;
    } catch (_) {
      failures++;
    }

    connection.set(false);
    if (cancelToken.isCancelled) break;

    // Putus karena server menutup koneksi (normal) -> sambung lagi segera.
    // Gagal berturut-turut -> tunggu makin lama, maksimal 15 detik.
    final delay = failures == 0
        ? const Duration(milliseconds: 300)
        : Duration(seconds: (failures * 2).clamp(2, 15));
    await Future<void>.delayed(delay);
  }
}

Map<String, dynamic> _decode(String raw) {
  try {
    final decoded = jsonDecode(raw);
    if (decoded is Map) return decoded.cast<String, dynamic>();
  } catch (_) {}
  return const {};
}

/// Mengubah baris-baris teks SSE menjadi [StaffEvent]. Komentar (": ping"), field `retry`,
/// dan event tanpa data diabaikan. [onId] dipanggil dengan id event terakhir untuk `Last-Event-ID`.
Stream<StaffEvent> parseSseEvents(
  Stream<String> lines, {
  void Function(String id)? onId,
}) async* {
  String? id;
  var type = 'message';
  final data = StringBuffer();

  await for (final line in lines) {
    if (line.isEmpty) {
      // Baris kosong = akhir satu event.
      if (data.isNotEmpty) {
        if (id != null) onId?.call(id);
        yield StaffEvent(type: type, data: _decode(data.toString()), id: id);
      }
      id = null;
      type = 'message';
      data.clear();
      continue;
    }

    if (line.startsWith(':')) continue;

    final separator = line.indexOf(':');
    final field = separator == -1 ? line : line.substring(0, separator);
    var value = separator == -1 ? '' : line.substring(separator + 1);
    if (value.startsWith(' ')) value = value.substring(1);

    switch (field) {
      case 'id':
        id = value;
      case 'event':
        type = value;
      case 'data':
        if (data.isNotEmpty) data.write('\n');
        data.write(value);
    }
  }
}
