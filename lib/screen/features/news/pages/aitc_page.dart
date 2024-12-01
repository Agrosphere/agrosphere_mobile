import 'package:flutter/material.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/features/news/widgets/category.dart';
import 'package:late_blight/screen/features/news/widgets/download_button.dart';
import 'package:late_blight/screen/features/news/widgets/visit_site.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AitcPage extends StatelessWidget {
  final Map<String, dynamic> aitc;
  const AitcPage({super.key, required this.aitc});

  @override
  Widget build(BuildContext context) {
    Widget renderNotice() {
      final size = MediaQuery.of(context).size;
      final link = aitc['download_link'];
      if (link == null || link.isEmpty) {
        return SizedBox();
      }
      //check the link is pdf or not
      if (link.toString().contains(RegExp('pdf', caseSensitive: false))) {
        return handlePDF(size, link);
      }
      final images = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'svg'];
      if (images.contains(link.toString().split('.').last)) {
        return Image.network(link);
      }

      return SizedBox();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(aitc['title']),
        elevation: 3,
        backgroundColor: appBarColor,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              aitc['title'],
              softWrap: true,
              style: TextStyle(
                fontSize: 20,
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
            renderNotice(),
            VisitSiteCard(
              siteUrl: aitc['source'],
            )
          ],
        ),
      ),
    );
  }
}

Widget handlePDF(Size size, String link) {
  return Container(
    height: size.height,
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(top: 8),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
    ),
    child: SfPdfViewer.network(
      scrollDirection: PdfScrollDirection.horizontal,
      enableTextSelection: true,
      enableDocumentLinkAnnotation: true,
      link,
      canShowPaginationDialog: true,
    ),
  );
}
