// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_sound_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(orderSound)
final orderSoundProvider = OrderSoundProvider._();

final class OrderSoundProvider
    extends $FunctionalProvider<OrderSound, OrderSound, OrderSound>
    with $Provider<OrderSound> {
  OrderSoundProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderSoundProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderSoundHash();

  @$internal
  @override
  $ProviderElement<OrderSound> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrderSound create(Ref ref) {
    return orderSound(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderSound value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderSound>(value),
    );
  }
}

String _$orderSoundHash() => r'833cd6dc8715cea12a945fc5f62ef60ce8f4af44';
