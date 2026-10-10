import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/dialog_error_helper.dart';
import '../../../models/product_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/primary_button.dart';
import '../providers/kasir_menu_provider.dart';
import 'kasir_menu_category_item.dart';
import 'kasir_menu_photo_picker.dart';

class KasirMenuFormDialog extends ConsumerStatefulWidget {
  const KasirMenuFormDialog({super.key, this.product});

  /// `null` berarti mode tambah menu baru.
  final ProductModel? product;

  static Future<void> show(BuildContext context, [ProductModel? product]) {
    return showDialog<void>(
      context: context,
      builder: (_) => KasirMenuFormDialog(product: product),
    );
  }

  @override
  ConsumerState<KasirMenuFormDialog> createState() =>
      _KasirMenuFormDialogState();
}

class _KasirMenuFormDialogState extends ConsumerState<KasirMenuFormDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final TextEditingController nameController;
  late final TextEditingController priceController;
  late int? selectedCategoryId;
  late bool isAvailable;
  String? imagePath;
  bool isSubmitting = false;

  bool get _isEdit => widget.product?.id != null;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product?.name ?? '');
    priceController = TextEditingController(
      text: widget.product?.price == null ? '' : '${widget.product?.price}',
    );
    selectedCategoryId = widget.product?.categoryId;
    isAvailable = widget.product?.isAvailable ?? true;
    imagePath = widget.product?.imageUrl;
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) return;

    setState(() => isSubmitting = true);
    try {
      // Foto lokal diunggah otomatis oleh saveProduct sebelum produk disimpan.
      await ref
          .read(kasirMenuProvider.notifier)
          .saveProduct(
            ProductModel(
              id: widget.product?.id,
              branchId: widget.product?.branchId ?? 1,
              categoryId: selectedCategoryId,
              categoryName: _categoryNameOf(selectedCategoryId),
              imageUrl: imagePath,
              name: nameController.text.trim(),
              price:
                  int.tryParse(
                    priceController.text.replaceAll(RegExp(r'[^0-9]'), ''),
                  ) ??
                  0,
              isAvailable: isAvailable,
              addonGroups: widget.product?.addonGroups,
            ),
          );
    } catch (error) {
      if (!mounted) return;
      setState(() => isSubmitting = false);
      final parsed = parseDialogError(error);
      CustomSnackbar.error(context, parsed.message, title: parsed.title);
      return;
    }

    if (!mounted) return;
    setState(() => isSubmitting = false);
    Navigator.of(context).pop();
    CustomSnackbar.success(
      context,
      _isEdit ? 'Perubahan menu tersimpan.' : 'Menu baru berhasil ditambahkan.',
      title: 'Berhasil',
    );
  }

  String? _categoryNameOf(int? categoryId) {
    for (final category in ref.read(kasirMenuCategoriesProvider)) {
      if (category.id == categoryId) return category.name;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.neutral10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 18,
              children: [
                Text(
                  _isEdit ? 'Edit Menu' : 'Tambah Menu',
                  style: AppTypography.h8Bold.copyWith(
                    color: AppColors.neutral100,
                  ),
                ),
                KasirMenuPhotoPicker(
                  imagePath: imagePath,
                  onChanged: (path) => setState(() => imagePath = path),
                ),
                CustomTextField(
                  name: 'name',
                  label: 'Nama Menu',
                  hint: 'Contoh: Ayam Bakar Madu',
                  controller: nameController,
                ),
                CustomTextField(
                  name: 'price',
                  label: 'Harga',
                  hint: 'Contoh: 28000',
                  keyboardType: TextInputType.number,
                  controller: priceController,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'Kategori',
                      style: AppTypography.bodyRegularL.copyWith(
                        color: AppColors.neutral100,
                      ),
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                        ref.watch(kasirMenuCategoriesProvider).length,
                        (index) => KasirMenuCategoryItem(
                          label:
                              ref
                                  .watch(kasirMenuCategoriesProvider)[index]
                                  .name ??
                              '-',
                          isSelected:
                              selectedCategoryId ==
                              ref.watch(kasirMenuCategoriesProvider)[index].id,
                          onTap: () => setState(() {
                            selectedCategoryId = ref
                                .read(kasirMenuCategoriesProvider)[index]
                                .id;
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tersedia',
                            style: AppTypography.bodySemiboldM.copyWith(
                              color: AppColors.neutral100,
                            ),
                          ),
                          Text(
                            'Matikan kalau menu sedang habis.',
                            style: AppTypography.bodyRegularS.copyWith(
                              color: AppColors.neutral70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: isAvailable,
                      activeTrackColor: AppColors.successMain,
                      onChanged: (value) => setState(() => isAvailable = value),
                    ),
                  ],
                ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: 'Batal',
                        reverse: true,
                        borderColor: AppColors.neutral40,
                        textColor: AppColors.neutral80,
                        height: 48,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Expanded(
                      child: PrimaryButton(
                        text: isSubmitting ? 'Menyimpan...' : 'Simpan',
                        height: 48,
                        enabled: !isSubmitting && selectedCategoryId != null,
                        onPressed: _submit,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
