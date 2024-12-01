import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:late_blight/model/chat.dart';

Future<Uint8List> compressImage(File file, {int quality = 25}) async {
  return await Isolate.run(() {
    final image = file.readAsBytesSync();
    final decodedImage = img.decodeImage(image);
    final compressedImage = img.encodeJpg(decodedImage!, quality: quality);
    return compressedImage;
  });
}

Future<Map<String, dynamic>> isolateSaveImage(
    Directory directory, ChatModel chat) async {
  // Run the isolate and await its completion
  final result = await Isolate.run(() async {
    final filePath = "${directory.path}/${chat.chatId}.png";
    // Check if the file exists
    if (await File(filePath).exists()) {
      // final aspectRatio =
      //     calculateAspectRatio(await File(filePath).readAsBytes());
      return {'file': File(filePath), 'aspectRatio': 1};
    }
    // Decode the content from the chat model
    final bytes = base64Decode(chat.message);
    File(filePath).writeAsBytesSync(bytes);
    // Return the new aspect ratio after saving the image
    // final aspectRatio = calculateAspectRatio(bytes);
    return {'file': File(filePath), 'aspectRatio': 1};
  });
  return result;
}

double calculateAspectRatio(Uint8List bytes) {
  final image = img.decodeImage(bytes);
  if (image == null) {
    throw Exception('Failed to decode image');
  }
  return image.width / image.height;
}
