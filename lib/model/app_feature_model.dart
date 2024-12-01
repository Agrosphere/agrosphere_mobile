class AppFeatureModel {
  String featureDescription;
  String imageUrl;
  AppFeatureModel({
    required this.featureDescription,
    required this.imageUrl,
  });
  AppFeatureModel copyWith(
      {String? featureDescription,
      String? imageUrl,
      String? description,
      String? route}) {
    return AppFeatureModel(
      featureDescription: featureDescription ?? this.featureDescription,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
