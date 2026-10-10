// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kasir_menu_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KasirMenu)
final kasirMenuProvider = KasirMenuProvider._();

final class KasirMenuProvider
    extends $AsyncNotifierProvider<KasirMenu, List<ProductModel>> {
  KasirMenuProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kasirMenuProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kasirMenuHash();

  @$internal
  @override
  KasirMenu create() => KasirMenu();
}

String _$kasirMenuHash() => r'a413738c15d313d2ff443bfeaa0ff718b4e10ed3';

abstract class _$KasirMenu extends $AsyncNotifier<List<ProductModel>> {
  FutureOr<List<ProductModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ProductModel>>, List<ProductModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ProductModel>>, List<ProductModel>>,
              AsyncValue<List<ProductModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Kategori menu dari backend (GET /v1/categories).

@ProviderFor(categories)
final categoriesProvider = CategoriesProvider._();

/// Kategori menu dari backend (GET /v1/categories).

final class CategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CategoryModel>>,
          List<CategoryModel>,
          FutureOr<List<CategoryModel>>
        >
    with
        $FutureModifier<List<CategoryModel>>,
        $FutureProvider<List<CategoryModel>> {
  /// Kategori menu dari backend (GET /v1/categories).
  CategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<CategoryModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CategoryModel>> create(Ref ref) {
    return categories(ref);
  }
}

String _$categoriesHash() => r'db89a1998ca9c4ba26294ad6a347062c85bf3042';

/// `null` berarti tab "Semua".

@ProviderFor(KasirMenuCategory)
final kasirMenuCategoryProvider = KasirMenuCategoryProvider._();

/// `null` berarti tab "Semua".
final class KasirMenuCategoryProvider
    extends $NotifierProvider<KasirMenuCategory, int?> {
  /// `null` berarti tab "Semua".
  KasirMenuCategoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kasirMenuCategoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kasirMenuCategoryHash();

  @$internal
  @override
  KasirMenuCategory create() => KasirMenuCategory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$kasirMenuCategoryHash() => r'8bc7f78bc574c790a7fc73e7451ab825ab61dd1f';

/// `null` berarti tab "Semua".

abstract class _$KasirMenuCategory extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(kasirMenuCategories)
final kasirMenuCategoriesProvider = KasirMenuCategoriesProvider._();

final class KasirMenuCategoriesProvider
    extends
        $FunctionalProvider<
          List<CategoryModel>,
          List<CategoryModel>,
          List<CategoryModel>
        >
    with $Provider<List<CategoryModel>> {
  KasirMenuCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kasirMenuCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kasirMenuCategoriesHash();

  @$internal
  @override
  $ProviderElement<List<CategoryModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<CategoryModel> create(Ref ref) {
    return kasirMenuCategories(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CategoryModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CategoryModel>>(value),
    );
  }
}

String _$kasirMenuCategoriesHash() =>
    r'0ebfd0cc1d1c385443cbc12e650cb416c48bbbc2';

@ProviderFor(filteredKasirMenu)
final filteredKasirMenuProvider = FilteredKasirMenuProvider._();

final class FilteredKasirMenuProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductModel>>,
          List<ProductModel>,
          FutureOr<List<ProductModel>>
        >
    with
        $FutureModifier<List<ProductModel>>,
        $FutureProvider<List<ProductModel>> {
  FilteredKasirMenuProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredKasirMenuProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredKasirMenuHash();

  @$internal
  @override
  $FutureProviderElement<List<ProductModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductModel>> create(Ref ref) {
    return filteredKasirMenu(ref);
  }
}

String _$filteredKasirMenuHash() => r'8768be1835682fade7637dc4635d20a3052ba00c';
