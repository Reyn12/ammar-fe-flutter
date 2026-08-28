import 'order_enums.dart';

class ShiftModel {
  const ShiftModel({
    this.id,
    this.userId,
    this.userName,
    this.startTime,
    this.endTime,
    this.status,
    this.startingCash,
    this.expectedCash,
    this.actualCash,
    this.cashOrderCount,
    this.qrisOrderCount,
  });

  final int? id;
  final int? userId;
  final String? userName;
  final DateTime? startTime;
  final DateTime? endTime;
  final ShiftStatus? status;
  final int? startingCash;
  final int? expectedCash;
  final int? actualCash;
  final int? cashOrderCount;
  final int? qrisOrderCount;

  bool get isActive => status == ShiftStatus.active;

  /// Selisih uang fisik vs perkiraan sistem. Positif = lebih, negatif = kurang.
  int get cashDifference => (actualCash ?? 0) - (expectedCash ?? 0);

  Duration get runningDuration =>
      (endTime ?? DateTime.now()).difference(startTime ?? DateTime.now());

  ShiftModel copyWith({
    DateTime? endTime,
    ShiftStatus? status,
    int? actualCash,
  }) {
    return ShiftModel(
      id: id,
      userId: userId,
      userName: userName,
      startTime: startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      startingCash: startingCash,
      expectedCash: expectedCash,
      actualCash: actualCash ?? this.actualCash,
      cashOrderCount: cashOrderCount,
      qrisOrderCount: qrisOrderCount,
    );
  }

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      userName: json['user_name']?.toString(),
      startTime: DateTime.tryParse(json['start_time']?.toString() ?? ''),
      endTime: DateTime.tryParse(json['end_time']?.toString() ?? ''),
      status: ShiftStatus.fromValue(json['status']?.toString()),
      startingCash: (json['starting_cash'] as num?)?.toInt(),
      expectedCash: (json['expected_cash'] as num?)?.toInt(),
      actualCash: (json['actual_cash'] as num?)?.toInt(),
      cashOrderCount: (json['cash_order_count'] as num?)?.toInt(),
      qrisOrderCount: (json['qris_order_count'] as num?)?.toInt(),
    );
  }
}
