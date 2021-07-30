import 'package:flutter/material.dart';

import '../../widgets/pdfWidget.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return PDFWidget(
      path: 'assets/docs/termsConditions.pdf',
    );
  }
}
