import 'package:flutter/material.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/widgets/app_features_carousel_slider.dart';
import 'package:late_blight/widgets/diseases_horizontal_list.dart';
import 'package:late_blight/widgets/insects_categories_horizontal_list.dart';
import 'package:late_blight/widgets/insects_horizontal_list.dart';

class ReadKrishi extends StatelessWidget {
  const ReadKrishi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 3,
        shadowColor: Colors.black,
        title: Text("कृषि"),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: InsectsCategoryHorizontalList()),
          const SliverToBoxAdapter(child: DiseasesHorizontalList()),
          const InsectsHorizontalList(),
        ],
      ),
    );
  }
}
