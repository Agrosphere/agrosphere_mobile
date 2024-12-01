import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/utils/enums.dart';

class LateBlightHistoryModel {
  List<double> predictedWeather;
  double lateblightprobability;
  String predictedDate;
  LateBlightHistoryModel({
    required this.predictedWeather,
    required this.lateblightprobability,
    required this.predictedDate,
  });
  LateBlightHistoryModel copyWith(
      {String? placename,
      List<double>? predictedWeather,
      double? lateblightprobability,
      String? predictedDate}) {
    return LateBlightHistoryModel(
      predictedWeather: predictedWeather ?? this.predictedWeather,
      lateblightprobability:
          lateblightprobability ?? this.lateblightprobability,
      predictedDate: predictedDate ?? this.predictedDate,
    );
  }

  factory LateBlightHistoryModel.fromJson(Map<String, dynamic> json) {
    double probability = json['late_blight_probability'];
    probability = probability.abs();

    return LateBlightHistoryModel(
      predictedDate: json['created_at'],
      lateblightprobability: probability > 1.0 ? probability - 1 : probability,
      predictedWeather: [],
    );
  }
}

class LateBlightHistoryBlocModel {
  List<LateBlightHistoryModel> data;
  RequestState requestState;
  LateBlightHistoryBlocModel({required this.data, required this.requestState});

  LateBlightHistoryBlocModel copyWith(
      {List<LateBlightHistoryModel>? data, RequestState? requestState}) {
    return LateBlightHistoryBlocModel(
        data: data ?? this.data,
        requestState: requestState ?? this.requestState);
  }
}

class LateBlightHistoryBloc extends Cubit<LateBlightHistoryBlocModel> {
  LateBlightHistoryBloc()
      : super(
          LateBlightHistoryBlocModel(
            data: [],
            requestState: RequestState.idel,
          ),
        );

  fetchHistory(String placeName) async {
    emit(state.copyWith(requestState: RequestState.loading));
    try {
      final response = await API.get(
        "prediction/lateblight/histories?place_name=$placeName",
      );
      // print(placeName);
      // print(response.data);
      final List<LateBlightHistoryModel> predictions = List.from(
          response.data.map((json) => LateBlightHistoryModel.fromJson(json)));
      // print(placeName);
      // print(predictions);
      emit(state.copyWith(
        requestState: RequestState.success,
        data: predictions,
      ));
    } catch (e) {
      emit(state.copyWith(
        requestState: RequestState.fail,
      ));
    }
  }
}
