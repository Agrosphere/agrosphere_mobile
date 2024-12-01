import 'package:flutter/material.dart';
import 'package:late_blight/screen/features/news/widgets/category.dart';
import 'package:late_blight/screen/features/news/widgets/visit_site.dart';

class RenderGorkhaPatraOnline extends StatelessWidget {
  final Map<String, dynamic> gorkhaPatraOnline;
  final bool hasVisitSite;
  const RenderGorkhaPatraOnline({
    super.key,
    required this.gorkhaPatraOnline,
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
              gorkhaPatraOnline['title'],
              maxLines: hasVisitSite ? null : 1,
              softWrap: true,
              style: TextStyle(
                fontSize: hasVisitSite ? 20 : 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              gorkhaPatraOnline['author'],
            ),
            SizedBox(height: 4),
            Text(
              gorkhaPatraOnline['date'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            category(gorkhaPatraOnline['category']),
            Text(
              gorkhaPatraOnline['description'],
              softWrap: true,
              maxLines: hasVisitSite ? 3 : 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  gorkhaPatraOnline['source'],
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
                siteUrl: gorkhaPatraOnline['source'],
              )
          ],
        ),
      ),
    );
  }
}
