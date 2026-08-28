import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/kasir_nav_item.dart';

part 'kasir_nav_provider.g.dart';

@riverpod
class KasirNav extends _$KasirNav {
  @override
  KasirNavItem build() => KasirNavItem.incomingOrders;

  void select(KasirNavItem item) => state = item;
}
