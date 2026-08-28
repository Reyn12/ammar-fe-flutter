class HomeNewsModel {
  const HomeNewsModel({
    this.title,
    this.description,
    this.image,
    this.isAsset,
  });

  final String? title;
  final String? description;
  final String? image;
  final bool? isAsset;

  factory HomeNewsModel.fromJson(Map<String, dynamic> json) {
    return HomeNewsModel(
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      image: json['image']?.toString(),
      isAsset: json['is_asset'] as bool?,
    );
  }
}
