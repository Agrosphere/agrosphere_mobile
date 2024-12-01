import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VisitSiteCard extends StatelessWidget {
  final String siteUrl;

  const VisitSiteCard({
    super.key,
    required this.siteUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Visit Site',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  siteUrl,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {
                launchUrl(Uri.https(siteUrl));
              },
              icon: Icon(
                Icons.open_in_new,
                color: Colors.white,
              ),
              label: Text(
                'Open',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
