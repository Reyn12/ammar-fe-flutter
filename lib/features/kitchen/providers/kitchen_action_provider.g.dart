// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_action_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Aksi kitchen (proses/sajikan/process-all) — loading dialog via DialogMixin.

@ProviderFor(KitchenActionController)
final kitchenActionControllerProvider = KitchenActionControllerProvider._();

/// Aksi kitchen (proses/sajikan/process-all) — loading dialog via DialogMixin.
final class KitchenActionControllerProvider
    extends $AsyncNotifierProvider<KitchenActionController, bool?> {
  /// Aksi kitchen (proses/sajikan/process-all) — loading dialog via DialogMixin.
  KitchenActionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kitchenActionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kitchenActionControllerHash();

  @$internal
  @override
  KitchenActionController create() => KitchenActionController();
}

String _$kitchenActionControllerHash() =>
    r'8bb8939c433fdf5479970085ac46ed5bff6b652b';

/// Aksi kitchen (proses/sajikan/process-all) — loading dialog via DialogMixin.

abstract class _$KitchenActionController extends $AsyncNotifier<bool?> {
  FutureOr<bool?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool?>, bool?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool?>, bool?>,
              AsyncValue<bool?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
