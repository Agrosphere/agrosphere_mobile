import 'package:flutter/material.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/utils/utils.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          title: Text(TextUtils.help),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
                semanticLabel: 'Bookmark',
              ),
              onPressed: () {
                _pdfViewerKey.currentState?.openBookmarkView();
              },
            ),
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_left,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SfPdfViewer.network(
          API.getUrl("help/get_help/"),
          key: _pdfViewerKey,
        ),
      ),
    );
  }
}
