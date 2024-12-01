import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:late_blight/screen/features/news/pages/aitc_page.dart';
import 'package:late_blight/screen/features/news/pages/doa_page.dart';
import 'package:late_blight/screen/features/news/pages/gorkha_patra_page.dart';
import 'package:late_blight/screen/features/news/pages/vcdc_page.dart';
import 'package:late_blight/screen/features/news/widgets/handle_aitc.dart';
import 'package:late_blight/screen/features/news/widgets/handle_doanepal.dart';
import 'package:late_blight/screen/features/news/widgets/handle_gorkha_patra.dart';
import 'package:late_blight/screen/features/news/widgets/handle_halo_khabar.dart';
import 'package:late_blight/screen/features/news/widgets/handle_vdc.dart';

final Map<String, Widget Function(Map<String, dynamic>)> navPages = {
  'aitc.gov.np': (data) => AitcPage(aitc: data),
  'gorkhapatraonline.com': (data) => GorkhaPatraPage(item: data),
  'halokhabar.com': (data) => GorkhaPatraPage(item: data),
  'vcdc.gov.np': (data) => VcdcPage(item: data),
  'doanepal.gov.np': (data) => DOAPage(item: data),
};

class RenderNews extends StatelessWidget {
  final List<Map<String, dynamic>> newsList;
  const RenderNews({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget Function(Map<String, dynamic>)> sourceToWidget = {
      'aitc.gov.np': (data) => RenderAITC(aitc: data),
      'gorkhapatraonline.com': (data) =>
          RenderGorkhaPatraOnline(gorkhaPatraOnline: data),
      'halokhabar.com': (data) => RenderHaloKhabar(haloKhabar: data),
      'vcdc.gov.np': (data) => RenderVDC(vdc: data),
      'doanepal.gov.np': (data) => RenderDoaNepal(doaNepal: data),
    };
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final news = newsList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => navPages[news['source']]!(news),
                ),
              );
            },
            child: sourceToWidget[news['source']]!(news),
          );
        },
        childCount: newsList.length,
      ),
    );
  }
}

class RenderLatestNews extends StatelessWidget {
  final List<Map<String, dynamic>> newsList;
  const RenderLatestNews({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget Function(Map<String, dynamic>)> sourceToWidget = {
      'aitc.gov.np': (data) => RenderAITC(
            aitc: data,
            hasVisitSite: false,
          ),
      'gorkhapatraonline.com': (data) => RenderGorkhaPatraOnline(
            gorkhaPatraOnline: data,
            hasVisitSite: false,
          ),
      'halokhabar.com': (data) => RenderHaloKhabar(
            haloKhabar: data,
            hasVisitSite: false,
          ),
      'vcdc.gov.np': (data) => RenderVDC(
            vdc: data,
            hasVisitSite: false,
          ),
      'doanepal.gov.np': (data) => RenderDoaNepal(
            doaNepal: data,
            hasVisitSite: false,
          ),
    };
    return SliverToBoxAdapter(
      child: newsList.isEmpty
          ? SizedBox()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Latest News",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CarouselSlider(
                  items: [
                    for (final news in newsList)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  navPages[news['source']]!(news),
                            ),
                          );
                        },
                        child: sourceToWidget[news['source']]!(news),
                      )
                  ],
                  options: CarouselOptions(
                    aspectRatio: 1.45,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    animateToClosest: true,
                    autoPlayCurve: Curves.easeInOutSine,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayInterval: Duration(seconds: 3),
                  ),
                ),
              ],
            ),
    );
  }
}
