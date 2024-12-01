import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/utils/enums.dart';

class LateBlightSegmentationModel {
  AGState state;
  bool hasResult;
  String url;
  List<dynamic> diseases;
  Map<String, dynamic> classColors;
  LateBlightSegmentationModel(
      {required this.hasResult,
      required this.state,
      required this.url,
      required this.diseases,
      required this.classColors});
  LateBlightSegmentationModel copyWith(
      {String? url,
      AGState? state,
      bool? hasResult,
      List<dynamic>? diseases,
      Map<String, dynamic>? classColors}) {
    return LateBlightSegmentationModel(
      hasResult: hasResult ?? this.hasResult,
      state: state ?? this.state,
      url: url ?? this.url,
      classColors: classColors ?? this.classColors,
      diseases: diseases ?? this.diseases,
    );
  }
}

class LateBlightSegModelBloc extends Cubit<LateBlightSegmentationModel> {
  LateBlightSegModelBloc()
      : super(LateBlightSegmentationModel(
          hasResult: false,
          state: AGState.idel,
          url: "",
          classColors: {},
          diseases: [],
        ));

  void setLoading() {
    emit(state.copyWith(state: AGState.loading));
  }

  void inference(File filePath) async {
    //upload _image
    _uploadImage(filePath);
  }

  void _uploadImage(File file) async {
    emit(state.copyWith(url: "", hasResult: false));
    try {
      final compressedFile = await _compressImage(file);

      if (compressedFile == null) {
        // print('Image compression failed');
        return;
      }

      String fileName = compressedFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      Response response = await API.request(
          'segmentation/lateblight/', RequestMethod.post,
          body: formData);
      if (response.statusCode == 200) {
        emit(state.copyWith(
          state: AGState.idel,
          hasResult: true,
          diseases: response.data['diseases'],
          classColors: response.data['class_colors'],
          url: API.getUrl(response.data['processed_image_url']),
        ));
        // Handle successful upload
      } else {
        debugPrint('Failed to upload: ${response.statusCode}');
        // Handle upload failure
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      // Handle exception
    } finally {
      emit(state.copyWith(state: AGState.idel));
    }
  }

  Future<File?> _compressImage(File file) async {
    final filePath = file.absolute.path;

    // Get the file extension (case insensitive)
    final fileExtension = filePath.split('.').last.toLowerCase();

    // Supported formats for FlutterImageCompress
    const supportedFormats = ['jpg', 'jpeg', 'png', 'heic'];

    if (!supportedFormats.contains(fileExtension)) {
      return file; // Return the original file for unsupported formats
    }

    // Generate output file path
    final lastIndex = filePath.lastIndexOf(RegExp(r'\.'));
    final splitFilePath = filePath.substring(0, lastIndex);
    final outPath = "${splitFilePath}_compressed.$fileExtension";

    try {
      // Compress the image
      var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outPath,
        quality: 50,
      );

      if (result != null) {
        return File(result.path);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  void reset() {
    emit(LateBlightSegmentationModel(
      hasResult: false,
      state: AGState.idel,
      url: "",
      classColors: {},
      diseases: [],
    ));
  }
}
