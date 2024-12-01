import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/bloc/language_bloc.dart';

import 'package:late_blight/model/weather.dart';
import 'package:late_blight/services/conveter.dart';
import 'package:late_blight/utils/lang_utils.dart';

class AboutWeather extends StatelessWidget {
  final Weather weather;
  const AboutWeather({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    bool checkIsDay() {
      DateTime now = DateTime.now();
      int currentHour = now.hour;
      return currentHour >= 6 &&
          currentHour < 18; // Assuming day is between 6 AM and 6 PM
    }

    List<Color> lineargradient = [
      const Color(0XFF536976),
      const Color(0XFF292E49)
    ];
    bool isDay = checkIsDay();
    if (isDay) {
      lineargradient = [const Color(0XFF00D2FF), const Color(0XFF3A7BD5)];
    }

    return BlocBuilder<LanguageBloc, AppLanguage>(
      builder: (context, language) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                YajnaLocalization.aboutWeather[language.name].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ),
            Card(
              elevation: 3,
              surfaceTintColor: Colors.blueAccent,
              color: Colors.white,
              shadowColor: Colors.white,
              child: Container(
                height: 160,
                width: Size.infinite.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: lineargradient,
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 75,
                      left: 20,
                      child: Text(
                        language == AppLanguage.en
                            ? '${(kelvinToCelsius(weather.temperature).toStringAsFixed(2))}°'
                            : '${toNepali(kelvinToCelsius(weather.temperature))}°',
                        style:
                            const TextStyle(fontSize: 36, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      right: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${YajnaLocalization.airPressure[language.name]}: ${language == AppLanguage.en ? weather.pressure : toNepali(weather.pressure)}',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            '${YajnaLocalization.humidity[language.name]}: ${language == AppLanguage.en ? weather.humidity : toNepali(weather.humidity)}%',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.pin_drop,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                weather.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 20,
                      child: Image.asset(
                        isDay ? "assets/sun.png" : "assets/mooon.png",
                        height: 80,
                        width: 100,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
