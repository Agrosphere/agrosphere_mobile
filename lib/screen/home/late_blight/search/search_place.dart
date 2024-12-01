import 'package:flutter/material.dart';

class SearchPlaceForLateBlight extends StatelessWidget {
  const SearchPlaceForLateBlight({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Place"),
      ),
      body: Center(
        child: Text("Search for the place"),
      ),
    );
  }
}
