// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:late_blight/bloc/language_bloc.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/home/ensemble_lcc/bloc/lcc_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:late_blight/screen/home/lcc/bloc/lcc_model.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:late_blight/utils/lang_utils.dart';
import 'package:late_blight/widgets/lcc.report.dart';

class EnsembleLCCMainPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const EnsembleLCCMainPage({Key? key});

  @override
  _LCCMainPageState createState() => _LCCMainPageState();
}

class _LCCMainPageState extends State<EnsembleLCCMainPage> {
  late String title;
  late String uses;
  late String description;
  final picker =
      ImagePicker(); // Allows us to pick image from gallery or camera

  bool hasUpdateAvailable = false;
  @override
  void initState() {
    // InitS is the first function that is executed by default when this class is called
    super.initState();
  }

  @override
  void dispose() {
    // Dis function disposes and clears our memory
    super.dispose();
  }

  pickImage(ImageSource imageSource, EnsembleLCCModel state) async {
    // This function to grab the image from camera
    if (state.remaining < 0) {
      Fluttertoast.showToast(msg: "Max files select limit is 10");
      return;
    }
    var image = await picker.pickMultiImage(
        imageQuality: 75, limit: state.remaining <= 1 ? 2 : state.remaining);
    if (image.isEmpty) return;
    List<String> paths = [];
    for (final path in image) {
      paths.add(path.path);
    }
    // ignore: use_build_context_synchronously
    BlocProvider.of<EnsembleLCCModelBloc>(context).addFiles(paths);
  }

  int getHighestValueIndex(List<double> predictions) {
    double highestValue = predictions[0];
    int highestIndex = 0;

    for (int i = 1; i < predictions.length; i++) {
      if (predictions[i] > highestValue) {
        highestValue = predictions[i];
        highestIndex = i;
      }
    }

    return highestIndex;
  }

  @override
  Widget build(BuildContext context) {
    Widget info(AppLanguage language) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blueGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.info,
                color: Colors.white70,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  YajnaLocalization.fieldPhotos[language.name].toString(),
                  softWrap: true,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      );
    }

    String result(List<double> result, AppLanguage language) {
      List<String> results = [
        language == AppLanguage.en
            ? "To get the best possible yeild it is recommended to apply 20 kgs of urea per hectare"
            : "अधिकतम नाफा कमाउनको लागि १ हेक्टर जमिनमा २० किलो युरिया मल लगाउनु पर्छ|",
        language == AppLanguage.en
            ? "We cannot say anything at the moment"
            : "अहिलेको लागि हामी केहि भन्न सक्दैनौं"
      ];
      int index = getHighestValueIndex(result);
      if (index == 0 || index == 1) {
        return results[0];
      } else {
        return results[1];
      }
    }

    Widget chooseImageSource(AppLanguage language) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(YajnaLocalization.imageSource[language.name].toString(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ListTile(
            onTap: () {
              //update the choose image source to gallery
              // BlocProvider.of<ChoosePhotoModel>(context)
              //     .change(ImageSource.gallery);
            },
            title: Text(
              YajnaLocalization.selectPhoto[language.name].toString(),
            ),
            leading: Radio<String>(
              value: '${YajnaLocalization.selectPhoto[language.name]}',
              groupValue:
                  YajnaLocalization.selectPhoto[language.name].toString(),
              onChanged: (value) {
                //update the choose image source to gallery
                // BlocProvider.of<ChoosePhotoModel>(context)
                //     .change(ImageSource.gallery);
              },
            ),
          ),
        ],
      );
    }

    Widget takePhotoWidget(EnsembleLCCModel state, AppLanguage language) {
      return GestureDetector(
        onTap: state.state == AGState.loading
            ? null
            : () {
                pickImage(ImageSource.gallery, state);
              },
        child: Container(
          width: MediaQuery.of(context).size.width - 200,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
          decoration: BoxDecoration(
            color: buttonColor1,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.folder,
                color: Colors.yellow,
              ),
              Text(
                YajnaLocalization.selectPhoto[language.name].toString(),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    Widget restart(AppLanguage language) {
      return GestureDetector(
        onTap: () {
          BlocProvider.of<EnsembleLCCModelBloc>(context).reset();
        },
        child: Container(
            width: MediaQuery.of(context).size.width - 200,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 16, 90, 2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.restart_alt,
                  color: Colors.white,
                ),
                Text(
                  YajnaLocalization.restart[language.name].toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            )),
      );
    }

    Widget seeResultButton(AppLanguage language) {
      return ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey; // Set button color to grey when disabled
              }
              return Colors.blue; // Set button color to blue when enabled
            },
          ),
        ),
        child: Text(
          YajnaLocalization.result[language.name].toString(),
        ),
      );
    }

    Widget viewLCCReport(AppLanguage language, LCCModel state) {
      return ElevatedButton(
        onPressed: () {
          lccReportBottomSheet(context, state);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey; // Set button color to grey when disabled
              }
              return Colors.blue; // Set button color to blue when enabled
            },
          ),
        ),
        child: const Text(
          "View Report",
        ),
      );
    }

    Widget showProbabilityIndex(List<double> results) {
      Size size = MediaQuery.of(context).size;

      List<Color> lccColors = [
        const Color(0xFFADFF2F), // GreenYellow for index 3
        const Color(0xFF32CD32), // LimeGreen for index 2
        const Color(0xFF008000), // Green for index 1
        const Color(0xFF006400),
      ];
      return Row(
        children: [
          for (int i = 0; i < lccColors.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 15,
                  width: size.width / 4.5,
                  color: lccColors[i],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${(results[i] * 100).toStringAsFixed(2)}%",
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            )
        ],
      );
    }

    return BlocBuilder<LanguageBloc, AppLanguage>(builder: (context, language) {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 3,
          backgroundColor: appBarColor,
          title: Text(
            YajnaLocalization.ensemble[language.name].toString(),
          ),
        ),
        body: SingleChildScrollView(
          reverse: false,
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Card(
                        color: cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              chooseImageSource(language),
                              info(language),
                              const SizedBox(
                                height: 25,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              BlocBuilder<EnsembleLCCModelBloc,
                                  EnsembleLCCModel>(
                                builder: (context, state) {
                                  if (state.hasResult ||
                                      state.state == AGState.result) {
                                    return restart(language);
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      takePhotoWidget(state, language),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (state.remaining != 0)
                                        Text(
                                          "Remaining: ${state.remaining.toString()}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (state.remaining == 0)
                                        CupertinoButton(
                                          color: Colors.black,
                                          onPressed:
                                              state.state == AGState.loading
                                                  ? null
                                                  : () {
                                                      BlocProvider.of<
                                                          EnsembleLCCModelBloc>(
                                                        context,
                                                      ).inferences();
                                                    },
                                          child: state.state == AGState.loading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : const Text("Proceed"),
                                        )
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              BlocBuilder<LCCModelBloc, LCCModel>(
                                builder: (context, state) {
                                  if (state.hasResult) {
                                    return seeResultButton(language);
                                  }
                                  return const SizedBox();
                                },
                              ),
                              const SizedBox(height: 20),
                              BlocBuilder<LCCModelBloc, LCCModel>(
                                builder: (context, state) {
                                  if (state.hasResult) {
                                    return viewLCCReport(language, state);
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // aboutInformation()
                      //Show result
                      BlocBuilder<EnsembleLCCModelBloc, EnsembleLCCModel>(
                        builder: (context, state) {
                          if (state.state == AGState.result) {
                            return Card(
                              color: cardColor,
                              shadowColor: cardColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        result(state.result, language),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    showProbabilityIndex(state.result)
                                  ],
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
