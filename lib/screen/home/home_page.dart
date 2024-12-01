import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/bloc/language_bloc.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/diseases/bloc/diseases_bloc.dart';
import 'package:late_blight/screen/features/market_price/widget/kalimati_price_slider.dart';
import 'package:late_blight/screen/insects/bloc/insects_bloc.dart';
import 'package:late_blight/utils/lang_utils.dart';
import 'package:late_blight/widgets/current.user_weather.dart';
import 'package:late_blight/widgets/login_alert.dart';
import 'package:late_blight/widgets/more_info.dart';
import 'package:late_blight/widgets/share.app.dart';
import 'package:late_blight/widgets/sub_app_carousel_slider.dart';
import 'package:late_blight/widgets/text_speech.dart';

class KrishiHomePage extends StatelessWidget {
  final AppLanguage language;
  const KrishiHomePage({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    void getData() {
      BlocProvider.of<DiseasesBloc>(context).fetchDiseases();
      BlocProvider.of<InsectsBloc>(context).fetchInsects();
    }

    getData();
    return RefreshIndicator(
      onRefresh: () {
        return Future<void>.delayed(const Duration(seconds: 2), getData);
      },
      child: CustomScrollView(
        shrinkWrap: true,
        primary: true,
        slivers: [
          const SliverToBoxAdapter(
            child: CurrentUserLocationWeather(),
          ),
          const SliverToBoxAdapter(
            child: MarketPriceSlider(),
          ),
          SliverToBoxAdapter(
            child: loginAlertInfo(context),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: Size.infinite.width,
              child: Card(
                color: ourServiceColor,
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Text(
                    YajnaLocalization.ourServices[language.name].toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SubAppCarouselSlider()),
          const SliverToBoxAdapter(
            child: ReadKrishiInfo(),
          ),
          // LoginFeatures(),

          const SliverToBoxAdapter(child: ShareAppWidget()),
        ],
        physics: const ClampingScrollPhysics(),
      ),
    );
  }
}
