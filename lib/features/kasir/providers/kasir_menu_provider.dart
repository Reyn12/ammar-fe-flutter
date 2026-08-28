import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../mocks/product_mocks.dart';
import '../../../models/category_model.dart';
import '../../../models/product_model.dart';

part 'kasir_menu_provider.g.dart';

@riverpod
class KasirMenu extends _$KasirMenu {
  @override
  Future<List<ProductModel>> build() async {
    // TODO: ganti mock ini dengan GET /v1/products.
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return ProductMocks.products;
  }

  Future<void> toggleAvailability(int productId) async {
    // TODO: ganti dengan PUT /v1/products/{id}.
    state = AsyncData([
      for (final product in state.value ?? <ProductModel>[])
        if (product.id == productId)
          product.copyWith(isAvailable: !(product.isAvailable ?? false))
        else
          product,
    ]);
  }

  Future<void> saveProduct(ProductModel product) async {
    // TODO: ganti dengan POST/PUT /v1/products.
    await Future<void>.delayed(const Duration(milliseconds: 400));

    if (product.id == null) {
      state = AsyncData([
        ...?state.value,
        ProductModel(
          id: DateTime.now().millisecondsSinceEpoch,
          branchId: product.branchId,
          categoryId: product.categoryId,
          categoryName: product.categoryName,
          imageUrl: product.imageUrl,
          name: product.name,
          price: product.price,
          isAvailable: product.isAvailable,
          addonGroups: product.addonGroups,
        ),
      ]);
      return;
    }

    state = AsyncData([
      for (final item in state.value ?? <ProductModel>[])
        if (item.id == product.id) product else item,
    ]);
  }

  Future<void> deleteProduct(int productId) async {
    // TODO: ganti dengan DELETE /v1/products/{id}.
    await Future<void>.delayed(const Duration(milliseconds: 400));

    state = AsyncData([
      for (final product in state.value ?? <ProductModel>[])
        if (product.id != productId) product,
    ]);
  }
}

/// `null` berarti tab "Semua".
@riverpod
class KasirMenuCategory extends _$KasirMenuCategory {
  @override
  int? build() => null;

  void select(int? categoryId) => state = categoryId;
}

@riverpod
List<CategoryModel> kasirMenuCategories(Ref ref) => ProductMocks.categories;

@riverpod
Future<List<ProductModel>> filteredKasirMenu(Ref ref) async {
  return (await ref.watch(kasirMenuProvider.future))
      .where(
        (product) =>
            ref.watch(kasirMenuCategoryProvider) == null ||
            product.categoryId == ref.watch(kasirMenuCategoryProvider),
      )
      .toList();
}
