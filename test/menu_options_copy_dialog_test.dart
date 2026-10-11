import 'package:ammar_fe_flutter/features/kasir/widgets/kasir_menu_options_copy_dialog.dart';
import 'package:ammar_fe_flutter/models/addon_group_model.dart';
import 'package:ammar_fe_flutter/models/product_model.dart';
import 'package:ammar_fe_flutter/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _esTeh = ProductModel(
  id: 1,
  name: 'Es Teh Manis',
  categoryName: 'Menu Minuman',
  addonGroups: [
    AddonGroupModel(name: 'Level Es'),
    AddonGroupModel(name: 'Level Gula'),
  ],
);
const _kopi = ProductModel(
  id: 2,
  name: 'Kopi Hitam',
  categoryName: 'Menu Minuman',
  addonGroups: [
    AddonGroupModel(name: 'Penyajian'),
    AddonGroupModel(name: 'Tambahan'),
  ],
);
const _ayam = ProductModel(
  id: 3,
  name: 'Ayam Bakar',
  categoryName: 'Menu Ikan & Lauk Utama',
  addonGroups: [AddonGroupModel(name: 'Level Pedas')],
);

Future<ValueGetter<ProductModel?>> _open(WidgetTester tester) async {
  ProductModel? picked;
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light,
      home: Builder(
        builder: (context) => TextButton(
          onPressed: () async => picked = await KasirMenuOptionsCopyDialog.show(
            context,
            const [_esTeh, _kopi, _ayam],
          ),
          child: const Text('buka'),
        ),
      ),
    ),
  );
  await tester.tap(find.text('buka'));
  await tester.pumpAndSettle();
  return () => picked;
}

void main() {
  testWidgets('lists menus with a summary of their option groups', (
    tester,
  ) async {
    await _open(tester);

    expect(find.text('Es Teh Manis'), findsOneWidget);
    expect(find.text('Level Es · Level Gula'), findsOneWidget);
    expect(find.text('Penyajian · Tambahan'), findsOneWidget);
  });

  testWidgets('search filters by menu name or category', (tester) async {
    await _open(tester);

    await tester.enterText(find.byType(TextField), 'kopi');
    await tester.pump();
    expect(find.text('Kopi Hitam'), findsOneWidget);
    expect(find.text('Es Teh Manis'), findsNothing);

    await tester.enterText(find.byType(TextField), 'lauk');
    await tester.pump();
    expect(find.text('Ayam Bakar'), findsOneWidget);
    expect(find.text('Kopi Hitam'), findsNothing);

    await tester.enterText(find.byType(TextField), 'zzz');
    await tester.pump();
    expect(find.text('Menu tidak ditemukan.'), findsOneWidget);
  });

  testWidgets('tapping a menu returns it', (tester) async {
    final picked = await _open(tester);

    await tester.tap(find.text('Kopi Hitam'));
    await tester.pumpAndSettle();

    expect(picked()?.id, 2);
  });

  testWidgets('cancel returns nothing', (tester) async {
    final picked = await _open(tester);

    await tester.tap(find.text('Batal'));
    await tester.pumpAndSettle();

    expect(picked(), isNull);
  });
}
