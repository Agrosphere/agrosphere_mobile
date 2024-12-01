import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/home/lcc/bloc/lcc_model_update_bloc.dart';
import 'package:late_blight/shared_prefs.dart';
import 'package:path_provider/path_provider.dart';

void readLccFilesAndUpdate(BuildContext context) async {
  final updateBloc = BlocProvider.of<LCCUpdateBloc>(context);
  final dir = await getApplicationSupportDirectory();
  final newdir = Directory("${dir.path}/model");
  final files = newdir.listSync();
  List<String> newFiles = [];
  for (FileSystemEntity entity in files) {
    if (entity is File) {
      if (entity.path.contains(".tflite")) {
       newFiles.add(entity.path);
        //deleteModelFiles(entity.path);
      }
    }
  }

  newFiles.sort();
  if (newFiles.isNotEmpty) {
    final len = newFiles.length - 1;
    final extractFileName = newFiles[len].split('/').last;
    YajnaKrishiSharePrefs.saveModelVersion(extractFileName);
    updateBloc.updateVersion(newFiles[len]);
    updateBloc.updateHasUpdate();
    for (var i = 0; i < len; i++) {
      deleteModelFiles(newFiles[i]);
    }
  } else {
    YajnaKrishiSharePrefs.saveModelVersion(null);
    updateBloc.updateVersion(null);
    updateBloc.updateHasUpdate();
  }
}

void deleteModelFiles(String path) {
  try {
    //delete the old model
    File(path).deleteSync();
  } catch (e) {
    debugPrint(e.toString());
  }
}
