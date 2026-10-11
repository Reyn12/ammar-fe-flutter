import 'package:ammar_fe_flutter/features/kasir/widgets/kasir_menu_form_dialog.dart';
import 'package:ammar_fe_flutter/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('Batal and Simpan stay at the bottom while the form scrolls', (
    tester,
  ) async {
    // Layar pendek: isi form pasti lebih tinggi dari dialognya.
    tester.view.physicalSize = const Size(1600, 700);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light,
          home: const KasirMenuFormDialog(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 1200));

    final saveBefore = tester.getRect(find.text('Simpan'));
    final cancelBefore = tester.getRect(find.text('Batal'));
    expect(saveBefore.bottom, lessThanOrEqualTo(350), reason: 'masuk layar');

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -400),
    );
    await tester.pump();

    expect(tester.getRect(find.text('Simpan')), saveBefore);
    expect(tester.getRect(find.text('Batal')), cancelBefore);
  });
}
