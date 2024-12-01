import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/model/insect_model.dart';
import 'package:late_blight/services/isar_service/insect_isar_service.dart';
import 'package:late_blight/utils/enums.dart';

class InsectStateModel {
  RequestState state;
  List<InsectGroup> insects;

  InsectStateModel({
    required this.state,
    required this.insects,
  });

  // CopyWith method for immutability
  InsectStateModel copyWith({
    RequestState? state,
    List<InsectGroup>? insects,
  }) {
    return InsectStateModel(
      state: state ?? this.state,
      insects: insects ?? this.insects,
    );
  }
}

class InsectsBloc extends Cubit<InsectStateModel> {
  InsectsBloc()
      : super(InsectStateModel(
          state: RequestState.idel,
          insects: [],
        ));

  InsectIsarService insectIsarService = InsectIsarService();
  Future<void> fetchInsects({bool refetch = false}) async {
    if (refetch) {
      _handleRefetch();
    } else {
      _handleFetch();
    }
  }

  void _handleRefetch() async {
    try {
      List<InsectGroup> fetchedInsects = await _fetchInsectsFromApi();
      //update the database with the new data
      await insectIsarService.deleteAll();
      await insectIsarService.addInsectGroup(fetchedInsects);
      emit(
        state.copyWith(state: RequestState.success, insects: fetchedInsects),
      );
    } catch (e) {
      // emit(state.copyWith(state: RequestState.fail));
    }
  }

  void _handleFetch() async {
    try {
      emit(state.copyWith(state: RequestState.loading));
      List<InsectGroup> fetchedInsects =
          await insectIsarService.getInsectGroups();
      if (fetchedInsects.isEmpty) {
        fetchedInsects = await _fetchInsectsFromApi();
        await insectIsarService.addInsectGroup(fetchedInsects);
      }
      emit(state.copyWith(
        state: RequestState.success,
        insects: fetchedInsects,
      ));
    } catch (e) {
      emit(state.copyWith(state: RequestState.fail));
    }
  }

  // Method to load diseases (you can add API calls or other logic here)
  // Future<void> loadInsects() async {
  //   if (state.state == RequestState.success && state.insects.isNotEmpty) return;
  //   try {
  //     // Set state to loading before starting the operation
  //     emit(state.copyWith(state: RequestState.loading));

  //     // fetch the data
  //     List<InsectGroup> fetchedInsects = await _fetchInsectsFromApi();
  //     // Set state to success with the fetched diseases
  //     emit(
  //       state.copyWith(state: RequestState.success, insects: fetchedInsects),
  //     );
  //   } catch (e) {
  //     // Set state to error if something goes wrong
  //     emit(state.copyWith(state: RequestState.fail));
  //   }
  // }

  Future<List<InsectGroup>> _fetchInsectsFromApi() async {
    final response = await API.get(
      "insects/",
    );

    List<InsectGroup> insects = (response.data['insects'] as List<dynamic>)
        .map((diseaseJson) => InsectGroup.fromJson(diseaseJson))
        .toList();
    return insects;
  }
}
