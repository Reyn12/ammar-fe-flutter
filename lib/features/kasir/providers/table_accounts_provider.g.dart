// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_accounts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TableAccounts)
final tableAccountsProvider = TableAccountsProvider._();

final class TableAccountsProvider
    extends $NotifierProvider<TableAccounts, List<TableAccountModel>> {
  TableAccountsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tableAccountsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tableAccountsHash();

  @$internal
  @override
  TableAccounts create() => TableAccounts();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TableAccountModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TableAccountModel>>(value),
    );
  }
}

String _$tableAccountsHash() => r'0b909830d798292ed94201f44dca1b1c97f721d9';

abstract class _$TableAccounts extends $Notifier<List<TableAccountModel>> {
  List<TableAccountModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<List<TableAccountModel>, List<TableAccountModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<TableAccountModel>, List<TableAccountModel>>,
              List<TableAccountModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
