import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:late_blight/screen/home/late_blight/bloc/weather.bloc.dart';
import 'package:late_blight/services/isar_service/location.service.dart';
import 'package:late_blight/shared_prefs.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:late_blight/widgets/about.weather.dart';
import 'package:shimmer/shimmer.dart';

class CurrentUserLocationWeather extends StatefulWidget {
  const CurrentUserLocationWeather({super.key});

  @override
  State<CurrentUserLocationWeather> createState() =>
      _CurrentUserLocationWeatherState();
}

class _CurrentUserLocationWeatherState
    extends State<CurrentUserLocationWeather> {
  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    //fetch the current user location
    final location = await YajnaKrishiSharePrefs.getCurrentUserLocation();
    if (location != null && mounted) {
      BlocProvider.of<WeatherBloc>(context)
          .fetch(location['latitude'], location['longitude']);
    }
    if (mounted) {
      determinePosition(context).then((value) async {
        // BlocProvider.of<MapBloc>(context).updateCurrentUserLocation(value);
        // ignore: use_build_context_synchronously
        BlocProvider.of<WeatherBloc>(context)
            .fetch(value.latitude, value.longitude);
        //save the current user location
        await YajnaKrishiSharePrefs.saveCurrentUserLocation(value);
      }).onError((error, stackTrace) {
        if (error.toString() == "Location services are disabled.") {
          _showLocationServiceDialog();
        }
      });
    }
  }

  void _showLocationServiceDialog() {
    Geolocator.isLocationServiceEnabled().then((value) {
      if (!value) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('स्थान सेवाहरू असक्षम गरियो'),
              content: const Text(
                  'कृपया यो सुविधा प्रयोग गर्न स्थान सेवाहरू सक्षम गर्नुहोस्।'),
              actions: <Widget>[
                TextButton(
                  child: const Text('ठिक छ'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Geolocator.openLocationSettings().then((value) {
                      fetch();
                    });
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        switch (state.state) {
          case RequestState.success:
            return AboutWeather(
              weather: state.weather!,
            );
          case RequestState.loading:
            return SizedBox(
              height: 200.0,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
