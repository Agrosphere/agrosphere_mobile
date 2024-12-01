import 'package:flutter/material.dart';
import 'package:late_blight/screen/features/news/widgets/category.dart';
import 'package:late_blight/screen/features/news/widgets/visit_site.dart';

class RenderHaloKhabar extends StatelessWidget {
  final Map<String, dynamic> haloKhabar;
  final bool hasVisitSite;
  const RenderHaloKhabar(
      {super.key, required this.haloKhabar, this.hasVisitSite = true});

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
              haloKhabar['title'],
              maxLines: hasVisitSite ? null : 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: hasVisitSite ? 20 : 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            if (hasVisitSite)
              Text(
                haloKhabar['author'],
              ),
            SizedBox(height: 8),
            Text(
              haloKhabar['date'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            category(haloKhabar['category']),
            Text(
              haloKhabar['description'],
              softWrap: true,
              maxLines: hasVisitSite ? 3 : 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  haloKhabar['source'],
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
                siteUrl: haloKhabar['source'],
              )
          ],
        ),
      ),
    );
  }
}
