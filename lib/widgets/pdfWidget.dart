import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PDFWidget extends StatefulWidget {
  final String title;
  final String path;

  const PDFWidget({Key key, @required this.path, this.title}) : super(key: key);

  @override
  _PDFWidgetState createState() => _PDFWidgetState();
}

class _PDFWidgetState extends State<PDFWidget> {
  PDFDocument _document;

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;

    /**
     *
     */
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.title != null
          ? AppBar(
              title: Text(
                widget.title,
                style: TextStyle(
                    fontFamily: 'LatoMedium', fontSize: _screenWidth / 20),
              ),
              elevation: 0.5,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: _screenWidth / 15,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            )
          : PreferredSize(preferredSize: Size(0.0, 0.0), child: SizedBox()),
      body: FutureBuilder<PDFDocument>(
        future: _getDocument(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return PDFView(
              document: snapshot.data,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<PDFDocument> _getDocument() async {
    if (_document != null) {
      return _document;
    }
    if (await hasSupport()) {
      return _document = await PDFDocument.openAsset(widget.path);
    } else {
      throw Exception(
        'PDF Rendering does not\n'
        'support on the system of this version',
      );
    }
  }
}

Future<bool> hasSupport() async {
  final deviceInfo = DeviceInfoPlugin();
  bool hasSupport = false;
  if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    hasSupport = int.parse(iosInfo.systemVersion.split('.').first) >= 11;
  } else if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    hasSupport = androidInfo.version.sdkInt >= 21;
  }
  return hasSupport;
}
