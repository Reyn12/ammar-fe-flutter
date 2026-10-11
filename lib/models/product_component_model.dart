/// Satu isi paket (menu biasa + jumlahnya).
class ProductComponentModel {
  const ProductComponentModel({
    this.componentId,
    this.name,
    this.price,
    this.qty,
    this.receivesOptions,
    this.isAvailable,
  });

  final int? componentId;
  final String? name;

  /// Harga satuan menu ini (untuk menghitung hemat paket).
  final int? price;
  final int? qty;

  /// Pilihan paket (mis. bakar/goreng) dan catatan pelanggan diteruskan ke isi ini.
  final bool? receivesOptions;
  final bool? isAvailable;

  ProductComponentModel copyWith({int? qty, bool? receivesOptions}) {
    return ProductComponentModel(
      componentId: componentId,
      name: name,
      price: price,
      qty: qty ?? this.qty,
      receivesOptions: receivesOptions ?? this.receivesOptions,
      isAvailable: isAvailable,
    );
  }

  /// Body untuk POST/PUT /v1/products (bagian components[]).
  Map<String, dynamic> toBody() => {
    'component_id': componentId,
    'qty': qty ?? 1,
    'receives_options': receivesOptions ?? false,
  };

  factory ProductComponentModel.fromJson(Map<String, dynamic> json) {
    return ProductComponentModel(
      componentId: (json['component_id'] as num?)?.toInt(),
      name: json['name']?.toString(),
      price: (json['price'] as num?)?.toInt(),
      qty: (json['qty'] as num?)?.toInt(),
      receivesOptions: json['receives_options'] as bool?,
      isAvailable: json['is_available'] as bool?,
    );
  }
}
