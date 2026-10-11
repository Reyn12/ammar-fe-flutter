import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/addon_group_model.dart';
import '../../../models/addon_model.dart';
import '../../../models/product_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../providers/kasir_menu_provider.dart';
import 'kasir_menu_category_item.dart';
import 'kasir_menu_options_copy_dialog.dart';

class _OptionDraft {
  _OptionDraft({
    this.id,
    String name = '',
    int price = 0,
    this.isAvailable = true,
  }) : nameController = TextEditingController(text: name),
       priceController = TextEditingController(
         text: price == 0 ? '' : '$price',
       );

  final int? id;
  final TextEditingController nameController;
  final TextEditingController priceController;
  bool isAvailable;

  void dispose() {
    nameController.dispose();
    priceController.dispose();
  }
}

class _GroupDraft {
  _GroupDraft({
    this.id,
    String name = '',
    this.isVariant = true,
    List<_OptionDraft>? options,
  }) : nameController = TextEditingController(text: name),
       options = options ?? [];

  final int? id;
  final TextEditingController nameController;
  final List<_OptionDraft> options;

  /// true = wajib pilih satu (mis. Level Es); false = opsional, boleh banyak (mis. Tambahan).
  bool isVariant;

  void dispose() {
    nameController.dispose();
    for (final option in options) {
      option.dispose();
    }
  }
}

/// Editor grup pilihan menu (Level Es, Level Gula, Tambahan, dst). Setiap perubahan
/// dikirim ke [onChanged] sebagai daftar lengkap grup.
class KasirMenuOptionsEditor extends ConsumerStatefulWidget {
  const KasirMenuOptionsEditor({
    super.key,
    required this.initialGroups,
    required this.onChanged,
    this.productId,
  });

  final List<AddonGroupModel> initialGroups;
  final ValueChanged<List<AddonGroupModel>> onChanged;

  /// Menu yang sedang diedit; dikeluarkan dari daftar "Salin dari menu lain".
  final int? productId;

  @override
  ConsumerState<KasirMenuOptionsEditor> createState() =>
      _KasirMenuOptionsEditorState();
}

class _KasirMenuOptionsEditorState
    extends ConsumerState<KasirMenuOptionsEditor> {
  late final List<_GroupDraft> groups;

  @override
  void initState() {
    super.initState();
    groups = widget.initialGroups.map(_draftFrom).toList();
  }

  @override
  void dispose() {
    for (final group in groups) {
      group.dispose();
    }
    super.dispose();
  }

  _GroupDraft _draftFrom(AddonGroupModel group, {bool keepIds = true}) {
    return _GroupDraft(
      id: keepIds ? group.id : null,
      name: group.name ?? '',
      isVariant: group.isVariant,
      options: [
        for (final addon in group.addons ?? <AddonModel>[])
          _OptionDraft(
            id: keepIds ? addon.id : null,
            name: addon.name ?? '',
            price: addon.price ?? 0,
            isAvailable: addon.isAvailable ?? true,
          ),
      ],
    );
  }

  void _emit() {
    widget.onChanged([
      for (final group in groups)
        () {
          final options = [
            for (final option in group.options)
              if (option.nameController.text.trim().isNotEmpty) option,
          ];
          return AddonGroupModel(
            id: group.id,
            name: group.nameController.text.trim(),
            isRequired: group.isVariant,
            minQty: group.isVariant ? 1 : 0,
            maxQty: group.isVariant ? 1 : options.length,
            addons: [
              for (final option in options)
                AddonModel(
                  id: option.id,
                  name: option.nameController.text.trim(),
                  price:
                      int.tryParse(
                        option.priceController.text.replaceAll(
                          RegExp(r'[^0-9]'),
                          '',
                        ),
                      ) ??
                      0,
                  isAvailable: option.isAvailable,
                ),
            ],
          );
        }(),
    ]);
  }

  void _change(VoidCallback update) {
    setState(update);
    _emit();
  }

  Future<void> _pickAndCopy(List<ProductModel> products) async {
    final source = await KasirMenuOptionsCopyDialog.show(context, products);
    if (source == null || !mounted) return;

    _copyFrom(source);
    CustomSnackbar.success(
      context,
      'Pilihan dari ${source.name ?? 'menu lain'} sudah disalin.',
      title: 'Berhasil',
    );
  }

  void _copyFrom(ProductModel source) {
    _change(() {
      for (final group in source.addonGroups ?? <AddonGroupModel>[]) {
        // Salinan baru tanpa id, supaya menu ini punya grup sendiri.
        groups.add(_draftFrom(group, keepIds: false));
      }
    });
  }

  InputDecoration _decoration(String hint) => InputDecoration(
    hintText: hint,
    isDense: true,
    filled: true,
    fillColor: AppColors.neutral10,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.neutral40),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.neutral40),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final copyable = [
      for (final product
          in ref.watch(kasirMenuProvider).value ?? <ProductModel>[])
        if (product.id != widget.productId &&
            (product.addonGroups ?? []).isNotEmpty)
          product,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'Pilihan Menu',
          style: AppTypography.bodyRegularL.copyWith(
            color: AppColors.neutral100,
          ),
        ),
        Text(
          'Contoh: Level Es, Level Gula, atau Tambahan. Kosongkan kalau menu ini tanpa pilihan.',
          style: AppTypography.bodyRegularS.copyWith(
            color: AppColors.neutral70,
          ),
        ),
        for (final group in groups) _buildGroup(group),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: () => _change(
                () => groups.add(_GroupDraft(options: [_OptionDraft()])),
              ),
              // TODO: ganti Material icon ini dengan asset ikon final.
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Tambah Grup Pilihan'),
            ),
            if (copyable.isNotEmpty)
              OutlinedButton.icon(
                onPressed: () => _pickAndCopy(copyable),
                // TODO: ganti Material icon ini dengan asset ikon final.
                icon: const Icon(Icons.copy_rounded, size: 18),
                label: const Text('Salin dari menu lain'),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildGroup(_GroupDraft group) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.neutral20,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: TextField(
                  controller: group.nameController,
                  onChanged: (_) => _emit(),
                  decoration: _decoration('Nama grup, mis. Level Es'),
                ),
              ),
              IconButton(
                tooltip: 'Hapus grup',
                // TODO: ganti Material icon ini dengan asset ikon final.
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.dangerMain,
                ),
                onPressed: () => _change(() {
                  groups.remove(group);
                  group.dispose();
                }),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              KasirMenuCategoryItem(
                label: 'Wajib pilih 1',
                isSelected: group.isVariant,
                onTap: () => _change(() => group.isVariant = true),
              ),
              KasirMenuCategoryItem(
                label: 'Opsional',
                isSelected: !group.isVariant,
                onTap: () => _change(() => group.isVariant = false),
              ),
            ],
          ),
          for (final option in group.options)
            Row(
              spacing: 8,
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: option.nameController,
                    onChanged: (_) => _emit(),
                    decoration: _decoration('Nama pilihan'),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: option.priceController,
                    onChanged: (_) => _emit(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: _decoration('+ Rp'),
                  ),
                ),
                Tooltip(
                  message: 'Tersedia',
                  child: Checkbox(
                    value: option.isAvailable,
                    onChanged: (value) =>
                        _change(() => option.isAvailable = value ?? true),
                  ),
                ),
                IconButton(
                  tooltip: 'Hapus pilihan',
                  // TODO: ganti Material icon ini dengan asset ikon final.
                  icon: const Icon(Icons.close_rounded, size: 20),
                  onPressed: () => _change(() {
                    group.options.remove(option);
                    option.dispose();
                  }),
                ),
              ],
            ),
          TextButton.icon(
            onPressed: () => _change(() => group.options.add(_OptionDraft())),
            // TODO: ganti Material icon ini dengan asset ikon final.
            icon: const Icon(Icons.add_rounded, size: 18),
            label: const Text('Tambah pilihan'),
          ),
        ],
      ),
    );
  }
}
