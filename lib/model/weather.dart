class Weather {
  double temperature;
  double minTemp;
  double maxTemp;
  double pressure;
  double humidity;
  String name;

  Weather({
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
    required this.pressure,
    required this.humidity,
    this.name = "",
  });

  Weather.fromJson(Map<String, dynamic> json)
      : temperature = json['main']['temp'].toDouble(),
        minTemp = json['main']['temp_min'].toDouble(),
        maxTemp = json['main']['temp_max'].toDouble(),
        pressure = json['main']['pressure'].toDouble(),
        humidity = json['main']['humidity'].toDouble(),
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temperature;
    data['temp_min'] = minTemp;
    data['temp_max'] = maxTemp;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    return data;
  }

  Weather copyWith(
      {double? temperature,
      double? minTemp,
      double? maxTemp,
      double? pressure,
      double? humidity,
      String? name}) {
    return Weather(
      temperature: temperature ?? this.temperature,
      minTemp: minTemp ?? this.minTemp,
      maxTemp: maxTemp ?? this.maxTemp,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      name: name ?? this.name,
    );
  }
}
