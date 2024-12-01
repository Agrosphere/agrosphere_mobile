import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/model/late_blight_prediction.dart';
import 'package:late_blight/utils/enums.dart';

class MapState {
  List<LateBlightPrediction> predictions;
  RequestState state;
  Position? currentUserLocation;
  String message;

  MapState(
      {required this.predictions,
      required this.state,
      required this.message,
      this.currentUserLocation});

  MapState copyWith(
      {List<LateBlightPrediction>? predictions,
      RequestState? state,
      String? message,
      Position? currentUserLocation}) {
    return MapState(
      predictions: predictions ?? this.predictions,
      state: state ?? this.state,
      message: message ?? this.message,
      currentUserLocation: currentUserLocation ?? this.currentUserLocation,
    );
  }
}

class MapBloc extends Cubit<MapState> {
  MapBloc()
      : super(
          MapState(
            predictions: [],
            state: RequestState.idel,
            message: "",
          ),
        );
  void updateCurrentUserLocation(Position position) {
    emit(state.copyWith(currentUserLocation: position));
  }

  Position? getPosition() {
    return state.currentUserLocation;
  }

  fetch() async {
    if (state.state == RequestState.success) return;
    try {
      final data = await API.get("/prediction/lateblight/750/all");

      List<LateBlightPrediction> predictions = List.from(
          data.data.map((json) => LateBlightPrediction.fromJson(json)));
      emit(
        state.copyWith(predictions: predictions, state: RequestState.success),
      );
    } catch (e) {
      // print(e);
      // emit(
      //   state.copyWith(state: RequestState.fail),
      // );
    }
  }
}
