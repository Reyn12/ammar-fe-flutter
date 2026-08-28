class HomeBannerItemModel {
  const HomeBannerItemModel({
    this.image,
    this.isAsset,
  });

  final String? image;
  final bool? isAsset;

  factory HomeBannerItemModel.fromJson(Map<String, dynamic> json) {
    return HomeBannerItemModel(
      image: json['image']?.toString(),
      isAsset: json['is_asset'] as bool?,
    );
  }
}
