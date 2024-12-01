import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/model/diseases_model.dart';
import 'package:late_blight/services/isar_service/diseases_isar_service.dart';
import 'package:late_blight/utils/enums.dart';

class DiseasesStateModel {
  RequestState state;
  List<PlantDisease> diseases;

  DiseasesStateModel({
    required this.state,
    required this.diseases,
  });

  // CopyWith method for immutability
  DiseasesStateModel copyWith({
    RequestState? state,
    List<PlantDisease>? diseases,
  }) {
    return DiseasesStateModel(
      state: state ?? this.state,
      diseases: diseases ?? this.diseases,
    );
  }
}

class DiseasesBloc extends Cubit<DiseasesStateModel> {
  DiseasesBloc()
      : super(DiseasesStateModel(
          state: RequestState.idel,
          diseases: [],
        ));

  final DiseasesIsarService _diseasesIsarService = DiseasesIsarService();

  Future<void> fetchDiseases({bool refetch = false}) async {
    if (refetch) {
      _handleRefetch();
    } else {
      _loadDiseases();
    }
  }

  void _handleRefetch() async {
    try {
      List<PlantDisease> fetchedDiseases = await _fetchDiseasesFromApi();
      await _diseasesIsarService.addIfNotExists(fetchedDiseases);
      emit(state.copyWith(
        state: RequestState.success,
        diseases: fetchedDiseases,
      ));
    } catch (e) {
      // emit(state.copyWith(state: RequestState.fail));
    }
  }

  void _loadDiseases() async {
    if (state.state == RequestState.loading ||
        state.state == RequestState.success && state.diseases.isNotEmpty) {
      return;
    }
    try {
      emit(state.copyWith(state: RequestState.loading));
      List<PlantDisease> diseases = await _diseasesIsarService.getDiseases();
      if (diseases.isEmpty) {
        diseases = await _fetchDiseasesFromApi();
        await _diseasesIsarService.addDiseases(diseases);
      }
      emit(state.copyWith(
        state: RequestState.success,
        diseases: diseases,
      ));
    } catch (e) {
      emit(state.copyWith(
        state: RequestState.fail,
      ));
    }
  }

  // A mock function that simulates fetching diseases from an API
  Future<List<PlantDisease>> _fetchDiseasesFromApi() async {
    final response = await API.get(
      "diseases/",
    );

    List<PlantDisease> plantDiseases =
        (response.data['diseases'] as List<dynamic>)
            .map((diseaseJson) => PlantDisease.fromJson(diseaseJson))
            .toList();
    return plantDiseases;
  }
}
