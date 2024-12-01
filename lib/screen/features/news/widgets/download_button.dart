import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:late_blight/services/download_model.dart';

Widget download(String url) {
  Future<void> downloadMedia() async {
    try {
      final service = DownloadService();
      await service.start(url, path: 'media', saveInPublic: true);
      Fluttertoast.showToast(msg: 'Downloading...');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to download');
    }
  }

  return IconButton(
    icon: Icon(Icons.download),
    onPressed: () async {
      await downloadMedia();
    },
    color: Colors.blueAccent,
  );
}
