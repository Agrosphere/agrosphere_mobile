class AgriculturalReport {
  final List<Crop> recommendedVegetables;
  final List<Fruit> recommendedFruits;
  final LocationProperties locationProperties;
  final List<CropProperties> cropProperties;
  final String predictedDate;

  AgriculturalReport({
    required this.recommendedVegetables,
    required this.recommendedFruits,
    required this.locationProperties,
    required this.cropProperties,
    required this.predictedDate,
  });

  factory AgriculturalReport.fromJson(dynamic data) =>
      AgriculturalReport.fromMap(data);

  factory AgriculturalReport.fromMap(Map<String, dynamic> json) {
    return AgriculturalReport(
      recommendedVegetables: List<Crop>.from(
          json["recommended_vegetable"].map((x) => Crop.fromMap(x))),
      recommendedFruits: List<Fruit>.from(
          json["recommended_fruits"].map((x) => Fruit.fromJson(x))),
      locationProperties:
          LocationProperties.fromJson(json["location_properties"]),
      cropProperties: List<CropProperties>.from(
          json["crop_properties"].map((x) => CropProperties.fromJson(x))),
      predictedDate: json["predicted_date"],
    );
  }
}

class Crop {
  final String vegetableName;
  final String vegetableNameEnglish;
  final String season;
  final String description;

  Crop({
    required this.vegetableName,
    required this.vegetableNameEnglish,
    required this.season,
    required this.description,
  });

  factory Crop.fromMap(Map<String, dynamic> json) => Crop(
        vegetableName: json["vegetable_name"],
        vegetableNameEnglish: json["vegetable_name_english"],
        season: json["season"],
        description: json["description"],
      );
}

class Fruit {
  final String nepaliName;
  final String englishName;
  final String season;
  final String description;

  Fruit({
    required this.nepaliName,
    required this.englishName,
    required this.season,
    required this.description,
  });

  factory Fruit.fromJson(Map<String, dynamic> json) => Fruit(
        nepaliName: json['fruit_name'],
        englishName: json['fruit_name_english'],
        season: json['season'],
        description: json['description'],
      );
}

class LocationProperties {
  final double soilPh;
  final String soilPhosphorus;
  final String soilPotassium;
  final String soilNitrogen;
  final double altitude;
  final double weatherTemperature;
  final double weatherPrecipitation;
  final double weatherHumidity;

  LocationProperties({
    required this.soilPh,
    required this.soilPhosphorus,
    required this.soilPotassium,
    required this.soilNitrogen,
    required this.altitude,
    required this.weatherTemperature,
    required this.weatherPrecipitation,
    required this.weatherHumidity,
  });

  factory LocationProperties.fromJson(Map<String, dynamic> json) =>
      LocationProperties(
        soilPh: json['soil_ph'],
        soilPhosphorus: json['soil_phosphorus'],
        soilPotassium: json['soil_potassium'],
        soilNitrogen: json['soil_nitrogen'],
        altitude: json['Altitude'],
        weatherTemperature: json['weather_temperature'],
        weatherPrecipitation: json['weather_precipitation'],
        weatherHumidity: json['weather_humidity'],
      );
}

class CropProperties {
  final String name;
  final String soilPhRange;
  final String soilPhosphorusRange;
  final String soilPotassiumRange;
  final String soilNitrogenRange;
  final String temperatureRange;
  final String precipitationRange;
  final String humidityRange;
  final String altitudeRange;

  CropProperties({
    required this.name,
    required this.soilPhRange,
    required this.soilPhosphorusRange,
    required this.soilPotassiumRange,
    required this.soilNitrogenRange,
    required this.temperatureRange,
    required this.precipitationRange,
    required this.humidityRange,
    required this.altitudeRange,
  });

  factory CropProperties.fromJson(Map<String, dynamic> json) => CropProperties(
        name: json['Name'],
        soilPhRange: json['soil_ph'],
        soilPhosphorusRange: json['soil_phosphorus'],
        soilPotassiumRange: json['soil_potassium'],
        soilNitrogenRange: json['soil_nitrogen'],
        temperatureRange: json['weather_temperature'],
        precipitationRange: json['weather_precipitation'],
        humidityRange: json['weather_humidity'],
        altitudeRange: json['Altitude'],
      );
}
