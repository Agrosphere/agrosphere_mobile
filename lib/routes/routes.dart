import 'package:flutter/material.dart';
import 'package:late_blight/screen/account/user_dashboard.dart';
import 'package:late_blight/screen/diseases/disease.dart';
import 'package:late_blight/screen/diseases/diseases.dart';
import 'package:late_blight/screen/features/chat/chat_main_page.dart';
import 'package:late_blight/screen/features/chat_ai/chat_ai.dart';
import 'package:late_blight/screen/features/market_price/market_price.dart';
import 'package:late_blight/screen/features/news/news.dart';
import 'package:late_blight/screen/features/read/read.dart';
import 'package:late_blight/screen/home/ensemble_lcc/ensemble_lccmainpage.dart';
import 'package:late_blight/screen/home/late_blight/help/help.dart';
import 'package:late_blight/screen/home/late_blight/late_blight_home.dart';
import 'package:late_blight/screen/home/late_blight/search/search_place.dart';
import 'package:late_blight/screen/home/late_blight_segmentation/late_blight_seg_main.dart';
import 'package:late_blight/screen/home/lcc/lccmainpage.dart';
import 'package:late_blight/screen/home/main_page.dart';
import 'package:late_blight/screen/insects/insect.dart';
import 'package:late_blight/screen/insects/insect_category.dart';
import 'package:late_blight/screen/insects/insects.dart';
import 'package:late_blight/screen/login/login.dart';
import 'package:late_blight/screen/onboarding/onboarding.dart';
import 'package:late_blight/screen/register/register.dart';
import 'package:late_blight/screen/splash.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/splash': (context) => const SplashScreen(),
  '/onboarding': (context) => const OnboardingPage(),
  '/main_app': (context) => const MainApp(),
  "/lcc": (context) => const LCCMainPage(),
  "/late_blight": (context) => const LateBlightHome(),
  '/search-lateblight': (context) => const SearchPlaceForLateBlight(),
  '/login': (context) => Login(),
  '/register': (context) => Register(),
  '/help': (context) => const Help(),
  '/late_blight_seg': (context) => const LateBlightSegmentationMain(),
  '/lcc_ensemble': (context) => const EnsembleLCCMainPage(),
  '/diseases': (context) => const Diseases(),
  '/disease': (context) => const Disease(),
  '/insects': (context) => const InsectsView(),
  '/insect': (context) => const InsectView(),
  '/insect_categories': (context) => const InsectCategories(),
  '/news': (context) => const AgricultureNews(),
  '/chat-ai': (context) => const ChatAi(),
  '/market-price': (context) => const KaliMatiTarkariPrice(),
  '/chat': (context) => const ChatMainPage(),
  '/user-dashboard': (context) => const UserDashboard(),
  '/read-krishi': (context) => const ReadKrishi(),
  '/ripen_unripen': (context) => const LateBlightSegmentationMain(),
};
