import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/dialog_error_helper.dart';
import '../../../models/category_model.dart';
import '../../../network/api_service.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/primary_button.dart';
import '../providers/kasir_menu_provider.dart';

/// Owner menambah, mengganti nama, dan menghapus kategori menu.
class KasirCategoryManageDialog extends ConsumerStatefulWidget {
  const KasirCategoryManageDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => const KasirCategoryManageDialog(),
    );
  }

  @override
  ConsumerState<KasirCategoryManageDialog> createState() =>
      _KasirCategoryManageDialogState();
}

class _KasirCategoryManageDialogState
    extends ConsumerState<KasirCategoryManageDialog> {
  final newNameController = TextEditingController();
  bool isBusy = false;

  @override
  void dispose() {
    newNameController.dispose();
    super.dispose();
  }

  /// Jalankan aksi ke backend, lalu muat ulang kategori & menu (nama kategori ikut berubah).
  Future<bool> _run(Future<void> Function(ApiService api) action) async {
    setState(() => isBusy = true);
    try {
      await action(ref.read(apiServiceProvider));
      ref.invalidate(categoriesProvider);
      ref.invalidate(kasirMenuProvider);
      return true;
    } catch (error) {
      if (mounted) {
        final parsed = parseDialogError(error);
        CustomSnackbar.error(context, parsed.message, title: parsed.title);
      }
      return false;
    } finally {
      if (mounted) setState(() => isBusy = false);
    }
  }

  Future<void> _add() async {
    final name = newNameController.text.trim();
    if (name.isEmpty) return;
    final ok = await _run((api) => api.createCategory(name));
    if (ok) newNameController.clear();
  }

  Future<void> _rename(CategoryModel category) async {
    final controller = TextEditingController(text: category.name);
    final name = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ganti nama kategori'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(controller.text.trim()),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    controller.dispose();

    if (name == null || name.isEmpty || name == category.name) return;
    await _run((api) => api.updateCategory(category.id ?? 0, name));
  }

  Future<void> _delete(CategoryModel category) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus kategori?'),
        content: Text('"${category.name}" akan dihapus dari daftar kategori.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(
              'Hapus',
              style: TextStyle(color: AppColors.dangerMain),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final ok = await _run((api) => api.deleteCategory(category.id ?? 0));
    if (ok && ref.read(kasirMenuCategoryProvider) == category.id) {
      ref.read(kasirMenuCategoryProvider.notifier).select(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(kasirMenuCategoriesProvider);

    return Dialog(
      backgroundColor: AppColors.neutral10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 560),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Text(
                'Kelola Kategori',
                style: AppTypography.h8Bold.copyWith(
                  color: AppColors.neutral100,
                ),
              ),
              Flexible(
                child: categories.isEmpty
                    ? Text(
                        'Belum ada kategori.',
                        style: AppTypography.bodyRegularM.copyWith(
                          color: AppColors.neutral70,
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        separatorBuilder: (_, _) => const Divider(
                          height: 1,
                          color: AppColors.neutral30,
                        ),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        category.name ?? '-',
                                        style: AppTypography.bodySemiboldM
                                            .copyWith(
                                              color: AppColors.neutral100,
                                            ),
                                      ),
                                      Text(
                                        '${category.productCount ?? 0} menu',
                                        style: AppTypography.bodyRegularS
                                            .copyWith(
                                              color: AppColors.neutral70,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Ganti nama',
                                  // TODO: ganti Material icon ini dengan asset ikon final.
                                  icon: const Icon(Icons.edit_outlined),
                                  onPressed: isBusy
                                      ? null
                                      : () => _rename(category),
                                ),
                                IconButton(
                                  tooltip: 'Hapus',
                                  // TODO: ganti Material icon ini dengan asset ikon final.
                                  icon: const Icon(
                                    Icons.delete_outline_rounded,
                                    color: AppColors.dangerMain,
                                  ),
                                  onPressed: isBusy
                                      ? null
                                      : () => _delete(category),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: TextField(
                      controller: newNameController,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _add(),
                      decoration: InputDecoration(
                        hintText: 'Nama kategori baru',
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.neutral40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  PrimaryButton(
                    text: 'Tambah',
                    wrapContent: true,
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    enabled: !isBusy,
                    onPressed: _add,
                  ),
                ],
              ),
              Text(
                'Kategori yang masih punya menu tidak bisa dihapus.',
                style: AppTypography.bodyRegularS.copyWith(
                  color: AppColors.neutral70,
                ),
              ),
              PrimaryButton(
                text: 'Tutup',
                reverse: true,
                borderColor: AppColors.neutral40,
                textColor: AppColors.neutral80,
                height: 48,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
