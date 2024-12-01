import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/local_collection/diseases_isar.dart';
import 'package:late_blight/local_collection/insect_isar.dart';
import 'package:late_blight/local_collection/kalimati_tarkari.dart';
import 'package:late_blight/providers/app_bloc_providers.dart';
import 'package:late_blight/routes/routes.dart';
import 'package:late_blight/services/isar_service/isar_service.dart';
import 'package:late_blight/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpIsarDBcollection();
  await YajnaKrishiSharePrefs.getUser();
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyDfycO09CpmrwrIJm_BoxaWQA_L_1b7blk",
              authDomain: "lateblight-25f24.firebaseapp.com",
              projectId: "lateblight-25f24",
              storageBucket: "lateblight-25f24.appspot.com",
              messagingSenderId: "453602999189",
              appId: "1:453602999189:web:52ce8a4bb1af061e22949c",
              measurementId: "G-D2NR2CN63G"));
    } else {
      await Firebase.initializeApp();
    }
    //Flutter downloader initalize
    await FlutterDownloader.initialize(
        debug:
            true, // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl:
            true // option: set to false to disable working with http links (default: false)
        );
    //fetch the lccversion
    String? lccVersion = await YajnaKrishiSharePrefs.getmodelVersion();
    //fetch the data from the sharepref
    // AppLanguage lang = await YajnaKrishiSharePrefs.getLanguage();
    runApp(
      MultiBlocProvider(
        providers: [
          ...getAppBlocProviders(lccVersion),
        ],
        child: App(),
      ),
    );
  } catch (e) {
    //print(e);
  }
}

setUpIsarDBcollection() async {
  List<CollectionSchema<dynamic>> schemas = [
    KalimatiTarkariSchema,
    InsectGroupIsarSchema,
    PlantDiseaseSchema,
  ];
  await IsarService.init(schemas);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: routes,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          appBarTheme: AppBarTheme(
            color: appBarColor,
            elevation: 3,
            shadowColor: Colors.black,
          )),
    );
  }
}
