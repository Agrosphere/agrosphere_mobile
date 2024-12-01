double kelvinToCelsius(double kelvin) {
  return kelvin - 273.15;
}

String toNepali(double englishNumber) {
  String numberAsString = englishNumber.toStringAsFixed(2);

  return numberAsString
      .replaceAll('1', '१')
      .replaceAll('2', '२')
      .replaceAll('3', '३')
      .replaceAll('4', '४')
      .replaceAll('5', '५')
      .replaceAll('6', '६')
      .replaceAll('7', '७')
      .replaceAll('8', '८')
      .replaceAll('9', '९')
      .replaceAll('0', '०');
}
