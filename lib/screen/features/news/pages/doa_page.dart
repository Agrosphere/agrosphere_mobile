import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/features/news/widgets/category.dart';
import 'package:late_blight/screen/features/news/widgets/visit_site.dart';

class DOAPage extends StatelessWidget {
  final Map<String, dynamic> item;
  const DOAPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['story_title']),
        elevation: 3,
        backgroundColor: appBarColor,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['story_title'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            if (item['images'].isNotEmpty)
              CachedNetworkImage(
                imageUrl: item['images'].first,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 8),
            Text(
              'Farmer: ${item['farmer_name']}',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),
            Text(
              'Address: ${item['address']}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Published: ${item['published_date']}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              item['story'],
              softWrap: true,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            category(item['category']),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Source: ${item['source']}',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            VisitSiteCard(
              siteUrl: item['source'],
            )
          ],
        ),
      ),
    );
  }
}
