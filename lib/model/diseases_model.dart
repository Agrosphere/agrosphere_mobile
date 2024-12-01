class PlantDisease {
  final String id;
  final String diseaseName;
  final String cause;
  final String imageUrl;
  final List<String> symptoms;
  final List<String> management;

  PlantDisease({
    required this.id,
    required this.diseaseName,
    required this.cause,
    required this.imageUrl,
    required this.symptoms,
    required this.management,
  });

  factory PlantDisease.fromJson(Map<String, dynamic> json) {
    return PlantDisease(
      id: json['_id'] as String,
      diseaseName: json['रोगको नाम'] as String,
      cause: json['रोगको कारण'] as String,
      imageUrl: json['रोगको तस्बिर'] as String,
      symptoms: List<String>.from(json['लक्षणहरू']),
      management: List<String>.from(json['व्यवस्थापन']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'रोगको नाम': diseaseName,
      'रोगको कारण': cause,
      'रोगको तस्बिर': imageUrl,
      'लक्षणहरू': symptoms,
      'व्यवस्थापन': management,
    };
  }
}
