// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kasir_transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KasirTransactions)
final kasirTransactionsProvider = KasirTransactionsProvider._();

final class KasirTransactionsProvider
    extends $AsyncNotifierProvider<KasirTransactions, List<OrderModel>> {
  KasirTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kasirTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kasirTransactionsHash();

  @$internal
  @override
  KasirTransactions create() => KasirTransactions();
}

String _$kasirTransactionsHash() => r'aca31fe31df5e324dcdec448ceac1151b3f413be';

abstract class _$KasirTransactions extends $AsyncNotifier<List<OrderModel>> {
  FutureOr<List<OrderModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<OrderModel>>, List<OrderModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<OrderModel>>, List<OrderModel>>,
              AsyncValue<List<OrderModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
