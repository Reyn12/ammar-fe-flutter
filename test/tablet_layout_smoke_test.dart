import 'package:ammar_fe_flutter/features/auth/screens/login_page.dart';
import 'package:ammar_fe_flutter/features/kasir/pages/kasir_shell_page.dart';
import 'package:ammar_fe_flutter/features/kasir/widgets/kasir_confirm_cash_dialog.dart';
import 'package:ammar_fe_flutter/features/kasir/widgets/kasir_menu_form_dialog.dart';
import 'package:ammar_fe_flutter/features/kasir/widgets/kasir_shift_close_dialog.dart';
import 'package:ammar_fe_flutter/features/kasir/widgets/kasir_shift_open_dialog.dart';
import 'package:ammar_fe_flutter/features/kitchen/pages/kitchen_board_page.dart';
import 'package:ammar_fe_flutter/mocks/order_mocks.dart';
import 'package:ammar_fe_flutter/mocks/shift_mocks.dart';
import 'package:ammar_fe_flutter/resources/app_theme.dart';
import 'package:ammar_fe_flutter/widget/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> _pumpTablet(WidgetTester tester, Widget child) async {
  tester.view.physicalSize = const Size(2560, 1600);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(theme: AppTheme.light, home: child),
    ),
  );
  await tester.pump(const Duration(milliseconds: 1200));
  await tester.pump(const Duration(milliseconds: 400));
}

void main() {
  testWidgets('login page renders in landscape', (tester) async {
    await _pumpTablet(tester, const LoginPage());
    expect(find.text('Ammar POS'), findsOneWidget);
  });

  testWidgets('kasir shell renders in landscape', (tester) async {
    await _pumpTablet(tester, const KasirShellPage());
    expect(find.text('Pesanan Masuk'), findsWidgets);
  });

  testWidgets('kitchen board renders in landscape', (tester) async {
    await _pumpTablet(tester, const KitchenBoardPage());
    expect(find.text('Batch Preparation'), findsOneWidget);
  });

  testWidgets('konfirmasi tunai dialog renders', (tester) async {
    await _pumpTablet(
      tester,
      KasirConfirmCashDialog(order: OrderMocks.incomingOrders.first),
    );
    expect(find.text('Konfirmasi Pembayaran Tunai'), findsOneWidget);
  });

  testWidgets('form menu dialog renders', (tester) async {
    await _pumpTablet(tester, const KasirMenuFormDialog());
    expect(find.text('Tambah Menu'), findsOneWidget);
  });

  testWidgets('buka shift dialog renders', (tester) async {
    await _pumpTablet(tester, const KasirShiftOpenDialog());
    expect(find.text('Buka Shift'), findsWidgets);
  });

  testWidgets('tutup shift dialog renders', (tester) async {
    await _pumpTablet(
      tester,
      KasirShiftCloseDialog(shift: ShiftMocks.activeShift),
    );
    expect(find.text('Tutup Shift'), findsWidgets);
  });

  testWidgets('logout dialog renders', (tester) async {
    await _pumpTablet(tester, const LogoutDialog());
    expect(find.text('Keluar dari aplikasi?'), findsOneWidget);
  });
}
