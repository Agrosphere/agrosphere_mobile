import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/features/market_price/bloc/tarkari_bloc.dart';
import 'package:late_blight/screen/features/news/bloc/news_bloc.dart';
import 'package:late_blight/screen/home/bloc/nav_index.dart';
import 'package:late_blight/screen/home/late_blight/bloc/navbar_bloc.dart';
import 'package:late_blight/screen/home/late_blight/bloc/weather.bloc.dart';
import 'package:late_blight/screen/home/late_blight/map/bloc/map_bloc.dart';
import 'package:late_blight/screen/onboarding/bloc/onboarding_bloc.dart';
import 'package:late_blight/bloc/language_bloc.dart';

getOtherProviders() {
  final otherProviders = [
    BlocProvider(create: (context) => LanguageBloc()),
    BlocProvider(create: (context) => WeatherBloc()),
    BlocProvider(create: (context) => MapBloc()),
    BlocProvider(create: (context) => NavbarBloc()),
    BlocProvider(create: (context) => OnBoardingBloc()),
    BlocProvider(create: (context) => KalimatiTarkariBloc()),
    BlocProvider(create: (context) => NewsBloc()),
    BlocProvider(create: (context) => NavIndexBloc()),
  ];
  return otherProviders;
}
