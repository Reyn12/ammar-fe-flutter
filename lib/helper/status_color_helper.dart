import 'package:flutter/material.dart';

import '../models/order_enums.dart';
import '../resources/resources.dart';

class StatusColor {
  const StatusColor({required this.foreground, required this.background});

  final Color foreground;
  final Color background;
}

const StatusColor _neutralStatus = StatusColor(
  foreground: AppColors.neutral70,
  background: AppColors.neutral20,
);

StatusColor orderItemStatusColor(OrderItemStatus? status) {
  switch (status) {
    case OrderItemStatus.pending:
      return const StatusColor(
        foreground: AppColors.neutral80,
        background: AppColors.neutral30,
      );
    case OrderItemStatus.cooking:
      return const StatusColor(
        foreground: AppColors.orangeMain,
        background: AppColors.warningSurface,
      );
    case OrderItemStatus.ready:
      return const StatusColor(
        foreground: AppColors.successMain,
        background: AppColors.successSoft,
      );
    case null:
      return _neutralStatus;
  }
}

StatusColor orderStatusColor(OrderStatus? status) {
  switch (status) {
    case OrderStatus.pending:
      return const StatusColor(
        foreground: AppColors.neutral80,
        background: AppColors.neutral30,
      );
    case OrderStatus.cooking:
      return const StatusColor(
        foreground: AppColors.orangeMain,
        background: AppColors.warningSurface,
      );
    case OrderStatus.ready:
      return const StatusColor(
        foreground: AppColors.successMain,
        background: AppColors.successSoft,
      );
    case OrderStatus.completed:
      return const StatusColor(
        foreground: AppColors.primaryMain,
        background: AppColors.primarySurface,
      );
    case OrderStatus.cancelled:
      return const StatusColor(
        foreground: AppColors.dangerMain,
        background: AppColors.dangerSurface,
      );
    case null:
      return _neutralStatus;
  }
}

StatusColor paymentStatusColor(PaymentStatus? status) {
  switch (status) {
    case PaymentStatus.paid:
      return const StatusColor(
        foreground: AppColors.successMain,
        background: AppColors.successSoft,
      );
    case PaymentStatus.unpaid:
    case PaymentStatus.expired:
      return const StatusColor(
        foreground: AppColors.dangerMain,
        background: AppColors.dangerSurface,
      );
    case null:
      return _neutralStatus;
  }
}
