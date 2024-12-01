import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/model/late_blight_prediction.dart';
import 'package:late_blight/utils/enums.dart';

class LateBlightProbabilityState {
  RequestState state;
  String? message;
  double probability;
  String? date;
  List<LateBlightPrediction> predictions;
  LateBlightProbabilityState(
      {required this.state,
      this.message,
      required this.probability,
      this.date,
      required this.predictions});

  LateBlightProbabilityState copyWith(
      {RequestState? state,
      String? message,
      double? probability,
      String? date,
      List<LateBlightPrediction>? predictions}) {
    return LateBlightProbabilityState(
      state: state ?? this.state,
      message: message ?? this.message,
      probability: probability ?? this.probability,
      date: date ?? this.date,
      predictions: predictions ?? this.predictions,
    );
  }
}

class LateBlightProbabilityBloc extends Cubit<LateBlightProbabilityState> {
  LateBlightProbabilityBloc()
      : super(LateBlightProbabilityState(
          state: RequestState.idel,
          probability: 0.0,
          predictions: [],
        ));

  void fetch(Position position) async {
    if (state.state == RequestState.success) return;
    emit(state.copyWith(state: RequestState.loading));
    try {
      final response = await API.get("prediction/lateblight/750/data",
          queryParameters: {
            "lat": position.latitude,
            "long": position.longitude
          });

      double probability =
          double.parse(response.data["probability"].toString());
      probability = probability > 1.0 ? probability - 1 : probability;
      String date = response.data["created_at"];

      final List<LateBlightPrediction> predictions = List.from(response
          .data["near_places"]
          .map((json) => LateBlightPrediction.fromJson(json)));

      emit(state.copyWith(
        state: RequestState.success,
        probability: probability.abs(),
        date: date,
        predictions: predictions,
      ));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(state: RequestState.fail, message: e.toString()));
    }
  }

  void refetch(Position position) async {
    if (state.state == RequestState.success) return;
    emit(state.copyWith(state: RequestState.loading));
    try {
      final response = await API.get("prediction/lateblight/data",
          queryParameters: {
            "lat": position.latitude,
            "long": position.longitude
          });

      double probability = double.parse(response.data["probability"]);
      probability = probability > 1.0 ? probability - 1 : probability;
      String date = response.data["created_at"];

      final List<LateBlightPrediction> predictions = List.from(response
          .data["near_places"]
          .map((json) => LateBlightPrediction.fromJson(json)));

      emit(state.copyWith(
        state: RequestState.success,
        probability: probability.abs(),
        date: date,
        predictions: predictions,
      ));
    } catch (e) {
      // emit(state.copyWith(message: e.toString()));
    }
  }
}
