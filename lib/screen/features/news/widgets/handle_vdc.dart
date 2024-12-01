import 'package:flutter/material.dart';
import 'package:late_blight/screen/features/news/widgets/category.dart';
import 'package:late_blight/screen/features/news/widgets/download_button.dart';
import 'package:late_blight/screen/features/news/widgets/visit_site.dart';

class RenderVDC extends StatelessWidget {
  final Map<String, dynamic> vdc;
  final bool hasVisitSite;
  const RenderVDC({super.key, required this.vdc, this.hasVisitSite = true});

  @override
  Widget build(BuildContext context) {
    Widget forNotice() {
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
                vdc['subject'],
                maxLines: hasVisitSite ? null : 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: hasVisitSite ? 20 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              category(vdc['category']),
              SizedBox(height: 4),
              Text(
                'Published: ${vdc['published_date']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'End date: ${vdc['end_date']}',
                style: TextStyle(
                  fontSize: 14,
                  color: RegExp(r'closed', caseSensitive: false)
                          .hasMatch(vdc['end_date'].toString())
                      ? Colors.red
                      : Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  vdc['category'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    vdc['source'],
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.blueAccent,
                    ),
                  ),
                  download('https://${vdc['source']}${vdc['file_link']}'),
                ],
              ),
              if (hasVisitSite)
                VisitSiteCard(
                  siteUrl: vdc['source'],
                )
            ],
          ),
        ),
      );
    }

    Widget forPublication() {
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
                vdc['title'],
                maxLines: hasVisitSite ? null : 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: hasVisitSite ? 20 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  vdc['category'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    vdc['source'],
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Row(
                    children: [
                      download('https://${vdc['source']}${vdc['file_link']}'),
                      Text(vdc['download_size']),
                    ],
                  )
                ],
              ),
              if (hasVisitSite)
                VisitSiteCard(
                  siteUrl: vdc['source'],
                )
            ],
          ),
        ),
      );
    }

    return vdc['category'] == 'notice' ? forNotice() : forPublication();
  }
}
