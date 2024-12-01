import 'dart:async';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class KrishiBottomNavigationBar extends StatefulWidget {
  final void Function(int pageIndex) pageIndex;
  const KrishiBottomNavigationBar({super.key, required this.pageIndex});

  @override
  State<KrishiBottomNavigationBar> createState() =>
      _KrishiBottomNavigationBarState();
}

class _KrishiBottomNavigationBarState extends State<KrishiBottomNavigationBar>
    with TickerProviderStateMixin {
  // final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _fabAnimationController;
  late Animation<double> fabAnimation;

  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = [
    Icons.home,
    Icons.chat,
    Icons.price_change,
    Icons.newspaper,
  ];
  final iconText = [
    "घर",
    "च्याट",
    "बजार मूल्य",
    "समाचार",
  ];

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _hideBottomBarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedBottomNavigationBar.builder(
        blurEffect: true,
        itemCount: iconList.length,
        elevation: 7,
        borderColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(150, 43, 43, 43)
            : null,
        tabBuilder: (int index, bool isActive) {
          final color = isActive
              ? Colors.blue
              : Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  iconText[index].toString(),
                  maxLines: 1,
                  style: TextStyle(
                    color: color,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              )
            ],
          );
        },
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        activeIndex: _bottomNavIndex,
        scaleFactor: 2,
        splashColor: Colors.green,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 4,
        rightCornerRadius: 4,
        onTap: (index) {
          widget.pageIndex(index);
          setState(() => _bottomNavIndex = index);
        },
        hideAnimationController: _hideBottomBarAnimationController,
        hideAnimationCurve: Curves.easeInCubic,
      ),
    );
  }
}
