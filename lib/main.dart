import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/auth/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
      title: 'Donapp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 93, 255, 1), // azul
        secondaryHeaderColor: Color.fromRGBO(5, 4, 28, 1),
        accentColor: Color.fromRGBO(139, 180, 254, 1), // violeta
      ),
      home: LoginPage(),
    );
  }
}
