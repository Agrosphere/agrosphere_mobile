import 'package:flutter/material.dart';
import 'package:late_blight/screen/features/news/widgets/category.dart';
import 'package:late_blight/screen/features/news/widgets/download_button.dart';
import 'package:late_blight/screen/features/news/widgets/visit_site.dart';

class RenderAITC extends StatelessWidget {
  final Map<String, dynamic> aitc;
  final bool hasVisitSite;
  const RenderAITC({super.key, required this.aitc, this.hasVisitSite = true});

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
              aitc['title'],
              softWrap: true,
              maxLines: hasVisitSite ? null : 1,
              style: TextStyle(
                fontSize: hasVisitSite ? 20 : 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Text(
              aitc['published_date'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            category(aitc['category']),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  aitc['source'],
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueAccent,
                  ),
                ),
                download(aitc['download_link']),
              ],
            ),
            if (hasVisitSite)
              VisitSiteCard(
                siteUrl: aitc['source'],
              )
          ],
        ),
      ),
    );
  }
}
