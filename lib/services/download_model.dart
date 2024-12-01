import 'dart:async';
import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  Future<String?> start(String url,
      {String path = 'model', bool saveInPublic = false}) async {
    Directory root = await getApplicationSupportDirectory();
    final savedDir = Directory('${root.path}/$path');

    // Check if the directory exists, if not, create it
    if (!savedDir.existsSync()) {
      savedDir.createSync(recursive: true);
    }

    final id = await FlutterDownloader.enqueue(
      url: url,
      savedDir: savedDir.path,
      allowCellular: true,
      requiresStorageNotLow: true,
      showNotification: false,
      saveInPublicStorage: saveInPublic,
    );
    return id;
  }
}
