import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/utils/enums.dart';

class EnsembleLCCModel {
  AGState state;
  int remaining;
  bool hasResult;
  List<double> result;
  List<String> filePaths;
  EnsembleLCCModel({
    required this.remaining,
    required this.hasResult,
    required this.result,
    required this.state,
    required this.filePaths,
  });
  EnsembleLCCModel copyWith({
    List<String>? filePaths,
    AGState? state,
    bool? hasResult,
    int? remaining,
    List<double>? result,
  }) {
    return EnsembleLCCModel(
      remaining: remaining ?? this.remaining,
      hasResult: hasResult ?? this.hasResult,
      result: result ?? this.result,
      state: state ?? this.state,
      filePaths: filePaths ?? this.filePaths,
    );
  }
}

class EnsembleLCCModelBloc extends Cubit<EnsembleLCCModel> {
  EnsembleLCCModelBloc()
      : super(EnsembleLCCModel(
          hasResult: false,
          remaining: 10,
          result: [],
          state: AGState.idel,
          filePaths: [],
        ));

  void setLoading() {
    emit(state.copyWith(state: AGState.loading));
  }

  void addFiles(List<String> files) {
    if (state.filePaths.length == 10) return;
    List<String> currentFiles = state.filePaths;
    currentFiles.addAll(files);
    if (currentFiles.length > 10) {
      currentFiles = currentFiles.sublist(0, 10);
    }
    emit(state.copyWith(
      hasResult: false,
      remaining: 10 - currentFiles.length,
      filePaths: currentFiles,
    ));
  }

  void inferences() {
    _uploadImage();
  }

  void _uploadImage() async {
    emit(state.copyWith(hasResult: false, state: AGState.loading));
    try {
      List<MultipartFile> multipartFiles = [];
      for (var filePath in state.filePaths) {
        String fileName = filePath.split('/').last;
        multipartFiles
            .add(await MultipartFile.fromFile(filePath, filename: fileName));
      }
      FormData formData = FormData.fromMap({
        "file": multipartFiles,
      });

      Response response = await API.request(
        'lcc_ensemble/predict',
        RequestMethod.post,
        body: formData,
      );

      if (response.statusCode == 200) {
        emit(state.copyWith(
          hasResult: true,
          result: (response.data["prediction"] as List<dynamic>?)
              ?.map((item) => item as double)
              .toList(),
          state: AGState.result,
        ));
      } else {
        debugPrint('Failed to upload: ${response.statusCode}');
        emit(state.copyWith(state: AGState.idel));
        // Handle upload failure
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      emit(state.copyWith(state: AGState.idel));
      // Handle exception
    }
  }

  void showResult() {
    emit(state.copyWith(hasResult: true, state: AGState.result));
  }

  void reset() {
    emit(EnsembleLCCModel(
      hasResult: false,
      remaining: 10,
      result: [],
      state: AGState.idel,
      filePaths: [],
    ));
  }
}
