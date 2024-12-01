import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/bloc/language_bloc.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/home/late_blight/bloc/late_blight.probability.bloc.dart';
import 'package:late_blight/screen/home/late_blight/bloc/navbar_bloc.dart';
import 'package:late_blight/services/conveter.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:late_blight/utils/lang_utils.dart';
import 'package:percent_indicator/percent_indicator.dart';

class NearByLocation extends StatefulWidget {
  const NearByLocation({super.key});

  @override
  State<NearByLocation> createState() => _NearByLocationState();
}

class _NearByLocationState extends State<NearByLocation> {
  final CarouselSliderController _controller = CarouselSliderController();
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, AppLanguage>(
      builder: (context, language) {
        return BlocBuilder<LateBlightProbabilityBloc,
            LateBlightProbabilityState>(builder: (context, state) {
          switch (state.state) {
            case RequestState.success:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          YajnaLocalization.otherPlace[language.name]
                              .toString(),
                          style: const TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            BlocProvider.of<NavbarBloc>(context, listen: false)
                                .update(1);
                          },
                          child: Text(YajnaLocalization.seeMore[language.name]
                              .toString()),
                        ),
                      ),
                    ],
                  ),
                  Card(
                      surfaceTintColor: cardColor,
                      elevation: 3,
                      shadowColor: cardColor,
                      color: cardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CarouselSlider(
                            carouselController: _controller,
                            options: CarouselOptions(
                              height: 120.0,
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
                            items: state.predictions.take(5).map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            i.placeName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 21,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        CircularPercentIndicator(
                                          radius: 40,
                                          lineWidth: 10.0,
                                          percent: i.lateblightProbability,
                                          center: Text(
                                            language == AppLanguage.en
                                                ? ("${(i.lateblightProbability * 100).toStringAsFixed(2)}%")
                                                : ("${toNepali(i.lateblightProbability * 100)}%"),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          progressColor: i
                                                      .lateblightProbability >
                                                  0.4
                                              ? i.lateblightProbability > 0.7
                                                  ? Colors.red
                                                  : Colors.orange
                                              : Colors.green,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (final (index, _)
                                  in state.predictions.take(5).indexed)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                      color: index == currentPage
                                          ? Colors.blue
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                )
                            ],
                          )
                        ],
                      )),
                ],
              );
            default:
              return const SizedBox();
          }
        });
      },
    );
  }
}
