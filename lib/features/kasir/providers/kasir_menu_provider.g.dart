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

String _$kasirMenuHash() => r'4c87d4807dbf1d87b174fc6fe55168547624a87d';

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
    r'bc911d26dd9e555c5bd1776a3e5a37851ede2199';

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
