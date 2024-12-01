import 'package:flutter/material.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/screen/features/news/pages/aitc_page.dart';
import 'package:late_blight/screen/features/news/widgets/handle_vdc.dart';

class VcdcPage extends StatelessWidget {
  final Map<String, dynamic> item;
  const VcdcPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Widget renderNotice() {
      final size = MediaQuery.of(context).size;
      final link = "https://vcdc.gov.np${item['file_link']}";
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
        title: Text(
          item.containsKey('subject') ? item['subject'] : item['title'],
        ),
        elevation: 3,
        backgroundColor: appBarColor,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RenderVDC(vdc: item),
            renderNotice(),
          ],
        ),
      ),
    );
  }
}
