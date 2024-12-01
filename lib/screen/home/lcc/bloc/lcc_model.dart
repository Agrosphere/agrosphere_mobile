import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/utils/enums.dart';

class LCCModel {
  AGState state;
  int remaining;
  bool hasResult;
  List<int> result;
  List<String> filePaths;
  LCCModel({
    required this.remaining,
    required this.hasResult,
    required this.result,
    required this.state,
    required this.filePaths,
  });
  LCCModel copyWith({
    List<String>? filePaths,
    AGState? state,
    bool? hasResult,
    int? remaining,
    List<int>? result,
  }) {
    return LCCModel(
      remaining: remaining ?? this.remaining,
      hasResult: hasResult ?? this.hasResult,
      result: result ?? this.result,
      state: state ?? this.state,
      filePaths: filePaths ?? this.filePaths,
    );
  }
}

class LCCModelBloc extends Cubit<LCCModel> {
  LCCModelBloc()
      : super(LCCModel(
          hasResult: false,
          remaining: 10,
          result: [],
          state: AGState.idel,
          filePaths: [],
        ));

  void setLoading() {
    emit(state.copyWith(state: AGState.loading));
  }

  void addInference(int result, String filePath) {
    final List<int> results = [...state.result];
    results.add(result);
    state.filePaths.add(filePath);
    int remaining = state.remaining;
    remaining--;
    emit(state.copyWith(
      hasResult: remaining <= 0 ? true : false,
      state: AGState.camera,
      result: results,
      filePaths: [...state.filePaths],
      remaining: remaining,
    ));
  }

  void showResult() {
    emit(state.copyWith(hasResult: true, state: AGState.result));
  }

  void reset() {
    emit(LCCModel(
      hasResult: false,
      remaining: 10,
      result: [],
      state: AGState.idel,
      filePaths: [],
    ));
  }
}
