import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/weather.dart';
import 'package:late_blight/utils/enums.dart';

class WeatherState {
  Weather? weather;
  RequestState state;
  String? message;

  WeatherState({
    this.weather,
    required this.state,
    this.message,
  });

  WeatherState copyWith({
    Weather? weather,
    RequestState? state,
    String? message,
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }
}

class WeatherBloc extends Cubit<WeatherState> {
  WeatherBloc() : super(WeatherState(state: RequestState.idel));

  void fetch(double latitude, double longitude) async {
    if (state.state == RequestState.success) return;
    emit(state.copyWith(state: RequestState.loading));
    try {
      final response = await API.client.fetch(RequestOptions(
        baseUrl:
            "${Config.WEATHER_API_URL}/weather?lat=$latitude&lon=$longitude&appId=${Config.apikey}",
      ));

      final weather = Weather.fromJson(response.data);
      weather.copyWith(name: response.data["name"]);
      emit(state.copyWith(
        state: RequestState.success,
        weather: weather,
      ));
    } catch (e) {
      emit(state.copyWith(
        state: RequestState.fail,
        weather: null,
      ));
    }
  }

  void refetch(Position position) async {
    try {
      final response = await API.client.fetch(RequestOptions(
        baseUrl:
            "${Config.WEATHER_API_URL}/weather?lat=${position.latitude.toDouble()}&lon=${position.longitude.toDouble()}&appId=${Config.apikey}",
      ));
      final weather = Weather.fromJson(response.data['main']);
      emit(state.copyWith(
        state: RequestState.success,
        weather: weather,
      ));
    } catch (e) {
      //
    }
  }
}
