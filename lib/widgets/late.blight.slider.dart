import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LateBlighSlider extends StatefulWidget {
  const LateBlighSlider({super.key});

  @override
  State<LateBlighSlider> createState() => _LateBlighSliderState();
}

class _LateBlighSliderState extends State<LateBlighSlider> {
  final CarouselSliderController _controller = CarouselSliderController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final items = [1, 2, 3, 4, 5];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 3,
        shadowColor: const Color.fromARGB(110, 0, 0, 0),
        color: Colors.white,
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
              items: items.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/logo.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                            colorBlendMode: BlendMode.colorBurn,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Somet infor"),
                          )
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
                for (final (index, _) in items.indexed)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: index == currentPage ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
