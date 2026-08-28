// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Kitchen)
final kitchenProvider = KitchenProvider._();

final class KitchenProvider extends $AsyncNotifierProvider<Kitchen, void> {
  KitchenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kitchenProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kitchenHash();

  @$internal
  @override
  Kitchen create() => Kitchen();
}

String _$kitchenHash() => r'6300c127de2ba8d8e1e6e115eb0a839400352ace';

abstract class _$Kitchen extends $AsyncNotifier<void> {
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
