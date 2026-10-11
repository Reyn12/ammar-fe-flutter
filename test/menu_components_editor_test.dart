import 'package:ammar_fe_flutter/features/kasir/providers/kasir_menu_provider.dart';
import 'package:ammar_fe_flutter/features/kasir/widgets/kasir_menu_components_editor.dart';
import 'package:ammar_fe_flutter/helper/format_currency_helper.dart';
import 'package:ammar_fe_flutter/models/addon_group_model.dart';
import 'package:ammar_fe_flutter/models/addon_model.dart';
import 'package:ammar_fe_flutter/models/product_component_model.dart';
import 'package:ammar_fe_flutter/models/product_model.dart';
import 'package:ammar_fe_flutter/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _tipeAyam = AddonGroupModel(
  id: 9,
  name: 'Tipe Ayam',
  isRequired: true,
  minQty: 1,
  maxQty: 1,
  addons: [AddonModel(id: 1, name: 'Bakar', price: 0, isAvailable: true)],
);

const _products = [
  ProductModel(
    id: 1,
    name: 'Ayam Goreng',
    price: 17000,
    categoryName: 'Lauk',
    isAvailable: true,
    addonGroups: [_tipeAyam],
  ),
  ProductModel(
    id: 2,
    name: 'Nasi Putih',
    price: 5000,
    categoryName: 'Makanan',
    isAvailable: true,
  ),
  ProductModel(
    id: 3,
    name: 'Paket Hemat',
    price: 25000,
    categoryName: 'Paket',
    isAvailable: true,
    components: [ProductComponentModel(componentId: 1, name: 'Ayam Goreng')],
  ),
];

class _FakeMenu extends KasirMenu {
  @override
  Future<List<ProductModel>> build() async => _products;
}

class _Harness {
  _Harness(this.priceController);

  final TextEditingController priceController;
  List<ProductComponentModel> components = const [];
  List<AddonGroupModel> taken = const [];
}

Future<_Harness> _pump(
  WidgetTester tester, {
  List<ProductComponentModel> initial = const [],
  int? productId,
}) async {
  tester.view.physicalSize = const Size(1600, 2400);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);

  final harness = _Harness(TextEditingController(text: '20000'))
    ..components = initial;
  addTearDown(harness.priceController.dispose);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [kasirMenuProvider.overrideWith(_FakeMenu.new)],
      child: MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: SingleChildScrollView(
            child: KasirMenuComponentsEditor(
              productId: productId,
              initialComponents: initial,
              priceController: harness.priceController,
              onChanged: (value) => harness.components = value,
              onTakeOptions: (groups) {
                harness.taken = groups;
                return groups.length;
              },
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return harness;
}

Future<void> _addFromPicker(WidgetTester tester, String name) async {
  await tester.tap(find.text('Tambah Isi Paket'));
  await tester.pumpAndSettle();
  await tester.tap(find.text(name));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('picker offers regular menu only and adds it with quantity 1', (
    tester,
  ) async {
    final harness = await _pump(tester);

    await tester.tap(find.text('Tambah Isi Paket'));
    await tester.pumpAndSettle();
    expect(find.text('Ayam Goreng'), findsOneWidget);
    expect(find.text('Nasi Putih'), findsOneWidget);
    expect(
      find.text('Paket Hemat'),
      findsNothing,
      reason: 'paket tidak bisa jadi isi',
    );

    await tester.tap(find.text('Ayam Goreng'));
    await tester.pumpAndSettle();

    expect(harness.components.single.componentId, 1);
    expect(harness.components.single.qty, 1);
    expect(harness.components.single.price, 17000);
  });

  testWidgets('menu already in the package is not offered again', (
    tester,
  ) async {
    await _pump(tester);
    await _addFromPicker(tester, 'Ayam Goreng');

    await tester.tap(find.text('Tambah Isi Paket'));
    await tester.pumpAndSettle();

    expect(find.text('Nasi Putih'), findsOneWidget);
    // Satu "Ayam Goreng" milik baris isi paket, bukan daftar pilihan.
    expect(find.text('Ayam Goreng'), findsOneWidget);
  });

  testWidgets('quantity, removal and saving hint follow the edits', (
    tester,
  ) async {
    final harness = await _pump(tester);
    await _addFromPicker(tester, 'Ayam Goreng');
    await _addFromPicker(tester, 'Nasi Putih');

    await tester.tap(find.byTooltip('Tambah').last);
    await tester.pump();

    expect(harness.components.map((c) => c.qty), [1, 2]);
    // 17.000 + 2 x 5.000 = 27.000 dibanding harga paket 20.000
    expect(find.textContaining('hemat ${formatRupiah(7000)}'), findsOneWidget);

    harness.priceController.text = '30000';
    await tester.pump();
    expect(
      find.textContaining('${formatRupiah(3000)} lebih mahal'),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Hapus isi').first);
    await tester.pump();
    expect(harness.components.single.componentId, 2);
  });

  testWidgets('taking options copies the groups and marks the component', (
    tester,
  ) async {
    final harness = await _pump(tester);
    await _addFromPicker(tester, 'Ayam Goreng');
    await _addFromPicker(tester, 'Nasi Putih');

    // Nasi tidak punya pilihan, jadi tombolnya hanya ada di Ayam.
    expect(find.text('Ambil pilihan dari menu ini'), findsOneWidget);
    await tester.tap(find.text('Ambil pilihan dari menu ini'));
    await tester.pump();

    expect(harness.taken.single.name, 'Tipe Ayam');
    expect(harness.components.first.receivesOptions, isTrue);
    expect(harness.components.last.receivesOptions, isFalse);

    // Snackbar konfirmasi punya timer 3 detik.
    await tester.pump(const Duration(seconds: 4));
  });

  test('component body matches what the backend expects', () {
    expect(
      const ProductComponentModel(
        componentId: 1,
        qty: 2,
        receivesOptions: true,
      ).toBody(),
      {'component_id': 1, 'qty': 2, 'receives_options': true},
    );
  });
}
