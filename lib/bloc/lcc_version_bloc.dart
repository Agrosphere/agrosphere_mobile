import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/shared_prefs.dart';

class LCCVersionBloc extends Cubit<String?> {
  LCCVersionBloc(super.initialState);

  //to change the language setting
  void changeLanguage(String appLanguage) {
    emit(appLanguage);
    YajnaKrishiSharePrefs.saveModelVersion(appLanguage).then((value) {
      if (value!) {
        debugPrint("Changed");
      }
    });
  }
}
