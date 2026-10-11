import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../models/addon_group_model.dart';
import '../../../models/product_component_model.dart';
import '../../../models/product_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../providers/kasir_menu_provider.dart';
import 'kasir_menu_options_copy_dialog.dart';

/// Editor isi paket: pilih menu biasa + jumlahnya. Daftar kosong berarti menu biasa.
/// Setiap perubahan dikirim ke [onChanged] sebagai daftar lengkap.
class KasirMenuComponentsEditor extends ConsumerStatefulWidget {
  const KasirMenuComponentsEditor({
    super.key,
    required this.initialComponents,
    required this.priceController,
    required this.onChanged,
    required this.onTakeOptions,
    this.productId,
  });

  final List<ProductComponentModel> initialComponents;

  /// Harga paket yang sedang diketik, untuk info hemat.
  final TextEditingController priceController;
  final ValueChanged<List<ProductComponentModel>> onChanged;

  /// Menyalin grup pilihan sebuah isi ke paket; mengembalikan jumlah grup yang ditambahkan.
  final int Function(List<AddonGroupModel> groups) onTakeOptions;

  /// Menu yang sedang diedit; tidak boleh jadi isinya sendiri.
  final int? productId;

  @override
  ConsumerState<KasirMenuComponentsEditor> createState() =>
      _KasirMenuComponentsEditorState();
}

class _KasirMenuComponentsEditorState
    extends ConsumerState<KasirMenuComponentsEditor> {
  late List<ProductComponentModel> components;

  @override
  void initState() {
    super.initState();
    components = [...widget.initialComponents];
  }

  void _change(List<ProductComponentModel> next) {
    setState(() => components = next);
    widget.onChanged(next);
  }

  ProductModel? _productOf(int? id) {
    for (final product
        in ref.read(kasirMenuProvider).value ?? <ProductModel>[]) {
      if (product.id == id) return product;
    }
    return null;
  }

  Future<void> _add() async {
    final used = {for (final component in components) component.componentId};
    final candidates = [
      for (final product
          in ref.read(kasirMenuProvider).value ?? <ProductModel>[])
        // Paket lain tidak bisa jadi isi paket.
        if (product.id != widget.productId &&
            !product.isPackage &&
            !used.contains(product.id))
          product,
    ];

    final picked = await KasirMenuOptionsCopyDialog.show(
      context,
      candidates,
      title: 'Tambah Isi Paket',
      description: 'Pilih menu yang menjadi bagian dari paket ini.',
      subtitleOf: (product) =>
          '${product.categoryName ?? '-'} · ${formatRupiah(product.price ?? 0)}',
    );
    if (picked == null) return;

    _change([
      ...components,
      ProductComponentModel(
        componentId: picked.id,
        name: picked.name,
        price: picked.price,
        qty: 1,
        receivesOptions: false,
        isAvailable: picked.isAvailable,
      ),
    ]);
  }

  void _update(int index, ProductComponentModel next) {
    _change([
      for (var i = 0; i < components.length; i++)
        if (i == index) next else components[i],
    ]);
  }

  void _takeOptions(int index) {
    final groups = _productOf(components[index].componentId)?.addonGroups ?? [];
    final added = widget.onTakeOptions(groups);
    _update(index, components[index].copyWith(receivesOptions: true));

    CustomSnackbar.success(
      context,
      added > 0
          ? '$added grup pilihan diambil dari ${components[index].name}.'
          : 'Grup pilihannya sudah ada di paket ini.',
      title: 'Pilihan paket',
    );
  }

  int get _itemsTotal => components.fold(
    0,
    (total, component) => total + (component.price ?? 0) * (component.qty ?? 1),
  );

  @override
  Widget build(BuildContext context) {
    // Dipantau supaya daftar menu (untuk pilihan isi) tetap termuat selama editor tampil.
    ref.watch(kasirMenuProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'Isi Paket',
          style: AppTypography.bodyRegularL.copyWith(
            color: AppColors.neutral100,
          ),
        ),
        Text(
          'Kosongkan kalau ini menu biasa. Kalau diisi, dapur menerima tiap isi sebagai item sendiri.',
          style: AppTypography.bodyRegularS.copyWith(
            color: AppColors.neutral70,
          ),
        ),
        for (var i = 0; i < components.length; i++) _buildComponent(i),
        if (components.isNotEmpty)
          ListenableBuilder(
            listenable: widget.priceController,
            builder: (context, _) => _buildSavingHint(),
          ),
        OutlinedButton.icon(
          onPressed: _add,
          // TODO: ganti Material icon ini dengan asset ikon final.
          icon: const Icon(Icons.add_rounded, size: 18),
          label: const Text('Tambah Isi Paket'),
        ),
      ],
    );
  }

  Widget _buildSavingHint() {
    final price =
        int.tryParse(
          widget.priceController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    final saving = _itemsTotal - price;

    return Text(
      saving >= 0
          ? 'Harga satuan semua isi ${formatRupiah(_itemsTotal)}. Dengan harga paket ini pelanggan hemat ${formatRupiah(saving)}.'
          : 'Harga satuan semua isi ${formatRupiah(_itemsTotal)}. Harga paket ${formatRupiah(-saving)} lebih mahal dari beli satuan.',
      style: AppTypography.bodyRegularS.copyWith(
        color: saving >= 0 ? AppColors.neutral70 : AppColors.dangerMain,
      ),
    );
  }

  Widget _buildComponent(int index) {
    final component = components[index];
    final hasOptions =
        (_productOf(component.componentId)?.addonGroups ?? []).isNotEmpty;
    final qty = component.qty ?? 1;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.neutral20,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      component.name ?? '-',
                      style: AppTypography.bodySemiboldM.copyWith(
                        color: AppColors.neutral100,
                      ),
                    ),
                    Text(
                      formatRupiah(component.price ?? 0),
                      style: AppTypography.bodyRegularS.copyWith(
                        color: AppColors.neutral70,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Kurangi',
                // TODO: ganti Material icon ini dengan asset ikon final.
                icon: const Icon(Icons.remove_circle_outline_rounded),
                onPressed: qty > 1
                    ? () => _update(index, component.copyWith(qty: qty - 1))
                    : null,
              ),
              Text('$qty', style: AppTypography.bodySemiboldM),
              IconButton(
                tooltip: 'Tambah',
                // TODO: ganti Material icon ini dengan asset ikon final.
                icon: const Icon(Icons.add_circle_outline_rounded),
                onPressed: qty < 99
                    ? () => _update(index, component.copyWith(qty: qty + 1))
                    : null,
              ),
              IconButton(
                tooltip: 'Hapus isi',
                // TODO: ganti Material icon ini dengan asset ikon final.
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.dangerMain,
                ),
                onPressed: () => _change([
                  for (var i = 0; i < components.length; i++)
                    if (i != index) components[i],
                ]),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: component.receivesOptions ?? false,
                onChanged: (value) => _update(
                  index,
                  component.copyWith(receivesOptions: value ?? false),
                ),
              ),
              Expanded(
                child: Text(
                  'Terima pilihan & catatan paket (mis. bakar/goreng)',
                  style: AppTypography.bodyRegularS.copyWith(
                    color: AppColors.neutral80,
                  ),
                ),
              ),
            ],
          ),
          if (hasOptions)
            TextButton.icon(
              onPressed: () => _takeOptions(index),
              // TODO: ganti Material icon ini dengan asset ikon final.
              icon: const Icon(Icons.copy_rounded, size: 18),
              label: const Text('Ambil pilihan dari menu ini'),
            ),
        ],
      ),
    );
  }
}
