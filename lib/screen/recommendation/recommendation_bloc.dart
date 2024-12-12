import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/screen/recommendation/agriculture_crop.dart';
import 'package:late_blight/utils/enums.dart';

class AgriculturalReportState {
  AgriculturalReport? report;
  RequestState state;
  AgriculturalReportState({required this.report, required this.state});
  AgriculturalReportState copyWith(
      {AgriculturalReport? report, RequestState? state}) {
    return AgriculturalReportState(
        report: report ?? this.report, state: state ?? this.state);
  }
}

class AgriculturalReportCubit extends Cubit<AgriculturalReportState> {
  AgriculturalReportCubit()
      : super(AgriculturalReportState(
          report: null,
          state: RequestState.idel,
        ));

  Future<void> fetchReport(double longitude, double latitude) async {
    // Replace this with your actual API call or data fetching logic
    try {
      emit(state.copyWith(state: RequestState.loading));
      final report = await _fetchReportFromApi(longitude, latitude);
      emit(state.copyWith(report: report, state: RequestState.success));
    } catch (e) {
      emit(state.copyWith(state: RequestState.fail));
    }
  }

  Future<AgriculturalReport> _fetchReportFromApi(
      double longitude, double latitude) async {
    const baseUrl = "https://recommendation.safalstha.com.np/api/";
    var body = {
      "lat": latitude,
      "long": longitude,
    };

    try {
      final response = await API.getWithFullUrl(
        "$baseUrl/recommendation/data",
        queryParameters: body,
      );

      if (response.statusCode == 200) {
        return AgriculturalReport.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to fetch report data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching report: $error');
    }
  }
}
