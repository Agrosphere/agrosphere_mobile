import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/bloc/language_bloc.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/account/widgets/user_profile.dart';
import 'package:late_blight/screen/features/chat/chat_main_page.dart';
import 'package:late_blight/screen/features/market_price/market_price.dart';
import 'package:late_blight/screen/features/news/news.dart';
import 'package:late_blight/screen/home/bloc/nav_index.dart';
import 'package:late_blight/screen/home/home_page.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:late_blight/widgets/navigation_bottom_bar.dart';

class MainHomePage extends StatelessWidget {
  final AppLanguage language;
  final PageController pageController;
  const MainHomePage({
    super.key,
    required this.language,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    Widget userProfile() {
      return BlocBuilder<LoginBloc, LoginBlocModelState>(
        builder: (context, state) {
          final user = state.loggedInUser;
          if (user != null) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/user-dashboard");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: UserProfile(
                  user: user,
                  border: Border.all(
                    color: Colors.yellow,
                    width: 2,
                  ),
                  size: const Size(40, 40),
                  isVisitor: true,
                ),
              ),
            );
          }
          return SizedBox();
        },
      );
    }

    final screens = [
      KrishiHomePage(
        language: language,
      ),
      ChatMainPage(),
      KaliMatiTarkariPrice(),
      AgricultureNews(),
      // Information(),
      // if (user != null)
      //   UserDashboard(
      //     pageController: pageController,
      //   )
    ];

    final titles = [
      "घर",
      "च्याट",
      "बजार मूल्य",
      "समाचार",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 3,
        shadowColor: Colors.black,
        title: Row(
          children: [
            Image.asset(
              "assets/logo.png",
              height: 24,
            ),
            SizedBox(
              width: 15,
            ),
            BlocBuilder<NavIndexBloc, int>(builder: (context, state) {
              return Text(
                titles[state],
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
          ],
        ),
        actions: [
          userProfile(),
        ],
      ),
      body: BlocBuilder<NavIndexBloc, int>(
        builder: (context, index) {
          return screens[index];
        },
      ),
      bottomNavigationBar: KrishiBottomNavigationBar(pageIndex: (index) {
        // print(index);
        // set the index to the bloc
        BlocProvider.of<NavIndexBloc>(context).updateIndex(index);
      }),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white24, // Shadow color
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 2), // Shadow offset
            ),
          ],
        ),
        child: FloatingActionButton(
          elevation: 11,
          mini: false,
          autofocus: false,
          clipBehavior: Clip.antiAlias,
          enableFeedback: true,
          onPressed: () {
            //navigate to the trek mate
            Navigator.pushNamed(context, '/chat-ai');
          },
          tooltip: "Krishi Guru",
          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          child: ClipOval(
            child: Image.asset(
              "assets/chat-bot.gif",
              color: Colors.white,
              width: 36,
              height: 36,
              colorBlendMode: BlendMode.srcIn,

              fit: BoxFit.cover, // Ensures the image covers the circle
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
