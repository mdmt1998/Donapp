import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/auth/loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, // Color for Android
        statusBarBrightness:
            Brightness.light // Dark == white status bar -- for IOS.
        ));

    // final _screenSizeWidth = MediaQuery.of(context).size.width;
    // final _fontScaling = MediaQuery.of(context).textScaleFactor;

    /**
     * 
     */
    return MaterialApp(
      title: 'DonApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(38, 110, 246, 1),
        secondaryHeaderColor: Colors.black87,
        accentColor: Color.fromRGBO(153, 148, 250, 1),
      ),
      home: LoginPage(),
    );
  }
}
