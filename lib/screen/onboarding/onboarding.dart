import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/model/onboarding.item.dart';
import 'package:late_blight/screen/onboarding/bloc/onboarding_bloc.dart';
import 'package:late_blight/shared_prefs.dart';
import 'package:late_blight/utils/utils.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  bool isShowAlert = false;

  List<OnBoardingItem> items = [
    OnBoardingItem(
        content:
            "पछौटे डढुवा (Late blight) गोलभेडा र आलुमा लाग्ने ढुसीजन्य रोग हो । यो रोग फाइटोप्थोरा ईन्फेस्टेन्स (Phytopthora infestans) नामक ढुसीबाट लाग्ने गर्दछ । यस रोगले बिरूवाको पात, डाँठ र फलमा आक्रमण गर्दछ ।",
        imagePath: "assets/welcome.gif",
        title: "डढुवा पूर्वानुमान APP मा स्वागत छ!"),
    OnBoardingItem(
      content:
          "डढुवा पुर्बनुमानले तपाईलाई डढुवाको भबिष्यबाणी गर्नेछ र समयमै डढुवाको प्रतिकार गर्न तयार गर्नेछ।  आउने पाँचदिनको मौसम पुर्बनुमान गरि यसले तपाईलाई डढुवा जोखिमको जानकारी गराउने छ।",
      imagePath: "assets/potato.jpg",
      title: "डढुवा पूर्वानुमान, तपाईंको सारथी",
    ),
    OnBoardingItem(
      content:
          "कृषक दाजुभाईहरुलाई डढुवाको पूर्व जानकारी दिन तयार परेका छौ।  यसले करिब ४२ बर्षको मौसम बिबरणको आधारमा कम्प्युटरको कृत्रिम बुद्धिमत्ता विकास गरि बनाइएको सफल प्रबिधि को आधारमा काम गर्छ।",
      imagePath: "assets/tomato.jpg",
      title: "डढुवा विरुद्ध हाम्रो प्रयास",
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showAlert(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 5),
        () => {
              showCupertinoDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text(
                        "के तपाइँ प्रयोगकर्ता पुस्तिका हेर्न चाहनुहुन्छ?"),
                    actions: [
                      CupertinoButton(
                        child: const Text(
                          "रद्द गर्नुहोस्",
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoButton(
                        child: Text(TextUtils.yes),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "/help");
                        },
                      )
                    ],
                  );
                },
              )
            });
  }

  @override
  Widget build(BuildContext context) {
    if (!isShowAlert) {
      _showAlert(context);
      isShowAlert = true;
    }
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<OnBoardingBloc, int>(
          builder: (context, state) => Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  BlocProvider.of<OnBoardingBloc>(context).update(page);
                },
                children: [
                  for (final item in items) _buildPage(item),
                ],
              ),
              Positioned(
                bottom: 20.0,
                left: 0,
                right: 0,
                child: _onBoardingButtonController(state),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _onBoardingButtonController(int currentPage) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
            color: Colors.black,
            child: Text(currentPage == 0 ? TextUtils.skip : TextUtils.back),
            onPressed: () {
              if (currentPage == 0) {
                YajnaKrishiSharePrefs.setOnBoarding(true).then((value) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, "/main_app");
                });
              } else {
                //back
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              }
            },
          ),
          CupertinoButton(
            color: const Color(0xFF4CAF50),
            padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
            child: Text(
              currentPage != items.length - 1
                  ? TextUtils.next
                  : TextUtils.finished,
            ),
            onPressed: () {
              if (currentPage == items.length - 1) {
                //finished
                YajnaKrishiSharePrefs.setOnBoarding(true).then((value) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, "/main_app");
                });
              } else {
                //next
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnBoardingItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (item.imagePath.isNotEmpty)
            Image.asset(
              item.imagePath,
              height: 250,
              width: 250,
            ),
          if (item.title.isNotEmpty) const SizedBox(height: 50.0),
          if (item.title.isNotEmpty)
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 20.0),
          if (item.content.isNotEmpty)
            Text(
              item.content,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
