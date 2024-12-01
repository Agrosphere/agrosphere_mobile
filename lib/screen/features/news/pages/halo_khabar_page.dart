import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/features/news/widgets/category.dart';
import 'package:late_blight/screen/features/news/widgets/visit_site.dart';

class HaloKhabarPage extends StatelessWidget {
  final Map<String, dynamic> item;
  const HaloKhabarPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['title']),
        elevation: 3,
        backgroundColor: appBarColor,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['title'],
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              item['author'],
            ),
            SizedBox(height: 8),
            Text(
              item['source'],
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.blueAccent,
              ),
            ),
            Text(
              item['date'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            category(item['category']),
            if (item['image'].isNotEmpty)
              CachedNetworkImage(imageUrl: item['image'].first),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['description'],
                softWrap: true,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
            ),
            SizedBox(height: 8),
            VisitSiteCard(
              siteUrl: item['source'],
            )
          ],
        ),
      ),
    );
  }
}
