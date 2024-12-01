import 'package:flutter/material.dart';
import 'package:late_blight/screen/features/news/widgets/category.dart';
import 'package:late_blight/screen/features/news/widgets/visit_site.dart';

class RenderDoaNepal extends StatelessWidget {
  final Map<String, dynamic> doaNepal;
  final bool hasVisitSite;

  const RenderDoaNepal({
    super.key,
    required this.doaNepal,
    this.hasVisitSite = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doaNepal['story_title'],
              style: TextStyle(
                fontSize: hasVisitSite ? 20 : 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Farmer: ${doaNepal['farmer_name']}',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),
            if (hasVisitSite)
              Text(
                'Address: ${doaNepal['address']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            SizedBox(height: 8),
            Text(
              'Published: ${doaNepal['published_date']}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            if (hasVisitSite)
              Text(
                doaNepal['story'],
                softWrap: true,
                maxLines: hasVisitSite ? 3 : 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            SizedBox(height: 8),
            category(doaNepal['category']),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Source: ${doaNepal['source']}',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            if (hasVisitSite)
              VisitSiteCard(
                siteUrl: doaNepal['source'],
              )
          ],
        ),
      ),
    );
  }
}
