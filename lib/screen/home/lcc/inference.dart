import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class LCCInference {
  IsolateInterpreter? _interpreater;
  LCCInference(String path, {bool isAssets = false}) {
    _load_model(path, isAssets: isAssets);
  }

  // ignore: non_constant_identifier_names
  _load_model(String path, {bool isAssets = false}) async {
    try {
      File file = File(path);
      if (!file.existsSync()) {
        throw Exception("File not found");
      }
      // Read the contents of the file as a string
      final contents = file.readAsBytesSync();
      //load the model from the assets if the isAssets = True other from file
      final interpreter = isAssets
          ? await Interpreter.fromAsset(
              path,
              options: InterpreterOptions()..threads = 4,
            )
          : Interpreter.fromBuffer(
              contents,
              options: InterpreterOptions()..useNnApiForAndroid = true,
            );
      interpreter.allocateTensors();
      _interpreater =
          await IsolateInterpreter.create(address: interpreter.address);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  IsolateInterpreter? get interpreter => _interpreater;

  Future<int> inference(String path, {int resize = 224}) async {
    try {
      final imageData = File(path).readAsBytesSync();
      img.Image image = (img.decodeImage(imageData))!;
      var resizedImage = img.copyResize(image, width: resize, height: resize);
      // Convert the resized image to a 1D Float32List.
      var inputBytes = _imageToByteListFloat32(resizedImage, resize);
      // Output container
      final output = Float32List(1 * 4).reshape([1, 4]);
      final input = inputBytes.reshape([1, resize, resize, 3]);
      // Run data throught model
      await interpreter!.run(input, output);
      //converting the model output to the List<double>
      final predictionResult = output[0] as List<double>;
      //finding the highest probability
      double maxElement =
          predictionResult.reduce((double maxElement, double element) {
        return element > maxElement ? element : maxElement;
      });
      List labels = [0, 1, 2, 3];
      //finding the index belonging to the maxElement or probability
      int index = predictionResult.indexOf(maxElement);
      // print(labels[index]);
      return labels[index];
    } catch (e) {
      debugPrint(e.toString());
    }
    return -1;
  }

  Future<void> dispose() {
    //close the interpreter
    return interpreter!.close();
  }

  Float32List _imageToByteListFloat32(img.Image image, int inputSize) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    //flatting the image into 1D
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        //normalize the read, green and blue
        buffer[pixelIndex++] = (pixel.r / 255);
        buffer[pixelIndex++] = (pixel.g / 255);
        buffer[pixelIndex++] = (pixel.b / 255);
      }
    }
    return convertedBytes;
  }
}
