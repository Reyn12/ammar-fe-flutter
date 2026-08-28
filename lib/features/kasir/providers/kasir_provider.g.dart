// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kasir_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Kasir)
final kasirProvider = KasirProvider._();

final class KasirProvider extends $AsyncNotifierProvider<Kasir, void> {
  KasirProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kasirProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kasirHash();

  @$internal
  @override
  Kasir create() => Kasir();
}

String _$kasirHash() => r'738c87afe8e064386c12b0beaaada30f1708deac';

abstract class _$Kasir extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
