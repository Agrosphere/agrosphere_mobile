import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/model/app_feature_model.dart';

class AppFeaturesCarouselSlider extends StatefulWidget {
  const AppFeaturesCarouselSlider({
    super.key,
  });

  @override
  State<AppFeaturesCarouselSlider> createState() => _LateBlighSliderState();
}

class _LateBlighSliderState extends State<AppFeaturesCarouselSlider> {
  final CarouselSliderController _controller = CarouselSliderController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // LanguageBloc bloc = BlocProvider.of<LanguageBloc>(context, listen: true);
    var features = [
      AppFeatureModel(
        featureDescription:
            "Farm with Precision: AI Solutions for Sustainable Growth",
        imageUrl: "assets/features1.png",
      ),
      AppFeatureModel(
        featureDescription: "Smart Agriculture Starts with AI",
        imageUrl: "assets/feature2.png",
      ),
      AppFeatureModel(
        featureDescription: "AI Solutions for Sustainable Agriculture",
        imageUrl: "assets/features1.png",
      ),
    ];

    Widget subApp(AppFeatureModel feature) {
      return GestureDetector(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  feature.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0.4,
                  child: Container(color: Colors.black),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    feature.featureDescription,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            color: Colors.transparent,
            surfaceTintColor: cardColor,
            elevation: 3,
            shadowColor: const Color.fromARGB(110, 0, 0, 0),
            child: Column(
              children: [
                CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                    height: 150.0,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                  ),
                  items: features.map((app) {
                    return Builder(
                      builder: (BuildContext context) {
                        return subApp(app);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
