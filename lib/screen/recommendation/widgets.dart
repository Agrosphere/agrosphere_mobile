import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/recommendation/agriculture_crop.dart';
import 'package:late_blight/screen/recommendation/recommendation_bloc.dart';
import 'package:late_blight/utils/enums.dart';

class RecommendationWidget extends StatefulWidget {
  const RecommendationWidget({super.key});

  @override
  State<RecommendationWidget> createState() => _RecommendationWidgetState();
}

class _RecommendationWidgetState extends State<RecommendationWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgriculturalReportCubit, AgriculturalReportState>(
      builder: (context, state) {
        if (state.state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == RequestState.success) {
          if (state.report != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LocationDetailsWidget(
                  locationDetails: state.report!.locationProperties,
                ),
                RecommendationVegetable(
                  crops: state.report!.recommendedVegetables,
                  cropProperties: state.report!.cropProperties,
                ),
                RecommendationFruit(
                  fruits: state.report!.recommendedFruits,
                  cropProperties: state.report!.cropProperties,
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

Widget item(String filename, String label, String value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Tooltip(
      message: label,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(8),
        ),
        height: 48,
        width: 180,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/$filename",
              height: 36,
              width: 36,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                value,
                softWrap: true,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class LocationDetailsWidget extends StatelessWidget {
  final LocationProperties locationDetails;
  const LocationDetailsWidget({super.key, required this.locationDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "माटो विवरण र मौसम विवरण",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                item(
                  "soil-ph-meter.png",
                  "Soil PH",
                  locationDetails.soilPh.toString(),
                ),
                item(
                  "nitrogen.png",
                  "Soil Nitrogen",
                  "${locationDetails.soilNitrogen} kg/ha",
                ),
                item(
                  "potassium.png",
                  "Soil Potassium",
                  "${locationDetails.soilPotassium} kg/ha",
                ),
                item(
                  "soil_phosphorus.png",
                  "Soil Phosphorus",
                  "${locationDetails.soilPhosphorus} kg/ha",
                ),
                item(
                  "mountain.png",
                  "Altitude",
                  "${locationDetails.altitude}m",
                ),
                item(
                  "hot.png",
                  "Weather temperature",
                  "${locationDetails.weatherTemperature.toStringAsFixed(2)} °C",
                ),
                item(
                  "rain.png",
                  "Weather Precipitation",
                  "${locationDetails.weatherTemperature.toStringAsFixed(2)} mm",
                ),
                item(
                  "humidity.png",
                  "Humidity",
                  "${locationDetails.weatherHumidity.toStringAsFixed(2)} %",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RecommendationVegetable extends StatelessWidget {
  final List<Crop> crops;
  final List<CropProperties> cropProperties;
  const RecommendationVegetable(
      {super.key, required this.crops, required this.cropProperties});

  @override
  Widget build(BuildContext context) {
    if (crops.isEmpty) {
      return SizedBox();
    }
    void showAlertBox(Crop crop) {
      //map the crop properties
      final properties = cropProperties.firstWhere(
        (element) => element.name == crop.vegetableNameEnglish,
      );

      showDialog(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.keyboard_backspace_sharp,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        crop.vegetableName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    crop.vegetableNameEnglish,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    crop.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "फसलको विवरण",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    item(
                      "soil-ph-meter.png",
                      "Soil PH",
                      properties.soilPhRange.toString(),
                    ),
                    item(
                      "nitrogen.png",
                      "Soil Nitrogen",
                      properties.soilNitrogenRange.toString(),
                    ),
                    item(
                      "potassium.png",
                      "Soil Potassium",
                      properties.soilNitrogenRange.toString(),
                    ),
                    item(
                      "soil_phosphorus.png",
                      "Soil Phosphorus",
                      properties.soilPhosphorusRange.toString(),
                    ),
                    item(
                      "mountain.png",
                      "Altitude",
                      properties.altitudeRange,
                    ),
                    item(
                      "hot.png",
                      "Weather temperature",
                      properties.temperatureRange,
                    ),
                    item(
                      "rain.png",
                      "Weather Precipitation",
                      "${properties.precipitationRange} ",
                    ),
                    item(
                      "humidity.png",
                      "Humidity",
                      "${properties.humidityRange} ",
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }

    Widget vegetableItem(Crop crop) {
      return GestureDetector(
        onTap: () {
          showAlertBox(crop);
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(11),
          height: 80,
          width: 180,
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            crop.vegetableName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("फसल सुझावहरू",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: crops.map((e) => vegetableItem(e)).toList(),
          ),
        ],
      ),
    );
  }
}

class RecommendationFruit extends StatelessWidget {
  final List<Fruit> fruits;
  final List<CropProperties> cropProperties;
  const RecommendationFruit({
    super.key,
    required this.fruits,
    required this.cropProperties,
  });

  @override
  Widget build(BuildContext context) {
    if (fruits.isEmpty) {
      return SizedBox();
    }

    void showAlertBox(Fruit crop) {
      //map the crop properties
      final properties = cropProperties.firstWhere(
        (element) => element.name == crop.englishName,
      );

      showDialog(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.keyboard_backspace_sharp,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        crop.nepaliName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    crop.englishName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    crop.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "फलको विवरण",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    item(
                      "soil-ph-meter.png",
                      "Soil PH",
                      properties.soilPhRange.toString(),
                    ),
                    item(
                      "nitrogen.png",
                      "Soil Nitrogen",
                      properties.soilNitrogenRange.toString(),
                    ),
                    item(
                      "potassium.png",
                      "Soil Potassium",
                      properties.soilNitrogenRange.toString(),
                    ),
                    item(
                      "soil_phosphorus.png",
                      "Soil Phosphorus",
                      properties.soilPhosphorusRange.toString(),
                    ),
                    item(
                      "mountain.png",
                      "Altitude",
                      properties.altitudeRange,
                    ),
                    item(
                      "hot.png",
                      "Weather temperature",
                      properties.temperatureRange,
                    ),
                    item(
                      "rain.png",
                      "Weather Precipitation",
                      "${properties.precipitationRange} ",
                    ),
                    item(
                      "humidity.png",
                      "Humidity",
                      "${properties.humidityRange} ",
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }

    Widget fruitItem(Fruit crop) {
      return GestureDetector(
        onTap: () {
          showAlertBox(crop);
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(11),
          height: 80,
          width: 180,
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            crop.nepaliName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("फल सुझावहरू",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: fruits.map((e) => fruitItem(e)).toList(),
          ),
        ],
      ),
    );
  }
}
