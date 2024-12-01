import 'package:flutter/material.dart';
import 'package:late_blight/widgets/insects_categories_horizontal_list.dart';

class InsectCategories extends StatelessWidget {
  const InsectCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insects Categories"),
      ),
      body: const InsectsCategoryHorizontalList(
        isHorizontal: false,
      ),
    );
  }
}
