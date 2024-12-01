import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:late_blight/bloc/language_bloc.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/home/late_blight_segmentation/late_blight_segmentation_bloc.dart';
import 'package:late_blight/screen/home/lcc/bloc/choose_photo_model.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:late_blight/utils/lang_utils.dart';

class LateBlightSegmentationMain extends StatefulWidget {
  const LateBlightSegmentationMain({super.key});

  @override
  State<LateBlightSegmentationMain> createState() =>
      _LateBlightSegmentationMainState();
}

class _LateBlightSegmentationMainState
    extends State<LateBlightSegmentationMain> {
  late final LateBlightSegModelBloc _bloc;
  final picker =
      ImagePicker(); // Allows us to pick image from gallery or camera
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<LateBlightSegModelBloc>(context);
  }

  Widget chooseImageSource(AppLanguage language) {
    return BlocBuilder<ChoosePhotoModel, ImageSource>(
      builder: (context, state) {
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

  pickImage(ImageSource imageSource) async {
    // This function to grab the image from camera
    var image = await picker.pickImage(source: imageSource);

    if (image == null) return null;
    //upload the image
    _bloc.setLoading();
    _bloc.inference(File(image.path));
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
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
        ),
      );
    });
  }

  Widget widgetDiseases(List<dynamic> diseases) {
    return Card(
      color: cardColordark,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              diseases.length > 1 ? "Diseases" : "Disease",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
              ),
              softWrap: true,
            ),
            Column(
              children: diseases.map((disease) {
                return Text(
                  disease.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  softWrap: true,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      // Add more colors as needed
      default:
        return Colors.black; // Default color if the name doesn't match
    }
  }

  Widget widgetClassLabel(Map<String, dynamic> classColors) {
    return Card(
      elevation: 3,
      color: cardColordark,
      shadowColor: cardColordark,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: classColors.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      width: 35,
                      height: 10,
                      color: getColorFromName(
                        entry.value,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    entry.key.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              YajnaLocalization.lateblightSeg[language.name].toString(),
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
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  BlocBuilder<LateBlightSegModelBloc,
                                      LateBlightSegmentationModel>(
                                    builder: (context, state) {
                                      return takePhotoWidget(
                                        state.state,
                                        language,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BlocBuilder<LateBlightSegModelBloc,
                              LateBlightSegmentationModel>(
                            builder: (context, state) {
                              if (state.hasResult) {
                                return Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: widgetClassLabel(
                                              state.classColors),
                                        ),
                                        Expanded(
                                          child: widgetDiseases(state.diseases),
                                        ),
                                      ],
                                    ),
                                    Card(
                                      elevation: 3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Image.network(
                                            state.url,
                                            fit: BoxFit
                                                .cover, // Optional: Adjust as needed
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                          // aboutInformation()
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ),
      );
    });
  }
}
