import 'dart:math';

// Function to calculate the distance between two coordinates using the Haversine formula
double calculateDistance(
  double startLatitude,
  double startLongitude,
  double endLatitude,
  double endLongitude,
) {
  const double radiusOfEarth = 6371; // Earth's radius in kilometers

  // Convert degrees to radians
  double startLatRad = startLatitude * pi / 180;
  double endLatRad = endLatitude * pi / 180;
  double deltaLatRad = (endLatitude - startLatitude) * pi / 180;
  double deltaLonRad = (endLongitude - startLongitude) * pi / 180;

  // Haversine formula
  double a = sin(deltaLatRad / 2) * sin(deltaLatRad / 2) +
      cos(startLatRad) *
          cos(endLatRad) *
          sin(deltaLonRad / 2) *
          sin(deltaLonRad / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = radiusOfEarth * c; // Distance in kilometers

  return distance;
}
