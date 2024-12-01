import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/bloc/language_bloc.dart';
import 'package:late_blight/model/sub_app.dart';
import 'package:late_blight/utils/lang_utils.dart';

class SubAppCarouselSlider extends StatefulWidget {
  const SubAppCarouselSlider({
    super.key,
  });

  @override
  State<SubAppCarouselSlider> createState() => _LateBlighSliderState();
}

class _LateBlighSliderState extends State<SubAppCarouselSlider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LanguageBloc bloc = BlocProvider.of<LanguageBloc>(context, listen: true);
    var subapps = [
      // SubApp(
      //   appname: YajnaLocalization.lateblight[bloc.state.name].toString(),
      //   imageUrl: "assets/late_blight.png",
      //   description: "Predict late blight at your location",
      //   route: "/late_blight",
      // ),
      SubApp(
        appname: YajnaLocalization.lcc[bloc.state.name].toString(),
        imageUrl: "assets/lcc.png",
        description: "Check for nitrogen in rice",
        route: "/lcc",
      ),
      SubApp(
        appname: YajnaLocalization.lateblightSeg[bloc.state.name].toString(),
        imageUrl: "assets/late_blight.png",
        description: "",
        route: "/late_blight_seg",
      ),
      SubApp(
        appname: "Tomato Ripen or Unripen",
        imageUrl: "assets/ripen_unripen.png",
        description: "",
        route: "/late_blight_seg",
      ),
    ];

    Widget subApp(SubApp app) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, app.route, arguments: {
            "name": app.appname,
          });
        },
        child: SizedBox(
          width: 120,
          height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(11)),
                  child: Container(
                    color: Colors.white,
                    height: 120,
                    width: 140,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: Image.asset(
                        app.imageUrl,
                        isAntiAlias: true,
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                app.appname,
                softWrap: true,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  overflow: TextOverflow.fade,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.blue[200],
        surfaceTintColor: Colors.blueGrey[800],
        elevation: 3,
        shadowColor: const Color.fromARGB(110, 0, 0, 0),
        child: Wrap(
          spacing: 2,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final app in subapps) subApp(app),
          ],
        ),
      ),
    );
  }
}
