// use for the LCC model update available  or not

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/shared_prefs.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class LCCUpdateModel {
  bool hasupdate;
  bool isCheck;
  String? url;
  String? lccModelPath;
  LCCUpdateModel(this.hasupdate, this.url, this.isCheck, this.lccModelPath);
  LCCUpdateModel copyWith(
      {bool? hasupdate, String? url, bool? isCheck, String? lccModelPath}) {
    return LCCUpdateModel(hasupdate ?? this.hasupdate, url ?? this.url,
        isCheck ?? this.isCheck, lccModelPath ?? this.lccModelPath);
  }
}

class LCCUpdateBloc extends Cubit<LCCUpdateModel> {
  LCCUpdateBloc() : super(LCCUpdateModel(false, null, false, null));

  void init() {
    _getNewUpdateAvailable();
  }

  void updateVersion(String? version) {
    emit(state.copyWith(lccModelPath: version));
  }

  void updateHasUpdate() {
    emit(state.copyWith(hasupdate: false));
  }

  _getNewUpdateAvailable() async {
    if (state.isCheck) {
      return;
    }
    //fetch the lccversion
    String? lccVersion = await YajnaKrishiSharePrefs.getmodelVersion();
    try {
      final response = await API.get("lcc/new?version=$lccVersion");
      emit(state.copyWith(
        url: response.data['url'],
        hasupdate: response.data['hasUpdate'],
        isCheck: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        url: null,
        hasupdate: false,
        isCheck: false,
        lccModelPath: version,
      ));
      //error
    }
  }
}
