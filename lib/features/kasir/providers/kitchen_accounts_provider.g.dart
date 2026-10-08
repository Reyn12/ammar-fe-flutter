// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_accounts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KitchenAccounts)
final kitchenAccountsProvider = KitchenAccountsProvider._();

final class KitchenAccountsProvider
    extends $NotifierProvider<KitchenAccounts, List<KitchenAccountModel>> {
  KitchenAccountsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kitchenAccountsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kitchenAccountsHash();

  @$internal
  @override
  KitchenAccounts create() => KitchenAccounts();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<KitchenAccountModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<KitchenAccountModel>>(value),
    );
  }
}

String _$kitchenAccountsHash() => r'6614c96e74b88b4b52b6c33fdc4d8e58e4eec03c';

abstract class _$KitchenAccounts extends $Notifier<List<KitchenAccountModel>> {
  List<KitchenAccountModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<List<KitchenAccountModel>, List<KitchenAccountModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<KitchenAccountModel>, List<KitchenAccountModel>>,
              List<KitchenAccountModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
