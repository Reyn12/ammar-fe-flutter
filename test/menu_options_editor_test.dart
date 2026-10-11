import 'package:ammar_fe_flutter/features/kasir/widgets/kasir_menu_options_editor.dart';
import 'package:ammar_fe_flutter/models/addon_group_model.dart';
import 'package:ammar_fe_flutter/models/addon_model.dart';
import 'package:ammar_fe_flutter/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _levelEs = AddonGroupModel(
  id: 11,
  name: 'Level Es',
  isRequired: true,
  minQty: 1,
  maxQty: 1,
  addons: [
    AddonModel(id: 21, name: 'Normal', price: 0, isAvailable: true),
    AddonModel(id: 22, name: 'Tanpa Es', price: 0, isAvailable: true),
  ],
);

Future<List<AddonGroupModel> Function()> _pumpEditor(
  WidgetTester tester, {
  List<AddonGroupModel> initial = const [_levelEs],
  KasirMenuOptionsController? controller,
}) async {
  tester.view.physicalSize = const Size(1600, 2400);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);

  var latest = initial;
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: SingleChildScrollView(
            child: KasirMenuOptionsEditor(
              controller: controller,
              initialGroups: initial,
              onChanged: (groups) => latest = groups,
            ),
          ),
        ),
      ),
    ),
  );
  // Editor memuat daftar menu (untuk "Salin dari menu lain") lewat mock API yang punya delay.
  await tester.pump(const Duration(milliseconds: 1200));
  return () => latest;
}

void main() {
  testWidgets('shows existing groups and their options', (tester) async {
    await _pumpEditor(tester);

    expect(find.text('Level Es'), findsOneWidget);
    expect(find.text('Normal'), findsOneWidget);
    expect(find.text('Tanpa Es'), findsOneWidget);
  });

  testWidgets('switching a group to optional allows picking all options', (
    tester,
  ) async {
    final latest = await _pumpEditor(tester);

    await tester.tap(find.text('Opsional'));
    await tester.pump();

    final group = latest().single;
    expect(group.id, 11, reason: 'grup lama tetap membawa id');
    expect(group.isRequired, isFalse);
    expect(group.minQty, 0);
    expect(group.maxQty, 2);
    expect(group.addons!.map((addon) => addon.id), [21, 22]);
  });

  testWidgets('adding a group and an option builds a required group', (
    tester,
  ) async {
    final latest = await _pumpEditor(tester, initial: const []);

    await tester.tap(find.text('Tambah Grup Pilihan'));
    await tester.pump();

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'Level Gula');
    await tester.enterText(fields.at(1), 'Normal');
    await tester.enterText(fields.at(2), '2000');
    await tester.pump();

    final group = latest().single;
    expect(group.id, isNull);
    expect(group.name, 'Level Gula');
    expect(group.isRequired, isTrue);
    expect(group.minQty, 1);
    expect(group.maxQty, 1);
    expect(group.addons!.single.name, 'Normal');
    expect(group.addons!.single.price, 2000);
  });

  testWidgets('blank options are dropped and groups can be removed', (
    tester,
  ) async {
    final latest = await _pumpEditor(tester);

    await tester.tap(find.text('Tambah pilihan').first);
    await tester.pump();
    expect(
      latest().single.addons,
      hasLength(2),
      reason: 'opsi kosong diabaikan',
    );

    await tester.tap(find.byTooltip('Hapus grup'));
    await tester.pump();
    expect(latest(), isEmpty);
  });

  testWidgets(
    'controller appends copied groups once and skips duplicate names',
    (tester) async {
      final controller = KasirMenuOptionsController();
      final latest = await _pumpEditor(tester, controller: controller);

      const penyajian = AddonGroupModel(
        id: 77,
        name: 'Penyajian',
        isRequired: true,
        minQty: 1,
        maxQty: 1,
        addons: [AddonModel(id: 5, name: 'Es', price: 0, isAvailable: true)],
      );

      expect(controller.appendGroups(const [_levelEs, penyajian]), 1);
      await tester.pump();

      final groups = latest();
      expect(groups.map((group) => group.name), ['Level Es', 'Penyajian']);
      expect(
        groups.last.id,
        isNull,
        reason: 'salinan tidak membawa id menu asal',
      );
      expect(groups.last.addons!.single.id, isNull);
      expect(controller.appendGroups(const [penyajian]), 0);
    },
  );

  test('group body keeps ids and derives min/max like the backend expects', () {
    expect(_levelEs.isVariant, isTrue);
    expect(_levelEs.toBody(), {
      'id': 11,
      'name': 'Level Es',
      'is_required': true,
      'min_qty': 1,
      'max_qty': 1,
      'addons': [
        {'id': 21, 'name': 'Normal', 'price': 0, 'is_available': true},
        {'id': 22, 'name': 'Tanpa Es', 'price': 0, 'is_available': true},
      ],
    });
  });
}
