import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../mocks/product_mocks.dart';
import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../../../network/api_service.dart';

part 'kasir_menu_provider.g.dart';

@riverpod
class KasirMenu extends _$KasirMenu {
  @override
  Future<List<ProductModel>> build() async {
    return ref.watch(apiServiceProvider).fetchProducts();
  }

  Future<void> toggleAvailability(int productId) async {
    final current = state.value ?? <ProductModel>[];
    ProductModel? product;
    for (final item in current) {
      if (item.id == productId) product = item;
    }
    if (product == null) return;

    final updated = await ref
        .read(apiServiceProvider)
        .updateProductAvailability(
          productId: productId,
          isAvailable: !(product.isAvailable ?? false),
        );

    state = AsyncData([
      for (final item in current)
        if (item.id == productId) updated else item,
    ]);
  }

  Future<void> saveProduct(ProductModel product) async {
    final api = ref.read(apiServiceProvider);
    final saved = product.id == null
        ? await api.createProduct(product)
        : await api.updateProduct(product);

    if (product.id == null) {
      state = AsyncData([...?state.value, saved]);
      return;
    }

    state = AsyncData([
      for (final item in state.value ?? <ProductModel>[])
        if (item.id == product.id) saved else item,
    ]);
  }

  Future<void> deleteProduct(int productId) async {
    await ref.read(apiServiceProvider).deleteProduct(productId);
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
