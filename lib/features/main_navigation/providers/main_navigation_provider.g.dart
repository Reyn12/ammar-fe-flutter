// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_navigation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MainNavigationNotifier)
final mainNavigationProvider = MainNavigationNotifierProvider._();

final class MainNavigationNotifierProvider
    extends $NotifierProvider<MainNavigationNotifier, int> {
  MainNavigationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mainNavigationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mainNavigationNotifierHash();

  @$internal
  @override
  MainNavigationNotifier create() => MainNavigationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$mainNavigationNotifierHash() =>
    r'ab32677818919a2bd9d8a896138a9fcb4527b1a7';

abstract class _$MainNavigationNotifier extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
