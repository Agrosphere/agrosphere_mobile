class LateBlightPrediction {
  final String id;
  final double longitude;
  final double latitude;
  // final List<List<double>> predictedWeather;
  final double lateblightProbability;
  final String placeName;
  final String predictionDate;

  LateBlightPrediction({
    required this.id,
    required this.longitude,
    required this.latitude,
    // required this.predictedWeather,
    required this.lateblightProbability,
    required this.placeName,
    required this.predictionDate,
  });

  factory LateBlightPrediction.fromJson(Map<String, dynamic> json) {
    double probability = json.containsKey("lateblight_probability")
        ? double.parse(json['lateblight_probability'].toString())
        : double.parse(json['late_blight_probability'].toString());
    probability = probability.abs();
    return LateBlightPrediction(
      id: json['id'],
      longitude: double.parse(json['longitude'].toString()),
      latitude: double.parse(json['latitude'].toString()),
      lateblightProbability: probability > 1.0 ? probability - 1 : probability,
      placeName: json['place_name'] ?? "",
      predictionDate: json['created_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'longitude': longitude,
      'latitude': latitude,
      // 'predicted_weather': predictedWeather,
      'lateblight_probability': lateblightProbability,
      'place_name': placeName,
      'created_at': predictionDate,
    };
  }

  @override
  String toString() {
    return 'WeatherPrediction{id: $id, longitude: $longitude, latitude: $latitude, lateblightProbability: $lateblightProbability, placeName: $placeName, predictionDate: $predictionDate}';
  }
}
