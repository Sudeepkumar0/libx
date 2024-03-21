import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatelessWidget {
  final String bookname;
  final String pdfUrl;

  PDFViewerScreen({required this.bookname, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookname),
      ),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}