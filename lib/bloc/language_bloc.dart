import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/shared_prefs.dart';

enum AppLanguage { en, np }

class LanguageBloc extends Cubit<AppLanguage> {
  LanguageBloc() : super(AppLanguage.np);

  //to change the language setting
  void changeLanguage(AppLanguage appLanguage) {
    // emit(appLanguage);
    YajnaKrishiSharePrefs.saveLanguage(appLanguage).then((value) {
      if (value!) {
        debugPrint("Changed");
      }
    });
  }
}
