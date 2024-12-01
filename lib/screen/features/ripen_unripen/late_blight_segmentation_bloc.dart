import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/utils/enums.dart';

class TomatoRipenModel {
  AGState state;
  String message;
  TomatoRipenModel({
    required this.state,
    required this.message,
  });
  TomatoRipenModel copyWith({
    String? url,
    AGState? state,
    String? message,
  }) {
    return TomatoRipenModel(
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }
}

class TomatoRipenModelBloc extends Cubit<TomatoRipenModel> {
  TomatoRipenModelBloc()
      : super(TomatoRipenModel(
          state: AGState.idel,
          message: "",
        ));

  void setLoading() {
    emit(state.copyWith(state: AGState.loading));
  }

  void inference(File filePath) async {
    //upload _image
    _uploadImage(filePath);
  }

  void _uploadImage(File file) async {
    emit(state.copyWith(url: ""));
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
          'classifier/tomato_ripen/', RequestMethod.post,
          body: formData);
      if (response.statusCode == 200) {
        emit(state.copyWith(
          state: AGState.idel,
          message: response.data['message'],
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
    emit(TomatoRipenModel(
      message: "",
      state: AGState.idel,
    ));
  }
}
