import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AboutDisease extends StatefulWidget {
  const AboutDisease({super.key});

  @override
  State<AboutDisease> createState() => _HelpState();
}

class _HelpState extends State<AboutDisease> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.asset("assets/info.pdf", key: _pdfViewerKey);
  }
}
