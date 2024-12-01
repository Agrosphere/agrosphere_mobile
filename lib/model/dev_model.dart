class DeveloperModel {
  final String name;
  final String role;
  final String gmail;
  final String linkedin;
  final String facebook;
  final String imageUrl;
  final String details;
  final String github;

  DeveloperModel(
      {required this.name,
      required this.role,
      required this.gmail,
      required this.linkedin,
      required this.facebook,
      required this.imageUrl,
      required this.details,
      required this.github});

  // Factory method to create a DeveloperModel from JSON
  factory DeveloperModel.fromJson(Map<String, dynamic> json) {
    return DeveloperModel(
      name: json['name'],
      role: json['role'],
      gmail: json['gmail'],
      linkedin: json['linkedin'],
      facebook: json['facebook'],
      imageUrl: json['image_url'],
      details: json['details'],
      github: json['github'],
    );
  }

  // CopyWith method for updating individual fields
  DeveloperModel copyWith({
    String? name,
    String? role,
    String? gmail,
    String? linkedin,
    String? facebook,
    String? imageUrl,
    String? details,
    String? github,
  }) {
    return DeveloperModel(
      name: name ?? this.name,
      role: role ?? this.role,
      gmail: gmail ?? this.gmail,
      linkedin: linkedin ?? this.linkedin,
      facebook: facebook ?? this.facebook,
      imageUrl: imageUrl ?? this.imageUrl,
      details: details ?? this.details,
      github: github ?? this.github,
    );
  }
}
