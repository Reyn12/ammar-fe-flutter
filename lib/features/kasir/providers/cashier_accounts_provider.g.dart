// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashier_accounts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CashierAccounts)
final cashierAccountsProvider = CashierAccountsProvider._();

final class CashierAccountsProvider
    extends $NotifierProvider<CashierAccounts, List<CashierAccountModel>> {
  CashierAccountsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cashierAccountsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cashierAccountsHash();

  @$internal
  @override
  CashierAccounts create() => CashierAccounts();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CashierAccountModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CashierAccountModel>>(value),
    );
  }
}

String _$cashierAccountsHash() => r'843ff1045038765572f948b8cf18b5fbabd03c05';

abstract class _$CashierAccounts extends $Notifier<List<CashierAccountModel>> {
  List<CashierAccountModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<List<CashierAccountModel>, List<CashierAccountModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<CashierAccountModel>, List<CashierAccountModel>>,
              List<CashierAccountModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
