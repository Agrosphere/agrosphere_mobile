// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:late_blight/bloc/language_bloc.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/home/late_blight/bloc/late_blight.probability.bloc.dart';
import 'package:late_blight/screen/home/late_blight/bloc/weather.bloc.dart';
import 'package:late_blight/screen/home/late_blight/map/bloc/map_bloc.dart';
import 'package:late_blight/services/isar_service/location.service.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:late_blight/widgets/late_blight_history.dart';
import 'package:late_blight/widgets/near_by_location.dart';
import 'package:late_blight/widgets/prediction.dart';
import 'package:shimmer/shimmer.dart';

class LateBlightMainPage extends StatefulWidget {
  const LateBlightMainPage({super.key});

  @override
  State<LateBlightMainPage> createState() => _MainPageState();
}

class _MainPageState extends State<LateBlightMainPage> {
  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() {
    determinePosition(context).then((value) {
      // BlocProvider.of<MapBloc>(context).updateCurrentUserLocation(value);
      // ignore: use_build_context_synchronously
      BlocProvider.of<WeatherBloc>(context)
          .fetch(value.latitude, value.longitude);
      // ignore: use_build_context_synchronously
      BlocProvider.of<LateBlightProbabilityBloc>(context).fetch(value);
      // ignore: use_build_context_synchronously
      BlocProvider.of<MapBloc>(context).fetch();
      // ignore: use_build_context_synchronously
      BlocProvider.of<MapBloc>(context).updateCurrentUserLocation(value);
    }).onError((error, stackTrace) {
      if (error.toString() == "Location services are disabled.") {
        _showLocationServiceDialog();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
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
    Future<void> onRefresh() {
      determinePosition(context).then((value) {
        // ignore: use_build_context_synchronously
        BlocProvider.of<WeatherBloc>(context).refetch(value);
        //  BlocProvider.of<WeatherBloc>(context).(value);
        // ignore: use_build_context_synchronously
        BlocProvider.of<LateBlightProbabilityBloc>(context).refetch(value);
        // ignore: use_build_context_synchronously
        BlocProvider.of<MapBloc>(context).updateCurrentUserLocation(value);
      });

      return Future.delayed(
        const Duration(seconds: 1),
      );
    }

    return BlocBuilder<LanguageBloc, AppLanguage>(builder: (context, language) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return buildMobile(context);
                },
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildMobile(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<LateBlightProbabilityBloc, LateBlightProbabilityState>(
          builder: (context, state) {
            switch (state.state) {
              case RequestState.success:
                return SectionPrediction(
                  probability: state.probability,
                );
              case RequestState.idel:
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
                return Container();
            }
          },
        ),
        const SizedBox(
          height: 15,
        ),
        const NearByLocation(),
        const SizedBox(
          height: 15,
        ),
        const LateBlightHistoryChart(),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
