import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/table_account_model.dart';

class TableQrDownloadHelper {
  const TableQrDownloadHelper._();

  /// Simpan PNG QR meja ke folder dokumen app, lalu buka file-nya.
  static Future<String> download(TableAccountModel table) async {
    final painter = QrPainter(
      data: table.qrPayload,
      version: QrVersions.auto,
      gapless: true,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: Color(0xFF0A0A0A),
      ),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: Color(0xFF0A0A0A),
      ),
    );

    final imageData = await painter.toImageData(
      1024,
      format: ui.ImageByteFormat.png,
    );
    if (imageData == null) {
      throw Exception('Gagal membuat gambar QR.');
    }

    final dir = await getApplicationDocumentsDirectory();
    final file = File(
      '${dir.path}/qr-meja-${table.tableNumber}-${table.qrToken}.png',
    );
    await file.writeAsBytes(imageData.buffer.asUint8List());
    await OpenFilex.open(file.path);
    return file.path;
  }
}
