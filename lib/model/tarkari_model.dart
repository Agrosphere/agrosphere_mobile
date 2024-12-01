// models/product.dart
class VegAndFruit {
  final String id;
  final String name;
  final String unit;
  final String minPrice;
  final String maxPrice;
  final String avgPrice;
  final String date;

  VegAndFruit({
    required this.id,
    required this.name,
    required this.unit,
    required this.minPrice,
    required this.maxPrice,
    required this.avgPrice,
    required this.date,
  });

  factory VegAndFruit.fromJson(Map<String, dynamic> json) {
    return VegAndFruit(
      id: json['_id'],
      name: json['कृषि उपज'],
      unit: json['ईकाइ'],
      minPrice: json['न्यूनतम'],
      maxPrice: json['अधिकतम'],
      avgPrice: json['औसत'],
      date: json['date'],
    );
  }
}
