// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:late_blight/bloc/language_bloc.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/model/sub_app.dart';
import 'package:late_blight/screen/home/lcc/bloc/choose_photo_model.dart';
import 'package:late_blight/screen/home/lcc/bloc/lcc_model_update_bloc.dart';
import 'package:late_blight/screen/home/lcc/download_model/download_model.dart';
import 'package:late_blight/screen/home/lcc/inference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:late_blight/screen/home/lcc/bloc/lcc_model.dart';
import 'package:late_blight/services/download_model.dart';
import 'package:late_blight/services/read_model_files.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:late_blight/utils/lang_utils.dart';
import 'dart:isolate';

import 'package:late_blight/widgets/lcc.report.dart';

class LCCMainPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LCCMainPage({Key? key});

  @override
  _LCCMainPageState createState() => _LCCMainPageState();
}

class _LCCMainPageState extends State<LCCMainPage> {
  late final LCCModelBloc _bloc;
  late final LCCUpdateBloc _updateBloc;
  late String title;
  late String uses;
  late String description;
  final picker =
      ImagePicker(); // Allows us to pick image from gallery or camera
  late LCCInference inference;
  bool inferenceInitalized = false;
  final _port = ReceivePort();

  bool hasUpdateAvailable = false;
  @override
  void initState() {
    // InitS is the first function that is executed by default when this class is called
    super.initState();
    _bloc = BlocProvider.of<LCCModelBloc>(context);
    _updateBloc = BlocProvider.of<LCCUpdateBloc>(context);
    _updateBloc.init();
    initSetupDowloader();
  }

  void initSetupDowloader() {
    bool isRegistered = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isRegistered) {
      IsolateNameServer.removePortNameMapping('downloader_send_port');
      IsolateNameServer.registerPortWithName(
          _port.sendPort, 'downloader_send_port');
    }

    _port.listen((dynamic data) {
      //if download is complete then change the state by reading file
      if (DownloadTaskStatus.fromInt(data[1]) == DownloadTaskStatus.complete) {
        readLccFilesAndUpdate(context);
      }
    });
    //download callback register
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    if (send != null) {
      send.send([id, status, progress]);
    } else {
      debugPrint("Send Port is empty");
    }
  }

  @override
  void dispose() {
    // Dis function disposes and clears our memory
    super.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    _bloc.reset();
    if (inferenceInitalized) {
      inference.dispose();
    }
  }

  classifyImage(File image) async {
    _bloc.setLoading();
    inferenceInitalized = true;
    int output = await inference.inference(image.path, resize: 224);
    _bloc.addInference(output, image.path);
  }

  pickImage(ImageSource imageSource) async {
    // This function to grab the image from camera
    var image = await picker.pickImage(source: imageSource);
    if (image == null) return null;
    classifyImage(File(image.path));
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
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      );
    }

    String result(List<int> result) {
      int counter = 0;

      for (int value in result) {
        if (value == 0 || value == 1) {
          counter++;
        }
      }

      if (counter > 5) {
        return "अधिकतम नाफा कमाउनको लागि १ हेक्टर जमिनमा २० किलो युरिया मल लगाउनु पर्छ";
      } else {
        return "अहिलेको लागि हामी केहि भन्न सक्दैनौं";
      }
    }

    Widget chooseImageSource(AppLanguage language) {
      return BlocBuilder<ChoosePhotoModel, ImageSource>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(YajnaLocalization.imageSource[language.name].toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              ListTile(
                onTap: () {
                  //update the choose image source to gallery
                  BlocProvider.of<ChoosePhotoModel>(context)
                      .change(ImageSource.gallery);
                },
                title: Text(
                  YajnaLocalization.selectPhoto[language.name].toString(),
                ),
                leading: Radio<String>(
                  value: '${YajnaLocalization.selectPhoto[language.name]}',
                  groupValue: state == ImageSource.gallery
                      ? YajnaLocalization.selectPhoto[language.name].toString()
                      : '',
                  onChanged: (value) {
                    //update the choose image source to gallery
                    BlocProvider.of<ChoosePhotoModel>(context)
                        .change(ImageSource.gallery);
                  },
                ),
              ),
              ListTile(
                onTap: () {
                  //update the choose image source to gallery
                  BlocProvider.of<ChoosePhotoModel>(context)
                      .change(ImageSource.camera);
                },
                title:
                    Text(YajnaLocalization.takePhoto[language.name].toString()),
                leading: Radio<String>(
                  value: '${YajnaLocalization.selectPhoto[language.name]}',
                  groupValue: state == ImageSource.camera
                      ? YajnaLocalization.selectPhoto[language.name].toString()
                      : '',
                  onChanged: (value) {
                    //update the choose image source to camera
                    BlocProvider.of<ChoosePhotoModel>(context)
                        .change(ImageSource.camera);
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    Widget takePhotoWidget(AGState state, AppLanguage language) {
      return BlocBuilder<ChoosePhotoModel, ImageSource>(
          builder: (context, imageSource) {
        return GestureDetector(
          onTap: state == AGState.loading
              ? null
              : () {
                  pickImage(imageSource);
                },
          child: Container(
            width: MediaQuery.of(context).size.width - 200,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
            decoration: BoxDecoration(
              color: buttonColor1,
              borderRadius: BorderRadius.circular(15),
            ),
            child: state == AGState.loading
                ? const CircularProgressIndicator()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        imageSource == ImageSource.camera
                            ? Icons.camera_alt
                            : Icons.folder,
                        color: Colors.yellow,
                      ),
                      Text(
                        imageSource == ImageSource.camera
                            ? YajnaLocalization.takePhoto[language.name]
                                .toString()
                            : YajnaLocalization.selectPhoto[language.name]
                                .toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
          ),
        );
      });
    }

    Widget restart(AppLanguage language) {
      return GestureDetector(
        onTap: () {
          _bloc.reset();
        },
        child: Container(
            width: MediaQuery.of(context).size.width - 200,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
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
        onPressed: () {
          _bloc.showResult();
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
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    Widget subApp(SubApp app) {
      return GestureDetector(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(11)),
                child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    app.imageUrl,
                    height: 125,
                    width: 115,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        app.appname,
                        softWrap: true,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        app.description.isEmpty
                            ? "No description"
                            : app.description,
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: 145,
                        child: CupertinoButton(
                          color: Colors.black,
                          padding: const EdgeInsets.fromLTRB(24, 4, 24, 4),
                          onPressed: () {
                            Navigator.pushNamed(context, app.route, arguments: {
                              "name": app.appname,
                            });
                          },
                          child: const Text(
                            "Open",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget modelNotAvailable(LCCUpdateModel state) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: Size.infinite.width,
              child: Card(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Model not found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        "Please download the model by clicking the download button",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CupertinoButton(
                        color: Colors.black,
                        padding: const EdgeInsets.fromLTRB(32, 4, 32, 4),
                        onPressed: () {
                          if (state.url != null) {
                            Fluttertoast.showToast(
                                msg: "Downloading model...",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            DownloadService()
                                .start(state.url!, path: "model")
                                .then((value) {
                              debugPrint(value);
                              Fluttertoast.showToast(
                                  msg: "Downloaded Successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }).catchError((a) {
                              Fluttertoast.showToast(
                                  msg: "Failed to download model",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          }
                        },
                        child: const Text("Download"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      subApp(
                        SubApp(
                          appname: "Ensemble युरिया कमी मापन",
                          imageUrl: "assets/late_blight.png",
                          description: "",
                          route: "/lcc_ensemble",
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // aboutInformation()
          ],
        ),
      );
    }

    return BlocBuilder<LanguageBloc, AppLanguage>(builder: (context, language) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ChoosePhotoModel()),
        ],
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            elevation: 3,
            backgroundColor: appBarColor,
            title: Text(
              YajnaLocalization.lcc[language.name].toString(),
            ),
          ),
          body: SingleChildScrollView(
            reverse: false,
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              child: BlocBuilder<LCCUpdateBloc, LCCUpdateModel>(
                builder: (context, lccState) {
                  if (lccState.lccModelPath == null) {
                    return modelNotAvailable(lccState);
                  } else {
                    inference = LCCInference(lccState.lccModelPath!);
                  }
                  if (lccState.hasupdate) {
                    showModelUpdateDialog(context, lccState);
                  }
                  String currentVersion = lccState.lccModelPath!
                      .split('/')
                      .last
                      .split('_')[2]
                      .replaceAll('.tflite', '');
                  return Container(
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
                                    SizedBox(
                                      height: 75,
                                      width: Size.infinite.width,
                                      child: Card(
                                        color: Colors.black87,
                                        child: Center(
                                            child: Text(
                                          "Current Model Version: $currentVersion",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        )),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    chooseImageSource(language),
                                    info(language),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    BlocBuilder<LCCModelBloc, LCCModel>(
                                      builder: (context, state) {
                                        if (state.hasResult) {
                                          return const SizedBox();
                                        }
                                        return Center(
                                          child: SizedBox(
                                            child: Text(
                                              state.remaining == 0
                                                  ? YajnaLocalization
                                                      .result[language.name]
                                                      .toString()
                                                  : '${YajnaLocalization.photoYetToCapture[language.name].toString()} ${state.remaining}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    BlocBuilder<LCCModelBloc, LCCModel>(
                                      builder: (context, state) {
                                        if (state.hasResult ||
                                            state.state == AGState.result) {
                                          return restart(language);
                                        }
                                        return takePhotoWidget(
                                            state.state, language);
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

                                    //Show result
                                    BlocBuilder<LCCModelBloc, LCCModel>(
                                      builder: (context, state) {
                                        if (state.state == AGState.result) {
                                          return SizedBox(
                                            child: Text(result(state.result)),
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            subApp(
                              SubApp(
                                appname: "Ensemble युरिया कमी मापन",
                                imageUrl: "assets/late_blight.png",
                                description: "",
                                route: "/lcc_ensemble",
                              ),
                            )
                            // aboutInformation()
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
